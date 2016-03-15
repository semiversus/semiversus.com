title: Interrupts bei Atmel AVR
parent: uebersicht.md

!!! panel-info "Diese Seite beschreibt die Interrupts des ATMega16"
    Prinzipiell lässt sich diese Information auch auf andere Mikrocontroller der AVR Serie übertragen, es empfiehlt sich
    aber die Informationen mit dem entsprechenden Datenblatt zu vergleichen!

# Allgemeines 
*Interrupts* ermöglichen eine Unterbrechung des "normalen" Programmablaufs, um auf Änderungen zu reagieren.

## Polling
Überlegen wir uns folgende Situation:
Es ist 23 Uhr und wir müssen um 6:15 Uhr aufstehen. Neben unserem Bett steht eine Uhr. Wir haben nun die Möglichkeit
einfach immer wieder auf diese Uhr zu schauen, um zu überprüfen, ob es mittlerweile 6:15 Uhr ist. Dies ist eine sehr
stupide Herangehensweise und wir können nicht einfach einschlafen, da wir den Zeitpunkt nicht verpassen sollen. Wir
können sehr wohl etwas anderes nebenbei machen, z.B. Lesen. Wir müssen aber immer wieder auf die Uhr schauen.

Dieser Vorgang nennt sich **Polling**. Ein Mikrocontrollerprogramm prüft in jedem Hauptschleifendurchlauf, ob es zu
einer Zustandsänderung gekommen ist.

Dieses System hat einige Nachteile:

* Die Überprüfung benötigt Zeit und diese Zeit wird bei jedem Hauptschleifendurchlauf *"verbraucht"*
* Die Schlafmodies des Mikrocontrollers können nicht benutzt werden, um Strom zu sparen
* Zwischen zwei Überprüfungen benötigt die Hauptschleife Zeit für den Rest und es ist nur in diesen Abständen möglich zu prüfen

Es gibt auch Vorteile:

* Es kann zu keinem Ressourcenkonflikt zwischen Interrupt und Hauptprogramm kommen
* Ein Interruptaufruf benötigt auch Zeit. Bei sehr kurzen Hauptschleifen kann *Polling* durchaus eine kürzere Reaktionszeit haben
* Es steht auch auf Systemen ohne Interrupts zur Verfügung

## Interrupts
Im oben beschriebenen Beispiel mit der Uhr wäre ein Interrupt vergleichbar mit dem Alarm eines Weckers. Der Wecker kann
auf 6:15 Uhr gestellt werden und wir können uns auf andere Tätigkeiten konzentrieren oder auch komplett Schlafen. Die
Konfiguration des Weckers ist gut vergleichbar mit der Konfiguration von Interrupts.

In einem Mikrocontroller gibt es fest vorgegebene *Quellen* für Interrupts. Der ATMega16 unterstützt etwa folgende Interrupts:

* `INT0_vect` - Externer Interrupt 0
* `INT1_vect` - Externer Interrupt 1
* `INT2_vect` - Externer Interrupt 2
* `TIMER2_COMP_vect` - Timer/Counter 2 Compare Match
* `TIMER2_OVF_vect` - Timer/Counter 2 Overflow
* `TIMER1_CAPT_vect` - Timer/Counter 1 Capture Event
* `TIMER1_COMPA_vect` - Timer/Counter 1 Compare Match A
* `TIMER1_COMPB_vect` - Timer/Counter 1 Compare Match B
* `TIMER1_OVF_vect` - Timer/Counter 1 Overflow
* `TIMER0_COMP_vect` - Timer/Counter 0 Compare Match
* `TIMER0_OVF_vect` - Timer/Counter 0 Overflow
* `SPI_STC_vect` - Serial Transfer Complete
* `USART_RXC_vect` - USART Receive Complete
* `USART_UDRE_vect` - USART Data Register Empty
* `USART_TXC_vect` - USART Transmit Complete
* `ADC_vect` - ADC Conversion Complete
* `EE_RDY_vect` - EEPROM Ready
* `ANA_COMP_vect` - Analog Comparator
* `TWI_vect` - Two-Wire Interface (bzw. I²C) 
* `SPM_RDY_vect` - Store Program Memory Ready

### Interrupt Service Routinen
Eine *Interrupt Service Routine* ist der Programmcode der ausgeführt wird, wenn der Interrupt ausgelöst wurde. Diese
wird im Sourcecode über das `ISR()` Makro definiert. Um auf dieses Makro und andere Interruptfunktionalitäten
zuzugreifen, muss `avr/interrupt.h` inkludiert werden.

Beispiel:

    #!c
    #include <avr/interrupt.h>
    
    ISR(ADC_vect) { // Interrupt Service Routine für den Analog/Digitalwandler
      // Dieser Code wird beim Auslösen des Interrupts ausgeführt
      // ...
    }

### Einrichten eines Interrupts
Damit ein Interrupt zur Ausführung kommt, werden folgende Punkte benötigt:

* Implementierung der *Interrupts Service Routine*
* Konfiguration der entsprechenden Register, um einen Interrupt für die entsprechende Komponente zu ermöglichen
* Aufruf von `sei()` im Hauptprogramm, um die *globale Interruptfreigabe* zu aktivieren
* Die Komponente kommt in einen Zustand, der den Interrupt auslöst (meist über ein *Interrupt Flag*)

Als Beispiel für einen einfachen Interrupt wird auf [externe Interrupts]({filename}avr_externer_interrupt.md) verwiesen.

!!! panel-warning "Interrupt ohne Service Routine"
    Wird eine Komponente so konfiguriert, dass sie einen Interrupt auslösen kann, die entsprechende Interruptroutine aber
    nicht vorhanden ist kommt es zu einem unerwarteten Ereignis: Der Mikrocontroller führt einen Neustart (Reset) durch.

Interrupts, die keine eigene Service Routine haben führen die Serviceroutine `BADISR_vect` aus. Diese Routine führt einen
Reset aus.

Es ist möglich eine eigene Funktion für `BADISR_vect` zu definieren. Für große Projekte empfiehlt sich dies auch, da es
schnell bei der Fehlersuche passieren kann, dass eine Service Routine gelöscht oder fälschlicherweise ein Interrupt
freigegeben wird. Die Implementierung ist wie folgt möglich:

    #!c
    ISR(BADISR_vect) { // Interrupt Service Routine für alle nicht definierten Interrupt Routinen
      // ... dies Funktion kann auch einfach leer bleiben
    }
