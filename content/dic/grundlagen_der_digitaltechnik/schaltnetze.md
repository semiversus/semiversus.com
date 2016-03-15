title: Grundlegende Schaltnetze
parent: uebersicht.md

# Allgemeines
Es gibt viele Schaltnetze, deren Funktion häufig eingesetzt wird. Dabei werden die Schaltnetze nicht mehr auf der Ebene der Logikgatter betrachtet, sondern die Funktionalität wird abstrahiert.

## Multiplexer
Ein Multiplexer (auch oft kurz "Mux") selektiert aus mehreren Eingängen einen einzelnen aus und gibt den Wert, der an diesem Eingang anliegt am Ausgang aus. Man unterscheidet die Multiplexer nach Anzahl der Eingänge. Die einfachste Form ist ein Multiplexer mit zwei Eingängen.

![Multiplexer mit 2 Eingängen]({filename}mux2_symbol.svg)

In der Wahrheitstabelle wird ersichtlich, dass nur der jeweils ausgewählte Eingang den Ausgang beeinflusst. Ist `s0`=0 so gilt `a`=`e0`, bei `s0`=1 gilt `a`=`e1`.

s0|e1|e0|a 
:-:|:-:|:-:|:-:
0|x|0|0
0|x|1|1
1|0|x|0
1|1|x|1

Bei mehr als zwei Eingängen ist auch mehr als ein Selektionseingang notwendig.

![Multiplexer mit 4 Eingängen]({filename}mux4_symbol.svg)

## Halb-Addierer
Der Halb-Addierer dient zur Addition von zwei einstelligen Binärzahlen. Als Ausgang stehen das Summenbit und ein Übertragsbit (engl. `Carry`)  zur Verfügung. Der Übertrag wird benötigt, sobald man zwei mindestens zweistellige Binärzahlen addieren will.

![Halbaddierer]({filename}halbaddierer_struktur.svg)

x|y|s|c 
:-:|:-:|:-:|:-:
0|0|0|0
0|1|1|0
1|0|1|0
1|1|0|1

## Voll-Addierer
Der Voll-Addierer berücksichtigt einen Übertrag aus einer vorhergehenden Stufe. Der Voll-Addierer kann mittels zwei Halb-Addierer realisiert werden.

![Volladdierer]({filename}volladdierer_struktur.svg)

Um nun zwei 4 Bit Zahlen zu addieren, werden insgesamt vier einzelne Addierer benötigt, die jeweils zwei Bit unter Berücksichtigung eines Übertrages der Vorstufe addieren. Der Addierer, der die niederwertigsten Bits addiert kann auch ein Halbaddierer sein, da kein Übertrag beachtet werden muss. Wird ein Voll-Addierer genutzt, muss der entsprechende Übertragseingang auf `0` gesetzt werden.

![4Bit Addierer]({filename}ripple_carry_adder.svg)

## Komparator
Ein Komparator vergleicht zwei Binärzahlen gleicher Bitbreite miteinander. Eine einfache Ausführung des Komparators hat dabei nur einen "ist gleich"-Ausgang. Sind also beide Zahlen gleich groß, so wird der "ist gleich"-Ausgang auf `1` gesetzt. Eine Erweiterung stellt die Variante mit zusätzlichem "größer"- und "kleiner"-Ausgang dar.

Um mehrere Komparatoren zu kombinieren, sind Eingänge für "ist gleich", "größer" und "kleiner" Signale der Vorstufe notwendig.

![4 Bit Komparator]({filename}komparator_4bit.svg)

## Prioritätsenkoder
Der Prioritätsenkoder gibt die Nummer des aktiven Eingangs aus, der die höchste Priorität hat. Im folgenden Beispiel gibt es vier Eingänge (`i0` bis `i3`), wobei `i3` die höchste Priorität hat. Ist `i3` aktiv, wird am Ausgang der Wert 3 (`y1`=1, `y0`=1), unabhängig davon, welchen Zustand die anderen Eingänge haben.

i3|i2|i1|i0|y1|y0|
:-:|:-:|:-:|:-:|:-:|:-:
0|0|0|0|0|0
0|0|0|1|0|0
0|0|1|x|0|1
0|1|x|x|1|0
1|x|x|x|1|1
