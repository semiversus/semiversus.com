title: Codeschloss
toc: False
next: servo.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels Megacard wird ein Codeschloss implementiert.

# Stufe 1
* Mittels der vier Tasten wird ein vierstelliger Code vorgegeben (z.B. **A**-**D**-**B**-**A**)
* Werden die Tasten in der richtigen Reihenfolge gedrückt, schalten alle LEDs ein (Schloss geöffnet)
* Bei jedem Tastendruck ertönt ein kurzer Bestätigungston
* Zuvor eingegebene falsche Codes werden ignoriert - folgende richtige Eingabe soll aber erkannt werden
  * So führt die Eingabe von D-C-**A**-**D**-**B**-**A**
* Das Schloss wird wieder geschlossen, wenn eine Tasteneingabe beim geöffnenten Schloss erfolgt (alle LEDs wieder aus)

# Stufe 2
Erweiterung von Stufe 1

* Wenn der Code richtig eingegeben wurde kann ein neuer Code programmiert werden
  * Dazu muss eine Taste für länger als 1 Sekunde gedrückt werden
  * Dies wird mit einem Signalton bestätigt
* Für die neue Codeeingabe werden die Tasten in der gewünschten Reihenfolge gedrückt
* Nach der Neueingabe schließt sich das Schloss wieder und der neue Code muss eingegeben werden

# Stufe 3
Erweiterung von Stufe 2

* Mittels externem Display wird die Codeeingabe sowie der aktuelle Status sichtbar gemacht
* Der Code soll im EEPROM gespeichert werden
