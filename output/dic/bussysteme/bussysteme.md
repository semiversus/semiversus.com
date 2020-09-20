title: Bussysteme Übersicht
parent: uebersicht.md

# Allgemeines
Busse dienen zur Übertragung von Daten zwischen Komponenten, stellen also ein gemeinsames Medium dar. Werden exakt zwei Komponenten miteinander verbunden, spricht man typischerweise von einer **Punkt-zu-Punkt** Verbindung, bei mehr als zwei Komponenten spricht man von einem **Bus**.

An Busse gibt es je nach Einsatzzweck verschiedene Anforderungen:

* Geringer Verkabelungsaufwand
* Datenübertragungsrate
* niedrige Latzenzzeit
* Deterministisches Zeitverhalten
* galvanische Trennung
* An- und Abkoppeln während dem Betrieb
* sichere Datenübertragung

## Parallel und serielle Verbindung
Parallele Busse werden typischerweise bei lokalen Verbindungen innerhalb eines Systems genutzt, bei der sehr viele Daten übertragen Werden müssen (z.B. zwischen Prozessor und Speicher). Dabei kommen meist Bitbreiten von 8 Bit bis 128 Bit zum Einsatz. Durch Hinzufügen von zusätzlichen Verbindungen können Funktionen zur Kontrolle und Steuerung realisiert werden.

Der Hauptvorteil von seriellen Verbindungen ist die vereinfachte Verkabelung. Dadurch sind Systeme flexibler und die Entfernung zwischen den einzelnen Komponenten kann wesentlich größer sein. Heute wird oft der Begriff *Feldbus* verwendet. Die erste Generation von Feldbussen hat Busse mit der bis dahin gängigen Parallelverdrahtung zur Datenübertragung und Systeme mit analoger Singalübertragung ersetzt.

# ISO-OSI 7-Schichten Modell
Um die Kommunikationsprotokolle zu entwickeln und beschreiben wurde durch die ISO ein 7-Schichten Modell standartisiert. Jede Schicht stellt dabei eine Aufgabe dar und die einzelnen Schichten setzen dabei aufeinander auf.

**Schicht 7 – Anwendungsschicht**: In dieser Schicht wird die eigentliche Aufgabe beschrieben (z.B. EMail-Kommunikation, CANOpen, usw.).

**Schicht 6 – Darstellungsschicht**: Beschreibt die Darstellung der Daten. Auch Komprimierung oder Verschlüsselung werden in dieser Schicht durchgeführt.

**Schicht 5 – Sitzungsschicht**: Beschreibt die Prozesskommunikation zwischen zwei Systemen.

**Schicht 4 – Transportschicht**: Diese Schicht ist für die Transport-Kontrolle zuständig. Weiters wird das Segmentieren eines Datenstroms in einzelne Pakete gesteuert. In typisches Beispiel ist hier TCP bzw. UDP.

**Schicht 3 – Vermittlungsschicht**: In dieser Schicht werden die einzelnen Pakete zwischen verschiedenen Stationen vermittelt und übertragen. Typischer Vertreter ist das *Internet Protocol* (*IP*).

**Schicht 2 – Sicherungsschicht**: Sorgt für eine fehlerfreie Punkt-zu-Punkt Übertragung. Hier wird der Buszugriff und die Datensicherung gesteuert.

**Schicht 1 – Bitübertragungsschicht**: Diese Schicht stellt die physikalische Datenübertragung dar. Hier werden elektrische Pegel und Kodierungen definiert. Weiters werden durch diese Schicht die Stecker definiert.

Für Feldbusse sind nicht alle Schichten gleich wichtig. Die meisten Feldbusse kommen durch die Definition der Schichten 1 und 2 aus. Teilweise sind auch die Schichten 3 und 7 definiert.

# Buszugriff
Da mehrere Komponenten auf ein gemeinsames Medium zugreifen, muss sichergestellt werden, dass zu jedem Zeitpunkt nur eine Komponente aktiv auf den Bus zugreift (sprich *sendet*). Der Buszugriff wird durch die ISO-OSI Schicht 2 definiert.

## Kontrollierter Buszugriff
Beim kontrollierten Buszugriff ist der Sender eindeutig bestimmt. Dazu gibt es zwei Verfahren:

**Master/Slave**: Es gibt einen Master, der Daten an Slaves schickt oder abfragt. Jede Kommunikation wird durch den Master initiiert und der (angesprochene) Slave antwortet auf diese Anfrage.

**Token-Passing**: Bei diesem Verfahren wird der Bus meist als logischer Ring realisiert. Jeder Teilnehmer kann auf dem Bus senden, wenn er im Besitz des *Tokens* ist. Dieser Token existiert genau einmal. Wenn ein Teilnehmer einen Token empfängt, kann er entweder auf den Bus zugreifen und nach Abschluss den Token weiterschicken oder wenn er keinen Buszugriff initiieren möchte, den Token gleich weiterschicken.

**Summenrahmen-Verfahren**: Dieses Verfahren nutzt einen ringförmigen Bus, wobei die einzelnen Teilnehmer intern Schieberegister nutzen. Jeder Teilnehmer gibt die Bits an seinen nächsten Nachbar weiter, bis die Daten wieder beim Master landen. Vor dem Zugriff auf den Bus schreiben die Teilnehmer ihre Daten in das Schieberegister. Der Master liest sämtliche Schieberegister aus und schreibt gleichzeitig neue Daten an die Teilnehmer hinaus.

## Zufälliger Buszugriff
Wenn in einem System mehrere Master bzw. Sender je nach Bedarf auf den Bus zugreifen, benötigt es eine Regelung des Zugriffs (*Arbitrierung*).

**Mittels Bus-Arbiter**: Der Arbiter entscheidet, wer den Zugriff auf den Bus erhält. Dazu werden teilweise einzelne Steuerleitungen zwischen den Mastern und dem Arbiter benötigt.

**CSMA**: Bei *Carrier Sense Multiple Access* schaut jeder Master, ob der Bus verfügbar ist, bevor eine einen Buszugriff initiiert. Wenn dies der Fall ist, greift er auf den Bus zu. Hier kann es zu einem Problem kommen, wenn zwei Master gleichzeitig einen Buszugriff initiieren wollen, da beide Master einen freien Bus feststellen und die Übertragung beginnen.

**CSMA/CD**: Bei der Erweiterung mittels *Collision Detection* erkennen die sendenden Teilnehmer, dass es zu einer Kollision gekommen ist. Wird eine Kollision erkannt, beenden alle Teilnehmer die Aussendung und startet sie nach einer zufälligen Zeit erneut. Da es sich hier um einen stochastischen Prozess handelt, ist ein solcher Bus niemals Echtzeitfähig. Diese Buszugriffsregelung wird von Ethernet verwendet.

**CSMA/CR**: Bei der Erweiterung mittels *Collision Resolution* kann es zu Kollisionen kommen, diese werden aber während dem Senden beseitigt. Dies geschieht meist, indem eine Identifikation bitweise übertragen wird und ein Bitzustand dominant gegenüber dem anderen ist, sich also durchsetzt. Der überstimmte Sender stellt seine Übertragung ein. Dieses Verfahren wird bei *CAN* verwendet.



