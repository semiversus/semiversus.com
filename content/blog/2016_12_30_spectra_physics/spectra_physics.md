title: Elektronik- und Softwareentwicklung bei Spectra Physics
date: 2016-12-30
tags: Verschiedenes
image: spectra_tb.png

Spectra Physics Standort Rankweil/Vorarlberg (Österreich) hat derzeit eine Stelle für Elektronik/Softwareentwicklung offen (hier die [Stellenanzeige](http://www.spectra-physics.com/company/rankweil-de/karriere/rankweil-karriere-elektronik-entwicklungsingenieur)). Da die Stellenanzeigen meist sehr allgemein gehalten sind, möchte ich die Aufgabengebiete unserer Abteilung beschreiben.

## Unser Team
Unser Team besteht aus Fachleuten mit Spezialisierung in einem oder mehreren Fachbereichen. Im folgenden werden die einzelnen Fachbereiche beschrieben. Selten wird jemand in allen Fachbereichen Erfahrung gesammelt haben. Die unscharfe Abgrenzung der Fachbereiche mag für manche ungewohnt wirken - ich finde, es ist unsere größte Stärke. Die meisten in unserem Team haben dadurch viel Wissen in Fachbereichen aufgebaut, die ihnen anfangs unvertraut waren.

Ich bin seit acht Jahren bei Spectra Physics und bin hauptsächlich mit Firmware bzw. Softwareerstellung für Embedded Systems beschäftigt. Die Aufgabengebiete sind meist sehr fließend zwischen Firmware/Softwareentwicklung, reiner Elektronikentwicklung (Schaltplan/Layout), Entwicklung von Designs für programmierbare Logiken, Inbetriebnahme von Prototypen und Serienüberführung.

## Elektronik in einem Laser
Einfachste Lasersysteme bestehen aus einem Mikrocontroller (typischerweise Atmel AVR) und kommunizieren mittels RS485 und einem proprietären Protokoll mit dem PC. Das proprietäre Protokoll ist seit mehreren Jahren im Einsatz, und es sind viele Tools rund um das Protokoll entstanden, die das Entwicklerleben vereinfachen. Komplexe Lasersysteme bestehen aus einem Linux System auf ARM Basis und mehreren (bis zu 20) Mikrocontroller für die einzelnen Komponenten. Dazu kommt meist ein FPGA für die Steuerung und Kontrolle schneller Signale.

<img src="{filename}spectra.png" class="pull-right">
Für die Entwicklung der Mikrocontroller steht ein Grundgerüst mit vielen Softwaremodulen zur Verfügung. Programmiersprache ist C, je nach Anwendung auch mal Assembler oder C++. Die Entwicklung ist stark durch Automatisierung des Build Prozesses getrieben. Dazu gehören neben der vollständigen Distributionserstellung in einem Schritt auch Unit Tests. Ein Softwareentwicklungsprozess wurde erarbeitet und hat sich an vielen Stellen etabliert, an anderen Stellen sind noch Anpassungen notwendig. Auf dieser Ebene arbeiten ca. fünf Fachleute zusammen. Es hat sich ein einheitlicher Programmierstil geprägt, der die Einarbeitung in Projekte und den Wissensaustausch erleichtert.

Die Applikationslogik bei komplexeren Systemen läuft auf dem bereits genannten Linux Embedded System und wird dort in Python programmiert. Verwendet wird Python 3.5 mit aktuellen Sprachmitteln wie etwa asyncio. Die Applikation baut auf einer eigenen Bibliothek auf, die einen Großteil der Funktionalität abbildet. Ein großer Vorteil von Python ist hier die Unabhängigkeit von Hardware. So ist man unabhängig davon, ob die Applikation schlussendlich auf einem Desktopcomputer oder einem Embedded System entwickelt wird beziehungsweise laufen soll. Profilling hilft, zeitkritische Stellen zu erkennen, um diese dann in C oder Cython zu implementieren. So stellen wir sicher, dass auch komplexe Systeme eine niedrige Prozessorlast sowie eine schnelle Reaktionszeit haben.

## Herausforderungen
Neben der genannten Firmware/Softwareentwicklung ist die Elektronikentwicklung selbst ein großer Teil unseres Arbeitsalltags. Dies beginnt mit Schaltplanentwürfen und geht bis zur Entwicklung von Testständen für serienreife Produkte. Spannend an Lasersystemen finde ich persönlich die Vielfalt an notwendiger Elektronik:

* Spannungen von einigen Kilovolt, die in Nanosekunden geschalten werden
* Ströme von bis zu 100 Ampere, deren Welligkeit kleiner 50 Milliampere sein muss, um keine Einbussen bei der Strahlqualität zu haben
* Laserpulsfolgen von 60 Megahertz und mehr, die entsprechend verarbeitet werden müssen
* Messung und Regelung von Temperaturen auf 0,01 Grad Celsius genau
* Vielfältige Sensorik (Photodioden, Umgebungseinflüsse, ...) und Aktorik (Gleichspannungs- und Schrittmotoren, motorisierte Spiegel, ...)
* 8- und 32-Bit Mikrocontroller, FPGAs und Software für Desktopcomputer

Sämtliche Entwicklungen geschehen immer unter Berücksichtigung der Anforderung für medizinische Geräte oder industrielle Anwendungen. Die gesammelten Erfahrungen in diesen Bereichen haben großen Einfluss auf unsere Entwicklungsprozesse und damit unsere tägliche Praxis.

Ein weiteres Steckenpferd ist die Entwicklung von Designs für FPGAs. Wenn diskrete Elektronik zu komplex und der schnellste Mikrocontroller zu langsam ist, werden FPGAs verwendet, um unsere Anforderungen an zeitkritische Signalverarbeitung zu erfüllen. Wir programmieren in VHDL und verwenden typischerweise Bausteine von Altera.

Insgesamt kann ich für mich sagen, dass ich viele spannende Jahre hier verbracht habe und Tag für Tag Neues lernen kann. Ich bin stolz auf unser Team und auf unsere Produkte.

Wer weitere Fragen zur Arbeit bei Spectra Physics hat, kann sich gerne bei mir direkt melden. Sollte die Stelle in Kürze vergeben sein einfach trotzdem eine Initiativbewerbung starten. Wenn beim Lesen des ein oder anderen Absatzes die Finger voller Tatendrang zu kribbeln anfingen, bist du bei uns richtig ;-)
