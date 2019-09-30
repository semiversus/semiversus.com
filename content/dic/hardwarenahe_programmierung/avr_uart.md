title: Die UART des Atmel AVR
parent: uebersicht.md

!!! panel-info "Diese Seite beschreibt die UART des ATMega16"
    Prinzipiell lässt sich diese Information auch auf andere Mikrocontroller der AVR Serie übertragen, es empfiehlt sich
    aber die Informationen mit dem entsprechenden Datenblatt zu vergleichen!

!!! panel-info "Informationen im Datenblatt"
    Die Informationen dieser Seite entstammen dem originalen [Datenblatt]({filename}atmel_atmega16.pdf){: class="download" }
    (Rev. 2466T–AVR–07/10) des ATMega16 von Atmel.

    * *Seite 144-145*: Blockschaltbild und allgemeine Information
    * *Seite 163-167*: Registerbeschreibung
    * *Seite 167-171*: UART Baudrateregister und Beispiele für Baudrates

# Allgemeines
Um eine serielle Schnittstelle (siehe [RS232]({filename}../bussysteme/rs232.md)) zu realisieren stellt der Atmel AVR eine *USART*
(engl. für *Universal Synchronous and Asynchrouns Serial Receiver and Transmitter*) zur Verfügung.

Zur Arbeit mit dem *USART* werden fünf Register genutzt:

* Drei Konfigurations und Statusregister <code>UCSRA</code>, <code>UCSRB</code> und <code>UCSRC</code> (für *UART Control and Status Register* A, B und C)
* Das Baudrateregister <code>UBRR</code> für die Erzeugung des Übertragungstaktes
* Das Datenregister <code>UDR</code> (engl. für *UART Data Register*) zum Senden und Empfangen der einzelnen Bytes

Außerdem stehen drei mögliche Interrupts für die UART zur Verfügung:

* *Receive Complete* (<code>USART_RX_vect</code>) - signalisiert ein empfangenes Byte empfangen wurde
* *Transmit Complete* (<code>USART_TX_vect</code>) - signalisiert ein vollständig gesendetes Byte (inklusive Stopbit)
* *UART Data Register Empty* (<code>USART_UDRE_vect</code>) - signalisert einenen freien Sendebuffer

Die Konfigurations- und Statusregister sowie die Interrupts werden im folgenden näher erläutert.

<figure><img src="{filename}avr_uart.svg"><figcaption>AVR UART (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

# Konfigurations- und Statusregister
## USARTA

Bit|7|6|5|4|3|2|1|0
:-:!|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
Name|RXC|TXC|UDRE|FE|DOR|PE|U2X|MPCM
Read/Write|R|R/W|R|R|R|R|R/W|R/W
Init|0|0|1|0|0|0|0|0

### RXC - Receive Complete
Dieses Flag wird auf <code>1</code> gesetzt, wenn ein neues Byte im <code>UDR</code> zur Verfügung steht (empfangen wurde). Sobald <code>UDR</code>
gelesen wird, wird das Flag auf <code>0</code> gesetzt. Dieses Flag löst den *Receive Complete* Interrupt aus, sofern
dieser aktiviert ist.

### TXC - Transmit Complete
Das Flag wird auf <code>1</code> gesetzt, wenn ein komplettes Frame (inklusive Stopbit) gesendet wurde. Dieses Flag wird gelöscht,
wenn der *Transmit Complete* Interrupt aufgerufen wird oder kann direkt gelöscht werden, indem das Flag mit einer <code>1</code>
geschrieben wird. Dieses Flags löste den *Transmit Complete* Interrupt aus, sofern dieser aktiviert ist.

### UDRE - USART Date Register Empty
Dieses Flag ist auf <code>1</code>, wenn das Senderegister (wieder) leer ist. Dieses Flag löst den *USART Date Register Empty*
Interrupt aus, sogern dieser aktiviert ist. Das Flag liefert <code>0</code>, sobald auf <code>UDR</code> geschrieben wird. Nach dem Reset
ist dieses Flag <code>1</code>, um das leere <code>UDR</code> zu signalisieren.

### FE - Frame Error
Wurde beim Empfang das Stopbit falsch empfangen (sollte logisch <code>1</code> entsprechen) wird dieses Flag gesetzt. Das Flag wird
zurückgesetzt sobald <code>UDR</code> gelesen wird.

### DOR - Data OverRun
Ein *Data OverRun* tritt auf, wenn ein Byte empfangen wurde, der Empfangsbuffer aber vollgelaufen ist (<code>UDR</code> wurde nicht
ausgelesen). Sobald dies eintritt, wird das Flag auf <code>1</code> gesetzt. Zurückgesetzt wird es mit dem Lesen von <code>UDR</code>.

### PE - Parity Error
Wenn der Paritätscheck eingeschalten ist und das Paritätsbit der Übertragung nicht mit der Berechnung über die Datenbits
zusammen stimmt wird dieses Flag auf <code>1</code> gesetzt. Zurückgesetzt wird es mit dem Lesen von <code>UDR</code>.

### U2X - USART Double Speed
Bestimmt den Teiler für die Baudrategenerierung. <code>0</code> für Teiler 16 und <code>1</code> für Teiler 8. Näheres dazu unter *Baudrate
Generierung*.

### MPCM - Multiprocessor Communication Mode
Spezieller Modus um eine Filterung von Frames mit Adressinformationen vorzunehmen. Wird in der Praxis äußerst selten
benutzt. Für weitere Informationen dazu ist im Datenblatt nachzulesen.

## USARTB

**Bit**|7|6|5|4|3|2|1|0
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
**Name**|RXCIE|TXCIE|UDRIE|RXEN|TXEN|UCSZ2|RXB8|TXB8
**Read/Write**|R/W|R/W|R/W|R/W|R/W|R/W|R|R/W
**Init**|0|0|0|0|0|0|0|0

### RXCIE - Receive Complete Interrupt Enable
Um den Interruptvektor zu aktivieren, muss dieses Flag auf <code>1</code> sein. Der entsprechende Interruptvektor heißt
<code>USART_RX_vect</code>.

### TXCIE - Transmit Complete Interrupt Enable
Um den Interruptvektor zu aktivieren, muss dieses Flag auf <code>1</code> sein. Der entsprechende Interruptvektor heißt
<code>USART_TX_vect</code>.

### UDRIE - UART Data Register Empty Interrupt Enable
Um den Interruptvektor zu aktivieren, muss dieses Flag auf <code>1</code> sein. Der entsprechende Interruptvektor heißt
<code>USART_UDRE_vect</code>.

### RXEN - Receive Enable
Dieses Flag muss auf <code>1</code> sein, um den Empfänger der UART einzuschalten.

### RXEN - Transmit Enable
Dieses Flag muss auf <code>1</code> sein, um den Sender der UART einzuschalten.

## USARTC

**Bit**|7|6|5|4|3|2|1|0
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
**Name**|URSEL|UMSEL|UPM1|UPM0|USBS|UCSZ1|UCSZ0|UCPOL
**Read/Write**|R/W|R/W|R/W|R/W|R/W|R/W|R|R/W
**Init**|1|0|0|0|0|1|1|0

# Baudrate Generierung
Zur Generierung der Baudrate gilt folgende Formel:

%%f_{Baudrate}=\frac{f_{CLK}}{16\cdot(UBRR+1)} \Leftrightarrow UBRR=\frac{f_{CLK}}{16\cdot f_{Baudrate}}-1%%

Diese Formel gilt wenn das <code>U2X</code> in <code>UCSRA</code> gleich <code>0</code> ist. Für <code>U2X</code> gleich <code>1</code> gilt folgende Formel:

%%f_{Baudrate}=\frac{f_{CLK}}{8\cdot(UBRR+1)} \Leftrightarrow UBRR=\frac{f_{CLK}}{8\cdot f_{Baudrate}}-1%%
