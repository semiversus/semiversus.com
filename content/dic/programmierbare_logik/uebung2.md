title: VHDL Übung 2 - Blink
next: uebung3.md
parent: uebersicht.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird das BASYS2 Board verwendet"
    Für weitere Fragen zum Board bitte das [Manual]({filename}basys2_manual.pdf) konsultieren.

In dieser Übung wollen wir eine LED blinken lassen. Dazu nutzen wir den 50Mhz Takt, den das BASYS2 Board liefert.


# Vorbereitung 

* [Projektordner]({filename}vhdl_uebung_2.compress) herunterladen und entpacken
* Projekt `blink.xise` öffnen

# Top Level `blink.vhd`

    #!vhdl
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    entity blink is
      port (
        clk : in std_ulogic; -- 50 MHz clock
        led_o : out std_ulogic
      );
    end entity;

    architecture behave of blink is
    begin
      led_o <= '1'; 
    end architecture;

# Aufgabe 1 - Erstellen der UCF Datei
* Der Takt `clk` befindet sich am Pin `B8`.
* Die LED (`led_o`) ist am Pin `M5` angeschlossen.
* Erweitere dazu die Datei `blink.ucf` (siehe [Übung 1 - UCF Datei]({filename}uebung1.md#pinout) als Beispiel).

# Aufgabe 2 - Implementierung des Zählers
Um nun eine LED blinken zu lassen benötigen wir einen Zähler. Wenn 50 Millionen Taktzyklen gezählt sind ist eine Sekunde
vergangen. Dazu ändern wir die `architecture` wie folgt ab:

    #!vhdl
    architecture behave of blink is
      signal counter_reg : unsigned(31 downto 0) := (others => '0');
      signal led_reg : std_ulogic := '0';
    begin
      counter_proc: process(CLK)
      begin
        if rising_edge(CLK) then
          if counter_reg=50000000 then
            counter_reg <= (others => '0');
            led_reg <= not led_reg;
          else
            counter_reg <= counter_reg + 1;
          end if;
        end if;
      end process;

      led_o <= led_reg;
    end architecture;

# Aufgabe 3 - Überprüfung der Funktionsweise
Synthetisiere das Design und lade es auf das Board. Kontrolliere die korrekte Funktion.

# Aufgabe 4 - Timing Constraints setzen
Es gibt im Moment keine Vorgaben an die Taktfrequenz. Um eine solche Vorgabe zu machen, müssen wir einen
*Timing Constraint* setzen.

Wir erweitern dazu die Datei `blink.ucf` um folgende zwei Zeilen, um einen Takt von 50 Mhz zu spezifizieren.

    #!bash
    NET "clk" TNM_NET = CLK;
    TIMESPEC TS_CLK = PERIOD "clk" 50 MHz HIGH 50%;

Nachdem wir nun das Projekt synthetisieren betrachten wir die *Design Summary*:

![Design Summary]({filename}screenshot_design_summary.png)

# Aufgabe 5 - Auswählbare Blinkfrequenz

* Erweiterung von `blink.ucf` um folgende Zeile: `NET "switch_i" LOC="P11";`

Hinzufügen eines Eingangs in der Entity

    #!vhdl
    entity blink is
      port (
        clk : in std_ulogic; -- 50 MHz clock
        switch_i : in std_ulogic;
        led_o : out std_ulogic
      );
    end blink;

Nun soll die Blinkperiode bei `switch_i` gleich `0` eine Sekunde sein, bei `1` eine Zehntelsekunde.
