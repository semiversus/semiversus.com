title: Allgemeines zur Atmel AVR Architektur
parent: uebersicht.md

# Allgemeines
Datenblatt Atmel ATMega16 ([Download über Atmel.com](http://www.atmel.com/Images/doc2466.pdf){: class="external" })

Sämtliche Seitenangaben beziehen sich auf dieses Datenblatt (Rev. 2466T–AVR–07/10).

# Fuse und Lock Bits (*Seite 259-261*)
Bei den Fuse Bits handelt es sich um Bits, die während einem Programmiervorgang verändert werden können. Mit den Fuse Bits wird z.B. die Wahl der Taktquelle (intern oder extern, ...) ausgewählt. Der Name *Fuse Bit* kann hier etwas verwirren, da sie nicht wie Sicherungen wirken, die nur einmal programmiert werden können.

Bei den *Lock Bits* handelt es sich um einen Auslese Schutz. Wird ein Mikrocontroller in einem Produkt verwendet, kann es sinnvoll sein, den Programmspeicher-Inhalt vor einem Auslesen zu schützen. Es gibt drei verschiedene Modi dieses Schutzes:

* Programmieren und Auslesen des Programmspeichers erlaubt
* Programmieren erlaubt, aber nicht das Auslesen
* Weder Programmieren noch Auslesen erlaubt.

Diese Lockbits können nur einmal gesetzt werden und dann nicht wieder zurückgesetzt werden.

# Versorgung
Die Versorgungspannung ist abhängig vom verwendeten Typ. Beim ATMega16 gibt es zwei verschiedene Ausführungen (siehe Seite 336):

 | Takt | Versorgung
-|-|-
ATMega16 | bis 16Mhz | 4.5V bis 5.5V
ATMega16L | bis 8Mhz | 2.7V bis 5.5V

Die Stromaufnahme ist abhängig von der Betriebsspannung, der Betriebsart und der Taktfrequenz (siehe Seite 299-311). Generell kann gesagt werden, dass je kleiner die Betriebsspannung und die Taktfrequenz ist, desto kleiner ist der Stromverbrauch. Die verschiedenen Betriebsmodie helfen, den Stromverbrauch zu reduzieren, indem der Microcontroller seinen Betrieb einstellt und in verschiedene Stromsparmodis wechselt.

Bei der Versorgung wird zwischen der digitalen Versorgung für den eigentlichen Mikroprozessorkern und der analogen Versorgung für den ADC unterschieden.

# Reset (*Seite 37-41*)
Während dem Reset werden alle Register auf ihren Anfangszustand zurückgesetzt. Die Programmausführung startet beim Reset Vektor.

Es gibt verschiedene Möglichkeiten, einen Reset durchzuführen:

* **Power-On Reset**: Ein Reset wird durchgeführt, wenn sich die Betriebsspannung unter der Power-on-Reset Spannungsgrenze befindet.
* **External Reset**: Wenn am RESET Pin ein Low-Pegel anliegt, wird ein Reset durchgeführt.
* **Watchdog Reset**: Beim Watchdog des Atmel AVR handelt es sich um einen sogenannten Time-Out Watchdog. Zur Verwendung wird der Watchdog aktiviert. Die Applikation muss in regelmäßigen Zeitintervallen den Watchdog zurücksetzen. Wenn dieses Zeitintervall zu groß ist (z.B. weil die Applikation sich in einer Endlosschleife gefangen hat) wird der Watchdog aktiv und löst einen Reset aus.
* **Brown-Out Reset**: Die Brown-Out Detektion erkennt einen Abfall der Versorgungsspannung. Beim Atmel AVR können über Fuse Bits verschiedene Pegel eingestellt werden (beim ATMega16 2.7V und 4V). Ein Reset wird ausgelöst, wenn die Versorgungsspannung diesen Pegel unterschreitet und die Brown-Out Detektion generell aktiviert ist.
* **JTAG AVR Reset**: Die JTAG Schnittstelle dient dem direkten Zugriff auf die Register des Mikrocontrollers z.B. für Debugging Zwecke. Über diese Schnittstelle kann auch ein Reset ausgelöst werden.

# Takt (*Seite 24-31*)
Für den ATMega16 Mikrocontroller gibt es verschiedene Taktquellen auf der einen und Komponenten, die einen Takt benötigen, auf der anderen Seite.

Komponenten die mit einem Takt versorgt werden sind dabei:

* %%clk_{CPU}%%: Dieser Takt steuert die Abläufe innerhalb des Prozessorkerns und dem SRAM Speicher.
* %%clk_{I/O}%%: Die meisten Peripheriebausteine innerhalb des ATMega16 werden mittels diesem Takt gesteuert. Dazu zählen etwa die USART und der Timer/Counter.
* %%clk_{ADC}%%: Der ADC hat eine eigene Taktversorgung. Dies erlaubt das Anhalten des Prozessor und I/O Taktes, um eine möglichst störungsfreie Analogumsetzung zu ermöglichen.
* %%clk_{ASY}%%: Dieser Takt kann von einem externen 32kHz Quarzoszillator erzeugt werden. Dadurch wird es möglich, eine Echtzeitmessung auch innerhalb eines Stromspar Modus durchzuführen.

Der Watchdog Timer wird von einem eigenen Oszillator betrieben. Die Frequenz ist abhängig von Temperatur und Versorgungsspannung (Seite 321).

Als Taktquellen gibt es verschiedene Möglichkeiten, die per *Fuse Bits* ausgewählt werden:

* Externer Quarz (hoch und niederfrequent)
* Externer RC Oszillator
* Interner RC Oszillator (Kalibrierung über das OSCCAL Register).
* Externes Taktsignal

Zusätzlich zu den Taktquellen sind noch Startzeiten für die einzelnen Taktquellen über die Fuse Bits einstellbar. Diese Startzeiten werden benötigt, da die einzelnen Taktquellen eine bestimmte Zeit benötigen, bis sie auf ihrer Frequenz schwingen. Erst wenn diese Startzeit (Anzahl an definierten Taktzyklen und zusätzliche Verzögerung) vergangen ist, wird der Prozessorkern mit dem Takt versorgt. In der Praxis reicht es meist aus, einfach das Maximum an Startverzögerung einzustellen, da die daraus resultierende Zeit immer unter 100 Millisekunden ist.

# Sleep Modes (*Seite 32-36*)
Der Stromverbrauch jeder Komponente eines Mikrocontrollers besteht aus einem statischen Grundverbrauch (Leckströme, usw.) und einem dynamischen Verbrauch, der durch die Umschaltvorgänge, die vom Taktsignal ausgelöst werden, bestimmt wird. Der dynamische Verbrauch macht den größten Teil aus. Dadurch ist bei niedriger Taktfrequenz auch der Stromverbrauch niedriger. Wird für einen bestimmten Zeitraum der Prozessorkern nicht benötigt, kann dieser durch Abschalten des Prozessortaktes in einen sogenannten Schlafmodus gebracht werden und der Stromverbrauch reduziert sich.

Es stehen verschiedene Stromsparmodi zur Verfügung:

* **Idle**: Prozessor hält, bis ein Interrupt auftritt
* **ADC Noise Reduction**: Solange eine Analogwandlung läuft und kein Interrupt eintritt, wird der Takt des Prozessors und der IO Komponenten gestoppt. Dies verbessert die Messungen, indem Störungen minimiert werden.
* **Standby**: Deaktiviert zusätzlich den ADC Takt, sowie Interrupts für EEPROM/Flash.
* **Power Down** bzw. **Power Save**: In diesem Zustand wird der externe Oszillator gestoppt. Dies ermöglicht eine weitere Stromreduzierung. Tritt ein Interrupt auf, kommt es zu einer Verzögerung, da der Oszillator erst *anlaufen* muss. Dazu wird die durch die Fuse Bits eingestellte Verzögerung verwendet.
