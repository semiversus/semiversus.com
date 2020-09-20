title: VHDL Test (1)
parent: uebersicht.md

# Allgemeines
* [Projektordner]({filename}vhdl_test_1.compress){: class="download" } herunterladen und entpacken
* Insgesamt gibt es <span class="badge">29 Punkte</span>
* Die einzelnen Punkte bauen meist nicht aufeinander auf. Statt langer Fehlersuche lieber auf das nächste Beispiel wechseln.

# Lichtsteuerung
## Vorbereitung
* Projekt <samp>led_control/led_control.xise</samp> öffnen

## Aufgabenstellung
Es ist eine einfache Lichtsteuerung zu entwerfen. Diese Lichtsteuerung steuert eine LED an und wird mittels zwei Tasten
bedient:

* <code>button_toggle</code> - Schaltet das Licht ein bzw. aus
* <code>button_off</code> - Schaltet das Licht in 5 Sekunden aus

## Entwurf der Zustandsmaschine
<span class="badge">5 Punkte</span>

Zur Realisierung wird eine Zustandsmaschine genutzt.

* Bearbeite die Datei <samp>led_control_fsm.vhd</samp>
* Definiere die drei Zuständen <code>OFF</code>, <code>LIGHT</code> und <code>DOZE</code>
* Der Startzustand ist <code>OFF</code>
* Der Eingang <code>toggle_i</code> wechselt von <code>OFF</code> nach <code>LIGHT</code> bzw. von <code>LIGHT</code> oder <code>DOZE</code> nach <code>OFF</code>
* Der Eingang <code>off_i</code> wechselt von <code>LIGHT</code> nach <code>DOZE</code>, bei den anderen Zuständen hat er keine Auswirkung
* Der Eingang <code>timeout_i</code> bewirkt ein Wechsel von <code>DOZE</code> nach <code>OFF</code>, bei den anderen Zuständen hat er keine Auswirkung
* Der Ausgang <code>led_o</code> ist auf <code>'1'</code>, wenn die Zustandmaschine im Zustand <code>LIGHT</code> oder <code>DOZE</code> ist
* Der Ausgang <code>timer_enable_o</code> ist im Zustand <code>DOZE</code> auf <code>'1'</code>, ansonsten <code>'0'</code>
* Der Ausgang <code>timer_clear_o</code> ist im Zustand <code>LIGHT</code> auf <code>'1'</code>, ansonsten <code>'0'</code>

![FSM für Lichtsteuerung]({filename}test1_led_control_fsm.svg.tex)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_control_fsm_tb.vhd</samp>. Mittels <kbd>F6</kbd> lässt sich
    der gesamte Bereich zoomen.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>counter</samp>, <samp>button_dectect</samp> und <samp>led_control_fsm</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>led_control.vhd</samp> die gewünschte Funktionalität zu realisieren.

* Die Instanz der Komponente <samp>button_detect</samp> mit dem Namen <code>toggle_detect_component</code> ist bereits erstellt
    * <code>button_i</code> ist mit dem Eingang <code>button_toggle_i</code> verbunden
    * <code>detect_o</code> ist mit dem (bereits definiertem) Signal <code>toggle_detect</code> verbunden
* Erstelle eine Instanz der Komponente <samp>button_detect</samp> mit dem Namen <code>off_detect_component</code> analog zu <code>toggle_detect_component</code>
    * <code>button_i</code> ist mit dem Eingang <code>button_off_i</code> verbunden
    * <code>detect_o</code> ist mit dem (bereits definiertem) Signal <code>off_detect</code> verbunden
* Erstelle eine Instanz der Komponente <samp>led_control_fsm</samp> mit dem Namen <code>led_control_fsm_component</code>
    * <code>toggle_i</code> ist mit dem Signal <code>toggle_detect</code> verbunden
    * <code>off_i</code> ist mit dem Signal <code>off_detect</code> verbunden
    * <code>timeout_i</code> ist mit dem (bereits definiertem) Signal <code>timeout</code> verbunden
    * <code>led_o</code> ist mit dem Ausgang <code>led_o</code> verbunden
    * <code>timer_enable_o</code> ist mit dem (bereits definiertem) Signal <code>timer_enable</code> verbunden
    * <code>timer_clear_o</code> ist mit dem (bereits definiertem) Signal <code>timer_clear</code> verbunden
* Erstelle eine Instanz der Komponente <samp>counter</samp> mit dem Namen <code>timeout_component</code>
    * <code>WIDTH</code> in der *generic map* wird auf 28 gestellt (28 Bit)
    * <code>MAXIMUM</code> wird auf <code>CLK_TIMEOUT_DIVIDER</code> gestellt (ist im *generic* Teil des Top Levels bereits definiert)
    * <code>enable_i</code> ist mit dem Signal <code>timer_enable</code> verbunden
    * <code>reset_i</code> ist mit dem Signal <code>timer_clear</code> verbunden
    * <code>value_o</code> ist nicht verbunden (<code>open</code>)
    * <code>overflow_o</code> ist mit dem Signal <code>timeout</code> verbunden
* Jede Komponente hat einen Takteingang <code>clk</code>, welcher mit dem globalen <code>clk</code> verbunden wird

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_control_tb.vhd</samp>.

## Erweiterung der *Constraints* Datei
<span class="badge">2 Punkte</span>

In der Datei <samp>led_control.ucf</samp> ist nur das Signal <code>clk</code> definiert. Erweitere die Datei um folgende Zuordnungen

* <code>button_toggle_i</code> liegt an Pin <code>G12</code>
* <code>button_off_i</code> liegt an Pin <code>C11</code>
* <code>led_o</code> liegt an Pin <code>M5</code>

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board

# Helligkeitssteuerung mittels PWM
## Vorbereitung
* Projekt <samp>led_pwm/led_pwm.xise</samp> öffnen

## Aufgabenstellung
Die LED wird in diesem Beispiel mittels PWM angesteuert. Zwei Tasten steuern dabei die Helligkeit:

* <code>button_brighter</code> lässt die LED heller leuchten
* <code>button_darker</code> lässt die LED dunkler leuchten

Insgesamt gibt es 8 Helligkeitsstufen (3 Bit).

## PWM Erzeugung
<span class="badge">5 Punkte</span>

Ein PWM besteht aus einem Zähler, der ständig nach oben zählt. Bei einem Überlauf (im Bild mit *N2* beschrieben) fängt der Zähler einfach bei 0 wieder
an. Der Zählerstand wird verglichen mit einem vorgegebenen Pegel(*N1*) - sind diese gleich wird der Ausgang auf '0' gesetzt.
Bei einem Zählerstand von 0 wird der Ausgang auf '1' gesetzt (es sei den der vorgegebene Pegel ist 0).

<figure><img src="{filename}test1_pwm.svg"><figcaption>PWM Signalerzeugung (Bild: <a href="https://commons.wikimedia.org/wiki/File:DMT_Messung-PuBrei.svg">Saure</a> CC BY-SA 3.0)</figcaption></figure>

* Bearbeite die Datei <samp>pwm_generator.vhd</samp>.
* Der interne Zähler <code>counter_reg</code> zählt bei jeder steigenden Taktflanke nach oben
* Der Überlauf wird bewusst genutzt (es findet keine besondere Überprüfung statt)
* Der interne Zähler wird mit <code>level_i</code> verglichen - sind beide gleich wird <code>pwm_reg</code> auf <code>'0'</code> gesetzt
* Der interne Zähler wird weiters mit 0 verglichen - ist dies der Fall wird <code>pwm_reg</code> auf <code>'1'</code> gesetzt
* Für die Umwandlung des <samp>std_ulogic_vector</samp> <code>level_i</code> in ein <samp>unsigned</samp> verwende <code>unsigned(level_i)</code>
* Für den Vergleich des internen Zählers mit 0 wandle die 0 mittels <code>to_unsigned(0, WIDTH)</code> in ein <samp>unsigned</samp> um
* Der Ausgang <code>pwm_o</code> wird vom Registers <code>pwm_reg</code> angesteuert

![Blockschaltbild für PWM Erzeugung]({filename}test1_pwm_generator.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>pwm_generator_tb.vhd</samp>.

## Helligkeitseinstellung
<span class="badge">5 Punkte</span>

Um einen Pegel für die PWM vorzugeben benötigen wir eine Komponente den einen Pegel abhängig von Tastendrücken ändern kann.
Diese Komponente hat folgende Eingänge:

* <code>up_i</code> - Wenn dieser Eingang gleich <code>'1'</code> ist wird der Pegel um eins erhöht. Ist der Pegel auf Maximum wird nichts geändert.
* <code>down_i</code> - Bei aktivem <code>down_i</code> wird der Pegel um eins erniedrigt. Ist der Pegel auf 0 wird nichts geändert.

Die Ausgabe der Komponente ist der Ausgang <code>level_o</code>.

* Bearbeite die Datei <samp>level_adjust.vhd</samp>.
* Der Register <code>level_reg</code> zählt hinauf, wenn <code>up_i</code> gleich <code>'1'</code> ist bzw. hinunter wenn <code>down_i</code> gleich <code>'1'</code> ist
* Wenn <code>level_reg</code> am Maximum ist und <code>up_i</code> aktiv ist sollte der Wert sich nicht verändern
* Wenn <code>level_reg</code> am Minimum (0) ist und <code>down_i</code> aktiv ist sollte der Wert sich nicht verändern

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>level_adjust_tb.vhd</samp>.

## Implementierung des Top Levels
<span class="badge">5 Punkte</span>

Zur Verfügung stehen die Komponenten <samp>button_dectect</samp>, <samp>pwm_generator</samp> und <samp>level_adjust</samp>. Diese
Komponenten werden genutzt, um im Top Level <samp>led_pwm.vhd</samp> die gewünschte Funktionalität zu realisieren.

Das *Generic* <code>PWM_WIDTH</code> ist eine Konstante die genutzt werden kann, um das Generic <code>WIDTH</code> von <samp>pwm_generator</samp>
und <samp>level_adjust</samp> zu setzen. Das bei diesen 3 die Default Einstellung ist, wird es nicht unbedingt benötigt.

Einige benötigte Signale sind bereits vordefiniert.

Erstelle das Top Level anhand des folgenden Blockschaltbildes:

![Top Level für LED PWM]({filename}test1_led_pwm.jpg)

!!! panel-info "Testbench"
    Teste die Implementierung mittels der Testbench <samp>led_pwm_tb.vhd</samp>.

## Test am Board
<span class="badge">1 Punkt</span>

Synthetisiere das Projekt und teste das Ergebnis am Board
