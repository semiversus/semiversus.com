title: VHDL Signaltypen
next: operatoren.md
parent: uebersicht.md

# Allgemeines
Um eine digitale Schaltung beschreiben zu können benötigt man Leitungen, um einzelne Komponenten miteinander zu
verbinden. *Leitungen* entsprechen bei VHDL sogennanten Signalen (Schlüsselwort <code>signal</code>). Um in VHDL ein Signal zu
definiere muss das Signal einen bestimmten Signaltyp haben.

Der einfachste Signaltyp ist <code>bit</code>. Dieser Signaltyp kennt die beiden Werte <code>0</code> und <code>1</code>. Dies mag für digitale
Schaltungen auf den ersten Blick ausreichend erscheinen, es gibt aber einige Situationen, in denen diese beiden Werte
nicht ausreichen.

Signale werden wie folgt definiert:

    #!vhdl
    signal <name> : <typ>; -- Signal <name> ist vom Typ <typ> und wird nicht initialisert
    signal <name> : <typ> := <default>; -- Signal <name> ist vom Typ <typ> und wird mit <default> initialisiert

# Standard Logic 1164
Die der Bibliothek *Standard Logic 1164* werden Signaltypen definiert, die mehr als <code>0</code> und <code>1</code> darstellen können. Um
diese Bibliothek in einer VHDL Datei zu verwenden sind folgende zwei Zeilen notwendig:

    #!vhdl
    library ieee ;
    use ieee.std_logic_1164.all;

Diese Typen haben 9 Werte (d.h. werden sie auch *9-wertige Logik* genannt)

* <code>U</code>: *undefiniert* - wird für nichtinitalisierte Signale in der Simulation verwendet
* <code>X</code>: *unbekannt* (starker Treiber) - wenn zwei Ausgänge miteinander verbunden werden, die gegeneinander treiben
  (<code>0</code> und <code>1</code>)
* <code>0</code>: *logische Null* (starker Treiber)
* <code>1</code>: *logische Eins* (starker Treiber)
* <code>Z</code>: *hochohmig*
* <code>W</code>: *unbekannt* (schwacher Treiber)
* <code>L</code>: *logische Null* (schwacher Treiber)
* <code>H</code>: *logische Eins* (schwacher Treiber)
* <code>-</code>: *unwichtig* (vgl. *don't care* in KV-Diagrammen)

Werden mehrere Ausgänge zusammengeschalten setzen sich starke Treiber gegenüber schwachen durch. Ein <code>U</code> setzt sich
gegenüber aller anderen Werten durch. Die Funktion, die die Auflösung beschreibt nennt sich <code>resolution</code>-Funktion.

!!! panel-warning "*Resolved* Signale"
    Innerhalb eines FPGAs gibt es nie die Notwendigkeit mehrer Ausgänge **direkt** miteinander zu verbinden. Man hat
    immer die Möglichkeit, dies über eine Kombinatorik zu tun.

## <code>std_logic</code> und <code>std_ulogic</code>
Der Signaltyp <code>std_logic</code> wird in der Bibliothek *Standard Logic 1164* definiert und nutzt die oben gezeigte 9-wertige
Logik. Der Signaltype <code>std_logic</code> ist *resolved*, d.h. es ist möglich mehrere Ausgänge direkt miteinander zu verbinden.
Dies kann eine Fehlersuche erschweren, wenn versehentlich ein Signal von zwei Treibern angesteuert wird. Je nach Synthese-
Tool wird kein Fehler angezeigt.

Um nun zu verhindern, dass versehentlich zwei Treiber ein Signal ansteuern gibt es den Signaltyp <code>std_ulogic</code>. Das *U*
steht dabei für *unresolved* - es wird also bei mehreren Treibern nicht aufgelöst. Das Synthese-Tool gibt also auf
alle Fälle einen Fehler aus.

Was spricht für <code>std_logic</code>?

* Viele bestehende Beispiele und Lösungen verwenden <code>std_logic</code>
* Generierte VHDL Beschreibungen enthalten oft <code>std_logic</code>

Was spricht für <code>std_ulogic</code>?

* Es ist nicht versehentlich möglich, mit mehreren Treibern ein Signal anzusteuern
* Simulationen sind (manchmal) schneller, da es die *Resolution*-Funktion nicht benötigt

Eine Umwandlung von <code>std_logic</code> zu <code>std_ulogic</code> und umgekehrt ist jederzeit möglich.

!!! panel-info "In diesem Skriptum wird <code>std_ulogic</code> verwendet"
    Alle gezeigten Beispiele mit <code>std_ulogic</code> lassen sich auch mittels <code>std_logic</code> realisieren.

## Definition eines Signals mit <code>std_ulogic</code>

    #!vhdl
    signal led_reg : std_ulogic := '0'; -- Hier wird das Signal led_reg als std_ulogic definiert und mit '0' initialisiert

# Busse mittels <code>std_ulogic_vector</code>
In vielen Anwendungen werden mehrere Signale zu einem *Bus* zusammengefasst. Dazu wird der Signaltyp <code>std_ulogic_vector</code>
verwendet.

Um einen Bus <code>data_reg</code> mit 8 Signalen zu definieren und diesen mit den Bits <code>"00000001"</code> zu initialisieren wird folgende
Definition genutzt:

    #!vhdl
    signal data_reg : std_ulogic_vector(7 downto 0) := "00000001";

## <code>downto</code> und <code>to</code>
Im obigen Beispiel wurde <code>downto</code> genutzt um innerhalb des Vektors die einzelnen Indizies zu definieren. Wir können auf
ein einzelnes Signal im Bus mittels <code>data_reg(0)</code> zugreifen. Dies wurde laut obiger Definition <code>'1'</code> zurückliefern und
entspricht somit (wie erwartet) dem niederwertigsten Bit.

Würde <code>data_reg</code> wie folgt definiert sein:

    #!vhdl
    signal data_reg : std_ulogic_vector(0 to 7) := "00000001";

würden wir bei <code>data_reg(0)</code> den Wert <code>'0'</code> zurückbekommen, da der Index 0 nun dem äußerst linken Bit entspricht.

!!! panel-info "Verwende <code>downto</code>"
    Da bei den meisten Darstellungen das höchstwertigste Bit links und das niederwertigste Bit rechts steht bietet sich
    <code>downto</code> an. Prinzipiell spricht nichts gegen eine Verwendung von <code>to</code> solange man weiß, was man tut!

## Literale
Wir haben im obigen Beispiel die Initialisierung mit dem Bitstring <code>"00000001"</code> gesehen. Solche Werte werden *Literale* (
engl. *literals*) genannt. In diesem Beispiel wird jedes einzelne Bit aufgeschlüsselt. Das gleiche Ergebnis erzielt man
mittels <code>x"01"</code> für die Darstellung mittels hexadezimaler Zahl.

Eine andere Möglichkeit bietet die Darstellung mittels Mapping:

    #!vhdl
    signal data_reg : std_ulogic_vector(7 downto 0) := (0 => '1', others=>'0');

Diese Definition setzt den Index 0 auf <code>'1'</code> und alle anderen Bits auf <code>'0'</code>.

## Verknüpfen von Bussen
Busse lassen sich beliebig zusammenführen und aufteilen. Im folgenden Beispiel wird der 8 Bit Bus <code>data_in_reg</code> in zwei
Teilbusse <code>low_nibble</code> und <code>high_nibble</code> mit jeweils 4 Bit aufgeteilt. Der 8 Bit Bus <code>data_out_reg</code> besteht aus den
einzelnen 4 Bit Bussen, die in umgekehrter Reihenfolge wieder zusammengesetzt werden.

    #!vhdl
    signal data_in_reg : std_ulogic_vector(7 downto 0);
    signal low_nibble : std_ulogic_vector(3 downto 0);
    signal high_nibble : std_ulogic_vector(3 downto 0);
    signal data_out_reg : std_ulogic_vector(7 dowto 0);

    low_nibble <= data_in_reg(3 downto 0);
    high_nibble <= data_in_reg(7 downto 4);
    data_out_reg <= low_nibble & high_nibble;

Das gleiche würde sich auch wie folgt realisieren lassen:

    #!vhdl
    data_out_reg <= data_in_reg(3 downto 0) & data_in_reg(7 downto 4);

# Numerische Signaltypen <code>unsigned</code> und <code>signed</code>
Der Signaltyp <code>std_ulogic_vector</code> ist eine einfache Ansammlung einzelner <code>std_ulogic</code> Signale. Damit zu rechnen ist
nicht unmittelbar möglich. Für diese Anwendungsfälle gibt es die Bibliothek <code>numeric_std</code> mit den Signaltypen <code>unsigned</code>
und <code>signed</code>.

    #!vhdl
    library ieee ;
    use ieee.numeric_std.all;

Die Definition selbst entspricht der Definition von Bussen mittels <code>std_ulogic_vector</code>:

    #!vhdl
    signal counter_reg : unsigned(7 downto 0);

Damit werden nun Addition und Subtraktion mit anderen <code>unsigned</code> bzw. <code>signed</code> Typen sowie *Integern* möglich:

    #!vhdl
    counter_reg <= counter_reg + 1;

# Ganzzahlen mittels <code>integer</code>

In vielen Anwendungen werden arithmetische Operationen mit Signalen durchgeführt. Oft ist es aber nicht notwendig, auf
die einzelnen Bits zuzugreifen. Für solche Zwecke gibt folgende Ganzzahl Signaltypen:

* <code>integer</code>: Ganzzahl, je nach Synthesetool meist als 32 Bit vorzeichbehaftete Zahl representiert
* <code>natural</code>: Subtype von <code>integer</code> die positive Zahlen inklusive <code>0</code> enthält.
* <code>positive</code>: Subtype von <code>integer</code> die ausschließlich positive Zahlen enthält (ohne <code>0</code>).

## Eingrenzung mittels <code>range</code>
Für Signale kann der Wertebereich der Ganzzahltypen weiter eingeschränkt werden. Für einen Zähler im Dezimalsystem
bietet sich eventuell folgende Definition an:

    #!vhdl
    signal dec_counter_reg : integer range 0 to 9;

!!! panel-warning "Überlauf bei <code>integer</code>"
    Wenn wie im obigen Beispiel der Bereich auf 0 bis 9 eingeschränkt ist, bedeutet dies nicht, dass bei einem Überlauf
    (9+1) das Ergebnis auf 0 überläuft. Es ist ein Hinweis für Simulation und Synthese, die im Falle eine Warnung
    ausgeben können, der Überlauf selbst muss aber durch eine eigene Beschreibung abgefangen werden.

# Konvertierung und Casting

Wird ein Signaltyp mit dem Wert eines anderen Signaltyps angesteuert benötigt man eine Konvertierung bzw. einen *Cast*.

Die Typen <code>std_ulogic_vector</code>, <code>unsigned</code> und <code>signed</code> sind Vektoren. Hier reicht es aus den Typ zu *casten*. Bei einer
Umwandlung von einem <code>integer</code> zu einem Vektor benötigt man die Information, wieviele Bits notwendig sind.

Für die folgenden Beispiele gehen wir von folgender Definition aus:

    #!vhdl
    signal sul_vector : std_ulogic_vector(7 downto 0);
    signal u_vector : unsigned(7 downto 0);
    signal s_vector : signed(7 downto 0);
    signal int : integer range 0 to 255;

## <code>std_ulogic_vector</code>

    #!vhdl
    u_vector <= unsigned(sul_vector);
    s_vector <= signed(sul_vector);
    int <= to_integer(unsigned(sul_vector));

Die Umwandlung eines <code>std_ulogic_vector</code> in <code>unsigned</code> und <code>signed</code> geht einfach, da es sich nur die Interpretation der
Bits ändert.

Bei der Umwandlung in einen <code>integer</code> gibt es das Problem, dass <code>std_ulogic_vector</code> nur eine Ansammlung
von Bits ist, ohne eine Wertigkeit vorzugeben. Die Umwandlung zu <code>integer</code> geschieht über einen Cast zu <code>unsigned</code> bzw.
<code>signed</code> und dann die Konvertierung in einen <code>integer</code>.

## <code>unsigned</code> und <code>signed</code>

    #!vhdl
    -- Umwandlung von unsigned
    sul_vector <= std_ulogic_vector(u_vector);
    int <= to_integer(u_vector);

    -- Umwandlung von signed
    sul_vector <= std_ulogic_vector(s_vector);
    int <= to_integer(s_vector);

Die Umwandlung funktioniert hier änhlich zu <code>std_ulogic_vector</code>.

## <code>integer</code>

    #!vhdl
    u_vector <= to_unsigned(int, 8);
    s_vector <= to_signed(int, 8);
    sul_vector <= std_ulogic_vector(to_unsigned(int, 8));

Bei der Konvertierung eines <code>integer</code>s in einen Vektor sind entsprechende Konvertierungsfunktionen zu nutzen. Der Weg
von <code>integer</code> zu <code>std_ulogic_vector</code> kann dabei je nach Anwendung über <code>to_unsigned</code> und <code>to_signed</code> führen.
