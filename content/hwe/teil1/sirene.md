title: Sirene
toc: False
parent: uebersicht.md

# Kurzbeschreibung
Das Sirenensignal besteht aus einem sich in der Frequenz änderndem Rechtecksignal. Konkret soll zwischen zwei Frequenzen
umgeschalten werden.

Realisieren lässt sich das ganze mittels zwei Timer. Ein Timer [NE555](https://de.wikipedia.org/wiki/NE555) dient als
Rechteckgenerator. Ein zweiter moduliert die Frequenz des ersten.

Anschlüsse:

* Klemme mit 2 Anschlüssen für die Versorgung (9 - 15 Volt)
* Klemme mit 2 Anschlüssen für den Lautsprecher

# Recherche
Das zentrale Bauteil ist der *NE555*

* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?
* Wie lässt sich die Frequenz durch einen zweiten Timer ändern?

# Spezifikation
* Die Sirene soll zwischen den beiden Frequenzen 440 Hz und 563 Hz jede Sekunde wechseln
* Die Versorgungsspannung soll bei 5 Volt liegen, welche mittels Linearregler aus der Eingangsspannung "erzeugt" wird
