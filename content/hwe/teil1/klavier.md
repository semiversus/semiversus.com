title: Klavier
toc: False
next: fuellstand.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels des Bausteins Timer [NE555](https://de.wikipedia.org/wiki/NE555) soll ein Klavier aufgebaut werden.
Dazu wird der Timer Baustein als [astabile Kippstufe](https://de.wikipedia.org/wiki/NE555#Astabile_Kippstufe)
betrieben, um ein Rechtecksignal zu erzeugen. Mittels 7 Tasten soll die Frequenz entsprechend eingestellt werden.

Anschlüsse:
* Klemme mit 2 Anschlüssen für die Versorgung (9 - 15 Volt)
* Klemme mit 2 Anschlüssen für den Lautsprecher

# Recherche
Das zentrale Bauteil ist der *NE555*
* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?

Die Frequenzen soll der C-Dur Tonleiter entsprechen
* Wie errechnen sich die Frequenzen einer Tonleiter?
* Wie wird sich die Toleranz der Bauteile auf die Frequenz auswirken?

# Spezifikation
* Die Frequenz der einzelnen Töne soll auf 10 [Cent](https://de.wikipedia.org/wiki/Cent_(Musik)) genau sein
