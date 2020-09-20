title: Externe Interrupts beim Atmel AVR
parent: uebersicht.md

!!! panel-info "Diese Seite beschreibt die externen Interrupts des ATMega16"
    Prinzipiell lässt sich diese Information auch auf andere Mikrocontroller der AVR Serie übertragen, es empfiehlt sich
    aber die Informationen mit dem entsprechenden Datenblatt zu vergleichen!

!!! panel-info "Informationen im Datenblatt"
    Die Informationen dieser Seite entstammen dem originalen [Datenblatt]({filename}atmel_atmega16.pdf){: class="download" }
    (Rev. 2466T–AVR–07/10) des ATMega16 von Atmel.

    * *Seite [68-70]({filename}atmel_atmega16.pdf){: class="download" }*: Externe Interrupts

# Allgemeines

Der ATMega16 hat drei Pins, die einen *externen Interrupt* auslösen können. *Extern* bedeuted in diesem Fall, dass die
eigentliche Interruptquelle nicht innerhalb des Mikrocontrollers ist, sondern eben extern.

# Pinbelegung
Die drei Pins sind in der folgenden Pinbelegung markiert.
<figure><img src="{filename}avr_ext_interrupt_pins.svg"><figcaption>Externe Interrup Pins beim AVR (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

* <code>INT0</code> - PORT D - Bit 2
* <code>INT1</code> - PORT D - Bit 3
* <code>INT2</code> - PORT B - Bit 2 (zusätzliche Mehrfachbelegung mit dem analogen Komperator)

Bei entsprechender Konfiguration kann ein Interrupt ausgelöst werden, wenn sich der Pegel am entsprechenden Pin ändert.

# Register zur Konfiguration
## MCUCR
Der Grund für das Auslösen eines Interrupts bei den beiden externen Interrupts INT0 und INT1 wird über das Register <code>MCUCR</code> (MCU Control Register) gesteuert.

Bit|7|6|5|4|**3**|**2**|**1**|**0**
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|SM2|SE|SM1|SM0|**ISC11**|**ISC10**|**ISC01**|**ISC00**
Read/Write|R/W|R/W|R/W|R/W|**R/W**|**R/W**|**R/W**|**R/W**
Init|0|0|0|0|**0**|**0**|**0**|**0**

Dazu haben wir vier verschiedene Konfigurationsmöglichkeiten für INT0 und INT1:

ISCx1 | ISCx0 | Beschreibung
-|-|-
0|0|Löst bei logisch <code>0</code> Pegel aus
0|1|Löst bei deiner Pegeländerung aus (steigende oder fallende Flanke)
1|0|Löst bei fallende Flanke (Pegeländerung von logisch '1' auf '0')
1|1|Löst bei steigender Flanke (Pegeländerung von logisch '0' auf '1')

## MCUCSR
Der externe Interrupt für INT2 wird über das Register <code>MCUCSR</code> (MCU Control and Status Register) gesteuert.

Bit|7|**6**|5|4|3|2|1|0
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|JTD|**ICS2**|-|JTRF|WDRF|BORF|EXTRF|PORF
Read/Write|R/W|**R/W**|R|R/W|R/W|R/W|R/W|R/W
Init|0|0|0|-|-|-|-|-

Ist <code>ISC2</code> auf logisch <code>0</code> wird der Interrupt bei einer fallenden Flanke ausgelöst. Bei logisch <code>1</code> wird entsprechend
bei einer steigenden Flanke ausgelöst.

## GICR
Die Freigabe der Interrupts erfolgt über das Register <code>GICR</code> (General Interrupt Control Register).

Bit|**7**|**6**|**5**|4|3|2|1|0
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|**INT1**|**INT0**|**INT2**|-|-|-|IVSEL|IVCE
Read/Write|**R/W**|**R/W**|**R/W**|R|R|R|R/W|R/W
Init|**0**|**0**|**0**|0|0|0|0|0

Die Bits INT0, INT1 und INT2 aktivieren die Interruptfreigabe.

Für den Aufruf der entsprechenden Interruptrountine sind nun folgende Punkte notwendig:

* Das entsprechende Bit bei <code>GICR</code> ist gesetzt, damit der Interrupt freigegeben ist
* Über <code>sei()</code> wurde die globale Interruptfreigabe aktiviert (siehe [Interrupts]({filename}avr_interrupts.md) im Skriptum)
* Eine Pegeländerung entsprechend der Konfiguration unter <code>MCUCR</code> bzw. <code>MCUCSR</code> tritt beim entsprechenden Pin auf

## GIFR
Über dieses Register kann das Statusflag beim entsprechenden Interrupt abgefragt werden. Dies ist notwendig, wenn die
Detektion einer Pegeländerung genutzt werden soll, aber keine Interrupt Service Routine aufgerufen werden soll.

Bit|**7**|**6**|**5**|4|3|2|1|0
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|**INTF1**|**INTF0**|**INTF2**|-|-|-|-|-
Read/Write|**R/W**|**R/W**|**R/W**|R|R|R|R|R
Init|**0**|**0**|**0**|0|0|0|0|0

Tritt die konfigurierte Pegeländerung auf wird das entsprechende <code>INTFx</code> Flag gesetzt. Zurückgesetzt wird das Flag,
indem entwededer die Interrupt Service Routine aufgerufen wurde oder indem man eine logische <code>1</code> an das entsprechende
Bit schreibt.

# Beispiel
In diesem Beispiel wird folgendes konfiguriert:

* INT0 reagiert auf eine fallende Flanke und nutzt die entsprechende Interrupt Service Routine
* INT1 reagiert auf jeden Pegelwechsel und fragt den Zustand per *Polling* über das *GIFR* Register ab
* INT2 wird nicht genutzt

Umsetzung:

    #!c
    #include <avr/interrupt.h>

    ISR(INT0_vect) {
      // Interrupt Service Routine für INT0
      // ...
    }

    int main(void) {
      MCUCR=0x06; // entspricht 0b0000 01 10 -> INT0 löst bei fallender Flanke aus, INT1 bei jedem Pegelwechsel
      MCUCSR=0x00; // entspricht 0b0 0 000000 -> INT2 löst bei fallender Flanke aus (wird aber nicht genutzt)
      GICR=0x40; entspricht 0b010 00000 -> INT0 Interrupt ist freigegeben, INT1 und INT2 nicht

      sei(); // globale Interruptfreigabe

      while(1) {
        // Hauptschleife

        if (GIFR&0x80) { // überprüfe Zustand von INT1
          GIFR|=0x80; // setze Flag für INT1 zurück
          // ...
        }

        // ...
      }

      return 0;
    }
