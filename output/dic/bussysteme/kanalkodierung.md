title: Kanalkodierung
parent: uebersicht.md

# Allgemeines
Um Information in digitaler Form zu Übertragen muss es über ein physkalisches Medium transportiert werden. Die Kanalkodierung bzw. genauer der Leitungskode beschreibt die Pegelfolgen, in der die Daten auf der Leitung liegen. Dies kann in elektrischer Form aber auch in optischer oder elektro-magnetischer Form beschrieben werden.

## Synchrone und Asynchrone Übertragung
Bei der synchronen Übertragung wird ein Taktsignal mitgeschickt. Der Empfänger kann sich dadurch mit dem Sender synchronisieren und die Daten empfangen.

Bei der asynchronen Übertragung laufen Sender und Empfänger jeweils mit einer eigenen Taktfrequenz. Die Übertragung der einzelnen Symbole muss entweder mit einer genau definierten Symbolrate übertragen werden oder die einzelnen Symbole ermöglichen die Rückgewinnung des Taktes. Zur Rückgewinnung des Taktes werden die Taktflanken genutzt.

## Gleichspannungsfreiheit
In bestimmten Anwendung ist die Übertragung von Gleichspannungsanteilen nicht möglich. Dies ist z.B. der Fall, wenn das Signal zwecks galvanischer Trennung über einen Impulstransformator geführt wird. Das Potential sollte also im Mittel idealerweise bei 0 liegen. Kodes die dies ermöglichen werden als *gleichspannungsfrei* bezeichnet.

# Binäre Leitungskodes
## NRZ (Non Return to Zero)
Im einfachsten Fall wird den logischen Zustände 0 und 1 ein Logikpegel auf der physischen Leitung zugeordnet.

![NRZ]({filename}nrz.svg.tex)

Bei der RS232 Schnittstelle steht (nicht wie im obigen Beispiel) eine negative Spannung für logisch 1 und eine positive Spannung für logisch 0.

### Bitstuffing
Ein Nachteil bei der NRZ Kodierung sind die fehlenden Flanken bei der Übertragung von vielen gleichen Symbolen (viele logische 0 oder 1). Um für solche Fälle zusätzliche Taktflanken zu erzeugen, kann durch *Bitstuffing* (oder deutsch Bitstopfen) ein zusätzliches invertiertes Bit eingefügt werden. Mit *Bitweite* beschreibt man dabei die Anzahl der Bits mit gleichem Pegel die zum Einfügen eines *Stopfbits* führt. Der Empfänger muss nach dem gleichen Prinzip dieses Stopfbit wieder entfernen.

<figure><img src="{filename}bitstuffing.svg"><figcaption>Bitstopfen mit Weite 5 (Bild: <a href="https://commons.wikimedia.org/wiki/File:Bitstuffing.svg">Mik81</a> Public Domain)</figcaption></figure>

Am obigen Beispiel sieht man das Einfügen eines Stopfbits bei Bitweite 5.

## NRZI
Die *Non Return to Zero Invert* Kodierung ordnet einem der beiden Bit-Werte den bereits anliegenden Leitungszustand zu, dem anderen Bit-Wert einen Zustandswechsel (Invert). Daraus ergibt sich unmittelbar die Polaritätsfreiheit bei differentieller Übertragung: Ein Verpolen der Übertragungsleitung ändert nicht die Bitfolge. Wenn der Zustand, der keine Leitungszustandsänderung bringt, zu oft übertragen wird, kann auch durch die fehlenden Flanken die Synchronisation verloren gehen. Eine Lösung ist hier ebenfalls das Bitstuffing.

![NRZI]({filename}nrzi.svg.tex)

Bei diesem Beispiel wird bei logisch 1 der Pegel geändert, bei logisch 0 beibehalten.

# Manchester Kodierung
Bei der Manchesterkodierung entspricht eine Null-Eins-Folge einer logischen Null (steigende Flanke), eine Eins-Null-Folge (fallende Flanke) einer logischen Eins:
Hierdurch wird erreicht, dass

* stets Pegelwechsel zur Taktrückgewinnung vorhanden sind
* der Gleichanteil im Mittel immer gleich Null ist

Ein Nachteil dabei ist, dass sich die erforderliche Symbolrate am Übertragungskanal verdoppelt.

![Machester Kodierung]({filename}manchester.svg.tex)

Beim *differentiellen Manchestercode* steht ein Polaritätswechsel am Taktanfang für eine logische Null (zwei Flankenwechsel pro Bit), bei einer logischen Eins erfolgt kein Polaritätswechsel am Taktanfang (ein Flankenwechsel pro Bit).

# Blockcodes
Bei Blockcodes werden verschiedene Symbole zusammengefasst und durch eine alternative Symbolgruppe übertragen.

**4B5B** ist ein Code, der jeweils 4 Bits auf 5 Bits abbildet, also 16 Block-Codes auf 32 Leitungscodes. Der Code ist nicht gleichstromfrei, besitzt aber immer zumindest einen Bitwechsel, um den Takt rückzugewinnen.

Der **8B10B**-Code ist ein Leitungscode in der Telekommunikationstechnik. Dabei werden 8 Bit Daten mit 10 Bit kodiert, sodass zum einen ein Gleichspannungsausgleich gewährleistet ist und zum anderen Taktrückgewinnung aus dem Datensignal möglich ist. Der erzeugte Datenstrom hat einen Overhead von 25% gegenüber dem originalen. Ein ähnlicher, aber deutlich effizienterer Code ist der **64B66B**-Code, welcher 64 Bits auf 66 Bits abbildet und daher nur ca. 3% Overhead erzeugt.

Blockcodes können zur Fehlererkennung und Fehlerkorrektur bei der Übertragung von Daten über fehlerbehaftete Kanäle verwendet werden. Dabei ordnet der Sender dem zu übertragenen Informationswort der Länge m ein Codewort der Länge n zu, wobei n>m gilt. Durch das Hinzufügen der  zusätzlichen Symbole entsteht Redundanz und die Informationsrate sinkt; jedoch kann der Empfänger die redundante Information nun dazu nutzen Übertragungsfehler zu erkennen und zu korrigieren.
