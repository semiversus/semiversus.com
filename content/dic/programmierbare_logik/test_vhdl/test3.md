title: VHDL Test (3)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_3.compress){: class="download" } herunterladen und entpacken
* Insgesamt gibt es <span class="badge">29 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Einschaltverzögerung
## Vorbereitung
* Projekt <tt>led_toggle/led_toggle.xise</tt> öffnen

## Aufgabenstellung
Zwei LEDs sollen mittels zwei Taster angesteuert werden. 

* `button_toggle` - Wechselt zwischen LED1 und LED2, bzw. schaltet LED1 ein, falls die LEDs ausgeschaltet waren.
* `button_off` - Schaltet die LEDs aus

## Entwurf der Zustandsmaschine 
<span class="badge">5 Punkte</span>

Zur Realisierung wird eine Zustandsmaschine genutzt.

* Bearbeite die Datei <tt>led_toggle_fsm.vhd</tt>
* Definiere die drei Zuständen `OFF`, `LED1` und `LED2`
* Der Startzustand ist `OFF`
* Der Eingang `toggle_i` wechselt von `OFF` nach `LED1` bzw. wechselt von `LED1` nach `LED2` und umgekehrt
* Der Eingang `off_i` wechselt immer in den Zustand `OFF`
* Der Eingang `off_i` hat die höhere Priorität als der Eingang `toggle_i`
* Der Ausgang `led1_o` ist auf `'1'`, wenn die Zustandmaschine im Zustand `LED1` ist
* Der Ausgang `led2_o` ist auf `'1'`, wenn die Zustandmaschine im Zustand `LED2` ist

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>led_toggle_fsm_tb.vhd</tt>. Mittels <kbd>F6</kbd> lässt sich
    der gesamte Bereich zoomen.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <tt>button_dectect</tt> und <tt>led_toggle_fsm</tt>. Diese
Komponenten werden genutzt, um im Top Level <tt>led_toggle.vhd</tt> die gewünschte Funktionalität zu realisieren.

* Die Instanz der Komponente <tt>button_detect</tt> mit dem Namen `toggle_detect_component` ist bereits erstellt
    * `button_i` ist mit dem Eingang `button_toggle_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `toggle_detect` verbunden
* Erstelle eine Instanz der Komponente <tt>button_detect</tt> mit dem Namen `off_detect_component` analog zu `toggle_detect_component`
    * `button_i` ist mit dem Eingang `button_off_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `off_detect` verbunden
* Erstelle eine Instanz der Komponente <tt>led_toggle_fsm</tt> mit dem Namen `led_toggle_fsm_component`
    * `toggle_i` ist mit dem Signal `toggle_detect` verbunden
    * `off_i` ist mit dem Signal `off_detect` verbunden
    * `led1_o` ist mit dem Ausgang `led1_o` verbunden
    * `led2_o` ist mit dem Ausgang `led2_o` verbunden
* Jede Komponente hat einen Takteingang `clk`, welcher mit dem globalen `clk` verbunden wird

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>led_toggle_tb.vhd</tt>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <tt>led_toggle.ucf</tt> ist nur das Signal `clk` definiert. Erweitere die Datei um folgende Zuordnungen

* `button_toggle_i` wird durch den Taster <tt>BTN0</tt> angesteuert
* `button_off_i` wird durch den Taster <tt>BTN1</tt> angesteuert
* `led1_o` ist die LED <tt>LD0</tt>
* `led2_o` ist die LED <tt>LD1</tt>

<figure><img src="{filename}../basys2_pinout.svg"><figcaption>Pinout des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board

# Ampel mit Überwachung
## Vorbereitung
* Projekt <tt>lights/lights.xise</tt> öffnen

## Aufgabenstellung
Es soll eine Ampel mit zwei Modis realisiert werden: 

* Orange-Blinken (Orange Leuchte geht ein und aus)
* Wechsel zwischen Grün, Orange, Rot, Rot-Orange und wieder Grün

Die Ausgänge für die drei Farben der Ampel werden mittels drei Bit Vektor dargestellt:

* Bit0 (ganz rechts) entspricht der grünen Leuchte
* Bit1 entspricht der orangen Leuchte
* Bit2 (ganz links) entspricht der roten Leuchte.

So steht z.B. `"110"` für eine Ampel, bei der Rot und Orange leuchtet. Bei `OFF` soll nichts leuchten.

Zusätzlich soll eine *Überwachung* vorhanden sein, die feststellt, ob es zu ungültigen Kombinationen gekommen ist (z.B.
wenn Rot und Grün gleichzeitig leuchten). Die Überwachung würde in diesem Fall die Ampel Rot leuchten lassen.

## Überwachung
<span class="badge">5 Punkte</span>

Die Komponente `supervisor` (deutsch *Überwacher*) soll die Zustände der drei Lampen überprüfen. Dazu hat die Komponente
den Eingang `monitor_i` und den Ausgang `result_o`.

* Liegt an `monitor_i` eine gültige Kombination an (z.B. `"001"` für Grün) soll diese Kombination am Ausgang `result_o` erscheinen
* Liegt eine ungültige Kombination an (z.B. `"101"`) soll stattdessen die Kombination für Rot ausgegeben werden (`"100"`)
* Gültige Kombinationen sind alle Ausgaben der Zustände `GREEN`, `ORANGE`, `RED`, `RED_ORANGE` und `OFF`

Die Komponente ist in vier Ausführungen (*Architectures*) bereits in der Datei <tt>supervisor.vhd</tt> beschrieben. Die
*Architectures* lauten `behave1`, `behave2`, `behave3` und `behave4`.

Erstelle in der Datei <tt>supervisor_tb.vhd</tt> eine Testbench, die herausfindet, welche der vier Ausführungen
funktioniert (es ist genau eine).

## Komponente `lights_fsm`
<span class="badge">5 Punkte</span>

Erstelle die Komponente `lights_fsm` durch Bearbeitung der Datei <tt>lights_fsm.vhd</tt>.

* Die Ampel wechselt nur den Zustand, wenn `next_i` gleich `'1'` ist
* Ist der Eingang `mode_i` gleich `'0'` soll die Ampel zwischen den Zuständen `ORANGE` und `OFF` wechseln
* Bei `mode_i` gleich `'1'` soll die Ampel zyklisch zwischen `GREEN`, `ORANGE`, `RED`, `RED_ORANGE` wechseln und anschließend bei `GREEN` wieder starten
* Ist die Ampel im Zustand `GREEN`, `RED` oder `RED_ORANGE` und `mode_i` ist `'0'` soll der nächste Zustand `ORANGE` sein
* Ist die Ampel im Zustand `OFF` und `mode_i` ist `'1'` soll der nächste Zustand `ORANGE` sein
* Der Startzustand ist `ORANGE`

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>lights_fsm_tb.vhd</tt>.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <tt>counter</tt>, <tt>light_fsm</tt> und <tt>supervisor</tt>. Diese
Komponenten werden genutzt, um im Top Level <tt>lights.vhd</tt> die gewünschte Funktionalität zu realisieren.

Mit dem <tt>counter</tt> soll ein 700 Millisekunden Takt generiert werden. Wieviel Takte des 50 Mhz Taktes sind dazu
notwendig und wieviel Bits werden benötigt, um diesen Wert darstellen zu können? Trage diese Werte in der Default-Einstellung
von `COUNTER_WIDTH` und `COUNTER_MAXIMUM` ein:

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
    Teste die Implementierung mittels der Testbench <tt>lights_tb.vhd</tt>.

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
