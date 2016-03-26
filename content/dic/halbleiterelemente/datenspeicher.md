title: Datenspeicher Übersicht
parent: uebersicht.md

# Allgemeines
Speicher haben die Aufgabe Information zu speichern. Bei digitalen Speichern ist diese Information ein diskreter Zustand, in den meisten Fällen die Speicherung einer logisch 0 oder 1. Von Informationsverlust spricht man, wenn eine gepeicherte Information nicht mehr richtig wieder gelesen werden kann, bzw. der Zustand einer Speicherzelle sich ungewollt verändert hat.

## Historische Speicher
Zu den ersten digitalen und von einer Maschine verarbeitbaren Speicher zählt die [Lochkarte](https://de.wikipedia.org/wiki/Lochkarte){: class="external" }, die 1890 zur Volkszählung in der USA von Herman Hollerith eingeführt wurde und bis in die 1970er verwendet wurde.

<figure><img src="{filename}lochkarte.jpg"><figcaption>Lochkarte(Bild: <a href="https://commons.wikimedia.org/wiki/File:Lochkarte-white_hg.jpg">Hannes Grobe/AWI</a> CC BY 3.0)</figcaption></figure>

# Unterteilung
Die Unterteilung von Speicher kann durch verschiedene Eigenschaften erfolgen. Die wichtigsten Merkmale sind in den folgenden Abschnitten aufgeführt.

## Flüchtig oder Nicht-Flüchtig
Bei einem flüchtigen Speicher (englisch volatile memory) ist eine Betriebsspannung und teilweise eine zusätzliche Ansteuerung notwendig, um die Information speichern zu können. Fehlen diese Grundvoraussetzungen (z.B. Betriebsspannung fällt aus) geht die Information verloren. Bei einem nicht-flüchtigen Speicher (non-volatile memory) wird keine Betriebsspannung benötigt. Die Information wird hier entweder magnetisch (z.B. Festplatte), optisch (z.B. DVD) oder durch eine elektrische Ladung in einem isolierten Bereich (z.B. EPROM).

Im Detail betrachtet sind einige Verfahren für eine Zeitdauer von mehreren Jahren nicht flüchtig, durch Einflüße aus der Umgebung oder vom Verfahren selbst bedingt kann es aber zu einem Verlust der Information kommen.

## Speichermedium
Informationen können auf viele verschiedene Arten gespeichert werden. Die historisch älteste Art ist die Speicherung mittels mechanischer Veränderung eines Materials (z.B. Lochkarte). Die Information kann aber auch über einen Schaltungszustand gespeichert werden (z.B. Relais oder Flip-Flop). Weitere Möglichkeiten sind die magnetische und optische Speicherung. 

## Beschreibbarkeit
Hier unterscheidet man in Nur-Lese Speicher, der in der Anwendung nur gelesen werden kann und Schreib-Lese Speicher, der in der Anwendung sowohl beschrieben als auch gelesen werden kann. Eine Sonderform ist der sogenannte Einmal-Schreiben-Mehrfach-Lesen Speicher (englisch Write Once Read Many oder WORM). Hier kann der Speicher einmal beschrieben und dann mehrfach gelesen werden.

## Zugriffsart
Bei historischen Bandlaufwerken wird die Information auf einem magnetischen Band gespeichert, welches auf einer Rolle aufgerollt wird. Hier kann die Information nur sequentiell (also nacheinander) eingelesen werden. Das Gegenteil ist bei einem Speicher der Fall, der in einer zufälligen Reihenfolge adressiert werden kann, d.h. es kann wahlfrei darauf zugegriffen werden.

Viele Speicher können wahlfrei adressiert werden, haben aber einen deutlich höheren Datendurchsatz, wenn sie sequentiell gelesen bzw. geschrieben werden.

Eine Sonderform sind sogenannte First-In-First-Out Speicher (oder kurz FIFO). Diese Speicher besitzen ein Port, über welches Daten geschrieben werden und ein Port, über welches die Daten ausgelesen werden. Die Daten kommen in der Reihenfolge aus dem Speicher heraus, in der sie in den Speicher geschrieben wurden. Zusätzlich gibt es eine Signalisierung, ob Daten zum Lesen vorhanden sind und ob noch Platz vorhanden ist um Daten in den Speicher hineinzuschreiben.

## Betriebsart der Speicherzelle
Je nachdem wie eine Speicherzelle aufgebaut ist, kann es vorkommen, dass die Information zyklisch aufgefrischt werden muss. Man spricht dann von einer **dynamischen** Speichererhaltung. Dies ist typischerweise bei Speichern mit einem Kondensator als Speicherelement der Fall, da hier die Ladung über ein nicht ideales Dielektrikum abfließen. Bei Flip-Flops wird die Information ohne Auffrischung erhalten, daher spricht man von einer **statischen** Speichererhaltung. Bei einem Nur-Lese Speicher spricht man von einer **festen** Speichererhaltung.

## Speicherkapazität
Die Speicherkapazität ist die Anzahl der Bits, die gespeichert werden können. Dabei ist es in erster Linie unabhängig davon, in welcher Speicherorganisation diese gespeichert werden. Die Speicherkapazität wird meistens in Byte angegeben und ein Präfix wie *Kilo* oder *Mega* vorangestellt. Die Bedeutung laut IEC 80000-13:2008 der Präfixe entspricht dem SI System und sind dabei Zehnerpotenzen, d.h. *Kilo* entspricht 1.000 und *Mega* entspricht 1.000.000 . Da die Speicher aber binär adressiert werden, hat sich für die Präfixe der Faktor 1.024 angeboten. Um nun eine Verwechslung zu verhindern schlägt die Norm die Verwendung der Prefäxe *Kibi*, *Mebi* usw. vor, um einen Faktor von 1.024 zu beschreiben.

## Speicherorganisation
Die Speicherorganisation beschreibt die Anordnung der Speicherzellen bzw. die Breite eines Datenwortes. Ein speicher mit 1024 Bit kann z.B. als ein Speicher mit 1024 Speicherplätzen und einem Bit als Datenwort organisiert sein. Dies beschreibt man mittels der Bezeichnung *1024x1*. Der 1024 Bit Speicher kann aber auch ein Datenwort von einem Byte bzw. einem Oktett nutzen und hätte dann eine *64x8* Organisation, d.h. es gibt 64 Speicherplätze mit je 8 Bit Datenwortbreite.

## Zugriffsgeschwindigkeit
Die Zugriffsgeschwindigkeit ist abhängig vom Aufbau einer Speicherzelle bzw. dem Verfahren das genutzt wird, um eine Information zu Schreiben und zu Lesen. Bei der Zugriffsgeschwindigkeit wird zwischen Datenrate und Zugriffszeit. Bei der Datenrate geht es um die Geschwindigkeit, in der Daten sequentiell ausgelesen werden können. Die Zugriffszeit beschreibt die Dauer für einen wahlfreien Zugriff.
:
## Maximale Anzahl der Schreibzyklen
Teilweise sind Schreib bzw. Löschvorgänge nicht ohne Degeneration des Materials möglich. So kommt es beim Löschvorgang von Flash-Speichern zu einer allmählichen Zerstörung der Oxidschicht.

## Resistenz gegen Umwelteinflüsse
Je nach Aufbau der Speicherzelle können verschiedene Umwelteinflüsse die Information im Speicher beeinflussen. Ein magnetischer Speicher ist empfindlich gegenüber magnetischen Feldern. Bei Halbleiterspeicher können auch elektromagnetische Felder die Information verfälschen. 
# Halbleiterspeicher

## Ansteuerung mittels Adress-/Datenbus
Halbleiterspeicher haben im Allgemeinen über sogenannte Busse angesprochen. Die Adresse wird über den Adressbus übermittelt und beschreibt die Stelle im Speicher auf die zugegriffen wird. Die Daten werden über den Datenbus gelesen bzw. wenn möglich geschrieben. Der Zugriff wird über einen Kontrollbus gesteuert, welcher Steuer- und Statussignale zusammenfasst.

![Busse zur Ansteuerung von Speicher]({filename}adressbus.png)
