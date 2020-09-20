title: AVR Assembler
parent: uebersicht.md

!!! panel-info "Übungsblatt"
    Zu diesem Teil gibt es [Übungsaufgaben]({filename}uebung_avr_assembler.md)

# Allgemeines
Der Befehlssatz des Atmel AVR ist ein typischer *RISC*-Befehlssatz. Bei der Entwicklung der AVR Reihe stand vor allem eine möglichst effiziente Nutzung durch C-Compiler im Vordergrund.

* [Komplette Übersicht](http://www.atmel.com/images/Atmel-0856-AVR-Instruction-Set-Manual.pdf){: class="external" } über den Befehlssatz von Atmel
* [Auszug]({filename}avr_assembler_befehle.pdf){: class="download" } der wichtigsten Befehle

## Blockschaltbild
<figure><img src="{filename}avr_blockschaltbild.svg"><figcaption>Blockschaltbild des AVR (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

Im Blockschaltbild des Atmel AVR ATMega16 erkennt man am oberen und unteren Ende die vier IO-Ports.

Rund um den Prozessorkern (*AVR CPU*) befindet sich folgende Peripheriebausteine:

* ADC, mit Multiplexer auf die Pins von Port A
* I²C Schnittstelle (TWI - Two Wire Interface) auf Port C
* Timer/Counter
* Watchdogtimer mit dem internen Oszillator
* *MCU Ctrl. & Timing* - zuständig für den Prozessortakt und Reset
* Interrupt Einheit
* EEPROM
* USART auf Port D
* SPI auf Port B
* Komperator

Diese Peripheriebausteine sind über einen Adress/Datenbus mit dem Prozessorkern verbunden.

Der Prozessorkern besteht aus dem Flash Speicher für das eigentliche Programm und dem SRAM für die Laufzeitvariablen.
Der Programmzeiger (*Program Counter*) zeigt auf den aktuellen Befehl der vom *Instruction Register* zwischengespeichert
wird und durch den *Instruction Decoder* dekodiert wird.

Der *Stack Pointer* dient zum Ablegen von Werten und Rücksprungadressen im SRAM. Für Berechnungen mit der
*ALU* werden die Register R0 bis R31 genutzt. 3 16Bit Indexregister (X, Y und Z) dienen der indirekten Adressierung
des SRAMs. Das Statusregister ist unter anderem für die Flags der ALU zuständig (*Carry*, *Overflow*, usw.).

Im Prozessorkern sieht man auch die Harvardarchitektur, da der SRAM Speicher und der Flash Speicher durch getrennte
Adress/Datenbusse angesteuert werden.

# Registersatz
Die AVR Serie besitzt 32 allgemein verwendbare Register(<code>R0</code> bis <code>R31</code>). Die Register <code>R0</code> bis <code>R15</code> sind nicht verfügbar
für Befehle mit unmittelbaren Konstanten (z.B. <code>ldi</code>-load immediate).

Die Register <code>R27:R26</code> bilden gemeinsam das 16 Bit X-Register, wobei <code>R27</code> das höherwertige Byte darstellt und <code>R26</code> das
niederwertige. Neben dem X-Register gibt es analog das Y und Z Register:

* <code>R27:R26</code>: X-Register
* <code>R29:R28</code>: Y-Register
* <code>R31:R30</code>: Z-Register

Diese Register können für die indirekte Adressierung genutzt werden.

# Stack Pointer
Der Stack Pointer ist eine 16 Bit Adresse und zeigt auf die aktuelle Position im Stack. Auf dem Stack werden die
Rücksprungadressen bei einem <code>call</code>-Befehl und bei einem Interruptaufruf gespeichert. Zusätzlich kann der Stack genutzt
werden, um Register zu sichern oder Zwischenergebnisse zu speichern.

Der Stackpointer muss vor dem ersten Zugriff initialisiert werden. Dazu wird er an das Ende des Datenspeichers gesetzt.
Der AVR Assembler unterstützt das Symbol <code>RAMEND</code>, das die letzte Adresse des Datenspeichers darstellt. Die Makros <code>HIGH</code>
und <code>LOW</code> liefern die oberen bzw. unteren 8 Bit eines 16 Bit Wertes.

    ldi R16, HIGH(RAMEND)
    out SPH, R16
    ldi R16, LOW(RAMEND)
    out SPL, R16

# Adressräume
Bedingt durch die Harvard-Architektur der AVR Serie gibt es eine Trennung der Adressräume für den Befehlsspeicher (Flash), den Datenspeicher (SRAM) und dem EEPROM.

## Befehlsspeicher
Der Adressraum im Befehlsspeicher wird in folgende Bereiche unterteilt:

* **Interruptvektoren**: Sprungmarken für Reset und die Interruptquellen
* **Programmspeicher**: Nach den Interruptvektoren befindet sich das eigentliche Programm
* **Optionaler Bootloader**: Ein Teil des Befehlsspeichers kann geschützt und als Bootloader verwendet werden

## Datenspeicher

Adresse | Beschreibung
-|-
<code>0x00-0x1F</code> | Register <code>R0</code> bis <code>R31</code>
<code>0x20-0x5F</code> | I/O Register 0x00 bis 0x3F
<code>0x60</code>-Ende des internen SRAM | als Datenspeicher verwendbar

## EEPROM
Das EEPROM wird mittels I/O Register angesprochen.

# Befehlsübersicht
## Transferbefehle
### Kopieren von Registern mittels <code>mov</code>
Kopiert den Inhalt des Registers Rr in das Register Rd.

    mov r0, r16 ; Kopiert den Inhalt von R16 nach R0

Eine spezielle Variante ist <code>movw</code> . Hier werden zwei Register gleichzeitig kopiert, wobei als Basisregister nur geradzahlige Register möglich sind.

    movw r17:r16, r1:r0 ; Kopiert Register R1 nach R17 und Register R0 nach R16

### Laden von Registern mittels <code>ld</code>
Beim Laden gibt es mehrere Möglichkeiten der Adressierung der Quelle. Soll ein Konstante geladen werden, wird <code>ldi</code> verwendet.

    ldi R16, 0x20 ; Lädt den Wert 0x20 in das Register R16

Soll von einer bestimmten Speicheradresse geladen werden, wird <code>lds</code> verwendet.

    lds R0, 0x60 ; Lädt den Wert an der Adresse 0x60 ins Register R0

Die Register X,Y und Z können zum indirekten Laden von Werten verwendet werden. Dabei wird der Inhalt der Register als Adresse verwendet und an der Wert von der entsprechenden Adresse im Speicher geladen. Weiters ist es möglich, die Adresse nach dem Zugriff um 1 zu erhöhen (Post-Inkrement) oder vor dem Zugriff um 1 zu erniedrigen (Pre-Dekrement).

    ld r0, X ; Lädt den Wert an der durch das Register X dargestellten Adresse
    ld r1, Y+ ; Erhöht nach dem Laden das Y Register um 1
    ld r3, -Y; Erniedrigt vor dem Laden das Y Register um 1

Für den Zugriff auf Tabellen oder auf den Stack Frame eignet sich das Laden mittels Displacment. Dabei wird das Y oder Z Register verwendet und ein Offset hinzugerechnet.

    ldd r4, Y+20 ; Lädt den Wert an der durch Y+20 dargestellten Adresse

### Speichern von Werten im SRAM
Beim Speichern auf eine bestimmte Speicheradresse wird der Befehl <code>sts</code> benutzt.

    sts 0x60, R0 ; Speichert den Wert des Registers R0 an der Adresse 0x60

Ähnlich zu den *Load* Befehlen kann auch die indirekte Adressierung über X,Y und Z Register verwendet werden.

    st X, r0 ; Speichert das Register an der durch das Register X dargestellten Adresse
    st Y+, r1 ; Erhöht nach dem Speichern das Y Register um 1
    st -Y, r1; Erniedrigt vor dem Speichern das Y Register um 1

### Zugriff auf I/O Register
Der Zugriff auf I/O Register erfolgt mittels <code>in</code> und <code>out</code>.

    out PORTD, R0 ; Kopiere den Wert von R0 ins IO Register PORTD
    in R29, PINA   ; Kopiere den Wert des IO Registers PINA ins Register R29

### Arbeiten mit dem Stack
Der Stackpointer wird in den beiden Register <code>SPH</code> und <code>SPL</code> gespeichert. Mittels <code>push</code> und <code>pop</code> können Werte auf den Stack gelegt bzw. wieder vom Stack geholt werden. Der Stack wird außerdem genutzt, um die Rücksprungadresse bei Subroutinen-Aufrüfen mittels <code>call</code> bzw. <code>rcall</code> zu speichern.

## Arithmetische Befehle
Arthmetische Befehle verknüpfen üblicherweise entweder zwei Register miteinander oder ein Register mit einer Konstante.

Als Operationen stehen die Addtion (<code>add</code>) und Subtraktion (<code>sub</code>) zur Verfügung. Es gibt auch jeweils eine Veriante, in der das Übertragsbit aus einer vorhergehenden Operation verwendet wird (<code>adc</code> bzw. <code>sbc</code>). Für die Addition der Konstante 1 stehen die Befehle <code>inc</code> (Inkrement) bzw. <code>dec</code> (Dekrement) zur Verfügung.

## Logische Befehle
Zu den logischen Befehlen gehört die AND Verknüpfung (<code>and</code> bzw. <code>andi</code>), die ODER Verknüpfung (<code>or</code> bzw. <code>ori</code>), die Exclusive-ODER Verknüpfung (<code>eor</code>) und die Invertierung aller Bits (<code>com</code>).

## Sprünge
### Unbedingte Sprünge
Bei unbedingten Sprüngen ist der Sprung nicht von einer Bedingung abhängig. Es gibt relative Sprünge (<code>rjmp</code>) und absolute Sprünge (<code>jmp</code>). Die relativen Sprünge können den Befehlszähler um +/-2048 verändern. Dies benötigt zwar eine entsprechende Berücksichtigung vom Assembler bzw. Compiler aus, stellt aber durch die kompaktere Ausführung (ein Befehlswort statt zwei) eine Optimierung dar.

### Bedingte Sprünge
Die bedingten Sprünge bedienen sich der Überprüfung von Flags aus dem Statusregister und entscheiden anhand deren Zustandes, ob der Sprung genommen wird oder nicht. Häufig genutzt werden hier <code>breq</code> (branch if equal), <code>brne</code> (branch if not equal), <code>brlo</code> (branch if lower) und <code>brsh</code> (branch if same or higher).

Die Statusflags müssen durch einen vorhergehenden Befehl entsprechend gesetzt werden. Will man kein Register für einen Vergleich ändern, sondern nur die Statusflags, so eignet sich der <code>cp</code> (compare) Befehl. Dieser Vergleicht zwei Register mittels Subtraktion und setzt die Flags entsprechend.
