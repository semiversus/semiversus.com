title: Datenintegrität und Prüfsummen
parent: uebersicht.md

# Allgemeines
Um eine sichere Datenübertragung gewährleisten zu können ist es notwendig, dass der Empfänger eine fehlerhafte
Übertragung als solche erkennen kann (*Fehlererkennungsverfahren*). Es wird von einem *Fehlerkorrekturverfahren*
gesprochen, wenn darüber hinaus so viel Information zur Verfügung steht, dass aufgetretene Fehler korrigiert werden
können.

Um dies zu ermöglichen, müssen neben den Nutzdaten noch weitere Informationen vom Sender hinzugefügt werden, um eine
Fehlererkennung bzw. -korrektur zu ermöglichen. Diese weitere Information nennt sich *Redundanz*.

Bei jeder Datenübertragung kann es zu Fehlern kommen, d.h. es können einzelne oder mehrere Bits *umkippen*. Die
*Bitfehlerrate* ist ein statistisches Maß für die Qualtität der Datenübertragung. Je kleiner die Bitfehlerrate ist,
desto besser ist die Qualität. Eine Bitfehlerrate von 0.000 001 bedeutet, dass die Wahrscheinlichkeit der
Fehlübertragung eines Bits gleich 1 zu einer Million ist oder anders ausgedrückt: Im Mittel wird jedes Millionste Bit
falsch übertragen.

## Fehlerarten

* **Einzelfehler** - Es ist ein einzelnes Bit umgekippt
* **Bündelfehler** - Mehrere Bits hintereinander sind gekippt

# Prüfsummen
## Beispiel EAN13

![Strichkode]({filename}ean13.png)

Die *European Article Number* (EAN) stellt ein System zur Produktkennzeichnung dar. Hier wird eine Prüfsumme verwendet,
um mögliche Lese- oder Tippfehler zu erkennen. Die letzt Ziffer stellt die Prüfziffer dar. Diese wird berechnet, indem
die einzelnen Ziffern abwechselnd mit 3 und 1 multipliziert und anschließend addiert werden. Angefangen wird bei der
Ziffer neben der eigentlichen Prüfziffer. Die Prüfziffer ist dann die Differenz zum nächsten Vielfachen von 10.

Für das obige Beispiel bedeutet dies:

> 5*3 + 4*1 + 3*3 + 2*1 + 1*3 + 4*1 + 3*3 + 2*1 + 1*3 + 0*1 + 9*3 + 5*1=83

Die Differenz zum nächsten Vielfachen von 10 (83 -> 90) ist **7**.

Als Prüfsumme hätte man auch eine einfache Quersumme verwenden können. Dies hätte aber den Nachteil, dass die in der Praxis häufig auftretenden Zahlendreher (Vertauschung zweier Ziffern) nicht erkannt werden können.

## Einfache Prüfsummen
Bei einfachen Prüfsummen werden alle Datenbytes über einen Rechenoperator verknüpft. Dies kann zum Beispiel die Summe aller Bytes sein. Da die Summe Werte über 255 annehmen kann, werden nur die unteren 8 Bit der Summe verwendet. Diese einfachen Prüfsummen haben meist den Nachteil, dass schon Zweibitfehler nicht erkannt werden können.

## Paritätsbit

Bei der Prüfung der Datenintegrität mittels Paritätsbit wird einem Datenwort ein zusätzliches Paritätsbit hinzugefügt. Man unterscheided hierbei zwei Arten:

* **gerade** (engl. even) Parität: Das Paritätsbit erweitert das Datenwort so, dass die Gesamtzahl aller Einsen gerade ist.
* **ungerade** (engl. odd) Parität: Das Paritätsbit erweitert das Datenwort so, dass die Gesamtzahl aller Einsen ungerade ist.

Beispiel für gerade Parität:
Das Datenwort ist 0xA7 (binär 1010 0111). Die Anzahl der Einsen im Datenwort ist 5 und damit ungerade. Für eine gerade Anzahl an Einsen muss das Paritätsbit auch eine 1 sein. Das Ergebnis ist somit 1010 0111 **1**.

Durch das Paritätsbit können Einzelbitfehler erkannt werden. Wenn in einem Datenwort zwei Bits umkippen, kann der Fehler nicht entdeckt werden.

## Blockparität
Bei der Blockparität (auch Kreuzsicherung genannt) werden die einzelnen Bits in einer Matrix angeordnet und dann jeweils über die Zeilen und Spalten die Parität erweitert. Es ergibt sich auch eine Kreuzparität über die Spalten- und Zeilen-Paritätsbits.

![Kreuzsicherung]({filename}kreuzsicherung.svg)

In den Beispielen wird die gerade Parität verwendet. Die Paritätsbits werden vom Sender beim Senden entsprechend erweitert und anschließend vom Empfänger kontrolliert. Bei einem Einzelbitfehler kann die Position ermittelt werden, egal um welches Bit es sich handelt (Datenbereich, Paritätsbereich oder das Kreuzparitätsbit).

Einzelbitfehler können somit erkannt und sogar korrigiert werden. Zweibitfehler können erkannt werden, aber nicht korrigiert werden. Das gleiche gilt für Dreibitfehler. Bei Dreibitfehler kann es zu ungünstigen Konstellationen kommen, so dass es wie ein Einbitfehler aussieht. Bei Vierbitfehlern kann es zu Konstellationen kommen, in denen alle Paritätsbits wieder stimmen, obwohl insgesamt vier Bits umgefallen sind (siehe oberes Beispiel).
