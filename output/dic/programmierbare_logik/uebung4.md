title: VHDL Übung 4 - Strukturelles Design
next: uebung5.md
parent: uebersicht.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird das BASYS2 Board verwendet"
    Für weitere Fragen zum Board bitte das [Manual]({filename}basys2_manual.pdf){: class="download" } konsultieren.

In dieser Übung wird die Unterteilung in mehrere Komponenten gezeigt.

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_4.compress){: class="download" } herunterladen und entpacken
* Projekt <code>structural.xise</code> öffnen

# Aufgabe 1 - Zeichne eine Schaltung für <code>display.vhd</code>
In der Datei <code>display.vhd</code> werden die vier 7-Segment Anzeigen angesteuert. Dazu wird das Display mittels "Multiplex"
angesteuert, sprich jeds einzelme 7-Segment Anzeige ist nur abwechselnd nur kurze Zeit aktiv. Durch den schnellen
Wechsel bekommt das träge Auge des Menschen eine scheinbar "stehende" Anzeige zu sehen.

# Aufgabe 2 - <code>CLK_DIVIDER</code>
<code>CLK_DIVIDER</code> ist ein *Generic* mit dem eine Komponente parametrisiert werden kann. Erweitere die Einbindung vom <code>display</code>
in <code>structural.vhd</code> wie folgt:

    #!vhdl
    display_component: entity work.display
      generic map (
        CLK_DIVIDER => 50000
      )
      port map (
        digit0_i => "0011",
        digit1_i => "0010",
        digit2_i => "0001",
        digit3_i => "0000",
        clk => clk,
        segments_o => segments_o,
        an_o => an_o
      );

Damit ist die Geschwindigkeit, in der die Anzeigen *gemultiplext* werden parametrisierbar. Was passiert, wenn <code>CLK_DIVIDER</code>
die Werte 50 oder 1 zugewiesen wird? Was bei den Werten eine Million oder 50 Millionen?

# Aufgabe 3 - Implementierung eines 16 Bit Zählers
In der Datei <code>structural.vhd</code> soll ein 16 Bit Zähler implementiert werden, der mit 100 Hertz zählt.

Nutze dazu die signals <code>pre_counter_reg</code> als Vorteiler und <code>counter_reg</code> als 16 Bit Zähler. Die beiden Zähler können
mittels zwei <code>process</code> Anweisungen implementiert werden oder auch beide gemeinsam in einer <code>process</code> Anweisung. Im
folgenden Beispiel wird auch die Aufteilung des 16 Bit Zählregisters auf die jeweils 4 Bit Eingänge <code>digit0_i</code> bis <code>digit3_i</code>
gezeigt.

    #!vhdl
    architecture behave of structural is
      signal pre_counter_reg : integer range 0 to 500000 := 0; -- 50Mhz/500.000=100Hz
      signal counter_reg : unsigned(15 downto 0) := (others => '0');
    begin
      --
      -- < Hier > Implementierung der Zähler
      ---

      display_component: entity work.display
        port map (
          digit0_i => std_ulogic_vector(counter_reg(3 downto 0)),
          digit1_i => std_ulogic_vector(counter_reg(7 downto 4)),
          digit2_i => std_ulogic_vector(counter_reg(11 downto 8)),
          digit3_i => std_ulogic_vector(counter_reg(15 downto 12)),
          clk => clk,
          segments_o => segments_o,
          an_o => an_o
        );
    end architecture;

# Aufgabe 4 - Rücksetzen des Zählers mittels <code>button_i</code>

In der Toplevel-Entity ist ein Eingang <code>button_i</code> vorgesehen, der noch nicht verwendet wurde. Beim Drücken des Buttons
soll der 16 Bit Zähler zurückgesetzt werden.
