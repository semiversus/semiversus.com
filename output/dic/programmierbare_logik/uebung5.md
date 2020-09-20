title: VHDL Übung 5 - Stoppuhr
next: uebung6.md
parent: uebersicht.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird das BASYS2 Board verwendet"
    Für weitere Fragen zum Board bitte das [Manual]({filename}basys2_manual.pdf){: class="download" } konsultieren.

* Entwurf einer universeller Zählerkomponente
* Erkennung eines Tastendrucks
* Implementierung einer Zustandsmaschine
* Aufbau eines Top Levels

Die Stoppuhr entspricht in ihrer Bedienung einer klassichen digitalen Stoppuhr. Zwei Tasten reichen für die Bedienung
aus:

* **Start/Stop** - die Zeitnehmung wird gestartet bzw. gestopped
* **Reset/Lap** - die Zeitnumung wird zurückgesetzt bzw. die Zwischenzeit angezeigt

Die vier 7-Segment Anzeigen werden für die Ausgabe der Zeit verwendet (hier 0 Minuten, 13 Sekunden und 5
Zehntelsekunden):

![Stopwatch auf Basys2 Board]({filename}stopwatch_basys2.png)

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_5.compress){: class="download" } herunterladen und entpacken
* Projekt <code>stopwatch.xise</code> öffnen

# Entwicklung einer universellen Zählerkomponente
## Spezifikation
Der Zähler soll folgende Spezifikation erfüllen (immer synchron zur steigenden Taktflanke von <code>clk</code>):

* Wenn <code>enable_i</code> auf <code>0</code> ist soll der Zähler nicht zählen
* Wenn <code>enable_i</code> auf <code>1</code> ist soll der Zähler sich um eins erhöhen
* Wenn der Zählerstand <code>MAXIMUM</code> erreicht soll der Zähler (im nächsten Schritt) auf 0 gesetzt werden
* Solange <code>reset_i</code> auf <code>1</code> ist, soll der Zählerstand auf 0 gesetzt werden
* Ein gesetzes <code>reset_i</code> hat eine höhere Priorität als ein gesetzes <code>enable_i</code>
* <code>value_o</code> entspricht dem internen Zählerstand
* <code>overflow_o</code> ist <code>1</code>, wenn der interne Zählerstand bei <code>MAXIMUM</code> steht und <code>enable_i</code> auf <code>1</code> ist (kombinatorisch
verknüpft)

## Implementierung
* Öffne <code>counter.vhd</code>
* Erweitere das Design entsprechend der folgenden Spezifikation (an den mit <code>TODO</code> markierte Stellen)

## Test mittels Testbench

* Wechsle im Design Tab bei *View* nach *Simulation*
* Wähle die Testbench <code>counter_tb</code> (Datei <code>counter_tb.vhd</code>)
* Starte die Simulation mittels *Simulate Behavioral Model*

![XISE Simulation View]({filename}xise_simulation.png)

Beim Durchlaufen der Testbench werden etwaige Fehler des Design angezeigt. Eine erfolgreiche Testbench endet ohne
Fehlerausgaben:

![XISE Simulation View]({filename}counter_simulation.png)

# Tastendruck Erkennung
## Spezifikation
Tasteneingänge sind asynchron zum globalen Takt, deswegen müssen sie einsynchronisiert werden. Nachdem der Eingang
synchronisiert ist benötigt man im allgemeinen eine synchrone Flankenerkennung, d.h. bei einer steigenden Flanke soll
der Ausgang <code>detect_o</code> für einen Taktzyklus lang auf <code>1</code> sein. Eine fallende Flanke soll ignoriert werden.

## Timingdiagramm

![Timingdiagramm]({filename}uebung5_timing.svg.tex)

## Implementierung
Bearbeite dazu die Datei <code>button_detect.vhd</code>. Die beiden Register <code>button_reg1</code> und <code>button_reg2</code> dienen der
Einsynchronisierung des asynchronen Signals von <code>button_i</code>.

## Test mittels Testbench

* Wechsle im Design Tab bei *View* nach *Simulation*
* Wähle die Testbench <code>button_detec_tb</code> (Datei <code>button_detect_tb.vhd</code>)
* Starte die Simulation mittels *Simulate Behavioral Model*

Beim Durchlaufen der Testbench werden etwaige Fehler des Design angezeigt. Eine erfolgreiche Testbench endet ohne
Fehlerausgaben (siehe [Test des universellen Zählers](#test-mittels-testbench)).

# Zustandsmaschine für die Stoppuhr
## Spezifikation

Die Zustandsmaschine für die Stoppuhr soll im ersten Schritt drei Zustände umfassen:

* <code>CLEARED</code>
    * Zeit läuft nicht
    * Stoppuhr steht auf "0:00:0"
    * Mittels *Start/Stopp* soll die Zeitnehmung starten
    * *Reset/Lap+ hat keine Auswirkung
* <code>RUNNING</code>
    * Zeit läuft
    * Zeigt die aktuelle Zeit an
    * Mittels *Start/Stopp* soll die Zeitnehmung gestoppt werden
    * *Reset/Lap* hat keine Auswirkung
* <code>STOPPED</code>
    * Stoppuhr läuft nicht
    * Zeigt die (gestoppte) Zeit an
    * Mittels *Start/Stopp* soll die Zeitnehmung fortgesetzt werden
    * Mittels *Reset/Lap* soll die Zeit auf "0:00:0" zurückgesetzt werden

Die Zustandmaschine hat zwei Eingaben (Taster *Start/Stopp* und *Reset/Lap*). Die Ausgabe <code>clear_o</code> setzt die Zähler
zurück. Solange <code>enable_o</code> auf <code>'1'</code> ist laufen die Zähler.

## Zustandsdiagramm
Zeichne das Zustandsdiagramm. Wähle einen passenden Zustandsmaschinentyp aus
([Mealy oder Moore]({filename}../grundlagen_der_digitaltechnik/automatentheorie.md#moore-und-mealy-automat_1)).

## Implementierung
Vervollständige die Vorlage von <code>stopwatch_fsm</code>. Dort sind die Zustände <code>CLEARED</code>, <code>RUNNING</code> und <code>STOPPED</code> als Typ
definiert. Die Behandlung des Zustands <code>CLEARED</code> und die Ausgabe von <code>clear_o</code> ist als Beispiel bereits implementiert.

Der Ausgang <code>mode_o</code> wird erst später benötigt und soll vorerst nur <code>'0'</code> ausgeben.

    #!vhdl
    architecture behave of stopwatch_fsm is
      type state_t is (CLEARED, RUNNING, STOPPED);
      signal state : state_t := CLEARED;
    begin
      fsm_process: process (clk)
      begin
        if rising_edge(clk) then
          case state is
            when CLEARED =>
              if ss_i='1' then
                state <= RUNNING;
              end if;
            when RUNNING =>
              -- TODO
            when others => -- includes STOPPED
              -- TODO
          end case;
        end if;
      end process;

      clear_o <= '1' when state=CLEARED else '0';
      enable_o <= '0'; -- <<< TODO
      mode_o <= '0';
    end architecture;

## Test mittels Testbench
Teste die Zustandmaschine  mittels der Testbench <code>stopwatch_fsm_simple_tb</code> (Achte auf das <code>simple</code> im Name!).

# Integration aller Komponenten im Top Level
Mit den erstellten Komponenten wird nun ein Stoppuhr-Design aufgebaut. Dazu erweitern wird das Top Level Design in
<code>stopwatch.vhd</code>.

## Tastendruckerkennung`

Die Komponente <code>button_dect</code> wird verwendet, um das Signal <code>button_ss_i</code> und <code>button_rl_i</code> einzusynchronisieren und auf
eine steigende Flanke zu überprüfen. Dazu wird folgende Komponente in der <code>architecture</code> von <code>stopwatch.vhd</code> hinzugefügt:

    #!vhdl
    button_ss_detect_component: entity work.button_detect
    port map (
      clk => clk,
      button_i => button_ss_i,
      detect_o => button_ss_detect
    );

Analoges Vorgehen für die Taste <code>button_rl_i</code>.

## Zustandsmaschine

Die Zustandmaschine wird nun auch entsprechend eingebunden.

* Erstelle eine Instanz von <code>stopwatch_fsm</code> mit dem Namen <code>stopwatch_fsm_component</code>
* Verbinde den Eingang <code>clk</code> mit dem Signal <code>clk</code>
* Verbinde den Eingang <code>ss_i</code> mit dem Signal <code>button_ss_detect</code>
* Verbinde den Eingang <code>rl_i</code> mit dem Signal <code>button_rl_detect</code>
* Verbinde den Ausgang <code>mode_o</code> mit nichts (<code>open</code>)
* Verbinde den Ausgang <code>clear_o</code> mit dem Signal <code>clear</code>
* Verbinde den Ausgang <code>enable_o</code> mit dem Signal <code>enable</code>

## Vorteiler

Um Zehntelsekunden zu erzeugen wird ein Vorteiler mit dem Faktor 5 Millionen verwendet.

    #!vhdl
    prescale_component: entity work.counter
    generic map (
      WIDTH => 23,
      MAXIMUM => 5000000
    )
    port map (
      clk => clk,
      reset_i => clear,
      enable_i => enable,
      value_o => open,
      overflow_o => tenth_second_enable
    );

* Diese <code>counter</code> wird über das <code>generic map</code> als Zähler mit 23 Bit und Maximum bei 5 Millionen definiert
* Der Ausgang <code>value_o</code> wird nicht verwendet (wird durch <code>open</code> signalisiert)
* <code>overflow_o</code> steuert das Signal <code>tenth_second_enable</code> an (ist nun alle 5 Millionen Takte für einen Takt high)
* <code>enable_i</code> wird durch <code>enable</code> angesteuert (Ausgang der Zustandsmaschine)
* <code>reset_i</code> wird durch <code>clear</code> angesteuert (Ausgang der Zustandsmaschine)

## Zehntelsekunde
* Erstelle eine weitere Instanz eines Zählers(<code>tenth_second_component</code>) analog zu <code>prescale_component</code>
* <code>WIDTH</code> und <code>MAXIMUM</code> müssen nicht extra definiert werden (<code>generic map</code> kann wegfallen), da diese Werte der
  Standardeinstellung entsprechen
* <code>enable_i</code> wird durch <code>tenth_second_enable</code> angesteuert
* <code>reset_i</code> wird durch <code>clear</code> angesteuert
* <code>value_o</code> steuert <code>digit0</code> an
* <code>overflow_o</code> steuert <code>second_enable</code> an

## Sekunde
* Erstelle eine weitere Instanz eines Zählers(<code>second_component</code>) analog zu <code>tenth_second_component</code>
* <code>enable_i</code> wird durch <code>second_enable</code> angesteuert
* <code>value_o</code> steuert <code>digit1</code> an
* <code>overflow_o</code> steuert <code>ten_second_enable</code> an

## Zehner Sekunde
* Erstelle eine weitere Instanz eines Zählers(<code>ten_second_component</code>) analog zu <code>tenth_second_component</code>
* <code>MAXIMUM</code> wird auf 5 gestellt (Sekunden gehen bis 59) - dazu wird die <code>generic map</code> genutzt
* <code>enable_i</code> wird durch <code>ten_second_enable</code> angesteuert
* <code>value_o</code> steuert <code>digit2</code> an
* <code>overflow_o</code> steuert <code>minute_enable</code> an

## Minute
* Erstelle eine weitere Instanz eines Zählers(<code>minute_component</code>) analog zu <code>tenth_second_component</code>
* <code>enable_i</code> wird durch <code>minute_enable</code> angesteuert
* <code>value_o</code> steuert <code>digit3</code> an
* <code>overflow_o</code> wird nicht verwendet (mit <code>open</code> verbunden)

## <code>display</code> hinzufügen

    #!vhdl
    display_component: entity work.display
    port map (
      clk => clk,
      digit0_i => digit0,
      digit1_i => digit1,
      digit2_i => digit2,
      digit3_i => digit3,
      dots_i => "1010",
      segments_o => segments_o,
      an_o => an_o
    );

## Test auf der Hardware
Wechsle in die Implementierungsansicht und synthetisiere das Top Level Desgin <code>stopwatch</code>. Teste die Funktionsweise
auf dem Basys2 Board aus.

# Erweiterung um Zwischenzeitnehmung
## Spezifikation
Im letzen Schritt gibt es eine Erweiterung des bestehenden Designs: Die Zwischenzeitnehmung.

* Im Zustand <code>RUNNING</code> wird durch Drücken von *Reset/Lap* in den Zustand <code>LAP</code> gwechselt werden
* In <code>LAP</code> wird nicht die aktuelle Zeit angezeigt, sondern eine *zwischengespeicherter* Zeit
* Im Zustand <code>LAP</code> wird durch Drücken von *Reset/Lap* wieder zurück in den Zustand <code>RUNNING</code> gewechselt werden
* Im Zustand <code>LAP</code> wird durch Drücken von *Start/Stopp* in den Zustand <code>LAP_STOPPED</code> gewechselt werden
* Im Zustand <code>LAP_STOPPED</code> läuft die Zeit nicht weiter, es wird weiterhin die *zwischengespeicherte* Zeit angezeigt
* Im Zustand <code>LAP_STOPPED</code> wird durch Drücken von *Reset/Lap* in den Zustand *STOPPED* gewechselt

## Implementierung
Die Eingänge <code>digit0</code> bis <code>digit3</code> der <code>display_component</code> werden nun nicht mehr über die Zähler angesteuert sondern mittels
Register (<code>digit0_reg</code>, ... ist bereits definiert). Dieses Register soll die Eingänge <code>digit0</code>, ... übernehmen, wenn
das Signal <code>mode</code> auf <code>'1'</code> ist (Ausgang der Zustandsmaschine). Füge dazu einen <code>process</code> im Top Level ein.

Erweitere die Zustandsmaschine um die zusätzlichen Zustände und steuere <code>mode_o</code> entsprechend der Spezifikation an.

## Test mittels Testbench
Für die überarbeitete Zustandsmaschine steht eine Testbench bereit (<code>stopwatch_fsm_tb</code>).

## Test auf der Hardware
Wechsle in die Implementierungsansicht und synthetisiere das Top Level Desgin <code>stopwatch</code>. Teste die Funktionsweise
auf dem Basys2 Board aus.
