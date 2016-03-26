title: VHDL Übung 6 - Clicker
next: uebung7.md
parent: uebersicht.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird das BASYS2 Board verwendet"
    Für weitere Fragen zum Board bitte das [Manual]({filename}basys2_manual.pdf){: class="download" } konsultieren.

* Definition einer Zustandmaschine
* Integration der Komponenten im Top Level

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_6.compress){: class="download" } herunterladen und entpacken
* Projekt `clicker.xise` öffnen

# Aufbau des Top Levels
## Spezifikation
Im ersten Schritt soll ein Design erstellt werden, das über zwei Tasten angesteuert wird:

* `tap` - Mit dieser Taste wird das Spiel gestartet und während des Spiels werden die Tastendrücke gezählt
* `reset` - Diese Taste führt zum Spielanfang

Das Spiel kennt drei Zustände:

* `CLEARED` - Der initiale Zustand, alle Zähler werden gelöscht. Der Tastendruck von `reset` führt immer hierher.
* `RUNNING` - Das Spiel läuft für 60 Sekunden. Die Anzahl der Tastendrücke von `tap` wird mitgezählt.
* `STOPPED` - Nach den 60 Sekunden werden die Zähler angehalten (und somit das Ergebnis angezeigt)

Für dieses Spiel lassen sich viele Komponenten von [Übung 5 (Stoppuhr)]({filename}uebung5.md) wiederverwenden.

## Implementierung
Im folgenden Bild ist die gesamte Schalung und das Zustandsdiagramm zu sehen. Das Ziel ist eine Implementierung im Top
Level. Orientierung bietet [Übung 5]({filename}uebung5.md).

![Blockschaltbild und FSM]({filename}uebung6.jpg)
