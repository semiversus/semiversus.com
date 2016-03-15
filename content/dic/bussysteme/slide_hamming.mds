title: Hamming Abstand
date: 23.3.2015
author: Günther Jena
class: title-slide segue

---

title: Hamming-Abstand 
class: big
build_lists: true

Wieviele Bits unterscheiden die beiden *Codewörter* W1 und W2?

    W1: 1 0 0 1 1 1 0 1
    W2: 1 1 0 0 1 1 0 1

* 2 Bit, somit ist der Hammingabstand zwischen diesen Codewörtern **2**

---

title: Definition
build_lists: true

* Der **Hamming-Abstand *d* ** (oder Hamming-*Distanz*) zweier Blöcke mit fester Länge (sogenannte *Codewörter*) entspricht der Anzahl der unterschiedlichen Stellen.

* Der **Hamming-Abstand *D* ** eines vollständigen Codes entspricht dem minimalen Hamming-Abstand *d* aller Codewörter

---

title: Hamming Abstand

    W1: 0 0 0 0 0 0 0 0
    W2: 1 1 0 0 1 1 0 0
    W3: 1 1 0 1 1 1 0 1
    W4: 1 0 0 0 1 1 1 1

<table>
<tr><td></td><td>W1</td><td>W2</td><td>W3</td><td>W4</td></tr>
<tr><td>W1</td><td>-</td><td>4</td><td>6</td><td>5</td></tr>
<tr><td>W2</td><td>4</td><td>-</td><td>2</td><td>3</td></tr>
<tr><td>W3</td><td>6</td><td>2</td><td>-</td><td>3</td></tr>
<tr><td>W4</td><td>5</td><td>3</td><td>3</td><td>-</td></tr>
</table>

* Minimaler Hamming-Abstand: *2*

---

title: Fehlererkennung und Fehlerbehebung
build_lists: true

Die Fähigkeit eines Codes für Fehlererkennung und -behebung ist abhängig vom Hamming-Abstand

* Fehler*erkennung* erkennt einen Übertragungsfehler, kann diesen aber nicht beheben
    * Zur Erkennung eines *n*-Bit Fehlers wird *D*>=*n*+1 benötigt
* Fehler*behebung* erkennt einen Übertragungsfehler und kann diesen auch beheben
    * Zur Behebung eines *n*-Bit Fehlers wird *D*>=2*n*+1 benötigt

---

title: Beispiel Paritätsbit

Wird ein *n*-Bit Datenwort um ein Paritätsbit erweitert haben wir eine Hammingabstand von **2**.

    0 0 0 - 0
    0 0 1 - 1
    0 1 0 - 1
    0 1 1 - 0
    1 0 0 - 1
    1 0 1 - 0
    1 1 0 - 0
    1 1 1 - 1

* Es ist möglich 1-Bit Fehler zu erkennen, aber nicht sie zu beheben

---

title: Hamming Code
build_lists: true

* Die einzelnen Codewörter des Hammingcodes weisen einen Abstand von **3** auf
* Kann gezielt für ein *n*-Bit Datenwort konstruiert werden
* Kann 1-Bit Fehler erkennen und beheben
* Kann (teilweise) 2-Bit Fehler erkennen

---

title: Redundanz

Dies wird durch Hinzufügen von Redundanz mittels Paritätsbits durchgeführt.

<table>
<tr><td>Datenbits</td><td>Paritätsbits</td><td>Gesamt</td></tr>
<tr><td>1</td><td>2</td><td>3</td></tr>
<tr><td>4</td><td>3</td><td>7</td></tr>
<tr><td>11</td><td>4</td><td>15</td></tr>
<tr><td>26</td><td>5</td><td>31</td></tr>
<tr><td>57</td><td>6</td><td>63</td></tr>
<tr><td>120</td><td>7</td><td>127</td></tr>
<tr><td>247</td><td>8</td><td>255</td></tr>
</table>

---

title: Konstruktion eines Hamming Codes für 8 Bit
build_lists: true

* Laut Tabelle werden bei 8 Datenbits 4 Paritätsbits benötigt
* Dadurch werden 12 Bit Codewörter entstehen
* Diese werden auf die Positionen 1, 2, 4 und 8 gesetzt
* Die freien Stellen werden mit den Datenbits besetzt
* Man spricht in diesem Fall von einem "(12, 8)-Code"

---

title: Paritätsbits

          12 11 10  9  8  7  6  5  4  3  2  1 (0)
          D7 D6 D5 D4 P3 D3 D2 D1 P2 D0 P1 P0

    P0:    0  1  0  1  0  1  0  1  0  1  0  1 (0) 
    P1:    0  1  1  0  0  1  1  0  0  1  1  0 (0)
    P2:    1  0  0  0  0  1  1  1  1  0  0  0 (0)
    P3:    1  1  1  1  1  0  0  0  0  0  0  0 (0)

* Paritätsbit *P0* läßt ein Bit frei und verwendet das nächste
* Paritätsbit *P1* läßt zwei Bit frei und verwendet die nächsten zwei
* Paritätsbit *P2* läßt vier Bit frei und verwendet die nächsten vier
* ...
* Position 0 ist ein Platzhalter

---

title: Beispiel: Dekodieren des Wertes 0xFC

          12 11 10  9  8  7  6  5  4  3  2  1 (0)
          D7 D6 D5 D4 P3 D3 D2 D1 P2 D0 P1 P0
           1  1  1  1  ?  1  1  0  ?  0  ?  ?

    P0:    0  1  0  1  0  1  0  1  0  1  0  1 (0) 
    P1:    0  1  1  0  0  1  1  0  0  1  1  0 (0)
    P2:    1  0  0  0  0  1  1  1  1  0  0  0 (0)
    P3:    1  1  1  1  1  0  0  0  0  0  0  0 (0)

---

title: Lösung: Dekodieren des Wertes 0xFC

          12 11 10  9  8  7  6  5  4  3  2  1 (0)
          D7 D6 D5 D4 P3 D3 D2 D1 P2 D0 P1 P0
           1  1  1  1  0  1  1  0  1  0  0  1

    P0:    0  1  0  1  0  1  0  1  0  1  0  1 (0) 
    P1:    0  1  1  0  0  1  1  0  0  1  1  0 (0)
    P2:    1  0  0  0  0  1  1  1  1  0  0  0 (0)
    P3:    1  1  1  1  1  0  0  0  0  0  0  0 (0)

---

title: Simulation eines Übertragungsfehlers
build_lists: true

          12 11 10  9  8  7  6  5  4  3  2  1 (0)
          D7 D6 D5 D4 P3 D3 D2 D1 P2 D0 P1 P0
           1  1  1  1  0  0  1  0  1  0  0  1

    P0:    0  1  0  1  0  1  0  1  0  1  0  1 (0) 
    P1:    0  1  1  0  0  1  1  0  0  1  1  0 (0)
    P2:    1  0  0  0  0  1  1  1  1  0  0  0 (0)
    P3:    1  1  1  1  1  0  0  0  0  0  0  0 (0)

* Position 7 ist *umgefallen*
* Dadurch stimmen die Paritätsbits P0, P1 und P2 nicht mehr
* Oder anders ausgedrückt {P3, P2, P1, P0}={richtig, falsch, falsch, falsch} -> Binär 0111 gleich 7
* Zum Üben
    * Kodiere den Wert 0x36
    * Übertragen wurde 0011 0001 1000 
    * Übertragen wurde 0011 1011 0010 
