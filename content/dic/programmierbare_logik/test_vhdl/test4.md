title: VHDL Test (4)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_4.compress){: class="download" } herunterladen und entpacken
* Insgesamt gibt es <span class="badge">20 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Serielle Datenübertragung
## Vorbereitung
* Projekt <samp>transmitter.xise</samp> öffnen

## Aufgabenstellung
Um Daten zu Übertragen wird oft die serielle Schnittstelle verwendet. In diesem Beispiel soll ein Transmitter entsprechend
RS232 realisiert werden.

<figure><img src="{filename}../../bussysteme/rs232_timing.png"><figcaption>RS232 Timingdiagramm (Bild: <a href="https://commons.wikimedia.org/wiki/File:RS-232_timing.png">Gerald.deppe</a> Public Domain)</figcaption></figure>

Zum Testen soll mittels der acht Umschaltern (<samp>SW0</samp> bis <samp>SW7</samp>) ein 8 Bit Datenwort definiert werden und
durch Drücken des Tasters <samp>BTN0</samp> wird dieses dann *versendet*. Zum Versenden wird der Pegel der Sendeleitung
mittels LED angezeigt. Die Baudrate wird auf 1 Baud gestellt.

## <samp>uart_tx</samp> Komponente

### Zustandsmaschine
<span class="badge">10 Punkte</span>

* Die erforderliche Zustandsmaschine hat die Zustände <code>IDLE</code>, <code>START</code>, <code>DATA</code> und <code>STOP</code>
* Eingänge:
    * <code>send_i</code> - startet die Übertragung
    * Überlauf den Baudraten Generators - wechselt bei einer laufenden Übertragung zum nächsten Symbol
* Ausgänge:
    * <code>tx_o</code> - das zu sendende Bit (bzw. Symbol)
    * <code>busy_o</code> - zeigt eine laufende Übertragung an (<code>'1'</code> wenn eine Übertragung läuft)
* Wenn die Zustandsmaschine im Zustand <code>IDLE</code> ist und <code>send_i</code> gleich <code>'1'</code> ist, dann wird in den Zustand <code>START</code> gewechselt.
* Vom Zustand <code>START</code> wird in den Zustand <code>DATA</code> gewechselt, sobald der Zähler für die Baudrate übergelaufen ist
* Im Zustand <code>DATA</code> läuft ein Bit Zähler und zählt die Bits von 0 bis 7 (LSB zuerst)
* Jedes Bit wird für die Dauer ausgegeben, die sich aus der Baudrate ergibt
* Nach dem 8. Datenbit wird in den Zustand <code>STOP</code> gewechselt
* Vom Zustand <code>STOP</code> wird in den Zustand <code>IDLE</code> gewechselt, sobald der Zähler für die Baudrate übergelaufen ist
* Ausgabe von <code>tx_o</code>
    * Ist in <code>IDLE</code> und <code>STOP</code> auf <code>'1'</code>
    * Ist in <code>START</code> auf <code>'0'</code>
    * Entspricht während <code>DATA</code> dem zu übertragenden Datenbit

### Baudratengenerierung
<span class="badge">2 Punkte</span>

Für die Baudratengenerierung wird der bestehende Zähler (<samp>counter</samp>) verwendet. Die Entity enthält die beiden
Generics <samp>BAUDRATE_WIDTH</samp> und <samp>BAUDRATE_DIVIDER</samp>, die den Zähler konfigurieren.

### Bit Zähler
<span class="badge">2 Punkte</span>

Um die einzelnen Datenbits zu zählen (während des Zustands <code>DATA</code>) wird eine weitere Zählerinstanz verwendet. Diese
Zählerinstanz zählt von 0 bis 7.

Der Ausgang <code>value_o</code> des Bit Zählers ist vom Typ <samp>std_ulogic_vector</samp>. Dieser muss zuerst in einen <samp>unsigned</samp>
und dann mittels <samp>to_integer</samp> in einen Integer gewandelt werden, um mittels Indexzugriff das gewünschte Bit aus
dem <code>data_i</code> Vektor zu holen (z.B. <code>data_i(0)</code> holt Bit 0 des Vektors).

### Blockschaltbild
Dieses Blockschaltbild zeigt die einzelnen Komponenten der <samp>uart_tx</samp> Komponente. Die resultierende VHDL
Beschreibung sollte äquvivalent zu diesem Blockschaltbild sein.

![Blockschaltbild uart_tx]({filename}test4_uart_tx.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>uart_tx_tb.vhd</samp>.

## Implementierung des Top Levels
<span class="badge">3 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>button_dectect</samp> und <samp>uart_tx</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>transmitter.vhd</samp> die gewünschte Funktionalität zu realisieren.

Einige benötigte Signale sind bereits vordefiniert.

Erstelle das Top Level anhand des folgenden Blockschaltbildes:

![Blockschaltbild transmitter]({filename}test4_transmitter.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>transmitter_tb.vhd</samp>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <samp>transmitter.ucf</samp> ist nur das Signal <code>clk</code> definiert. Erweitere die Datei um folgende Zuordnungen

* <code>button_send_i</code> liegt an Pin <code>G12</code>
* <code>switches_data_i(0)</code> liegt an Pin <code>P11</code>
* <code>switches_data_i(1)</code> liegt an Pin <code>L3</code>
* <code>switches_data_i(2)</code> liegt an Pin <code>K3</code>
* <code>switches_data_i(3)</code> liegt an Pin <code>B4</code>
* <code>switches_data_i(4)</code> liegt an Pin <code>G3</code>
* <code>switches_data_i(5)</code> liegt an Pin <code>F3</code>
* <code>switches_data_i(6)</code> liegt an Pin <code>E2</code>
* <code>switches_data_i(7)</code> liegt an Pin <code>N3</code>
* <code>led_tx_o</code> liegt an Pin <code>M5</code>
* <code>led_busy_o</code> liegt an Pin <code>M11</code>

<figure><img src="{filename}../basys2_pinout.svg"><figcaption>Pinout des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
