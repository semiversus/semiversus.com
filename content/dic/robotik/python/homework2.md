title: Python Hausübung 2
parent: uebersicht.md

# TODO App

Verwende folgendes Template um mit der Übung zu starten: [Download]({static}todo.zip)

Erstellt wird eine TODO App. Die Verwendung sieht hier als Beispiel so aus:

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

1. Ordner aus `todo.zip` entpacken
1. Mittels Visual Studio Code den Ordner öffnen
1. Im Terminal mittels `python.exe -m venv .venv` den Ordner für die virtuelle Umgebung erstellen
1. Mittels `.venv/Scripts/activate.bat` die virtuelle Umgebung starten
1. Die erforderlichen Packete mittels `pip.exe install -r requirements.txt`

## Spezifikation

Die Applikation soll folgende Befehle unterstützen:
* `add *Text*` - fügt ein Element zur Todo Liste hinzu
* `remove *Index*` - Index (als Zahl) entfernt den entsprechenden Eintrag aus der Todo Liste
* `list` - Listet alle Elemente der Todo Liste auf
* `help` - Gibt einen Hilfetext aus, der kurz jeden Befehl beschreibt
* `exit` - Beendet die Applikation (verläßt die `input_loop` Funktion und liefert die Liste als Rückgabewert)

Weitere Spezifikationspunkte:
* Wenn `remove` mit einem ungültigen Wert aufgerufen wird, soll die Liste nicht verändert werden (aber auch sonst keine Ausgabe gemacht werden)
* `list`, `help` und `exit` sollen zusätzliche Argumente ignorieren
* Wenn ein ungültiger Befehl eingegeben wird (z.B. `att` statt `add`) soll der Ausgabetext von `help` ausgegeben werden