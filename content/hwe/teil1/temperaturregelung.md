title: Temperaturregelung
toc: False
next: klavier.md
parent: uebersicht.md

# Kurzbeschreibung
Es soll eine sogenannte [2-Punkt Regelung](https://de.wikipedia.org/wiki/Zweipunktregler) realisiert werden,
die je nach Temperatur zwei Relais ansteuert:
* Ist die Temperatur über der oberen Schwelle, so wird Relais 1 aktiviert
* Ist die Temperatur unter der unteren Schwelle, so wird Releais 2 aktiviert

An die beiden Relais können Lüfter oder Heizelemente angeschlossen werden, um die Temperatur entsprechend zu
vermindern bzw. zu erhöhen.

Anschlüsse:
* Klemme mit 2 Anschlüssen für die Versorgung (9 - 15 Volt)
* Klemme mit 2 Anschlüssen für Relais 1 (Schaltkontakt)
* Klemme mit 2 Anschlüssen für Relais 2 (Schaltkontakt)

# Recherche
Für die Temperaturmessung eignen sich **Heißleiter** (auch NTC Widerstand genannt).
* Wie wird aus der Temperatur eine Spannung abgeleitet?
* Wie schaut die Kennlinie eines Heißleiters aus?

Die durch die Temperaturmessung generierte Spannung muss mit einer oberen und unteren Schwelle verglichen werden.
* Wie lässt sich das realisieren?
* Wie hoch ist die jeweilige Vergleichsspannung für die obere und untere Schwelle

Je nach Temperatur werden zwei Relais angesteuert.
* Wie lassen sich Relais steuern?
* Was ist beim Schalten von induktiven Lasten (Spule des Relais) zu beachten?

# Spezifikation
* Die obere Temperaturschwelle soll bei 30°C liegen, die untere bei 20°C.
* Das Relais soll mindestens 230V AC/5A schalten können
