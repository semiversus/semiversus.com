title: Füllstandsmessung
toc: False
next: schrittmotor.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels Megacard wird der Füllstand eines Behälters gemessen. Dazu wird das Projekt aus dem 1. Teil verwendet ([Füllstandsmessung](../teil1/fuellstand.md)).

# Stufe 1
* Es wird eine Frequenzmessung realisiert, die die Frequenz an einem Pin misst
* Ist die Frequenz > 50kHz, dann wird LED 0 eingeschaltet (ansonsten aus)

# Stufe 2
Erweiterung von Stufe 1

* Die Frequenz wird in einen Füllstand umgerechnet (0 - 100%)
* Die Ausgabe erfolgt auf einem Display

# Stufe 3
* Die Frequenzen bei den Füllständen für 0%, 10%, 20% ... 100% werden im Microcontroller hinterlegt
* Anhand dieser Stützstellen wird wird die Frequenz linear interpoliert
* Wird ein Füllstand von 80% überschritten, wird über den Lautsprecher ein Alarmsignal ausgegeben
