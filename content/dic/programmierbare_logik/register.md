title: Register
next: synchronisierung.md
parent: uebersicht.md

# Allgemeines

Register dienen in der Digitaltechnik dazu, Werte zu speichern. Register können durch verschiedene Arten von Flip-Flops
realisiert werden (siehe [sequentielle Logik]({filename}../grundlagen_der_digitaltechnik/sequentielle_logik.md)).

# Register mit Reset

!!! panel-info "Name für das Reset Signal"
    Wie beim Taktsignal steht es dem Entwickler frei, einen Namen für das Resetsignal zu wählen. In der Praxis wird
    meist <code>rst</code> oder <code>reset</code> verwendet. Je nach Anwendung kann es *high*- oder *low*-aktiv sein. Bei *low*-aktiven Resets
    wird meist ein Postfix verwendet, der darauf hindeutet (z.B. <code>rst_n</code> für *NOT*).

    In diesem Skriptum wird das Resetsignal mit <code>rst</code> bezeichnet und ist bei *High* aktiv.

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

Dem taktflanken getriggerten D FlipFlop wurde ein asynchroner Reset hinzugefügt. <code>rst</code> wurde der Sensitivitätsliste hinzugefügt, d.h. der <code>process</code> wird auch für Änderungen an <code>rst</code> getriggert. Innerhalb des <code>process</code> wird zuerst <code>rst</code> ausgewertet und erst dann auf eine steigende Taktflanke überprüft.

![D-Flipflop mit asynchronem Reset]({filename}dff_async.svg.tex)

## Mit synchronem Reset

In diesem Beispiel soll der Zustand nur bei einer steigenden Taktflanke von <code>clk</code> und bei <code>rst</code> auf <code>1</code> zurüclgesetzt werden. Das Zurücksetzen erfolgt also synchron zum Takt.

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

Die Sensitivity List besteht nur mehr aus dem <code>clk</code> Signal. Bei einer steigenden Taktflanke wird ausgewertet, ob <code>rst</code> gleich <code>1</code> ist. Wenn dies der Fall ist, wird der interne Zustand <code>data_o</code> auf <code>0</code> gesetzt, ansonsten wird der Wert von <code>data_i</code> übernommen.

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
