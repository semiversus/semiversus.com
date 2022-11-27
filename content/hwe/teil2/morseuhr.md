title: Morseuhr
toc: False
next: keyboard.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels Megacard wird eine Uhr implementiert, wobei die aktuelle Zeit mittels [Morsecode](https://de.wikipedia.org/wiki/Morsecode) über den Lautsprecher
ausgegeben wird.

# Stufe 1
* Im ersten Schritt wird ein Zähler implementiert und der aktuelle Stand per Morsecode ausgegeben
* Nach dem Reset startet die Ausgabe mit 0 (▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄), dann 1 (▄ ▄▄▄ ▄▄▄ ▄▄▄ ▄▄▄), usw.

# Stufe 2
Erweiterung von Stufe 1

* Nach dem Reset startet die Uhrzeit bei "00:00"
* Nach jeder Minute wird die neue Uhrzeit wieder ausgegeben
* Mittels der vier Taster kann die Uhrzeit angepasst werden (Stunde +/-, Minute +/-)

# Stufe 3
Erweiterung von Stufe 2

* Auf einem externen Display wird die aktuelle Uhrzeit angezeigt
* Die Uhr wird um eine Datumsausgabe erweitert
* Für die Uhrzeit und Datumseingabe wird das Display und die Tasten sinnvoll genutzt
