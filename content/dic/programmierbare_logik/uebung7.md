title: VHDL Übung 7 - Testbench
parent: uebersicht.md

# Übungsaufgabe

In dieser Übung geht es um Testbenches.

# Vorbereitung

* [Projektordner]({filename}vhdl_uebung_7.compress){: class="download" } herunterladen und entpacken
* Projekt `testbench.xise` öffnen

# Schreiben der Testbench
## Spezifikation
Die Komponente `shifter` soll folgender Spezifikation entsprechen

* Die Komponente hat einen Ausgangsvektor `leds_o` mit 4 Bit Breite
* Nach dem Reset bzw. nach der Initialisierung wird `"0001"` auf `leds_o` ausgegeben.
* Ist während einer steigenden Taktflanke an `clk_i` der Eingang `up_i` aktiv sollen die Ausgänge in folgender Reihenfolge wechseln: `"0010"`, `"0100"`, `"1000"` und dann wieder `"0001"`
* Ist während einer steigenden Taktflanke an `clk_i` der Eingang `down_i` aktiv sollen die Ausgänge in folgender Reihenfolge wechseln: `"1000"`, `"0100"`, `"0010"` und dann wieder `"0001"`
* `down_i` hat die höhere Priorität wie `up_i`
* Ist weder `up_i` noch `down_i` aktiv, soll sich der Ausgang nicht verändern
* Der Eingang `reset_i` führt einen asynchronen Reset aus und dies hat die höchste Priorität

## Schreiben der Testbench
Erweitere die Datei <samp>shifter_tb.vhd</samp>.

* Mittels `assert` können Bedingungen geprüft werden.
* Mittels `wait for` kann für eine bestimmte Zeit gewartet werden.

Beispiel:

    #!vhdl
    wait for 10 ns;
    assert leds_o="0001" report "Nach dem Reset sollte der Ausgang auf 0001 sein";

Der Teil mit `report` ist optional. Ein `wait for 0 ns` wertet einmal alle Signale aus, dies hilft oft direkt nach dem
Start der Simulation (unmittelbar nach dem Start sind alle Signale *uninitialised*-`'U'`).

## Prüfen der Testbench
Für die Komponente `shifter` stehen vier verschiedene Implementierungen zur Verfügung (*architectures*). Die Testbench
soll erkennen, welcher der vier Implementierungen funktioniert.

Die Testbenches heißen `behave1`, `behave2`, `behave3` und `behave4`.
