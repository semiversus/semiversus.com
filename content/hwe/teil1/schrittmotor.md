title: Schrittmotor Ansteuerung
toc: False
next: servotester.md
parent: uebersicht.md

# Kurzbeschreibung
Ein Timer [NE555](https://de.wikipedia.org/wiki/NE555) wird genutzt, um die Schrittfrequenz für einen bipolaren Schrittmotor
zu erzeugen. Der Schrittmotor wird über zwei Vollbrücken angesteuert. Dazu können Treiber ICs verwendet werden (z.B. L297 und L298).

Anschlüsse:

* Klemme mit 2 Anschlüssen für die Versorgung (5 Volt)
* Klemme mit 4 Anschlüssen für den Schrittmotor

# Recherche
Das zentrale Bauteil ist der *NE555*

* Wie ist ein NE555 aufgebaut?
* Wie lässt sich die Frequenz einstellen?

Funktionsweise Schrittmotor

* Wie funktioniert ein bipolarer Schrittmotor?
* In welcher Folge müssen die Spannungen angelegt werden, um den Schrittmotor in eine Richtung zu bewegen?

# Spezifikation
* Die Frequenz des Timers soll bei ca. 100 Hertz liegen
