echo "Markdown"
echo "  WIR:"
find -name \*.md|xargs grep -i " wir " -l
echo "  MAN:"
find -name \*.md|xargs grep -i " man " -l
echo "  Tabs:"
find -name \*.md|xargs grep -P "\t" -l
echo "  Listen:"
find -name \*.md|xargs grep -Pzo "\n[^\*\n\# <]+[^\n]+\n\* .*" -l
echo "  Überschrift ohne Leerzeichen nach '#':"
find -name \*.md|xargs grep "^#\+[A-Za-z0-9]" -l
echo "  Kein \"parent\":"
find content/dic content/projekte -name \*.md|xargs grep "^parent:" -L
echo "VHDL und C"
echo "  Leerzeicheneinrückung:"
find -name \*.vhd -or -name \*.[ch]|xargs grep "  " -l
echo "  end für entity/architecture/process:"
find -name \*.vhd|xargs grep "end"|grep -v "architecture"|grep -v "entity"|grep -v "process"|grep -v "if"|grep -v "case"|grep -v "loop"
echo "Zeilenenden"
find -name \*.vhd -or -name \*.[ch]|xargs file|grep " LF"
