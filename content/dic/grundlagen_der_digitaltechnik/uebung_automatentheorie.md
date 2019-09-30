title: Übung zur Automatentheorie
parent: automatentheorie.md

# Graphische Darstellung des Getränke-Automaten
Stelle das Beispiel des [Getränke-Automaten]({filename}automatentheorie.md#beispiel-getrankeautomat) graphisch dar

# Automat mittels Logisim
Realisiere mittels Logisim den folgenden Automaten:

## Eingabealphabet
Σ={E0,E1,E2}={<code>00</code>,<code>01</code>,<code>10</code>}

Eingabe wird über die beiden Leitungen <code>e1</code> und <code>e0</code> realisiert.
## Ausgabealphabet
Γ={A0, A1}={<code>01</code>,<code>10</code>}

Ausgabe wird über die beiden Leitungen <code>a1</code> und <code>a0</code> realisiert.
## Zustandsmenge
Z={Z0,Z1,Z2}={<code>00</code>,<code>01</code>,<code>10</code>}

Der Zustand wird über die beiden D-Flip-Flop <code>z1</code> und <code>z0</code> realisiert.

## Zustandsübertragungsfunktion

<code>δ</code> | **E0** | **E1** | **E2**
:-:|:-:|:-:|:-:
**Z0** | Z0 | Z0 | Z1
**Z1** | Z2 | Z2 | Z2
**Z2** | Z0 | Z1 | Z2

## Ausgabefunktion

<code>ω</code> | **E0** | **E1** | **E2**
:-:|:-:|:-:|:-:
**Z0** | A0 | A0 | A0
**Z1** | A0 | A1 | A0
**Z2** | A1 | A1 | A1

