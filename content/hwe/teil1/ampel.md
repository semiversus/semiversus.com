title: Ampel
toc: False
next: verstaerker.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels 3 LEDs (grün, gelb und rot) soll das Ampelbild dargestellt werden. Dazu wird eine digitale
Logik aufgebaut, die zur Ansteuerung der LEDs dient (siehe [Automatentheorie]({filename}/dic/grundlagen_der_digitaltechnik/automatentheorie.md)).

Ein Timer [NE555](https://de.wikipedia.org/wiki/NE555) dient als Taktgeber.

Im folgenden die Anzahl der Takte der einzelnen Phasen:
* grün - 7 Takte
* gelb - 1 Takt
* rot - 7 Takte
* rot und gelb - 1 Takt

Anschlüsse:

* Klemme mit 2 Anschlüssen für die Versorgung (5 Volt)

# Recherche
Das zentrale Bauteil ist der *NE555*

* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?

# Spezifikation
* Die Frequenz des Timers soll bei ca. 1 Hertz liegen
