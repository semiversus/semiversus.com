title: Übung zur Automatentheorie
parent: automatentheorie.md

# Graphische Darstellung des Getränke-Automaten
Stelle das Beispiel des [Getränke-Automaten]({filename}automatentheorie.md#beispiel-getrankeautomat) graphisch dar

# Automat mittels Logisim
Realisiere mittels Logisim den folgenden Automaten:

## Eingabealphabet
Σ={E0,E1,E2}={`00`,`01`,`10`}

Eingabe wird über die beiden Leitungen `e1` und `e0` realisiert. 
## Ausgabealphabet
Γ={A0, A1}={`01`,`10`}

Ausgabe wird über die beiden Leitungen `a1` und `a0` realisiert.
## Zustandsmenge
Z={Z0,Z1,Z2}={`00`,`01`,`10`}

Der Zustand wird über die beiden D-Flip-Flop `z1` und `z0` realisiert.

## Zustandsübertragungsfunktion

`δ` | **E0** | **E1** | **E2**
:-:|:-:|:-:|:-:
**Z0** | Z0 | Z0 | Z1
**Z1** | Z2 | Z2 | Z2
**Z2** | Z0 | Z1 | Z2

## Ausgabefunktion

`ω` | **E0** | **E1** | **E2**
:-:|:-:|:-:|:-:
**Z0** | A0 | A0 | A0
**Z1** | A0 | A1 | A0
**Z2** | A1 | A1 | A1

