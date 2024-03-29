"""
Licensed under Public Domain Mark 1.0. 
See http://creativecommons.org/publicdomain/mark/1.0/
Author: Justin Bruce Van Horne <justinvh@gmail.com>
"""


"""
Python-Markdown LaTeX Extension

Adds support for $math mode$ and %text mode%. This plugin supports
multiline equations/text.

The actual image generation is done via LaTeX/DVI output.
It encodes data as base64 so there is no need for images directly.
All the work is done in the preprocessor.
"""

import re
import os
import string
import base64
import tempfile
import markdown


from subprocess import call, PIPE


# Defines our basic inline image
IMG_EXPR = "<img class='latex-inline math-%s' alt='%s' id='%s'" + \
        " src='data:image/png;base64,%s'>"

class LaTeXPreprocessor(markdown.preprocessors.Preprocessor):
    # These are our cached expressions that are stored in latex.cache
    cached = {}

    # Basic LaTex Setup as well as our list of expressions to parse
    tex_preamble = r"""\documentclass{article}
\usepackage[a4paper,landscape,margin=0in]{geometry}
\usepackage{amsthm}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage[utf8]{inputenc}
\usepackage{bm}
\usepackage[usenames,dvipsnames]{color}
\pagestyle{empty}
"""

    def __init__(self, configs):
        try:
            cache_file = open('latex.cache', 'r+')
            for line in cache_file.readlines():
                key, val = line.strip("\n").split(" ")
                self.cached[key] = val
        except IOError:
            pass

        self.config = {}
        self.config[("dvipng", "args")] = "-q -T tight -bg Transparent -z 9 -D 130"
        self.config[("delimiters", "text")] = "%%"
        self.config[("delimiters", "math")] = "%%"
        self.config[("delimiters", "preamble")] = "%%%"

        try:
            import ConfigParser
            cfgfile = ConfigParser.RawConfigParser()
            cfgfile.read('markdown-latex.cfg')

            for sec in cfgfile.sections():
                for opt in cfgfile.options(sec):
                    self.config[(sec, opt)] = cfgfile.get(sec, opt)
        except ConfigParser.NoSectionError:
            pass

        def build_regexp(delim):
            delim = re.escape(delim)
            regexp = r'(?<!\\)' + delim + r'(.+?)(?<!\\)' + delim
            return re.compile(regexp, re.MULTILINE | re.DOTALL)

        # %MATH% mode which is the typical LaTeX math mode.
        self.re_mathmode = build_regexp(self.config[("delimiters", "math")])
        # %%PREAMBLE%% text that modifys the LaTeX preamble for the document
        self.re_preamblemode = build_regexp(self.config[("delimiters", "preamble")])

    """The TeX preprocessor has to run prior to all the actual processing
    and can not be parsed in block mode very sanely."""
    def _latex_to_base64(self, tex, math_mode):
        """Generates a base64 representation of TeX string"""
        # Generate the temporary file
        tempfile.tempdir = ""
        path = tempfile.mktemp()
        tmp_file = open(path, "wb")
        tmp_file.write(self.tex_preamble)

        # Figure out the mode that we're in
        if math_mode:
            tmp_file.write("$"+tex.encode('utf8')+"$")
        else:
            tmp_file.write("%s" % tex)

        tmp_file.write('\n\end{document}')
        tmp_file.close()

        # compile LaTeX document. A DVI file is created
        status = call(('latex -halt-on-error %s' % path).split(), stdout=PIPE)

        # clean up if the above failed
        if status:
            self._cleanup(path, err=True)
            raise Exception("Couldn't compile LaTeX document." +
                "Please read '%s.log' for more detail." % path)

        # Run dvipng on the generated DVI file. Use tight bounding box.
        # Magnification is set to 1200
        dvi = "%s.dvi" % path
        png = "%s.png" % path

        # Extract the image
        cmd = "dvipng %s %s -o %s" % (self.config[("dvipng", "args")], dvi, png)
        status = call(cmd.split(), stdout=PIPE)

        # clean up if we couldn't make the above work
        if status:
            self._cleanup(path, err=True)
            raise Exception("Couldn't convert LaTeX to image." +
                    "Please read '%s.log' for more detail." % path)

        # Read the png and encode the data
        png = open(png, "rb")
        data = png.read()
        data = base64.b64encode(data)
        png.close()

        self._cleanup(path)

        return data

    def _cleanup(self, path, err=False):
        # don't clean up the log if there's an error
        extensions = ["", ".aux", ".dvi", ".png", ".log"]
        if err:
            extensions.pop()

        # now do the actual cleanup, passing on non-existent files
        for extension in extensions:
            try:
                os.remove("%s%s" % (path, extension))
            except (IOError, OSError):
                pass

    def run(self, lines):
        """Parses the actual page"""
        # Re-creates the entire page so we can parse in a multine env.
        page = "\n".join(lines)

        # Adds a preamble mode
        preambles = self.re_preamblemode.findall(page)
        for preamble in preambles:
            self.tex_preamble += preamble + "\n"
            page = self.re_preamblemode.sub("", page, 1)
        self.tex_preamble += "\n\\begin{document}\n"

        # Figure out our text strings and math-mode strings
        tex_expr = [(self.re_mathmode, True, x) for x in self.re_mathmode.findall(page)]

        # No sense in doing the extra work
        if not len(tex_expr):
            return page.split("\n")

        # Parse the expressions
        new_cache = {}
        for reg, math_mode, expr in tex_expr:
            simp_expr = filter(unicode.isalnum, expr)
            if simp_expr in self.cached:
                data = self.cached[simp_expr]
            else:
                data = self._latex_to_base64(expr, math_mode)
                new_cache[simp_expr] = data
            expr = expr.replace('"', "").replace("'", "")
            page = reg.sub(IMG_EXPR %
                    (str(math_mode).lower(), simp_expr,
                        simp_expr[:15], data), page, 1)

        # Perform the escaping of delimiters and the backslash per se
        tokens = []
        tokens += [self.config[("delimiters", "preamble")]]
        tokens += [self.config[("delimiters", "text")]]
        tokens += [self.config[("delimiters", "math")]]
        tokens += ['\\']
        for tok in tokens:
            page = page.replace('\\' + tok, tok)

        # Cache our data
        cache_file = open('latex.cache', 'a')
        for key, value in new_cache.items():
            cache_file.write("%s %s\n" % (key.encode('utf8'), value))
        cache_file.close()

        # Make sure to resplit the lines
        return page.split("\n")

class MarkdownLatex(markdown.Extension):
    """Wrapper for LaTeXPreprocessor"""
    def extendMarkdown(self, md, md_globals):
        # Our base LaTeX extension
        md.preprocessors.add('latex',
                LaTeXPreprocessor(self), ">html_block")


def makeExtension(configs=[]):
    """Wrapper for a MarkDown extension"""
    return MarkdownLatex(configs=configs)
