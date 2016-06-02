title: Process-Statement
next: register.md
parent: uebersicht.md

# Allgemeines
Ein `process` hat folgende Eigenschaften:

* Er besteht aus sequentiellen Anweisungen.
* Eine *Sensitivity List* definiert die Signale, bei deren Änderung die Anweisungen ausgewertet werden.
* Die "Ausführung" läuft parallel zu allen anderen `process` Statements
* Der `process` selbst enthält keine nebenläufige Statements
* Es erlaubt eine funktionale Beschreibung ähnlich zu einer Programmiersprache

# Prozess für kombinatorische Schaltungen
Bei kombinatorischen Schaltungen gibt es keine speichernden Elemente. Die Ausgänge sind direkt von den Eingängen abhängig.

## Beispiel

    #!vhdl
    half_adder_sum: process (a_i, b_i)
    begin
      carry_o <= a_i and b_i;
    end process;

Dieser Prozess wertet den Ausdruck `a_i and b_i` aus und weist das Ergebnis `carry_o` zu. Diese Auswertung geschieht
sobald sich `a_i` oder `b_i` ändert.

Einen kombinatorischen Prozess zeichnet aus, dass bei der Auswertung nur die Pegel der Signale ausgewertet werden.

!!! panel-warning "Unvollständige Sensitivity Liste"
    Für kombinatorische Prozesse ist eine vollständige Sensitivity Liste wichtig. Wird im obigen Beispiel etwa `a_i`
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
    Es steht dem Entwickler frei, einen Namen für das Taktsignal zu wählen. In der Praxis wird meist `clk` oder `clock`
    gewählt, sofern es nur einen Takt im Design gibt. Gibt es mehrere Takte bieter sich ein *Postfix* wie `clk_master`
    an.

    In diesem Skriptum wird das Taktsignal mit `clk` bezeichnet.

Im folgenden Beispiel wird die Verwendung der Funktion `rising_edge` gezeigt, um auf eine steigende Flanke an `clk` zu
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

Statt der Funktion `rising_edge` lässt sich auch folgendes Konstrukt verwenden:

    #!vhdl
    process(clk)
    begin
      if clk'event and clk='1' then
        data_o <= data_i;
      end if;
    end process;  

# Anweisung innerhalb eines Prozesses
## `if`-Anweisung
Die `if`-Answeisung wertet die Bedingung aus und entsprechend dann den *Wahr* Zweig oder gegebenenfalls den *Falsch*
Zweig (`else`) oder eine andere Bedingung aus (`elsif`). Die `if` Anweisung wird mit `endif;` beendet.

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

## `case`-Anweisung
Die `case`-Anweisung überprüft den Zustand eines Signals und führt davon abhängig eine Anweisung aus.

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
    Hier der Vergleich mit der entsprechenden `with`/`select` Anweisung als *nebenläufige* Anweisung:

        #!vhdl
        with digit_i select segments_o <=
          "0000001" when "0000", -- display 0
          "1001111" when "0001", -- display 1
          "0010010" when "0010", -- display 2
          -- ...
          "1111111" when others;
    
    Auch hier ist die Funktionalität identisch, die Schreibweise unterscheidet sich aber stark.

## `for`-Schleife
Die `for` Schleife erlaubt den vielfachen Aufbau eines Schaltungsteils.

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

Die Laufvariable `i` muss nicht eigens definiert werden. Der Typ für `i` ergibt sich aus den Elementen des Bereichs.
