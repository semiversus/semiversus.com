title: Register
next: synchronisierung.md
parent: uebersicht.md

# Allgemeines

Register dienen in der Digitaltechnik dazu, Werte zu speichern. Register können durch verschiedene Arten von Flip-Flops
realisiert werden (siehe [sequentielle Logik]({filename}../grundlagen_der_digitaltechnik/sequentielle_logik.md)).

# Register mit Reset

!!! panel-info "Name für das Reset Signal"
    Wie beim Taktsignal steht es dem Entwickler frei, einen Namen für das Resetsignal zu wählen. In der Praxis wird
    meist `rst` oder `reset` verwendet. Je nach Anwendung kann es *high*- oder *low*-aktiv sein. Bei *low*-aktiven Resets
    wird meist ein Postfix verwendet, der darauf hindeutet (z.B. `rst_n` für *NOT*).

    In diesem Skriptum wird das Resetsignal mit `rst` bezeichnet und ist bei *High* aktiv.

## Mit asynchronem Reset
    #!vhdl
    library ieee ;
    use ieee.std_logic_1164.all;

    entity dff is
      port(
        clk: in std_ulogic;
        rst: in std_ulogic;
        data_i: in std_ulogic;
        data_o: out std_ulogic
      );
    end entity;

    architecture behave of dff is
    begin
        process(rst, clk)
        begin
          if rst='1' then
            data_o <= '0';
          elsif rising_edge(clk) then
            data_o <= data_i;
          end if;
        end process;  
    end architecture;

Dem taktflanken getriggerten D FlipFlop wurde ein asynchroner Reset hinzugefügt. `rst` wurde der Sensitivitätsliste hinzugefügt, d.h. der `process` wird auch für Änderungen an `rst` getriggert. Innerhalb des `process` wird zuerst `rst` ausgewertet und erst dann auf eine steigende Taktflanke überprüft.

![D-Flipflop mit asynchronem Reset]({filename}dff_async.svg.tex)

## Mit synchronem Reset

In diesem Beispiel soll der Zustand nur bei einer steigenden Taktflanke von `clk` und bei `rst` auf `1` zurüclgesetzt werden. Das Zurücksetzen erfolgt also synchron zum Takt.

    #!vhdl
    library ieee ;
    use ieee.std_logic_1164.all;

    entity dff is
      port(
        clk: in std_ulogic;
        rst: in std_ulogic;
        data_i: in std_ulogic;
        data_o: out std_ulogic
      );
    end entity;

    architecture behave of dff is
    begin
        process(clk)
        begin
          if rising_edge(clk) then
            if rst='1' then
              data_o <= '0';
            else
              data_o <= data_i;
            end if;
          end if;
        end process;  
    end architecture;

Die Sensitivity List besteht nur mehr aus dem `clk` Signal. Bei einer steigenden Taktflanke wird ausgewertet, ob `rst` gleich `1` ist. Wenn dies der Fall ist, wird der interne Zustand `data_o` auf `0` gesetzt, ansonsten wird der Wert von `data_i` übernommen.

![D-Flipflop mit synchronem Reset]({filename}dff_sync.svg.tex)

## Mittels Initialisierung
In FPGAs lässt sich der Zustand eines FlipFlops nach einem Ein-Ausschalt Zyklus auch durch die Initialisierung des
entsprechenden Signals realisieren. Das Register hält dann den entsprechenden Initialisierungswert, nachdem der FPGA
sein Design geladen.

    #!vhdl
    architecture behave of dff is
      signal d_reg : std_ulogic := '0';
    begin
        process(clk)
        begin
          if rising_edge(clk) then
            d_reg <= data_i;
          end if;
        end process;

        data_o <= d_reg;
    end architecture;
