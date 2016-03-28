title: VHDL Test (2)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_2.compress){: class="download" } herunterladen und entpacken
* Insgesamt gibt es <span class="badge">29 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Einschaltverzögerung
## Vorbereitung
* Projekt <samp>led_delay/led_delay.xise</samp> öffnen

## Aufgabenstellung
Es ist eine einfache Einschaltverzögerung zu entwerfen. Diese Einschaltverzögerung steuert eine LED an und wird mittels zwei Tasten
bedient:

* `button_toggle` - Schaltet das Licht ein bzw. aus
* `button_on` - Schaltet das Licht in 3 Sekunden ein

## Entwurf der Zustandsmaschine 
<span class="badge">5 Punkte</span>

Zur Realisierung wird eine Zustandsmaschine genutzt.

* Bearbeite die Datei <samp>led_delay_fsm.vhd</samp>
* Definiere die drei Zuständen `OFF`, `LIGHT` und `DELAY`
* Der Startzustand ist `OFF`
* Der Eingang `toggle_i` wechselt von `LIGHT` nach `OFF` bzw. von `OFF` oder `DELAY` nach `LIGHT`
* Der Eingang `on_i` wechselt von `OFF` nach `DELAY`, bei den anderen Zuständen hat er keine Auswirkung
* Der Eingang `timeout_i` bewirkt ein Wechsel von `DELAY` nach `LIGHT`, bei den anderen Zuständen hat er keine Auswirkung
* Der Ausgang `led_o` ist auf `'1'`, wenn die Zustandmaschine im Zustand `LIGHT` ist
* Der Ausgang `timer_enable_o` ist im Zustand `DELAY` auf `'1'`, ansonsten `'0'`
* Der Ausgang `timer_clear_o` ist im Zustand `OFF` auf `'1'`, ansonsten `'0'`

![FSM für Lichtsteuerung]({filename}test2_led_delay_fsm.svg.tex)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_delay_fsm_tb.vhd</samp>. Mittels <kbd>F6</kbd> lässt sich
    der gesamte Bereich zoomen.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>counter</samp>, <samp>button_dectect</samp> und <samp>led_delay_fsm</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>led_delay.vhd</samp> die gewünschte Funktionalität zu realisieren.

* Die Instanz der Komponente <samp>button_detect</samp> mit dem Namen `toggle_detect_component` ist bereits erstellt
    * `button_i` ist mit dem Eingang `button_toggle_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `toggle_detect` verbunden
* Erstelle eine Instanz der Komponente <samp>button_detect</samp> mit dem Namen `on_detect_component` analog zu `toggle_detect_component`
    * `button_i` ist mit dem Eingang `button_on_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `on_detect` verbunden
* Erstelle eine Instanz der Komponente <samp>led_delay_fsm</samp> mit dem Namen `led_delay_fsm_component`
    * `toggle_i` ist mit dem Signal `toggle_detect` verbunden
    * `on_i` ist mit dem Signal `on_detect` verbunden
    * `timeout_i` ist mit dem (bereits definiertem) Signal `timeout` verbunden
    * `led_o` ist mit dem Ausgang `led_o` verbunden
    * `timer_enable_o` ist mit dem (bereits definiertem) Signal `timer_enable` verbunden
    * `timer_clear_o` ist mit dem (bereits definiertem) Signal `timer_clear` verbunden
* Erstelle eine Instanz der Komponente <samp>counter</samp> mit dem Namen `timeout_component`
    * `WIDTH` in der *generic map* wird auf 28 gestellt (28 Bit)
    * `MAXIMUM` wird auf `CLK_TIMEOUT_DIVIDER` gestellt (ist im *generic* Teil des Top Levels bereits definiert)
    * `enable_i` ist mit dem Signal `timer_enable` verbunden
    * `reset_i` ist mit dem Signal `timer_clear` verbunden
    * `value_o` ist nicht verbunden (`open`)
    * `overflow_o` ist mit dem Signal `timeout` verbunden
* Jede Komponente hat einen Takteingang `clk`, welcher mit dem globalen `clk` verbunden wird

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_delay_tb.vhd</samp>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <samp>led_delay.ucf</samp> ist nur das Signal `clk` definiert. Erweitere die Datei um folgende Zuordnungen

* `button_toggle_i` wird durch den Taster <samp>BTN0</samp> angesteuert
* `button_on_i` wird durch den Taster <samp>BTN1</samp> angesteuert
* `led_o` ist die LED <samp>LD0</samp>

<figure><img src="{filename}../basys2_pinout.svg"><figcaption>Pinout des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board

# Würfel
## Vorbereitung
* Projekt <samp>dice/dice.xise</samp> öffnen

## Aufgabenstellung
Mittels sieben LEDs wird ein Würfel dargestellt. Eine Taste startet durch das Drücken einen *Zufallsgenerator* und beim
Loslassen wird das Ergebnis angezeigt. Dieser *Zufallsgenerator* ist ein Zähler, der mit 50Mhz die 6 möglichen Zustände
durchwechselt.

## Decoder testen
<span class="badge">5 Punkte</span>

Der Decoder wandelt den Eingang `value_i` (3 Bit) in die entsprechende 7 LEDs Darstellung `leds_o` (7 Bit) um. Dabei
wird folgende kodierung verwendet:

LED6|LED5|LED4|LED3|LED2|LED1|LED0
:-:|:-:|:-:|:-:|:-:|:-:|:-:
Aus|Aus|Aus|**Ein**|Aus|Aus|Aus
Aus|Aus|**Ein**|Aus|**Ein**|Aus|Aus
Aus|**Ein**|Aus|**Ein**|Aus|**Ein**|Aus
**Ein**|Aus|**Ein**|Aus|**Ein**|Aus|**Ein**
**Ein**|**Ein**|Aus|**Ein**|Aus|**Ein**|**Ein**
**Ein**|**Ein**|**Ein**|Aus|**Ein**|**Ein**|**Ein**

* Die erste Zeile entspricht der Darstellung bei `value_i` gleich `"000"`
* *Ein* wird mittels `'1'` kodiert, *Aus* mittels `'0'`
* Bei nicht definierten Zustände sollen alle LEDs aus sein

Die Komponente ist in vier Ausführungen (*Architectures*) bereits in der Datei <samp>decoder.vhd</samp> beschrieben. Die
*Architectures* lauten `behave1`, `behave2`, `behave3` und `behave4`.

Erstelle in der Datei <samp>decoder_tb.vhd</samp> eine Testbench, die herausfindet, welche der vier Ausführungen
funktioniert (es ist genau eine).

## Komponente `shuffle`
<span class="badge">5 Punkte</span>

Erstelle die Komponente `shuffle` durch Bearbeitung der Datei <samp>shuffle.vhd</samp> nach folgender Skizze:

![Shuffle Komponente]({filename}test2_shuffle.jpg)

* Wenn `enable_i` auf `'1'` ist, soll der interne Zähler `counter_reg` bei einer steigenden Taktflanke hinaufzählen
* Der interne Zähler soll von 0 bis 5 zählen
* Das Register `result_reg` übernimmt bei einer steigenden Taktflanke den Wert von `counter_reg`, wenn `enable_i` gleich `'0'` ist

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>shuffle_tb.vhd</samp>.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>shuffle</samp>, <samp>decoder</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>dice.vhd</samp> die gewünschte Funktionalität zu realisieren.

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>dice_tb.vhd</samp>.

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
