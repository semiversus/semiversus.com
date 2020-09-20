title: Nebenläufigkeit
next: process.md
parent: uebersicht.md

# Allgemeines
Die <code>architecture</code> beschreibt den inneren Aufbau der Schaltung einer Komponente. Für diese Beschreibung stehen mehrere
Anweisungen zur Verfügung, die eine *Nebenläufigkeit* ermöglichen. Betrachtet man die Komponeten eine digitale Schaltung
laufen diese jede für sich gesehen unabhängig von der anderen. Die unabhängigkeit lässt sich auch mittels *Nebenläufigkeit*
(engl. *concurrent*) beschreiben, deswegen heißen diese Anweisungen auch engl. *concurrent statements*.

Es gibt folgende *concurrent statements*:

* <code>process</code> **Anweisungen** - Beschreiben einen nebenläufigen Prozess (siehe [<code>process</code> Anweisung]({filename}process.md))
* **Einfache Signalzuweisung** - Weist einen Ausdruck einem Signal zu
* **Bedingte Signalzuweisung** - Je nach Bedingung wird der *Wahr*-Ausdruck oder der *Falsch*-Ausdruck zugewiesen
* **Selektive Signalzuweisung** - Entspricht einem Multiplexer, der abhängig von einem *select*-Ausdruck den entsprechenden
Ausdruck auswählt.

# Einfache Signalzuweisung

    #!vhdl
    library ieee ;
    use ieee.std_logic_1164.all;

    entity half_adder is
      port(
        a_i: in std_ulogic;
        b_i: in std_ulogic;
        sum_o: out std_ulogic;
        carry_o: out std_ulogic
      );
    end entity;

    architecture behave of half_adder is
    begin
      sum_o <= a_i xor b_i;
      carry_o <= a_i and b_i;
    end architecture;

In diesem Beispiel wird ein [Halbaddierer]({filename}../grundlagen_der_digitaltechnik/schaltnetze.md#halb-addierer)
beschrieben. Bei den Signalzuweisungen von <code>sum_o</code> und <code>carry_o</code> handelt es sich um einfache Signalzuweisungen. Auf
der rechten Seite der Zuweisung steht ein Ausdruck, der durch Kombinatorik ausgewertet werden kann.

# Bedingte Signalzuweisung mittels <code>when</code>
Für eine bedingte Signalzuweisung wird folgender Syntax verwendet:

    #!vhdl
    signal <= expr_true when cond else expr_false;

Als konkretes Beispiel können wir wieder den Halbaddierer verwenden. Das Exklusiv-Oder lässt sich auch mittels Bedingung
realisieren. Ist der Eingang <code>b_i</code> gleich <code>0</code> enstpricht der Ausgang <code>a_i</code>, ansonsten entspricht der Ausgang <code>not a_i</code>:

## Beispiel

    #!vhdl
    sum_o <= a_i when b_i='0' else not a_i;

Bei einer bedingten Signalzuweisung wird immer ein Multiplexer mit zwei Eingängen beschrieben.

## Verschachtelung

Der Ausdruck im <code>else</code> Zweig kann auch wieder eine bedingte Signalzuweisung sein:

    #!vhdl
    result <= (others => '0') when clear='1' else
              input when load='1' else
              counter + 1;

# Selektive Signalzuweisung mittels <code>with</code>/<code>select</code>
Die *selektive* Signalzuweisung erlaubt den Aufbau eines Multiplexers mit mehreren Eingängen. Dazu wird folgender
Syntax verwendet:

    #!vhdl
    with select_expr select signal <=
      expr1 when choice,
      expr2 when choice2,
      expr3 when choice3,
      -- ...
      exprN when others;

## Beispiel
Dazu ein ausführlicheres Beispiel, das die Umwandlung einer 4 Bit BCD Zahl in eine Sieben Segment Anzeige erlaubt (siehe
auch [Übung1]({filename}uebung1.md)):

    #!vhdl
    library ieee;
    use ieee.std_logic_1164.all;

    entity seven_seg_decoder is
      port (
        digit_i : in std_ulogic_vector(3 downto 0);
        segments_o : out std_ulogic_vector(6 downto 0)
      );
    end entity;

    architecture behave of seven_seg_decoder is
    begin
      with digit_i select segments_o <=
        "0000001" when "0000", -- display 0
        "1001111" when "0001", -- display 1
        "0010010" when "0010", -- display 2
        "0000110" when "0011", -- display 3
        -- ...
        "1111111" when others;
    end architecture;
