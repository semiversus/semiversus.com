title: Künstliche Intelligenz spielt Super Mario
date: 2017-01-10
tags: Projekte
image: nesolution_tb.png

Optimierung von Systemen kann sehr schnell zu einer komplexen Aufgabe werden. Schwierig wird es, wenn Variablen nicht mehr getrennt voneinander optimiert werden können, sondern einander beeinflussen.

Die Standardansätze der Optimierung reichen oft nicht aus, wenn das zu optimierende System eine oder mehrere der folgenden Eigenschaften hat:

* Lokale Minima/Maxima
* Abhängige Variablen
* Sehr große Anzahl an Variablen
* Abbruch zu jedem Zeitpunkt, mit dem bis dorthin besten Ergebnis

Evolutionäre Algorithmen finden für solche Systeme Lösungen auf eine effiziente Art und Weise. Der Ablauf entspricht dem Namen nach der Evolutionstheorie und wiederholt sich in folgender Reihenfolge:

1. Reproduktion - bestehende Lösungen bilden die Basis für neue Lösungen
2. Mutation - die einzelnen Lösungen werden zufällig verändert
3. Selektion - die einzelnen Lösungen werden bewertet und die besten ausgewählt

# Nesolution
<iframe width="560" height="315" src="https://www.youtube.com/embed/D3tzE5VU0bU" frameborder="0" allowfullscreen></iframe>

Das Projekt Nesolution (auf Github) nutzt die Emulation einer Spielkonsole um mittels eines evolutionären Algorithmus Spiele mit einem vorgegebenen Ziel zu spielen. Dazu werden Tastenfolgen als Muster gespeichert und durch den Emulator abgespielt. Während der Emulation wird mit einer Bewertungsfunktion das Ergebnis beurteilt.

Beim Start wird mit einem leeren Muster der Tastenfolgen gestartet. Davon werden Kopien gemacht, die jeweils zufällig verändert werden. Jede dieser veränderten Kopien wird nun emuliert und bewertet. Zum Schluss wird die Kopie mit dem besten Ergebnis als Basis für die nächste Iteration genutzt.

Das Projekt steht als freie Software unter [Github](https://github.com/semiversus/nesolution) zur Verfügung.
