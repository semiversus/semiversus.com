title: VHDL Test (3)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_3.compress){: class="download" } herunterladen und entpacken
* Insgesamt gibt es <span class="badge">29 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Einschaltverzögerung
## Vorbereitung
* Projekt <samp>led_toggle/led_toggle.xise</samp> öffnen

## Aufgabenstellung
Zwei LEDs sollen mittels zwei Taster angesteuert werden.

* <code>button_toggle</code> - Wechselt zwischen LED1 und LED2, bzw. schaltet LED1 ein, falls die LEDs ausgeschaltet waren.
* <code>button_off</code> - Schaltet die LEDs aus

## Entwurf der Zustandsmaschine
<span class="badge">5 Punkte</span>

Zur Realisierung wird eine Zustandsmaschine genutzt.

* Bearbeite die Datei <samp>led_toggle_fsm.vhd</samp>
* Definiere die drei Zuständen <code>OFF</code>, <code>LED1</code> und <code>LED2</code>
* Der Startzustand ist <code>OFF</code>
* Der Eingang <code>toggle_i</code> wechselt von <code>OFF</code> nach <code>LED1</code> bzw. wechselt von <code>LED1</code> nach <code>LED2</code> und umgekehrt
* Der Eingang <code>off_i</code> wechselt immer in den Zustand <code>OFF</code>
* Der Eingang <code>off_i</code> hat die höhere Priorität als der Eingang <code>toggle_i</code>
* Der Ausgang <code>led1_o</code> ist auf <code>'1'</code>, wenn die Zustandmaschine im Zustand <code>LED1</code> ist
* Der Ausgang <code>led2_o</code> ist auf <code>'1'</code>, wenn die Zustandmaschine im Zustand <code>LED2</code> ist

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_toggle_fsm_tb.vhd</samp>. Mittels <kbd>F6</kbd> lässt sich
    der gesamte Bereich zoomen.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>button_dectect</samp> und <samp>led_toggle_fsm</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>led_toggle.vhd</samp> die gewünschte Funktionalität zu realisieren.

* Die Instanz der Komponente <samp>button_detect</samp> mit dem Namen <code>toggle_detect_component</code> ist bereits erstellt
    * <code>button_i</code> ist mit dem Eingang <code>button_toggle_i</code> verbunden
    * <code>detect_o</code> ist mit dem (bereits definiertem) Signal <code>toggle_detect</code> verbunden
* Erstelle eine Instanz der Komponente <samp>button_detect</samp> mit dem Namen <code>off_detect_component</code> analog zu <code>toggle_detect_component</code>
    * <code>button_i</code> ist mit dem Eingang <code>button_off_i</code> verbunden
    * <code>detect_o</code> ist mit dem (bereits definiertem) Signal <code>off_detect</code> verbunden
* Erstelle eine Instanz der Komponente <samp>led_toggle_fsm</samp> mit dem Namen <code>led_toggle_fsm_component</code>
    * <code>toggle_i</code> ist mit dem Signal <code>toggle_detect</code> verbunden
    * <code>off_i</code> ist mit dem Signal <code>off_detect</code> verbunden
    * <code>led1_o</code> ist mit dem Ausgang <code>led1_o</code> verbunden
    * <code>led2_o</code> ist mit dem Ausgang <code>led2_o</code> verbunden
* Jede Komponente hat einen Takteingang <code>clk</code>, welcher mit dem globalen <code>clk</code> verbunden wird

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_toggle_tb.vhd</samp>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <samp>led_toggle.ucf</samp> ist nur das Signal <code>clk</code> definiert. Erweitere die Datei um folgende Zuordnungen

* <code>button_toggle_i</code> wird durch den Taster <samp>BTN0</samp> angesteuert
* <code>button_off_i</code> wird durch den Taster <samp>BTN1</samp> angesteuert
* <code>led1_o</code> ist die LED <samp>LD0</samp>
* <code>led2_o</code> ist die LED <samp>LD1</samp>

<figure><img src="{filename}../basys2_pinout.svg"><figcaption>Pinout des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board

# Ampel mit Überwachung
## Vorbereitung
* Projekt <samp>lights/lights.xise</samp> öffnen

## Aufgabenstellung
Es soll eine Ampel mit zwei Modis realisiert werden:

* Orange-Blinken (Orange Leuchte geht ein und aus)
* Wechsel zwischen Grün, Orange, Rot, Rot-Orange und wieder Grün

Die Ausgänge für die drei Farben der Ampel werden mittels drei Bit Vektor dargestellt:

* Bit0 (ganz rechts) entspricht der grünen Leuchte
* Bit1 entspricht der orangen Leuchte
* Bit2 (ganz links) entspricht der roten Leuchte.

So steht z.B. <code>"110"</code> für eine Ampel, bei der Rot und Orange leuchtet. Bei <code>OFF</code> soll nichts leuchten.

Zusätzlich soll eine *Überwachung* vorhanden sein, die feststellt, ob es zu ungültigen Kombinationen gekommen ist (z.B.
wenn Rot und Grün gleichzeitig leuchten). Die Überwachung würde in diesem Fall die Ampel Rot leuchten lassen.

## Überwachung
<span class="badge">5 Punkte</span>

Die Komponente <code>supervisor</code> (deutsch *Überwacher*) soll die Zustände der drei Lampen überprüfen. Dazu hat die Komponente
den Eingang <code>monitor_i</code> und den Ausgang <code>result_o</code>.

* Liegt an <code>monitor_i</code> eine gültige Kombination an (z.B. <code>"001"</code> für Grün) soll diese Kombination am Ausgang <code>result_o</code> erscheinen
* Liegt eine ungültige Kombination an (z.B. <code>"101"</code>) soll stattdessen die Kombination für Rot ausgegeben werden (<code>"100"</code>)
* Gültige Kombinationen sind alle Ausgaben der Zustände <code>GREEN</code>, <code>ORANGE</code>, <code>RED</code>, <code>RED_ORANGE</code> und <code>OFF</code>

Die Komponente ist in vier Ausführungen (*Architectures*) bereits in der Datei <samp>supervisor.vhd</samp> beschrieben. Die
*Architectures* lauten <code>behave1</code>, <code>behave2</code>, <code>behave3</code> und <code>behave4</code>.

Erstelle in der Datei <samp>supervisor_tb.vhd</samp> eine Testbench, die herausfindet, welche der vier Ausführungen
funktioniert (es ist genau eine).

## Komponente <code>lights_fsm</code>
<span class="badge">5 Punkte</span>

Erstelle die Komponente <code>lights_fsm</code> durch Bearbeitung der Datei <samp>lights_fsm.vhd</samp>.

* Die Ampel wechselt nur den Zustand, wenn <code>next_i</code> gleich <code>'1'</code> ist
* Ist der Eingang <code>mode_i</code> gleich <code>'0'</code> soll die Ampel zwischen den Zuständen <code>ORANGE</code> und <code>OFF</code> wechseln
* Bei <code>mode_i</code> gleich <code>'1'</code> soll die Ampel zyklisch zwischen <code>GREEN</code>, <code>ORANGE</code>, <code>RED</code>, <code>RED_ORANGE</code> wechseln und anschließend bei <code>GREEN</code> wieder starten
* Ist die Ampel im Zustand <code>GREEN</code>, <code>RED</code> oder <code>RED_ORANGE</code> und <code>mode_i</code> ist <code>'0'</code> soll der nächste Zustand <code>ORANGE</code> sein
* Ist die Ampel im Zustand <code>OFF</code> und <code>mode_i</code> ist <code>'1'</code> soll der nächste Zustand <code>ORANGE</code> sein
* Der Startzustand ist <code>ORANGE</code>

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>lights_fsm_tb.vhd</samp>.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>counter</samp>, <samp>light_fsm</samp> und <samp>supervisor</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>lights.vhd</samp> die gewünschte Funktionalität zu realisieren.

Mit dem <samp>counter</samp> soll ein 700 Millisekunden Takt generiert werden. Wieviel Takte des 50 Mhz Taktes sind dazu
notwendig und wieviel Bits werden benötigt, um diesen Wert darstellen zu können? Trage diese Werte in der Default-Einstellung
von <code>COUNTER_WIDTH</code> und <code>COUNTER_MAXIMUM</code> ein:

    #!vhdl
    entity lights is
      generic (
        COUNTER_WIDTH : integer := 4; -- <<< TODO
        COUNTER_MAXIMUM : integer := 9 -- <<< TODO
      );
      port (
        clk : in std_ulogic; -- 50 MHz clock
        mode_i : in std_ulogic;
        leds_o : out std_ulogic_vector(2 downto 0)
      );
    end entity;

Erstelle das Top Level anhand des folgenden Blockschaltbildes:

![Top Level für Lights]({filename}test3_lights.jpg)

Gegebenenfalls müssen noch Signale definiert werden.

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>lights_tb.vhd</samp>.

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
