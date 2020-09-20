title: Modellierungsarten
parent: uebersicht.md

# Verhaltensmodellierung
Bei der Verhaltensmodellierung wird ein System durch einen Algorithmus in VHDL Notation veschrieben. Es werden keine
Gatter oder komplexere Komponenten direkt verwendet. Ein Verhaltensmodell ist im Prinzip eine *Black Box* Sicht des zu
beschreibenden Systems.

Ein [Volladdierer]({filename}../grundlagen_der_digitaltechnik/schaltnetze.md#voll-addierer) lässt sich mittels Verhaltensmodellierung wie folgt beschreiben:

    #!vhdl
    entity fulladder is
      port(
        x, y, cin: in std_ulogic;
        s, cout:out std_ulogic
      );
    end entity;

    architecture behave of fulladder is
    begin
      s <= '0' when (x = '0' and y = '0' and cin = '0') else
           '1' when (x = '0' and y = '0' and cin = '1') else
           '1' when (x = '0' and y = '1' and cin = '0') else
           '0' when (x = '0' and y = '1' and cin = '1') else
           '1' when (x = '1' and y = '0' and cin = '0') else
           '0' when (x = '1' and y = '0' and cin = '1') else
           '0' when (x = '1' and y = '1' and cin = '0') else
           '1' when (x = '1' and y = '1' and cin = '1');
      cout <= '0' when (x = '0' and y = '0' and cin = '0') else
              '0' when (x = '0' and y = '0' and cin = '1') else
              '0' when (x = '0' and y = '1' and cin = '0') else
              '1' when (x = '0' and y = '1' and cin = '1') else
              '0' when (x = '1' and y = '0' and cin = '0') else
              '1' when (x = '1' and y = '0' and cin = '1') else
              '1' when (x = '1' and y = '1' and cin = '0') else
              '1' when (x = '1' and y = '1' and cin = '1');
    end architecture;

In der Beschreibung wird das Verhalten dargestellt, in diesem Beispiel mittels Umsetzung der Wahrheitstabelle.

# Strukturmodellierung
Die Basis für den strukturellen VHDL Entwurf ist ein synchrones Design. Prinzipiell besteht jedes synchrone Design aus
Kombinatorik und Flip-Flops (meist Register genannt), die alle auf einen gemeinsamen Takt synchronisiert sind.

Um das Design zu strukturieren wird meist das Design meist als Datenpfades aufgebaut. Elemente eines
Datenpfades sind dabei:

* Multiplexer
* Arithmetische Operatoren (Addierer, Subtrahierer, usw.)
* Logische Operatoren
* Komperatoren
* Register
* Diverse andere Elemente wie Vorzeichenerweiterung usw.

Die Elemente und die Pfade zwischen den Elementen können entweder einzelne Signale sein oder mehrere zusammengefasste
Signale (Busse).

## Beispiel

Im folgenden Beispiel soll ein Zähler aufgebaut werden mit drei Eingangssignale <code></code>value<code></code> (Bus mit 8 Bit), <code></code>load<code></code> und <code></code>clear<code></code>. Wie in allen
synchronen Designs wird ein gemeinsamer Takt für alle Register genutzt (hier <code></code>clock<code></code>). Das Register hat eine Bitbreite
von 8.

### Textuelle Beschreibung
Die Funktion soll wie folgt sein:

* Wenn <code></code>clear<code></code> gleich <code></code>1<code></code> ist, soll der Zählerstand auf <code></code>0<code></code> gesetzt werden,
* ansonsten wenn <code></code>load<code></code> gleich <code></code>1<code></code> ist, soll der Zählerstand auf <code></code>value<code></code> gesetzt werden
* ansonsten soll der Zählerstand um <code></code>value<code></code> erhöht werden.

### Schaltung
![Schaltung]({filename}vhdl_example_1.svg.tex)

### VHDL Entity

    #!vhdl
    entity sum is
      port (
        clk: in std_ulogic;
        value: in unsigned(7 downto 0);
        load: in std_ulogic;
        clear: in std_ulogic;
        result: out unsigned(7 downto 0)
      );
    end entity;

### VHDL Architecture

    #!vhdl
    architecture behave of sum is
    begin
      process(clk)
      begin
        if rising_edge(clk) then
          if clear='1' then
            result<=(others=>'0');
          elsif load='1' then
            result<=value;
          else
            result<=result+value;
          end if;
        end if;
      end process;
    end architecture;

### Timingdiagramm

![Timingdiagramm]({filename}vhdl_example_1_timing.svg.tex)

### Test des Designs

* [Online VHDL Modell mit Testbench](http://www.edaplayground.com/x/EcA){: class="external" }

## Umsetzung des Volladdierers
    #!vhdl
    entity fulladder is
      port(
        x, y, cin: in std_ulogic;
        s, cout:out std_ulogic
      );
    end entity;

    architecture structural of fulladder is
      signal halfadder1_s : std_ulogic ;
      signal halfadder1_cout : std_ulogic ;
      signal halfadder2_cout : std_ulogic ;
    begin
      halfadder1: entity work.halfadder
        port map (
          x => x,
          y => y,
          cout => halfadder1_cout,
          s => halfadder1_s
        );
      halfadder2: entity work.halfadder
        port map (
          x => halfadder1_s,
          y => cin,
          cout => halfadder2_cout,
          s => s
        );

      cout <= halfadder1_cout or halfadder2_cout;
    end architecture;

An diesem Beispiel für die strukturelle Modellierung sieht man den Aufbau mittels Komponenten. Dadurch
ergibt sich eine Hierarchie der Komponenten.

# Datenflussmodellierung
Bei der Datenfluss wird der *Fluss* der Daten modelliert. Dabei werden auf die Eingänge Transformationen
angewendet, um die Ausgänge zu berechnen.

    #!vhdl
    entity fulladder is
      port(
        x, y, cin: in std_ulogic;
        s, cout:out std_ulogic
      );
    end entity;

    architecture dataflow of fulladder is
    begin
      s <= x xor y xor cin;
      cout <= (x and y) or ( (x xor y) and cin);
    end architecture;
