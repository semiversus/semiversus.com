title: Timer beim Atmel AVR
parent: uebersicht.md

!!! panel-info "Diese Seite beschreibt die Timer des ATMega16"
    Prinzipiell lässt sich diese Information auch auf andere Mikrocontroller der AVR Serie übertragen, es empfiehlt sich
    aber die Informationen mit dem entsprechenden Datenblatt zu vergleichen!

!!! panel-info "Informationen im Datenblatt"
    Die Informationen dieser Seite entstammen dem originalen [Datenblatt]({filename}atmel_atmega16.pdf)
    (Rev. 2466T–AVR–07/10) des ATMega16 von Atmel.

    * *Seite 71-86*: Timer0 (8 Bit)
        * *[Seite 71]({filename}atmel_atmega16.pdf#page=71)*: Übersicht und Blockschaltbild
        * *[Seite 76-80]({filename}atmel_atmega16.pdf#page=76)*: Betriebsmodi
        * *[Seite 83-86]({filename}atmel_atmega16.pdf#page=83)*: Registerbeschreibung
    * *Seite 89-116*: Timer1 (16 Bit)
        * *[Seite 89]({filename}atmel_atmega16.pdf#page=76)*: Übersicht und Blockschaltbild
        * *[Seite 101-107]({filename}atmel_atmega16.pdf#page=101)*: Betriebsmodi
        * *[Seite 110-116]({filename}atmel_atmega16.pdf#page=110)*: Registerbeschreibung
    * *Seite 117-134*: Timer2 (8 Bit)
        * *[Seite 117]({filename}atmel_atmega16.pdf#page=117)*: Übersicht und Blockschaltbild
        * *[Seite 122-125]({filename}atmel_atmega16.pdf#page=122)*: Betriebsmodi
        * *[Seite 128-130]({filename}atmel_atmega16.pdf#page=128)*: Registerbeschreibung

# Allgemeines
Ein *Timer* ist ein spezieller Zähler, der Ereignisse zählt. Diese Ereignisse können sich auch vom Prozessortakt ableiten
und von daher kommt die Bezeichnung *Timer*. Prinzipiell ist ein Timer für folgende Aufgaben geeignet:

* Zeiten zwischen zwei Ereignissen messen
* Nach einer bestimmten Zeit ein Ereignis auslösen
* Periodische Ereignisse auslösen
* Ereignisse zählen
* Erzeugung von PWM Signalen

Diese Funktionalitäten werden in der Praxis sehr oft benötigt. Die universellen Einsatzmöglichkeiten haben allerdings
den Nachteil, dass der Timer teilweise recht komplex in der Anwendung sein kann.

Der ATMega16 enthält drei Timer. Timer 0 und 2 sind 8 Bit Timer, Time 1 ist ein 16 Bit Timer.

# Timer 0 (8 Bit Timer)
<figure><img src="{filename}avr_timer0.svg"><figcaption>Blockschaltbild des Timer 0 (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

Das Blockschaltbild des Timer 0 zeigt den prinzipiellen Aufbau des Timers welcher im folgenden beschrieben wird.

## Interrupts
Der Timer 0 nutzt zwei Interruptquellen:

* `TIMER0_OVF_vect` (im Blockschaltbild TOV0) - Löst aus, sobald es zu einem Überlauf des Timer Registers `TCNT0` kommt
* `TIMER0_COMP_vect` (im Blockschaltbild OC0) - Löst aus, sobald das Timer Register `TCNT0` gleich `OCR0` ist

## `TCNT0` - Timer Counter Register 
Dieses Register ist der Kern des Timers. Beim Timer 0 ist dieses Register 8 Bit groß, d.h. es kann von 0 bis 255 zählen.

`TCNT0` kann direkt gelesen und geschrieben werden. Die Steuerung (Control Logic) hat die Möglichkeit, dieses
Register auf 0 zu setzen oder das Register um eins zu erhöhen oder zu erniedrigen.

Die Steuerung ist abhängig von der Konfiguration über `TCCR0` und dem Status der Vergleiche mit 0, mit 0xFF und dem
Vergleich mit `OCR0`.

## `OCR0` - Vergleichsregister 
Das Register `OCR0` ist ein 8 Bit Register das für den Vergleich mit `TCNT0` genutzt wird. Der Vergleich kann für drei 
Funktionen benutzt werden:

* Die Generierung eines PWM Signals mittels *Waveform Generetion* am Pin *OC0*
* Das Auslösen des Interrupts `TIMER0_COMP_vect` bei Äquvivalenz mit `TCNT0`
* Die Auswertung mittels der Steuerung des Timer 0

## `TCCR0` - Timer Counter Control Register 

Bit|7|6|5|4|3|2|1|0
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|FOC0|WGM00|COM01|COM00|WGM01|CS02|CS01|CS00
Read/Write|W|R/W|R/W|R/W|R/W|R/W|R/W|R/W
Init|0|0|0|0|0|0|0|0

### FOC
Spezielles Bit zur Ausführung eines *Compare Match* in nicht PWM Modi. Für weitere Informationen dazu ist im Datenblatt
nachzulesen.

### WGM01 und WGM00 - Betriebsmodi
Diese beiden Bits beschreiben die Betriebsmodi des Timers:

Modus|WGM01|WGM00|Bezeichnung
-!|-|-!|-
0|0|0|Normaler Modus
1|0|1|PWM, Phasenkorrekt
2|1|0|CTC
3|1|1|Fast PWM

Die verschiedenen Modi sind unter "<a href="#betriebsmodi_1">Betriebsmodi</a>" ausführlich beschrieben.

### COM01 und COM00 - Funktion des *OC0* Pins
Beschreibt die Funktionsweise des Pins *OC0*. Sind beide Bits auf `0` wird der Pin als normaler Portpin verwendet
(Port B Bit 3). Bei anderen Kombinationen ist der *Compare Match Output Mode* aktiv und die normale Portfunktion wird
überschrieben. Weitere Informationen finden sich unter [PWM Erzeugung]({filename}avr_pwm.md).

### CS02, CS01 und CS00 - Clock Select

CS02|CS01|CS00|Bezeichnung
-|-|-!|-
0|0|0|Kein Takt (Timer ist quasi abgeschaltet)
0|0|1|Prozessortakt
0|1|0|Prozessortakt / 8
0|1|1|Prozessortakt / 64
1|0|0|Prozessortakt / 256
1|0|1|Prozessortakt / 1024
1|1|0|Fallende Flanke an Pin T0
1|1|1|Steigende Flanke an Pin T1

## `TIMSK` - Timer Interrupt Mask Register

Über das *Timer Interrupt Mask Register* werden die Interruptfreigaben für alle drei Timer gesetzt. Für den Timer0 gibt
es wie bereits beschrieben die beiden Interrupts `TOIE0` (Timer Overflow) und `OCIE0` (Output Compare Match). Um den
jeweiligen Interrupt zu aktivieren muss eine logische `1` an die entsprechende Stelle geschrieben werden.

Bit|7|6|5|4|3|2|**1**|**0**
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|OCIE2|TOIE2|TICIE1|OCIE1A|OCIE1B|TOIE1|**OCIE0**|**TOIE0**
Read/Write|R/W|R/W|R/W|R/W|R/W|R/W|**R/W**|**R/W**
Init|0|0|0|0|0|0|**0**|**0**

# Betriebsmodi
## Normaler Modus
Bei diesem Modus zählt der Timer bis zum Maximum seines Zählbereiches (255 bzw. 65535). Der Timer kann so konfiguriert
werden, dass beim Erreichen dieses Maximums der `TIMERn_OVF_vect` ausgelöst wird.

Die Frequenz, mit der ein Overflow bei Verwendung des Prozessortakts als Taktquelle auftritt ergibt sich mit:

%%f_{TOVF}=\frac{f_{CLK}}{Prescaler\cdot N_{max}}%%

Als Prescaler stehen dabei 1, 8, 64, 256 und 1024 zur Verfügung. %%N_{max}%% ist dabei 256 für 8 Bit Timer und 65536 für 
16 Bit Timer.

Der Interrupt TIMERn_COMPx_vect kann aktiviert werden und wird ausgelöst, sobald das Timerregister `TCNTn` den
Vergleichswert `OCRn` erreicht.

## CTC - Clear Timer on Compare
Hier zählt der Timer nach oben bis zum Erreichen des `OCRn` Registers. Das Register `TCNTn` wird beim Erreichen
zurückgesetzt. Der Timer kann so konfiguriert werden, dass beim Erreichen des `OCRn` Wertes der `TIMERn_COMPx_vect`
ausgelöst wird.

Die Frequenz, mit der ein *Compare Match* bei Verwendung des Prozessortakts als Taktquelle auftritt ergibt sich mit:

%%f_{COMP}=\frac{f_{CLK}}{Prescaler\cdot (OCRn + 1)}%%

## Fast PWM 
Beim Fast PWM zählt der Timer bis zum Maximum seines Zählberreichs. Das Register `OCRn` dient als Vergleich und abhängig
davon, ob `TCNTn` kleiner oder größer `OCRn` ist, kann der OCn Pin auf logisch `0` oder `1` gesetzt werden. Mehr dazu im Kapitel [PWM Erzeugung]({filename}avr_pwm.md).

## PWM, Phasenkorrekt
Siehe auch hier im Kapitel [PWM Erzeugung]({filename}avr_pwm.md).

# Pins

<figure><img src="{filename}avr_timer_pins.svg"><figcaption>Pins mit Timerfunktionalität (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>
