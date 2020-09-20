title: VHDL Übung 1 - Kombinatorische Logik
parent: uebersicht.md
next: uebung2.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird das BASYS2 Board verwendet"
    Für weitere Fragen zum Board bitte das [Manual]({filename}basys2_manual.pdf){: class="download" } konsultieren.

In dieser Übung nutzen wir vier Schalter des BASYS2 Boards (SW0 bis SW3) um damit eine 4 Bit Zahl einzugeben. Im FPGA
soll eine Kombinatorik entworfen werden, um mittels dieser 4 Bit Zahl eine 7 Segment Anzeige anzusteuern.

SW3|SW2|SW1|SW0|Ausgabe auf der 7 Segment Anzeige
:-:|:-:|:-:|:-:|:-:
Aus|Aus|Aus|Aus|0
Aus|Aus|Aus|Ein|1
Aus|Aus|Ein|Aus|2
Aus|Aus|Ein|Ein|3
Aus|Ein|Aus|Aus|4
Aus|Ein|Aus|Ein|5
Aus|Ein|Ein|Aus|6
Aus|Ein|Ein|Ein|7
Ein|Aus|Aus|Aus|8
Ein|Aus|Aus|Ein|9

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_1.compress){: class="download" } herunterladen und entpacken
* Projekt <code>seven_segments.xise</code> öffnen

# Top Level <code>seven_segments.vhd</code>

<code>seven_segments.vhd</code> ist das Top Level Design und definiert die oberste Ebene, d.h. diese Entity beschreibt mit ihrer
<code>port</code>-Direktive die Pins des FPGA Bausteins.

    #!vhdl
    library ieee;
    use ieee.std_logic_1164.all;

    entity seven_segment is
      port (
        switches_i : in std_ulogic_vector(3 downto 0);
        an_o : out std_ulogic_vector(3 downto 0);
        segments_o : out std_ulogic_vector(6 downto 0) -- segments "ABCDEFG"
      );
    end entity;

    architecture behave of seven_segment is
    begin
      with switches_i select segments_o <=
        "0000001" when "0000", -- display 0
        "1001111" when "0001", -- display 1
        -- ...
        "1111111" when others;

      an_o <= "0111";
    end architecture;

## Pinout
Die Signale <code>switches_i</code>, <code>an_o</code> und <code>segments_o</code> finden sich im folgenden Pinout des BASYS2 Boards:
<figure><img src="{filename}basys2_pinout.svg"><figcaption>Pinout des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

Das Pinout wird in der Datei <code>seven_segments.ucf</code> beschrieben. Für dieses VHDL Modell sieht es wie folgt aus:

    #!bash
    NET "switches_i(3)" LOC = "B4";
    NET "switches_i(2)" LOC = "K3";
    NET "switches_i(1)" LOC = "L3";
    NET "switches_i(0)" LOC = "P11";

    NET "an_o(3)" LOC = "K14"; # driver for left most display
    NET "an_o(2)" LOC = "M13";
    NET "an_o(1)" LOC = "J12";
    NET "an_o(0)" LOC = "F12"; # driver for right most display

    NET "segments_o(6)" LOC = "L14"; # segment A
    NET "segments_o(5)" LOC = "H12"; # segment B
    NET "segments_o(4)" LOC = "N14"; # segment C
    NET "segments_o(3)" LOC = "N11"; # segment D
    NET "segments_o(2)" LOC = "P12"; # segment E
    NET "segments_o(1)" LOC = "L13"; # segment F
    NET "segments_o(0)" LOC = "M12"; # segment G

## 7-Segment Anzeige
In der folgenden Abbildung sieht man die Anordnung der einzelnen Segmente:
<figure><img src="{filename}basys2_7segment.svg"><figcaption>7-Segment Anzeige des BASYS2 Boards(Bild: <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,790&Prod=BASYS2">Digilent Inc. BASYS2 Manual</a>)</figcaption></figure>

# Aufgabe 1 - Erweitern der kombinatorischen Beschreibung
    #!vhdl
    with switches_i(3 downto 0) select segments_o <=
      "0000001" when "0000", -- digit 0
      "1001111" when "0001", -- digit 1
      -- ...
      "1111111" when others;

Die kombinatorische Beschreibung ist nicht vollständig. Das Ziel ist es die Kombinatorik entsprechend um die Anzeige der
Werte 2 bis 9 zu erweitern.

# Aufgabe 2 - Test auf dem Board

Das Projekt soll synthetisiert und auf dem Board getestet werden.

# Aufgabe 3 - Erweiterung um die Darstellung von Hexadezimalzahlen

SW3|SW2|SW1|SW0|Ausgabe auf der 7 Segment Anzeige
:-:|:-:|:-:|:-:|:-:
Ein|Aus|Ein|Aus|A
Ein|Aus|Ein|Ein|B
Ein|Ein|Aus|Aus|C
Ein|Ein|Aus|Ein|D
Ein|Ein|Ein|Aus|E
Ein|Ein|Ein|Ein|F

* Überlege dir, wie die einzelnen Segmente angesteuert werden sollen, um die Buchstaben <code>A</code> bis <code>F</code> darzustellen.
* Teste das Design auf dem BASYS2 Board
