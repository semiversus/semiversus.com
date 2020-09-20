title: Fest- und Gleitkommazahlen
parent: uebersicht.md

# Allgemeines
Im Vergleich zu einer Zahl ohne Nachkommastellen (*Integer*-Zahl bzw. Ganzzahl) benötigt man für die Speicherung und Verarbeitung von Zahlen mit Nachkommastellen eigene Zahlenformate.

## Festkomma Zahlen
Die Anzahl der Nachkommastellen ist hier fix. Bei der Angabe des Formats gibt man oft die Anzahl der Vorkommastellen (bezeichnet mittels *I*) und die Anzahl der Nachkommastellen an (bezeichnet mittels *Q*). Das <code>I.Q</code> Format <code>32.0</code> beschreibt dabei eine 32 Bit Integerzahl. Bei einem <code>I.Q</code> Format von <code>1.31</code> hat die Zahl ein Bit als Vorkommastelle und 31 Bit als Nachkommastelle.

Beispiel <code>3.5</code> Format und der Binärzahl <code>01101011</code>:

0 | 1 | 1**,** | 0 | 1 | 0 | 1 | 1
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
%%2^\{2\}%% | %%2^\{1\}%% | %%2^\{0\}%% | %%2^\{-1\}%% | %%2^\{-2\}%% | %%2^\{-3\}%% | %%2^\{-4\}%% | %%2^\{-5\}%%
4 | 2 | 1 | 0.5 | 0.25 | 0.125 | 0.0625 | 0.03125

Die oben dargestellte Zahl hat den Wert (**0** * 4) + (**1** * 2) + (**1** * 1) + (**0** * 0.5) + (**1** * 0.25) + (**0** * 0.125) + (**1** * 0.0625) + (**1** * 0.03125) = **3.34375**

Bei der Addition und Subtraktion können die Zahlen als reine Integer betrachtet werden. Bei Multiplikation und Division muss eine Anpassung der Kommastelle durchgeführt werden.

## Gleitkomma Zahlen
Bei der Gleitkommazahl (auch *Fließkommazahl* genannt) wird die Darstellung mittels *Mantisse*(<code>M</code>) und *Exponent*(<code>E</code>) genutzt. Das Vorzeichen wird durch die Variable <code>S</code> beschrieben. Bei <code>S</code>=0 ist die Zahl Positiv, bei <code>S</code>=1 negativ.

%%x=-1^{S} \cdot M \cdot B^{E}%%

In der Digitaltechnik wird durchwegs 2 als Basis(<code>B</code>) verwendet. Um mit Gleitkommazahlen zu Rechnen sind genau Vorgaben zum Zahlenformat und zur Durchführung mathematischer Operationen, insbesondere für Rundungen, notwendig. Die Norm *IEEE 754* stellt eine solche Beschreibung dar.

In der *IEEE 754* wird die Anzahl und Position der Bits für Mantisse und Exponent definiert:

<figure><img src="{filename}float_ieeee_754.svg"><figcaption>Floating Point Darstellung mittels IEEE 754 (Bild: <a href="https://commons.wikimedia.org/wiki/File:IEEE-754-single.svg">RokerHRO</a> Public Domain)</figcaption></figure>

## Umrechnung
Zur Berechnung des Wertes aus einer *IEEE 754* Darstellung wird folgende Methode verwendet.

Beispiel: <code>0 10000011 00100110011001100110011</code> (aus [Wikipedia](https://de.wikipedia.org/wiki/IEEE_754){: class="external" }).

Der Exponent als Dezimalzahl ist hier <code>10000011</code>->131. Der Exponent wird als Zahl +127 gespeichert, um negative Zahlen darstellen zu können (sogenanntes *Biasing*). Der Exponent ist also 131-127=4.

Die Mantisse einer Gleitkommazahl wird immer Normalisiert gespeichert. Die Normalisierung schiebt das Komma in die Position, dass die Zahl einem <code>I.Q</code> Format von 1.23 entspricht und das MSB eine <code>1</code> ist. Da nun vor dem Komma immer eine <code>1</code> ist, muss diese nicht mehr gesondert abgespeichert werden. Um nun die Mantisse aus der Gleitkommadarstellung zu bekommen wird eine <code>1</code> vor das Komma gestellt. Die Mantisse ist also **1,**<code>00100110011001100110011</code>.

Da der Exponent 4 ist, müssen wir das Komma um 4 Stellen nach rechts verschieben:
<code>10010,0110011001100110011</code>. Als Dezimalzahl hat die Zahl den Wert 18,39999961853.

Das Vorzeichen ist Positiv, da das Vorzeichenbit <code>0</code> ist. Das Ergebnis ist also **+18,39999961853**.

## Besondere Werte
Der Wert <code>0</code> kann auf Grund der Normalisierung nicht gespeichert werden. Um eine <code>0</code> als Gleitkommazahl zu repräsentieren wird Exponent und Mantisse auf <code>0</code> gesetzt. Es gibt weiters besondere Darstellungen für positiv und negativ Unendlich sowie eine Darstellung für <code>NaN</code> (not a number bzw. keine Zahl).
