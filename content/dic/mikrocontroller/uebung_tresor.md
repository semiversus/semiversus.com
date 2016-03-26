title: Aufgabe Tresor
parent: uebersicht.md

# Aufgabenstellung

Es ist mittels der Megacard und der vorgegebenen Hardwareabstraktion ein Codeschloss zu implementieren.

* Die Ausgabe erfolgt über das direkt an der Megacard angeschlossene Display
* Die Eingabe erfolgt über die vier Taster S0 bis S3

Für die Implementierung wird folgende herangehensweise empfohlen:

* Zeiche den Zustandsdiagramm händisch auf
* Gib den Zustände Namen, die man als C Code Enumerationen verwenden kann (z.B. `STATE_WRONG_INPUT`)
* Nimm das Beispiel des [Weckers]({filename}/dic/mikrocontroller/embedded_watch.zip){: class="download" } als Vorlage
* Konzentriere dich anfangs auf die reine Eingabe und Überprüfung des Codes. Erweitere dann die Implementierung um die Zustände "Neuer Code 1" bis "Neuer Code 4".

# Funktionsweise
Direkt nach dem Einschalten soll der Code `1234` sein (entspricht dem Drücken der Tasten S0, S1, S2 und S3).

## Startzustand
* Das Display gibt `CLOSED` aus
* Ein Drücken der Tasten S0 bis S3 bewirkt die Codeeingabe der ersten Stelle. Nun wird in den nächsten Zustand gewechselt (Codeeingabe 1).

## Codeeingabe 1
* Das Display gibt `CLOSED` und in der zweiten Zeile `*` aus
* Ein Drücken der Tasten S0 bis S3 bewirkt die Codeeingabe der zweiten Stelle. Nun wird in den nächsten Zustand gewechselt (Codeeingabe 2).

## Codeeingabe 2
* Das Display gibt `CLOSED` und in der zweiten Zeile `**` aus
* Ein Drücken der Tasten S0 bis S3 bewirkt die Codeeingabe der dritten Stelle. Nun wird in den nächsten Zustand gewechselt (Codeeingabe 3).

## Codeeingabe 3
* Das Display gibt `CLOSED` und in der zweiten Zeile `***` aus
* Ein Drücken der Tasten S0 bis S3 bewirkt die Codeeingabe der vierten Stelle. Der eingegebene Code wird jetzt überprüft und in den Zustand "Offen" oder "Falsche Eingabe" gewechselt.

## Falsche Eingabe
* Das Display gibt `WRONG` und in der zweiten Zeile `CODE` aus
* Nach zwei Sekunden oder bei einem Tastendruck wird in den Startzustand gewechselt

## Offen
* Das Display gibt `OPEN` aus
* Wird für 3 Sekunden keine Taste gedrückt wechselt das System in den Startzustand
* Wird eine der Tasten S0 bis S3 gedrückt wird damit die erste Stelle eines neuen Code eingegeben. Das System wechselt in den Zustand "Neuer Code 1"

## Neuer Code 1
* Das Display gibt `NEW CODE` und in der zweiten Zeile die bereits eingegebene Stelle des Codes aus (z.B. `3`)
* Wird für 3 Sekunden keine Taste gedrückt, wird kein neuer Code eingestellt und das System wechselt in den Startzustand
* Wird eine der Tasten S0 bis S3 gedrückt wird damit die zweite Stelle des neuen Code eingegeben. Das System wechselt in den Zustand "Neuer Code 2"

## Neuer Code 2
* Das Display gibt `NEW CODE` und in der zweiten Zeile die bereits eingegebene Stelle des Codes aus (z.B. `30`)
* Wird für 3 Sekunden keine Taste gedrückt, wird kein neuer Code eingestellt und das System wechselt in den Startzustand
* Wird eine der Tasten S0 bis S3 gedrückt wird damit die dritte Stelle des neuen Code eingegeben. Das System wechselt in den Zustand "Neuer Code 3"

## Neuer Code 3
* Das Display gibt `NEW CODE` und in der zweiten Zeile die bereits eingegebene Stelle des Codes aus (z.B. `302`)
* Wird für 3 Sekunden keine Taste gedrückt, wird kein neuer Code eingestellt und das System wechselt in den Startzustand
* Wird eine der Tasten S0 bis S3 gedrückt wird damit die vierte Stelle des neuen Code eingegeben. Das System wechselt in den Zustand "Neuer Code 4"

## Neuer Code 4
* Das Display gibt `NEW CODE` und in der zweiten Zeile die bereits eingegebene Stelle des Codes aus (z.B. `3021`)
* Nach zwei Sekunden oder bei einem Tastendruck wird der neue Code übernommen und in den Startzustand gewechselt
