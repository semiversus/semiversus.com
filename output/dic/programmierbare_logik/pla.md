title: Programmierbare Logische Anordnungen
parent: uebersicht.md

# Allgemeines
Programmierbare Logik hat im Vergleich zu festverdrahten Logikbausteinen folgende Vorteile:

* Hohe Integrationsdichte (viele Gatter auf kleiner Fläche)
* Teilweise im Feld neu programmierbar
* Hohe Taktfrequenzen möglich

Es gibt je nach Programmierbarkeit folgende Klassifizierungen:

* **ASIC**s (Application Specific Integrated Circuits) sind integrierte Schaltkreise, die für ganz bestimmten Einsatzzweck entwickelt und gefertigt werden. Die Logik wird mittels *Standardzellenentwurf* entwickelt. Die Grundkosten sind sehr hoch, bei großen Stückzahlen sind die Kosten pro IC aber sehr gering.
* **OTP** (One Time Programmable) sind programmierbare Logikbausteine, die einmal programmierbar sind. Für die Speicherzellen wird dabei meist die *Anti-Fuse* Technologie genutzt.
* **Mehrfach Wiederbeschreibbar** sind programmierbare Logikbausteine, wenn als Speicherzellen EEPROM, Flash oder SRAM Zellen verwendet werden.

# Kombinatorische Grundstruktur
Einfache programmierbare Logikbausteine realisieren meist eine Grundstruktur, die es ermöglicht, die disjunktive Normalform von booleschen Gleichungen zu realisieren. Dazu werden die Eingänge mittels eines UND-Arrays zu Mintermen zusammengefasst. Die Minterme werden dann durch ein ODER-Array zur disjunktiven Normalform zusammengefasst und an die Ausgangspins geführt.

![Realisierung mittels disjunktiver Minimalform]({filename}pla_extended.svg)

Mit dieser Struktur können alle kombinatorischen Schaltungen realisiert werden, die keine kombinatorische Rückkopplung oder Schleife enthält. Man  unterscheidet bei den verschiedenen Bauformen, ob das UND- oder das ODER-Array programmierbar ist. Wird eine vom Anwender programmierbare Verbindung nicht genutzt, wird sichergestellt, dass dieses Signal einen Pegel hat, der die Funktionsweise nicht beeinträchtigt. So wird im UND-Array eine nicht verwendete Leitung auf einem <code>1</code>-Pegel gehalten und im ODER-Array auf einem <code>0</code>-Pegel.

Um die Darstellung zu vereinfachen werden die parallelen Eingänge der UND und ODER Gatter meist zusammengefasst:

![Vereinfachte Darstellung]({filename}pla.svg)

# Realisierung
## ROM Baustein
![Realisierung mittels ROM]({filename}pla_rom.svg)

Eine programmierbare Logik kann auch mit einem Speicher realisiert werden, wobei die Eingänge die Adresse darstellen und die Ausgänge sind die entsprechenden Datenausgänge. Der Speicherinhalt wird dadurch zur Darstellung einer Wahrheitstabelle.

An | A2 | A1 | A0 | Dm | D3 | D2 | D1 | D0
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
0 | 0 | 0 | 0 | *0* | *0* | *0* | *0* | *1*
0 | 0 | 0 | 1 | *0* | *0* | *1* | *1* | *1*
0 | 0 | 1 | 0 | *1* | *1* | *0* | *0* | *0*
 ... | ... | ... | ... | ... | ... | ... | ... | ...
1 | 1 | 1 | 1 | *0* | *0* | *1* | *0* | *1*

Ein ROM Baustein entspricht der vorgestellten kombinatorischen Grundstruktur, wobei der Teil im UND-Array fest verdrahtet ist und nur der Teil des ODER-Arrays vom Benutzer programmierbar ist. Ein Speicher mit <code>n</code> Adressbits und <code>m</code> Datenbits kann eine Kombinatorik mit <code>n</code> Eingängen und <code>m</code> Ausgängen realisieren.

## PLA
Bei einem PLA (Programmable Logic Array) sind sowohl UND- als auch das ODER-Array vom Anwender programmierbar.

## PAL
PALs (Programmable Array Logic) werden heute nicht mehr eingesetzt. Sie sind aber die Vorstufe zu vielen Entwicklungen, die heute noch in Verwendung sind. Bei PALs ist das UND-Array frei programmierbar, das ODER-Array ist festverdrahtet. PAL Bausteine sind nur einmal programmierbar.

## GAL
Eine Weiterentwicklung der *PAL*s stellen die *GAL* (Generic Array Logic) Bausteine von Lattice dar. Diese sind durch UV-Licht oder elektrisch löschbar und dadurch wiederbeschreibbar. An jedem Ausgang befindet sich eine *OLMC* (Output Logic Macro Cell). Diese Ausgangszelle enthält neben der Option, den Ausgang zu invertieren auch die Möglichkeit, ein Flipflop zu verwenden. Es besteht die Möglichkeit, Signale der OLMC wieder als Eingänge zu benutzen. Es ist möglich, den Ausgangstreiber hochohmig zu schalten und damit diesen Pin als Eingang zu benutzen.

![Generic Array Logic]({filename}gal.svg)
