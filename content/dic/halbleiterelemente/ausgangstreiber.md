title: Ausgangstreiber
parent: uebersicht.md

# Allgemeines
Bei logischen Gattern nach Boolescher Logik geht man von Ausgängen aus, die entweder eine logische 0 oder 1 liefern. Für die Praxis haben sich noch weitere Ausgangsstufen entwickelt, um weitere technische Realisierungen zu ermöglichen.

# Totem-Pole Ausgang

<figure><img src="{filename}totem_pole.svg"><figcaption>Totem-Pole Ausgang bei einem NAND Gatter (Bild: <a href="https://commons.wikimedia.org/wiki/User:MichaelFrey">MichaelFrey</a> CC BY-SA 2.0)</figcaption></figure>

Der Totem-Pole Ausgang oder auch Gegentakt-Ausgangsstufe wird bei TTL Gattern durch NPN-Transistoren realisiert. Bei CMOS Bauteilen dienen dazu jeweils ein n-Kanal und ein p-Kanal Feldeffekttransistor. Der Name *Totem-Pole* rührt von der Anordnung der Bauteile der Ausgangsstufe, die ähnlich einem Totempfahl der Indianer aussieht. Typischerweise können Totem-Pole Ausgänge mehr Strom nach Masse ziehen als sie über Versorgung liefern können.

Ein Totem-Pole Ausgang kann also die beiden logischen Pegel 0 und 1 ausgeben.

# Open-Collector Ausgang

<figure><img src="{filename}open_collector.svg"><figcaption>Open-Collector Ausgang bei einem NAND Gatter (Bild: <a href="https://commons.wikimedia.org/wiki/User:MichaelFrey">MichaelFrey</a> CC BY-SA 2.0)</figcaption></figure>

Bei Open-Collector Ausgang wird nur ein Transistor verwendet, dessen Kollektor als Ausgang dient. Damit kann das Potential am Ausgang auf Masse gezogen werden, aber es kann kein hohes Potential (logisch 1) ausgegeben werden. Um ein hohes Potential zu erhalten wird ein externer Pull-Up Widerstand verwendet. Dieser verbindet den Ausgang mit der Versorgung. Der Ausgang ist auf logisch 1 wenn der Transistor sperrt und damit der Ausgang über den Pull-Up Widerstand versorgt wird. Eine logische 0 wird ausgegeben indem der Transistor leitet und damit das Potenital auf Masse zieht.

Vorteile des Open-Collector Ausganges:

* Anpassung an verschiedene Betriebsspannungen: Die externe Betriebsspannung kann höher oder niedriger sein als die Betriebsspannung des Bausteils.
* Zusammenschalten mehrerer Ausgänge: Wenn mehrere Open-Collector Ausgänge zusammengeschaltet werden, setzt sich eine logische 0 durch, da damit das Potential auf Masse geschaltet wird

Folgende Punkte sind weiters zu beachten:

* Wird der Pull-Up zu niederohmig dimensioniert, kann der maximal erlaubte Strom des Ausgangstransistors überschritten werden. Damit wird entweder das Bauteil zerstört oder das Potential kann nicht auf Masse gezogen werden.
* Wird der Pull-Up zu hochohmig dimensioniert, reicht der Strom nicht mehr aus, das Potential auf logisch 1 zu ziehen.
* Je größer der Pull-Up Widerstand, desto langsamer der Wechsel von logisch 0 auf logisch 1. Je kleiner der Pull-Up Widerstand, desto mehr Leistung wird verbraucht.
* Typische Werte für Pull-Ups sind zwischen 1kOhm und 100kOhm.

Betrachtet man den Open-Collector Ausgang ohne Pull-Up kann dieser die logische 0 ausgeben oder *hochohmig* sein.

# Tri-State

<figure><img src="{filename}tri_state.svg"><figcaption>Tri-State Ausgang eines Inverters (Bild: <a href="https://commons.wikimedia.org/wiki/User:Mik81">Mik81</a> CC BY 2.0)</figcaption></figure>

Bei Tri-State Ausgang wird ein Totem-Pole Ausgang so erweitert, dass keiner der beiden Transistor leitet, d.h. weder logisch 0 noch logisch 1 ausgegeben wird. Dadurch ist der Ausgang *hochohmig*. Dieser dritte Zustand wird genutzt, um mehrere Ausgänge zusammenzuschalten. Dabei ist nur ein Eingang aktiv auf logisch 0 oder 1 und alle anderen Ausgänge sind hochohmig.

Der Tri-State Ausgang kann also logisch 0 und 1 ausgeben oder hochohmig sein.
