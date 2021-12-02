title: Schrittmotoransteuerung
toc: False
next: micropython.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels Megacard wird ein Schrittmotor angesteuert. Die Hardware (Schrittmotortreiber und Schrittmotor) werden zur Verfügung gestellt.

# Stufe 1
* Der Schrittmotor soll sich mit einer konstanten Frequenz (1kHz) in eine Richtung drehen

# Stufe 2
Erweiterung von Stufe 1

* Mittels zwei Taster wird die Drehrichtung vorgegeben
* Die Bewegung wird dabei "aufgezeichnet"
* Nach dem Drücken einer dritten Taste wird die aufgezeichnete Bewegung wieder abgespielt

# Stufe 3
Erweiterung von Stufe 2

* Die Frequenz des Schrittmotor wird nicht konstant ausgegeben, sondern über eine lineare Rampe erhöht bzw. verringert
  * 0% - 100% und umgekehrt in 2 Sekunden
* Die aktuelle Position und Frequenz wird auf einem Display ausgegeben
