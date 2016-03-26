title: Fließkommazahlen
parent: uebersicht.md

# Allgemeines
Im Vergleich zu einer Zahl ohne Nachkommastellen (*Integer*-Zahl bzw. Ganzzahl) benötigt man für die Speicherung und Verarbeitung von Zahlen mit Nachkommastellen eigene Zahlenformate.

## Festkomma Zahlen
Die Anzahl der Nachkommastellen ist hier fix. Bei der Angabe des Formats gibt man oft die Anzahl der Vorkommastellen (bezeichnet mittels *I*) und die Anzahl der Nachkommastellen an (bezeichnet mittels *Q*). Das `I.Q` Format `32.0` beschreibt dabei eine 32 Bit Integerzahl. Bei einem `I.Q` Format von `1.31` hat die Zahl ein Bit als Vorkommastelle und 31 Bit als Nachkommastelle.

Beispiel `3.5` Format und der Binärzahl `01101011`:

0 | 1 | 1**,** | 0 | 1 | 0 | 1 | 1 
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
%%2^{2}%% | %%2^{1}%% | %%2^{0}%% | %%2^{-1}%% | %%2^{-2}%% | %%2^{-3}%% | %%2^{-4}%% | %%2^{-5}%%
4 | 2 | 1 | 0.5 | 0.25 | 0.125 | 0.0625 | 0.03125

Die oben dargestellte Zahl hat den Wert (**0** * 4) + (**1** * 2) + (**1** * 1) + (**0** * 0.5) + (**1** * 0.25) + (**0** * 0.125) + (**1** * 0.0625) + (**1** * 0.03125) = **3.34375**

Bei der Addition und Subtraktion können die Zahlen als reine Integer betrachtet werden. Bei Multiplikation und Division muss eine Anpassung der Kommastelle durchgeführt werden.

## Gleitkomma Zahlen
Bei der Gleitkommazahl wird die Darstellung mittels *Mantisse*(`M`) und *Exponent*(`E`) genutzt. Das Vorzeichen wird durch die Variable `S` beschrieben. Bei `S`=0 ist die Zahl Positiv, bei `S`=1 negativ.

%%x=-1^{S} \cdot M \cdot B^{E}%%

In der Digitaltechnik wird durchwegs 2 als Basis(`B`) verwendet. Um mit Gleitkommazahlen zu Rechnen sind genau Vorgaben zum Zahlenformat und zur Durchführung mathematischer Operationen, insbesondere für Rundungen, notwendig. Die Norm *IEEE 754* stellt eine solche Beschreibung dar.

In der *IEEE 754* wird die Anzahl und Position der Bits für Mantisse und Exponent definiert:

<figure><img src="{filename}float_ieeee_754.svg"><figcaption>Floating Point Darstellung mittels IEEE 754 (Bild: <a href="https://commons.wikimedia.org/wiki/File:IEEE-754-single.svg">RokerHRO</a> Public Domain)</figcaption></figure>

## Umrechnung
Zur Berechnung des Wertes aus einer *IEEE 754* Darstellung wird folgende Methode verwendet.

Beispiel: `0 10000011 00100110011001100110011` (aus [Wikipedia](https://de.wikipedia.org/wiki/IEEE_754)){: class="external" }.

Der Exponent als Dezimalzahl ist hier `10000011`->131. Der Exponent wird als Zahl +127 gespeichert, um negative Zahlen darstellen zu können (sogenanntes *Biasing*). Der Exponent ist also 131-127=4.

Die Mantisse einer Gleitkommazahl wird immer Normalisiert gespeichert. Die Normalisierung schiebt das Komma in die Position, dass die Zahl einem `I.Q` Format von 1.23 entspricht und das MSB eine `1` ist. Da nun vor dem Komma immer eine `1` ist, muss diese nicht mehr gesondert abgespeichert werden. Um nun die Mantisse aus der Gleitkommadarstellung zu bekommen wird eine `1` vor das Komma gestellt. Die Mantisse ist also **1,**`00100110011001100110011`.

Da der Exponent 4 ist, müssen wir das Komma um 4 Stellen nach rechts verschieben:
`10010,0110011001100110011`. Als Dezimalzahl hat die Zahl den Wert 18,39999961853.

Das Vorzeichen ist Positiv, da das Vorzeichenbit `0` ist. Das Ergebnis ist also **+18,39999961853**.

## Besondere Werte
Der Wert `0` kann auf Grund der Normalisierung nicht gespeichert werden. Um eine `0` als Gleitkommazahl zu repräsentieren wird Exponent und Mantisse auf `0` gesetzt. Es gibt weiters besondere Darstellungen für positiv und negativ Unendlich sowie eine Darstellung für `NaN` (not a number bzw. keine Zahl).
