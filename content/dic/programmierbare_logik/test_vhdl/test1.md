title: VHDL Test (1)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_1.compress) herunterladen und entpacken
* Insgesamt gibt es <span class="badge">29 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Lichtsteuerung
## Vorbereitung
* Projekt <tt>led_control/led_control.xise</tt> öffnen

## Aufgabenstellung
Es ist eine einfache Lichtsteuerung zu entwerfen. Diese Lichtsteuerung steuert eine LED an und wird mittels zwei Tasten
bedient:

* `button_toggle` - Schaltet das Licht ein bzw. aus
* `button_off` - Schaltet das Licht in 5 Sekunden aus

## Entwurf der Zustandsmaschine 
<span class="badge">5 Punkte</span>

Zur Realisierung wird eine Zustandsmaschine genutzt.

* Bearbeite die Datei <tt>led_control_fsm.vhd</tt>
* Definiere die drei Zuständen `OFF`, `LIGHT` und `DOZE`
* Der Startzustand ist `OFF`
* Der Eingang `toggle_i` wechselt von `OFF` nach `LIGHT` bzw. von `LIGHT` oder `DOZE` nach `OFF`
* Der Eingang `off_i` wechselt von `LIGHT` nach `DOZE`, bei den anderen Zuständen hat er keine Auswirkung
* Der Eingang `timeout_i` bewirkt ein Wechsel von `DOZE` nach `OFF`, bei den anderen Zuständen hat er keine Auswirkung
* Der Ausgang `led_o` ist auf `'1'`, wenn die Zustandmaschine im Zustand `LIGHT` oder `DOZE` ist
* Der Ausgang `timer_enable_o` ist im Zustand `DOZE` auf `'1'`, ansonsten `'0'`
* Der Ausgang `timer_clear_o` ist im Zustand `LIGHT` auf `'1'`, ansonsten `'0'`

![FSM für Lichtsteuerung]({filename}test1_led_control_fsm.svg.tex)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>led_control_fsm_tb.vhd</tt>. Mittels <kbd>F6</kbd> lässt sich
    der gesamte Bereich zoomen.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <tt>counter</tt>, <tt>button_dectect</tt> und <tt>led_control_fsm</tt>. Diese
Komponenten werden genutzt, um im Top Level <tt>led_control.vhd</tt> die gewünschte Funktionalität zu realisieren.

* Die Instanz der Komponente <tt>button_detect</tt> mit dem Namen `toggle_detect_component` ist bereits erstellt
    * `button_i` ist mit dem Eingang `button_toggle_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `toggle_detect` verbunden
* Erstelle eine Instanz der Komponente <tt>button_detect</tt> mit dem Namen `off_detect_component` analog zu `toggle_detect_component`
    * `button_i` ist mit dem Eingang `button_off_i` verbunden
    * `detect_o` ist mit dem (bereits definiertem) Signal `off_detect` verbunden
* Erstelle eine Instanz der Komponente <tt>led_control_fsm</tt> mit dem Namen `led_control_fsm_component`
    * `toggle_i` ist mit dem Signal `toggle_detect` verbunden
    * `off_i` ist mit dem Signal `off_detect` verbunden
    * `timeout_i` ist mit dem (bereits definiertem) Signal `timeout` verbunden
    * `led_o` ist mit dem Ausgang `led_o` verbunden
    * `timer_enable_o` ist mit dem (bereits definiertem) Signal `timer_enable` verbunden
    * `timer_clear_o` ist mit dem (bereits definiertem) Signal `timer_clear` verbunden
* Erstelle eine Instanz der Komponente <tt>counter</tt> mit dem Namen `timeout_component`
    * `WIDTH` in der *generic map* wird auf 28 gestellt (28 Bit)
    * `MAXIMUM` wird auf `CLK_TIMEOUT_DIVIDER` gestellt (ist im *generic* Teil des Top Levels bereits definiert)
    * `enable_i` ist mit dem Signal `timer_enable` verbunden
    * `reset_i` ist mit dem Signal `timer_clear` verbunden
    * `value_o` ist nicht verbunden (`open`)
    * `overflow_o` ist mit dem Signal `timeout` verbunden
* Jede Komponente hat einen Takteingang `clk`, welcher mit dem globalen `clk` verbunden wird

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>led_control_tb.vhd</tt>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <tt>led_control.ucf</tt> ist nur das Signal `clk` definiert. Erweitere die Datei um folgende Zuordnungen

* `button_toggle_i` liegt an Pin `G12`
* `button_off_i` liegt an Pin `C11`
* `led_o` liegt an Pin `M5`

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board

# Helligkeitssteuerung mittels PWM
## Vorbereitung
* Projekt <tt>led_pwm/led_pwm.xise</tt> öffnen

## Aufgabenstellung
Die LED wird in diesem Beispiel mittels PWM angesteuert. Zwei Tasten steuern dabei die Helligkeit:

* `button_brighter` lässt die LED heller leuchten
* `button_darker` lässt die LED dunkler leuchten

Insgesamt gibt es 8 Helligkeitsstufen (3 Bit).

## PWM Erzeugung
<span class="badge">5 Punkte</span>

Ein PWM besteht aus einem Zähler, der ständig nach oben zählt. Bei einem Überlauf (im Bild mit *N2* beschrieben) fängt der Zähler einfach bei 0 wieder
an. Der Zählerstand wird verglichen mit einem vorgegebenen Pegel(*N1*) - sind diese gleich wird der Ausgang auf '0' gesetzt.
Bei einem Zählerstand von 0 wird der Ausgang auf '1' gesetzt (es sei den der vorgegebene Pegel ist 0).

<figure><img src="{filename}test1_pwm.svg"><figcaption>PWM Signalerzeugung (Bild: <a href="https://commons.wikimedia.org/wiki/File:DMT_Messung-PuBrei.svg">Saure</a> CC BY-SA 3.0)</figcaption></figure>

* Bearbeite die Datei <tt>pwm_generator.vhd</tt>.
* Der interne Zähler `counter_reg` zählt bei jeder steigenden Taktflanke nach oben
* Der Überlauf wird bewusst genutzt (es findet keine besondere Überprüfung statt)
* Der interne Zähler wird mit `level_i` verglichen - sind beide gleich wird `pwm_reg` auf `'0'` gesetzt
* Der interne Zähler wird weiters mit 0 verglichen - ist dies der Fall wird `pwm_reg` auf `'1'` gesetzt
* Für die Umwandlung des <tt>std_ulogic_vector</tt> `level_i` in ein <tt>unsigned</tt> verwende `unsigned(level_i)`
* Für den Vergleich des internen Zählers mit 0 wandle die 0 mittels `to_unsigned(0, WIDTH)` in ein <tt>unsigned</tt> um
* Der Ausgang `pwm_o` wird vom Registers `pwm_reg` angesteuert

![Blockschaltbild für PWM Erzeugung]({filename}test1_pwm_generator.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>pwm_generator_tb.vhd</tt>.

## Helligkeitseinstellung
<span class="badge">5 Punkte</span>

Um einen Pegel für die PWM vorzugeben benötigen wir eine Komponente den einen Pegel abhängig von Tastendrücken ändern kann.
Diese Komponente hat folgende Eingänge:

* `up_i` - Wenn dieser Eingang gleich `'1'` ist wird der Pegel um eins erhöht. Ist der Pegel auf Maximum wird nichts geändert.
* `down_i` - Bei aktivem `down_i` wird der Pegel um eins erniedrigt. Ist der Pegel auf 0 wird nichts geändert.

Die Ausgabe der Komponente ist der Ausgang `level_o`.

* Bearbeite die Datei <tt>level_adjust.vhd</tt>.
* Der Register `level_reg` zählt hinauf, wenn `up_i` gleich `'1'` ist bzw. hinunter wenn `down_i` gleich `'1'` ist
* Wenn `level_reg` am Maximum ist und `up_i` aktiv ist sollte der Wert sich nicht verändern
* Wenn `level_reg` am Minimum (0) ist und `down_i` aktiv ist sollte der Wert sich nicht verändern

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>level_adjust_tb.vhd</tt>.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <tt>button_dectect</tt>, <tt>pwm_generator</tt> und <tt>level_adjust</tt>. Diese
Komponenten werden genutzt, um im Top Level <tt>led_pwm.vhd</tt> die gewünschte Funktionalität zu realisieren.

Das *Generic* `PWM_WIDTH` ist eine Konstante die genutzt werden kann, um das Generic `WIDTH` von <tt>pwm_generator</tt>
und <tt>level_adjust</tt> zu setzen. Das bei diesen 3 die Default Einstellung ist, wird es nicht unbedingt benötigt.

Einige benötigte Signale sind bereits vordefiniert.

Erstelle das Top Level anhand des folgenden Blockschaltbildes:

![Top Level für LED PWM]({filename}test1_led_pwm.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <tt>led_pwm_tb.vhd</tt>.

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
