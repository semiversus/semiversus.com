title: Pomodoro Timer
toc: False
next: wuerfel.md
parent: uebersicht.md

# Kurzbeschreibung
Die [Pomodoro Technik](https://de.wikipedia.org/wiki/Pomodoro-Technik) ist eine Methode des Zeitmanagments.

Mittels des Bausteins Timer [NE555](https://de.wikipedia.org/wiki/NE555) wird eine [monostabile Kippstufe](https://de.wikipedia.org/wiki/NE555#Monostabile_Kippstufe)
betrieben. Beim Drücken einer Taste soll die LED für mehrere Minuten leuchten.

Anschlüsse:

* Klemme mit 2 Anschlüssen für die Versorgung (9 - 15 Volt)

# Recherche
Das zentrale Bauteil ist der *NE555*

* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?
* Welche Probleme kommen auf, wenn die Zeitdauer mehrere Minuten umfasst

# Spezifikation
* Die Zeitdauer soll bei 10 Minuten liegen
* Die Genauigkeit soll bei +/-20 Sekunden liegen
* Die Versorgungsspannung soll bei 5 Volt liegen, welche mittels Linearregler aus der Eingangsspannung "erzeugt" wird
