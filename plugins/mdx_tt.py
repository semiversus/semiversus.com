from markdown.inlinepatterns import Pattern, BACKTICK_RE
from markdown import util
import markdown

class BacktickPattern(Pattern):
    """ Return a `<var>` element containing the matching text. """
    def __init__ (self, pattern):
        Pattern.__init__(self, pattern)
        self.tag = "code"

    def handleMatch(self, m):
        el = util.etree.Element(self.tag)
        el.text = util.AtomicString(m.group(3).strip())
        return el

class TTExtension (markdown.Extension):
    def extendMarkdown(self, md, md_globals):
        self.md = md
        md.inlinePatterns["backtick"] = BacktickPattern(BACKTICK_RE)

def makeExtension(config=[]):
    return TTExtension(config)
