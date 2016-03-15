title: IO mittels AVR Portpins
parent: uebersicht.md

# Allgemeines
Die interne Beschaltung jedes IO Port Pins beinhaltet folgende Komponenten:

* Schutzdioden gegenüber Masse und Versorgungsspannung (Überspannung bzw. ESD)
* Aktivierbarer Pull-Up Widerstand
* Aktivierbare Ausgangsstufe
* Eingänge besitzen Schmitt-Trigger und Synchronisierung

<figure><img src="{filename}avr_io_pin.svg"><figcaption>AVR IO Pin (Quelle: <a href="http://www.atmel.com/images/doc2466.pdf">Datenblatt ATMega16</a> &copy; Atmel Corporation)</figcaption></figure>

Um von der Firmware aus auf einen IO Port Pin zuzugreifen, werden drei Register benötigt. Diese drei Register fassen jeweils 8 IO Pins zusammen. Die Gruppierung von 8 IO Pins wird auch *Port* genannt. Der ATMega16 hat 4 solcher Ports: Port *A*, *B*, *C* und *D*. Im folgenden wird statt des Portnamens ein `x` verwendet.

## `PINx` - das Eingangsregister
Das Eingangsregister zeigt den aktuellen Zustand der Pins an. Der aktuelle Zustand wird auch eingelesen, wenn der Pin als Ausgang beschalten ist. Die notwendigen Pegel zur Detektion einer `0` oder `1` ist abhängig von Versorgungsspannung und Temperatur.

## `DDRx` - das Richtungsregister
Das *Data Direction Register* legt fest, ob die jeweiligen Ausgangstreiber aktiv sind oder nicht. Bei aktivem Ausgangstreiber (`DDR`-Bit auf `1`) wird der Pegel des entsprechenden `PORTx` Registerbits auf den Ausgang gelegt.

## `PORTx` - das Ausgangsregister
Bei aktivem Ausgangstreiber wird der Ausgang entsprechend diesem Bit gesteuert. Ist der Ausgangstreiber nicht aktiv, so wird mit diesem Register der Pull-Up aktiviert.

## Pin Konfiguration
Mittels der Register `DDRx` und `PORTx` können folgende Konfigurationen eingestellt werden:

`DDRxn` | `PORTxn` | I/O | Pull-Up | Kommentar
-|-!|-|-|-
0 | 0 |  Eingang | Nein | Hochohmiger Eingang (Tri-State)
0 | 1 |  Eingang | Ja | Eingang mit Pull Up
1 | 0 |  Ausgang | Nein | Ausgang Low
1 | 1 |  Ausgang | Nein | Ausgang High
