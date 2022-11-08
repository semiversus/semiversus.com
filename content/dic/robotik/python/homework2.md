title: Python Hausübung 2
parent: uebersicht.md

# TODO App (3 Punkte)

Verwende folgendes Template um mit der Übung zu starten: [Download]({filename}todo.zip)

Erstellt wird eine TODO App. Die Verwendung sieht hier als Beispiel so aus:

    #!bash
    > add WDIC Hausübung
    > add Äpfel einkaufen
    > list
    1. WDIC Hausübung
    2. Äpfel einkaufen
    > add "Krieg und Frieden" lesen
    > remove 2
    > list
    1. WDIC Hausübung
    2. "Krieg und Frieden" lesen
    > exit

Im Beispiel enthalten sind auch Unittests, die die vorhandene Spezifikation testen.

## Erstellen der virtuellen Umgebung

1. Ordner aus <code>todo.zip</code> entpacken
1. Mittels Visual Studio Code den Ordner öffnen
1. Im Terminal mittels <code>python.exe -m venv .venv</code> den Ordner für die virtuelle Umgebung erstellen
1. Mittels <code>.venv/Scripts/activate.bat</code> die virtuelle Umgebung starten
1. Die erforderlichen Packete mittels <code>pip.exe install -r requirements.txt</code>

## Spezifikation

Die Applikation soll folgende Befehle unterstützen:

* <code>add *Text*</code> - fügt ein Element zur Todo Liste hinzu
* <code>remove *Index*</code> - Index (als Zahl) entfernt den entsprechenden Eintrag aus der Todo Liste
* <code>list</code> - Listet alle Elemente der Todo Liste auf
* <code>help</code> - Gibt einen Hilfetext aus, der kurz jeden Befehl beschreibt
* <code>exit</code> - Beendet die Applikation (verläßt die <code>input_loop</code> Funktion und liefert die Liste als Rückgabewert)

Weitere Spezifikationspunkte:

* Wenn <code>remove</code> mit einem ungültigen Wert aufgerufen wird, soll die Liste nicht verändert werden (aber auch sonst keine Ausgabe gemacht werden)
* <code>list</code>, <code>help</code> und <code>exit</code> sollen zusätzliche Argumente ignorieren
* Wenn ein ungültiger Befehl eingegeben wird (z.B. <code>att</code> statt <code>add</code>) soll der Ausgabetext von <code>help</code> ausgegeben werden

## Test mittels pytest

Ihr könnt eure Applikation mittels <code>pytest</code> testen. Richtet dafür einfach die virtuelle Umgebung ein und startet im Terminal von Visual Studio Code <code>pytest</code>.

## Zusatzpunkt (1 Punkt)

Schreibe eine Funktion <code>build_hashtag_dict</code>, die eine Liste mit Strings als Argument nimmt und eine Liste der Hashtags zusammenstellt.

Hier ein Beispiel:

    #!python
    >>> items = ['#Hausübung WDIC', 'Matheübung #korrigieren', '#Hausübung Deutsch #korrigieren', 'Ausschlafen']
    >>> build_hashtag_dict(items)
    {'Hausübung': ['#Hausübung WDIC', '#Hausübung Deutsch #korrigieren'], 'korrigieren': ['Matheübung korrigieren', '#Hausübung Deutsch #korrigieren']}

Abgabe über Teams.