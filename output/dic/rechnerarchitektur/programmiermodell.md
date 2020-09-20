title: Programmiermodell
parent: uebersicht.md

# Allgemeines
Das *Programmiermodell* (engl. *Instruction Set Architecture* oder kurz *ISA*) beschreibt den Aufbau eines Prozessors als abstraktes Modell. Dazu gehört:

* Beschreibung der Befehle, die der Prozessor ausführen kann
* Codierung der Befehle
* Adressierungsarten
* Aufbau der Register
* Zeitverhalten (Anzahl der benötigten Taktzyklen)

# Befehlssatz
Die Gesamtheit aller Befehle eines Prozessors wird auch Befehlssatz genannt. Je nach Umfang des Befehlssatzes wird zwischen der *CISC* und *RISC* Designphilosophie unterschieden. Bei der *Complex Instruction Set Computer* Philosophie gibt es Befehle, die sehr komplexe Operationen ausführen können. Diese benötigen aber meist mehrere Taktzyklen. Viele klassische Prozessorarchitekturen (zum Beispiel Intel x86, Zilog Z80 und Motorola 68k) gelten als typische Vertreter von Prozessorarchitekturen mit *CISC*-Befehlssätzen.

Der Begriff *CISC* wurde nachträglich eingeführt, um die bis damals vorherrschende Befehlssätze von neuartigen Design zu unterscheiden, die als *RISC* (*Reduced Instruction Set Computer*) Befehlssätze bezeichnet wurden. Bei *RISC* Befehlssätzen wird auf komplexe Befehle verzichtet, dadurch wird ein einfacheres Chipdesign ermöglicht.

## CISC

* benötigt im Vergleich weniger Programmspeicher, da die einzelnen Befehle komplexer sind und dadurch "mehr" ausführen können
* Meist benötigt ein Befehl mehrere Takte

Die Realisierung eines CISC Prozessors wird oft mittels *Mikrocode* realisiert. Zur Ausführung eines Befehl führt das Steuerwerk den entsprechenden Mikrocode aus. Dieser Mikrocode steuert den Datenpfad des Prozessors an. Dadurch können komplexe Befehle realisiert werden.

## RISC
Für die meisten Prozessoren mit *RISC*-Befehlssatz gilt:

* Load-Store Befehle: Speicherzugriffe erfolgen (nur) durch Load bzw. Store Befehle. Dies vereinfacht den Datenpfad
* Befehlsausführung meist in einem Taktzyklus
* Sehr viele frei verwendbare Register
* Befehle haben meist eine feste Länge
* Steuerwerk ist festverdrahtet (vgl. CISC mit Mikrocode)
* unabhängige Verarbeitungseinheiten ermöglichen Pipelining

# Befehle
## Transferbefehle
Transferbefehle werden verwendet, um Information innerhalb eines Prozessors oder über den Speicher zu transferieren. Da die Daten an ihrem Quellort nicht verändert werden ist der Vorgang eigentlich eine Kopie. Je nach Prozessorarchitektur können dies ein- oder mehrere Bytes auf einmal sein.

Eine Sondergruppe bilden Befehle, die mit dem Stack arbeiten. Es können Daten auf den Stack kopiert (<code>push</code>) oder vom Stack geholt (<code>pop</code>) werden.

## Arithmetische und logische Befehle
Bei diesem Befehlen wird eine arithmetische Operation (Addition, Subtraktion, Multiplikation, usw.) oder eine logische Operation (UND-, ODER-Verknüpfung, usw.). Auch Schiebe- und Rotationsoperationen gehören hier dazu. Die Operationen selbst werden im Prozessor mittels einer *Arithmetisch-Logischen Einheit* (engl. *arithmetic logic unit* oder kurz *ALU*) durchgeführt.

## Sprungbefehle
Sprungbefehle dienen zum Ändern des Programmablaufes. Dabei wird zwischen unbedingten und bedingten Sprüngen unterschieden. Unbedingte Sprünge werden immer ausgeführt, bedingte Sprünge sind abhängig von einem Prozessorstatus. Bei Sprüngen wird darüber hinaus zwischen absoluten Sprüngen (referenziert auf die Befehlsspeicheradresse 0) oder relativen Sprüngen (relativ zum aktuellen Befehlszähler) unterschieden. Bei allen Nicht-Sprung Befehlen wird der Programmablauf mit dem nachfolgenden Befehl fortgesetzt.

## Sonstige Befehle
Es gibt noch weitere Befehle, die in keine der aufgeführten Kategorien passen. Dazu zählen Befehle zum Umgang mit Interrupts, aktivierung bestimmter Betriebsarten (z.B. Sleep Modes) oder der häufig vorhandene <code>No Operation</code> Befehl, der während seiner Ausführung keine Änderung vornimmt und somit nur Zeit "verbraucht".

# Adressierungsarten
Die Adressierungsarten beschreiben die Möglichkeiten, wie ein Prozessor auf die Daten für eine Operation zugreift. Dies gilt für die Operanden sowie für das Ergebnis einer Operation.

## Unmittelbare Adressierung
Der benötigte Wert ist unmittelbar im Befehl selbst kodiert. Bei den meisten Prozessorarchitekturen gibt es Befehle, die ein Register mit einem unmittelbaren Wert laden. Auch absolute Sprünge sind meist durch einen Befehl mit unmittelbarer Adressierung realisiert.

## Registeradressierung
Bei der Registeradressierung wird das gewünschte Register angegeben.

## Absolute Adressierung
Bei der absoluten Adressierung wird  eine Adresse im Speicher übergeben. Geladen wird der Wert an dieser Adresse.

## Relative Adressierung
Die Relative Adressierung bezieht sich auf den Befehlszähler und wird für einen relativen Sprung verwendet. Dabei wird ein Wert zum Befehlszähler addiert bzw. subtrahiert.

## Indirekte Adressierung
Bei der indirekten Adressierung wird ein Register adressiert, welches eine Adresse auf den Speicher darstellt. Geladen wird der Wert an dieser Adresse.

Bei der indirekten Adressierung gibt es die Erweiterung, dass die Adresse, die im Register gespeichert ist entweder vor (Prä- ) oder nach (Post- ) der Ausführung des Befehls modifiziert wird. Meistens handelt es sich bei der Modifikation um eine Addition oder Subtraktion um 1 (Inkrement bzw. Dekrement).

## Indizierte Adressierung
Bei der indizierten Adressierung kommen zwei Adressen zum Einsatz. Es wird ähnlich zur indirekten Adressierung ein Register adressiert, welches eine Adresse auf den Speicher darstellt. Zu dieser Adresse wird dann ein unmittelbar kodierter Offset addiert.

## Andere Adressierungsarten
Es gibt ja nach Prozessormodell noch weitere Adressierungsarten. Es ist genauso möglich, dass ein Prozessor eine der oben angeführten Adressierungsarten nicht unterstützt.

Für Signalprozessoren steht meist eine Modulo-Adressierung zur Verfügung. Dies entspricht einer Indirekten Adressierung mit einer Modifizierung der Adresse im Register, wobei für die Berechnung der neuen Adresse eine Modulo-Operation durchgeführt wird. Dadurch lassen sich effiziente Ringspeicher erzeugen.

# Anzahl der Operanden
Befehlssätze können je nach Anzahl der Operanden, die ein Befehl nutzt, in Kategorien eingeteilt werden.

## Drei-Adress Architektur
Bei dieser Architektur kann ein Befehl bis zu drei Adressen nutzen. Dabei werden zwei Adressen für die Operanden und die dritte Adresse für das Ergebnis genutzt.

Beispiel (MIPS Architektur):

    addi $t1, $t0, 1 # $t1=$t0+1

## Zwei-Adress Architektur
Bei dieser Architektur stehen zwei Adressen pro Befehl zur Verfügung, wobei für viele Operationen eine Adresse für den Operand und gleichzeitig für das Ergebnis genutzt wird.

Beispiel (AVR Architektur):

    add r24, r25 ; r24=r24+r25

## Ein-Adress Architektur
Bei dieser Architektur spricht man auch vom *Akkumulator*-Rechner, da sämtliche Rechenoperationen nur über das *Akkumulator*-Register laufen.

Beispiel (68HC11 Architektur)

    adda $48 ; Addiere den Wert an der Speicherstelle 0x48 zum Akkumulator

## 0-Adress Architektur
Die 0-Adress Architektur ist ein Spezialfall, bei der ein Befehl keine Operanden adressieren kann. Eine Realisierungsvariante ist ein Stack-Prozessor, der selbst keine Register besitzt, sondern alle Operationen am Stack ausführt. Um Werte auf den Stack zu bekommen ist allerdings die unmittelbare Adressierung notwendig.

Beispiel (picoJava-II Architektur)

    iadd ; Hole zwei Integer vom Stack, addiere diese und lege diese wieder ab

Typische Stack Maschinen haben Befehle wie <code>push</code> und <code>pop</code> um Daten auf den Stack zu legen oder vom Stack zu entfernen. Rechenoperationen wie <code>add</code>, <code>mult</code>, <code>sub</code>, usw. holen zwei Werte vom Stack, führen mit diesen die Rechenoperation aus und legen das Ergebnis wieder am Stack ab.

Die Rechenoperation 4+5*(3+6) kann dabei folgenderweise realisiert werden:

    push 4
    push 5
    push 3
    push 6
    add ; addiert 3 und 6 und legt das Ergebnis 9 wieder am Stack ab
    mult ; multipliziert 5 und 9 und legt das Ergebnis 45 wieder am Stack ab
    add ; addiert 45 und 4 und legt das Ergebnis 49 wieder am Stack ab

Nach der Ausführung liegt nur mehr ein Wert am Stack und dies ist das Ergebnis.
