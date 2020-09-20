title: Funktionale Einheiten eines Prozessors
parent: uebersicht.md

# Allgemeines
Ein Rechner besteht aus verschiedenen Komponenten, die je nach Rechnerarchitektur unterschiedlich aufgebaut sind. Allgemein kann man aber folgende Komponenten Unterscheiden:

* Prozessorkern
* Programm- und Datenspeicher
* Peripherie Einheiten

Man spricht von einer Von-Neumann Architektur wenn Programme- und Datenspeicher in einem gemeinsamen Adressraum liegen. Da bei einem Befehl, der auf den Datenspeicher zugreift, insgesamt zwei Speicherzugriffe notwendig sind (Befehl selbst aus dem Speicher holen, Zugriff auf Daten), ergibt sich die Notwendigkeit, dass der Befehl mindesten zwei Takte benötigt. Dies wird auch als *Von-Neumann Flaschenhals* bezeichnet. Da historisch die Geschwindigkeit der Prozessoren wesentlich schneller stieg als die Geschwindigkeit der Speicherzugriffe wurde dieser Flaschenhals immer relevanter.

Ein Verbesserung bringt die Aufteilung in einen Programmspeicher und einen Datenspeicher, die unabhängig voneinander arbeiten können. Dies ist die *Harvard*-Architektur. Der Programmspeicher kann als Nur-Lese Speicher realisiert werden.

# Datenpfad
Der Prozessorkern besteht aus einem Datenpfad und einem Steuerwerk. Der Datenpfad enthält die Register und Datenspeicher, das Rechenwerk und die Busse zwischen den einzelnen Komponenten.

## Register
Bei Registern unterscheidet man zwischen Registern für einen speziellen Zweck oder sogenannten Registern zur allgemeinen Verwendung (*GPR* für engl. *General Purpose Register*).

Register mit speziellem Zweck sind unter anderem:

* *Akkumulator* - enthält die Ergebnisse des Rechenwerks
* *Stackpointer* - wird als Adresse auf den aktuellen Wert im Stack verwendet
* *Indexregister* - ein Register, welches generell zur Adressierung verwendet wird
* *Befehlszähler* - Adresse des aktuellen (bzw. meist nächsten) Befehls
* *Befehlsregister* - nimmt den aktuellen Befehl auf

## Rechenwerk
Das Rechenwerk dient der Manipulation von Daten. Dazu steht eine arithmetisch-logische Einheit (*ALU* für engl. *Arithmetic Logic Unit*) zur Verfügung. Diese ALU unterstützt verschiedene Rechenoperationen. Zusätzlich ist ein Register mit Statusflags vorhanden, die abhängig vom letzten Ergebnis der ALU gesetzt werden (Überlauf, Null, ...).

Typische Operationen die eine ALU durchführen kann:

* Addition
* Subtraktion
* Zweierkomplement
* Logische AND, OR, XOR Vernüpfung
* Invertierung
* Schiebeoperationen

Typische Statusflags sind:

* *Übertrag* (*C* für engl. *Carry*): Kommt es bei einer Operation zu einem Übertrag, wird das Übertragsbit in diesem Flag gespeichert
* *Überlauf* (*V* für engl. *oVerflow*): Stellt die Zahlenbereichsüberschreitung für Zweier-Komplement Operanden dar
* *Null* (*Z* für engl. *Zero*): Dieses Flag wird gesetzt, wenn das Ergebnis gleich 0 ist
* *Negativ* (*N* für engl. *Negative*): Bei der Zweierkomplement-Darstellung stellt das MSB das Vorzeichen dar (0: positiv, 1: negativ)

## Datenspeicher
Der Datenspeicher ist meist so ausgelegt, dass während einem Takt ein Lese- oder Schreibzugriff durchgeführt werden kann. Dazu legt der Prozessor eine Adresse an und leitet einen Lese- oder Schreibzugriff ein.

## Busse
Die Register und Funktionseinheiten sind über Busse miteinander verbunden. Ein Bus kann entweder als Punkt-zu-Punkt Verbindung implementiert werden. Dabei dienen Multiplexer als Schalter zwischen zwei verschiedenen Eingaben. Es gibt aber auch die Realisierung von Bussen, auf die mehrere Teilnehmer mittels Tri-State Ausgangstreiber zugreifen können.

# Steuerwerk
Das Steuerwerk steuert den Ablauf im Datenpfad. Um einen Befehl Abzuarbeiten nimmt man typischerweise einen Von-Neumann-Zyklus an. Je nach Prozessorarchitektur können die 5 Teilschritte zusammengefasst werden oder auch ein Teilschritt auf mehrere Takte ausgeweitet werden.

## Fetch Instruction (1)
Der aktuell vom Befehlszähler adressierte Befehl wird aus dem Befehlsspeicher in das Befehlsregister geladen. Der Befehlszähler wird erhöht, um auf den nächsten Befehl zu zeigen.

## Decode (2)
Der Befehl wird durch den Instruktionsdekoder ausgewertet. Die entsprechenden Steuersignale für den Datenpfad werden gesetzt.

## Fetch Operands (3)
Die Operanden für die Berechnung werden aus den Registern bzw. aus dem Speicher geholt.

## Execute (4)
Die Operation wird vom Rechenwerk durchgeführt. Wenn der aktuelle Befehl ein Sprungbefehl ist, wird der Befehlszähler mit der Sprungadresse geladen.

## Write Back (5)
Die Ergebnisse werden in die Register bzw. den Speicher zurückgeschrieben (sofern notwendig).

Die einzelnen Teilschritte können durch Pipelining parallelisiert werden. Dazu ist es notwendig, den einzelnen Teile im Datenpfad unabhängig zu realisieren.

## Realisierung
Das Steuerwerk kann auf zwei verschiedene Arten realisiert werden:

* *Fest verdrahtet*: Die Logik für die einzelnen Befehle ist beim Design mittels konkreter Logik realisiert
* *Mikrocode*: Das Steuerwerk ist selbst ein kleiner Prozessor, der für jeden Befehl einen sogenannten Mikrocode hinterlegt hat, der ausgeführt wird.

Die Realisierung mittels Mikrocode ist sehr flexibel und es besteht die Möglichkeit, bei schon ausgelieferten Prozessoren nachträglich die Mikrokodierung zu verändern. Der Nachteil ist der langsamer Ablauf im Vergleich zur fest verdrahteten Logik.

