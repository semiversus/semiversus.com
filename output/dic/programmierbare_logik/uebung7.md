title: VHDL Übung 7 - Testbench
parent: uebersicht.md

# Übungsaufgabe

In dieser Übung geht es um Testbenches.

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_7.compress){: class="download" } herunterladen und entpacken
* Projekt <code>testbench.xise</code> öffnen

# Schreiben der Testbench
## Spezifikation
Die Komponente <code>shifter</code> soll folgender Spezifikation entsprechen

* Die Komponente hat einen Ausgangsvektor <code>leds_o</code> mit 4 Bit Breite
* Nach dem Reset bzw. nach der Initialisierung wird <code>"0001"</code> auf <code>leds_o</code> ausgegeben.
* Ist während einer steigenden Taktflanke an <code>clk_i</code> der Eingang <code>up_i</code> aktiv sollen die Ausgänge in folgender Reihenfolge wechseln: <code>"0010"</code>, <code>"0100"</code>, <code>"1000"</code> und dann wieder <code>"0001"</code>
* Ist während einer steigenden Taktflanke an <code>clk_i</code> der Eingang <code>down_i</code> aktiv sollen die Ausgänge in folgender Reihenfolge wechseln: <code>"1000"</code>, <code>"0100"</code>, <code>"0010"</code> und dann wieder <code>"0001"</code>
* <code>down_i</code> hat die höhere Priorität wie <code>up_i</code>
* Ist weder <code>up_i</code> noch <code>down_i</code> aktiv, soll sich der Ausgang nicht verändern
* Der Eingang <code>reset_i</code> führt einen asynchronen Reset aus und dies hat die höchste Priorität

## Schreiben der Testbench
Erweitere die Datei <samp>shifter_tb.vhd</samp>.

* Mittels <code>assert</code> können Bedingungen geprüft werden.
* Mittels <code>wait for</code> kann für eine bestimmte Zeit gewartet werden.

Beispiel:

    #!vhdl
    wait for 10 ns;
    assert leds_o="0001" report "Nach dem Reset sollte der Ausgang auf 0001 sein";

Der Teil mit <code>report</code> ist optional. Ein <code>wait for 0 ns</code> wertet einmal alle Signale aus, dies hilft oft direkt nach dem
Start der Simulation (unmittelbar nach dem Start sind alle Signale *uninitialised*-<code>'U'</code>).

## Prüfen der Testbench
Für die Komponente <code>shifter</code> stehen vier verschiedene Implementierungen zur Verfügung (*architectures*). Die Testbench
soll erkennen, welcher der vier Implementierungen funktioniert.

Die Testbenches heißen <code>behave1</code>, <code>behave2</code>, <code>behave3</code> und <code>behave4</code>.
