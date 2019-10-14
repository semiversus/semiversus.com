title: Process-Statement
next: register.md
parent: uebersicht.md

# Allgemeines
Ein <code>process</code> hat folgende Eigenschaften:

* Er besteht aus sequentiellen Anweisungen.
* Eine *Sensitivity List* definiert die Signale, bei deren Änderung die Anweisungen ausgewertet werden.
* Die "Ausführung" läuft parallel zu allen anderen <code>process</code> Statements
* Der <code>process</code> selbst enthält keine nebenläufige Statements
* Es erlaubt eine funktionale Beschreibung ähnlich zu einer Programmiersprache

# Prozess für kombinatorische Schaltungen
Bei kombinatorischen Schaltungen gibt es keine speichernden Elemente. Die Ausgänge sind direkt von den Eingängen abhängig.

## Beispiel

    #!vhdl
    half_adder_sum: process (a_i, b_i)
    begin
      carry_o <= a_i and b_i;
    end process;

Dieser Prozess wertet den Ausdruck <code>a_i and b_i</code> aus und weist das Ergebnis <code>carry_o</code> zu. Diese Auswertung geschieht
sobald sich <code>a_i</code> oder <code>b_i</code> ändert.

Einen kombinatorischen Prozess zeichnet aus, dass bei der Auswertung nur die Pegel der Signale ausgewertet werden.

!!! panel-warning "Unvollständige Sensitivity Liste"
    Für kombinatorische Prozesse ist eine vollständige Sensitivity Liste wichtig. Wird im obigen Beispiel etwa <code>a_i</code>
    vergessen baut die Synthese ein speicherndes Element ein (Latch)!

Das obige Beispiel entspricht genau der folgenden nebenläufigen Anweisung:

    #!vhdl
    carry_o <= a_i and b_i;

# Prozess für sequentielle Schaltungen
Sequentiellen Schaltungen werden mittels speichernden Elementen (*Register*) realisiert. Bei
[synchronen Schaltungen]({filename}../grundlagen_der_digitaltechnik/synchrones_design.md) arbeiten alle Register mit
einem globalen Takt und reagieren auf die gleiche Taktflanke. Typischerweise wird die steigende Taktflanke gewählt,
prinzipiell lässt sich aber auch die fallende Taktflanke wählen.

## Erkennung einer Takflanke
Um eine Taktflanke erkennen zu können ist es notwendig, das Taktsignal in der Sensitivitätsliste hinzuzufügen. Damit wird
der Prozess ausgewertet, wenn sich am Taktsignal etwas ändert.

!!! panel-info "Name für das Taktsignal"
    Es steht dem Entwickler frei, einen Namen für das Taktsignal zu wählen. In der Praxis wird meist <code>clk</code> oder <code>clock</code>
    gewählt, sofern es nur einen Takt im Design gibt. Gibt es mehrere Takte bieter sich ein *Postfix* wie <code>clk_master</code>
    an.

    In diesem Skriptum wird das Taktsignal mit <code>clk</code> bezeichnet.

Im folgenden Beispiel wird die Verwendung der Funktion <code>rising_edge</code> gezeigt, um auf eine steigende Flanke an <code>clk</code> zu
reagieren:

## Beispiel
    #!vhdl
    library ieee ;
    use ieee.std_logic_1164.all;

    entity dff is
      port(
        clk: in std_ulogic;
        data_i: in std_ulogic;
        data_o: out std_ulogic
      );
    end entity;

    architecture behave of dff is
    begin
        process(clk)
        begin
          if rising_edge(clk) then
            data_o <= data_i;
          end if;
        end process;
    end architecture;

Statt der Funktion <code>rising_edge</code> lässt sich auch folgendes Konstrukt verwenden:

    #!vhdl
    process(clk)
    begin
      if clk'event and clk='1' then
        data_o <= data_i;
      end if;
    end process;

# Anweisung innerhalb eines Prozesses
## <code>if</code>-Anweisung
Die <code>if</code>-Answeisung wertet die Bedingung aus und entsprechend dann den *Wahr* Zweig oder gegebenenfalls den *Falsch*
Zweig (<code>else</code>) oder eine andere Bedingung aus (<code>elsif</code>). Die <code>if</code> Anweisung wird mit <code>endif;</code> beendet.

### Beispiel

    #!vhdl
    process(clear, load, input, counter)
    begin
      if clear='1' then
        result <= (others => '0');
      elsif load='1' then
        result <= input
      else
        result <= counter + 1;
      end if;
    end process;

!!! panel-info "Vergleich mit *nebenläufiger* Anweisung"
    Der Syntax von VHDL ist oft nicht sehr konsistent. Das gleiche Ergebnis lässt sich durch folgende Zuweisung als
    *nebenläufige* Anweisung realisieren:

        #!vhdl
        result <= (others => '0') when clear='1' else
                  input when load='1' else
                  counter + 1;

    Es gilt die unterschiedliche Anordnung zu beachten. Die Funktionalität ist identisch.

## <code>case</code>-Anweisung
Die <code>case</code>-Anweisung überprüft den Zustand eines Signals und führt davon abhängig eine Anweisung aus.

### Beispiel
    #!vhdl
    process(digit_i)
    begin
      case digit_i is
        when "0000" =>
          segments_o <= "0000001"; -- display 0
        when "0001" =>
          segments_o <= "1001111"; -- display 1
        when "0010" =>
          segments_o <= "0010010"; -- display 2
        -- ...
        when others =>
          segments_o <= "1111111";
      end case;
    end process;

!!! panel-info "Vergleich mit *nebenläufiger* Anweisung"
    Hier der Vergleich mit der entsprechenden <code>with</code>/<code>select</code> Anweisung als *nebenläufige* Anweisung:

        #!vhdl
        with digit_i select segments_o <=
          "0000001" when "0000", -- display 0
          "1001111" when "0001", -- display 1
          "0010010" when "0010", -- display 2
          -- ...
          "1111111" when others;

    Auch hier ist die Funktionalität identisch, die Schreibweise unterscheidet sich aber stark.

## <code>for</code>-Schleife
Die <code>for</code> Schleife erlaubt den vielfachen Aufbau eines Schaltungsteils.

### Beispiel
    #!vhdl
    process(clk)
    begin
      if rising_edge(clk) then
        for i in range 1 to 7 loop
          shift_reg(i) <= shift_i(i-1);
        end loop;
        shift_reg(0) <= '0';
      end if;
    end process;

Die Laufvariable <code>i</code> muss nicht eigens definiert werden. Der Typ für <code>i</code> ergibt sich aus den Elementen des Bereichs.
