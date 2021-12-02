title: PS2 Keyboard
toc: False
next: wecker.md
parent: uebersicht.md

# Kurzbeschreibung
Die Signale einer PS/2 Tastatur sollen ausgelesen werden und über eine UART Übertragen werden.

# Stufe 1
* Mittels Adapter wird eine PS2 Tastatur an die Megacard angesteckt
* Informationen zur PS/2 Ansteuerung finden sich [hier](https://www.marjorie.de/ps2/ps2.pdf)
* GPIOs werden entsprechend konfiguriert
* Wird das Drücken der Taste 'A' erfolgreich erkannt, wird eine LED aktiviert

# Stufe 2
Erweiterung von Stufe 1

* Das Drücken einer Taste führt zum Senden des entsprechenden ASCII Codes über die UART
* Die UART arbeitet mit 9600 Baud (8N1)

# Stufe 3
* Auf einem externen Display wird der eingegeben Text angezeigt
* Dabei soll auch die Rückstelltaste richtig funktionieren
* *Enter*-Taste löscht den angezeigten Text