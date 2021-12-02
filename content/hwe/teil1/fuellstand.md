title: Füllstandmessung
toc: False
next: pomodoro.md
parent: uebersicht.md

# Kurzbeschreibung
Die Änderung der Kapazität zwischen zwei leitenden Platten ist eine Möglichkeit den Füllstand in einem Behälter
zu messen (siehe [kapazitive Füllstandsmessung](https://de.wikipedia.org/wiki/Kapazitive_F%C3%BCllstandmessung)).

Mittels des Bausteins Timer [NE555](https://de.wikipedia.org/wiki/NE555) wird eine [astabile Kippstufe](https://de.wikipedia.org/wiki/NE555#Astabile_Kippstufe)
betrieben. Die Frequenz des erzeugtenRechtecksignal ist dann abhängig vom Füllstand im Behälter.

Anschlüsse:

* Klemme mit 2 Anschlüssen für die Versorgung (9 - 15 Volt)
* Klemme mit 2 Anschlüssen für die zwei leitenden Platten zur Füllstandsmessung.
* Klemme mit 2 Anschlüssen als Ausgang (Rechtecksignal)

# Recherche
Ein wichtiger Punkt ist die Dimensionierung der Mess-Kapazität

* Wie wirken sich Abstand und Fläche auf die Kapazität aus
* Wie erreicht man eine Kapazität bei einem leeren Behälter von ca. 500pF?
* Wie ändert sich die Kapazität beim Füllen des Behälters mit Wasser?

Das zentrale Bauteil ist der *NE555*

* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?

# Spezifikation
* Die Ausgabefrequenz soll bei ca. 100kHz bei einem leeren Behälter liegen
* Die Versorgungsspannung soll bei 5 Volt liegen, welche mittels Linearregler aus der Eingangsspannung "erzeugt" wird
