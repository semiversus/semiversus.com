title: Analog-Digital Konverter beim Atmel AVR
parent: uebersicht.md

!!! panel-info "Diese Seite beschreibt den ADC des ATMega16"
    Prinzipiell lässt sich diese Information auch auf andere Mikrocontroller der AVR Serie übertragen, es empfiehlt sich
    aber die Informationen mit dem entsprechenden Datenblatt zu vergleichen!

!!! panel-info "Informationen im Datenblatt"
    Die Informationen dieser Seite entstammen dem originalen [Datenblatt]({filename}atmel_atmega16.pdf){: class="download" }
    (Rev. 2466T–AVR–07/10) des ATMega16 von Atmel.

    * *Seite 204-221*: ADC
        * *Seite 204-205*: Übersicht und Blockschaltbild
        * *Seite 217-221*: Registerbeschreibung

# Allgemeines
Die wichtigsten Eigenschaften des ADC:

* 10 Bit Auflösung
* Bis zu 15 Tausend Wandlungen pro Sekunde
* 8 gemultiplexte Eingänge (in Kombination zu 7 differentiellen Messungen und 2 mit Verstärkung von 10 oder 200)
* Messungen bis V<sub>CC</sub>
* Integrierte 2.56 V Referenzspannung

# Aufbau
<figure><img src="{filename}avr_adc.svg"><figcaption>Blockschaltbild des ADC (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

## Eingänge
Im linken unteren Segment sind die Eingänge, die über Multiplexer zum eigentlichen ADC geführt werden. Der Multiplexer "*Pos. Input Mux*" kann zwischen den 8 Pins *ADC0* bis *ADC7* sowie Masse und einer *Bandgap*-Referenz (typ. 1.23 V) wählen.

Für differentielle Messungen wird jeweils ein zweiter Kanal benötigt, der über den Multiplexer "*Neg. Input Mux*" ausgewählt wird. Der positive und negative Kanal wird durch eine einstellbare Verstärkung (*Gain Amplifier*) zu einem Multiplexer geführt, der auswählt, ob eine sog. *Single Ended* oder eine differentielle Messung durchgeführt wird.

## AD Wandlung
Der ADC arbeitet mittels einer 10 Bit sukzessiven Approximation. Dazu wird ein 10 Bit DAC schrittweise auf die zu messende Spannung eingestellt. Mit jedem Bit mehr Auflösung wird über einen Komperator (*Sample & Hold Comperator*) entschieden, ob das nächste Bit 0 oder 1 sein soll. Als Konsequenz dieses Ablaufs benötigt diese Art von ADC mehrere Takte für die Umwandlung.

## Referenz
Als Referenz stehen drei Quellen zur Verfügung:

* Die analoge Betriebsspannung AVCC
* Die interne 2.56 Volt Referenzspannung
* Eine externe Referenzspannung am Pin AREF

# Register
## Register <code>ADMUX</code>

![Register ADMUX]({filename}avr_adc_admux.svg)

Das Register <code>ADMUX</code> steuert die Auswahl der Referenzspannung, der Anordnung der Datenbits und die Auswahl des zu messenden Kanals.

Wird als Referenzspannung die interne 2.56 Volt Referenz oder die Betriebsspannung AVCC gewählt empfiehlt es sich, an den Pin AREF einen Kondensator zu schalten, um Rauschen zu minimieren und die Referenzspannung möglichst stabil zu halten. In diesen zwei Fällen sollte auf keinen Fall eine externe Spannung am Pin AREF anliegen!

Die Anordnung der Datenbits mittels <samp>ADLAR</samp> kann je nach Anwendung eingestellt werden. Wird der 10 Bit Wert verwendet, kann beim <samp>avr-gcc</samp> Compiler mittels <samp>ADC</samp> auf die Kombination von <samp>ADCH</samp> und <samp>ADCL</samp> zugegriffen werden. Wenn einzeln auf die Register zugegriffen wird muss <samp>ADCL</samp> vor <samp>ADCH</samp> ausgelsen werden.

## Register <code>ADCSRA</code>

![Register ADCSRA]({filename}avr_adc_adcsra.svg)

### <samp>ADEN</samp> - ADC Enable

Schaltet den ADC ein.

### <samp>ADSC</samp> - ADC Start Conversion

Um eine Wandlung zu starten wird dieses Bit mit <code>1</code> beschrieben. Beim Lesen liefert dieses Bit eine <code>1</code> solange eine Wandlung läuft.

### <samp>ADATE</samp> - ADC Auto Trigger Enable

Es gibt zahlreiche Möglichkeiten, eine Wandlung durch Trigger starten zu lassen. Weitere Infos dazu finden sich im Datenblatt. Hier wird ausschließlich das Starten einer Wandlung durch die Firmware selbst beziehungsweise ein erneutes Starten nach einer Wandlung beschrieben.

### <samp>ADIF</samp> - ADC Interrupt Flag

Wenn eine Wandlung beendet wurde wird dieses Bit auf <code>1</code> gesetzt. Eine eventuell aktivierte Interruptroutine des ADCs setzt dieses Bit wieder auf <code>0</code>, sobald die entsprechende Interruptroutine aufgerufen wurde. Wird ohne Interrupts gearbeitet kann mittels schreiben einer <code>1</code> auf dieses Bit das Bit zurückgesetzt werden.

### <samp>ADIE</samp> -ADC Interrupt Enable

Aktiviert den ADC Interrupt (siehe Beispiele)

### <samp>ADPS2:0</samp> - ADC Prescaler Select Bits

Wählt den Teiler für die Wandlung des ADCs. Der ADC arbeitet mit einer Frequenz zwischen 50kHz und 200kHz. Diese Frequenz wird aus dem Prozessortakt und diesem Teiler erzeugt.

%%f_{ADC}=\frac{f_{CLK}}{Teiler}%%

# Umrechnung

Bei der Umrechnung einer Spannung am Eingang des ADC hin zum Wert als Zahl wird die Eingangsspannung im Verhältnis zur
Referenzspannung betrachtet und entsprechend der Auflösung (in Bits} des ADC umgewandelt:

%%Wert_{ADC}=\frac{U_{Eingang}}{U_{Referenz}} \cdot 2^{Bits}%%

Der Umgekehrte Fall ist dann die Umrechnung von einem Wert in die anliegende Spannung:

%%U_{Eingang}=\frac{Wert_{ADC}}{2^{Bits}} \cdot U_{Referenz}%%

Beim ATMega16 ist die Auflösung 10 Bit, d.h. es können %%2^{10}=1024%% *verschiedene Spannungen unterschieden* werden.

# Beispiele
Im folgenden Beispiel wird an Kanal 5 (Port A5) die Spannung gemessen. Als Referenz dient die Spannung am Pin AREF. Vom
10 Bit Ergebnis werden die oberen 8 Bit auf dem Port C ausgegeben.

## Ohne Interrupt

    #!c
    #include <avr/io.h>

    int main (void) {
      DDRC  = 0xFF;   // Port C.0-7 = Ausgang
      PORTC = 0x00;   // LEDs loeschen

      ADMUX = 0x05;                                 // Eingang 5 festlegen
      ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1); // ADC enable, Teiler auf 64
      while (1) {
        ADCSRA |= (1<<ADSC);          // ADC Wandlung starten
        while(!(ADCSRA & (1<<ADIF))); // Auf Abschluss der Konvertierung warten (ADIF-bit)
        PORTC = ADC>>2;               // Ausgabe der oberen 8 Bit auf PORTC
      }
      return 0;
    }

## Mit Interrupt
Bei jedem Aufruf der Interruptservice Routine <code>ADC_vect</code> wird das Ergebnis der AD Wandlung ausgewertet (mittels <code>ADC</code>) und
eine neue Wandlung gestartet.

    #!c
    #include <avr/io.h>
    #include <avr/interrupt.h>

    ISR(ADC_vect) {
      PORTC = ADC>>2;           // Ausgabe der oberen 8 Bit auf PORTC
      ADCSRA |= (1<<ADSC);      // ADC Wandlung starten
    }

    int main (void) {
      DDRC  = 0xFF;   // Port C.0-7 = Ausgang
      PORTC = 0x00;   // LEDs loeschen

      ADMUX = 0x05;   // Eingang 5 festlegen
      ADCSRA = (1<<ADEN) | (1<<ADSC) | (1<<ADIE) | (1<<ADPS2) | (1<<ADPS1); // ADC enable,
                                        //Wandlung starten, Interrupt enable, Teiler auf 64
      sei();

      while (1) {
        // main loop
      }
      return 0;
    }
