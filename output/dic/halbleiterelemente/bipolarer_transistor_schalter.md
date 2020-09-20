title: Bipolarer Transistor als Schalter
parent: uebersicht.md

# Allgemeines
Eine typische Anwendung für Transistoren ist das Schalten von Lastströmen. Der einfachste Fall ist eine Last, die keinen
Bezug zum Massepontential braucht. Dies nennt man *Low-Side* schalten.

# Low-Side Schalter 
![Prinzipschaltbild]({filename}bipolarer_transistor_schalter.svg)

Für dieses Beispiel wird ein [TIP31A](https://www.onsemi.com/pub/Collateral/TIP31A-D.PDF){: class="external" } (NPN
Transistor %%I_{C Max}%%=3A, %%U_{CE Max}%%=60V) verwendet.

Für die Auswahl des Transistors und der Berechnung von %%R_B%% müssen zwei Fälle betrachtet werden. Der ausgeschaltete und der
eingeschaltete Zustand.

## Ausgeschalteter Zustand
Bei der Auswahl des Transistors ist es wichtig, dass die im ausgeschalteten Zustand anliegende Spannung %%V+%% an Kollektor
und Emitter nicht zu einer Beschädigung führt. Im Datenblatt ist diese Maximale Spannung von %%U_{CE}%% meist mit %%U_{CE0}%%
bzw. %%V_{CE0}%% beschrieben. Für den gegebenen Transistor ist diese Spannung 60V, d.h. die Betriebsspannung darf nicht
höher 60 Volt sein. 

Ein zweiter Punkt der meist kein Problem darstellt ist der Abschaltstrom des Transistors. Wenn durch die Basis kein Strom
fließt, aber eine Spannung %%U_{CE}%% anliegt so ist der Strom %%I_C%% nicht 0 sondern es fließt ein sehr kleiner *Abschaltstrom*.
Dieser findet sich im Datenblatt meist unter %%I_{CE0}%% bzw. *Collector Cutoff Current*.

## Eingeschalteter Zustand
Im eingeschaltenen Zustand ist die Spannung %%U_{CE}%% am Transistor sehr klein. Der ausgewählte Transistor muss hier zwei
Eigenschaften besitzen:

* Der Strom durch den Kollektor muss kleiner %%I_{C Max}%% sein
* Die abfallende Leistung am Transistor muss kleiner %%P_{D}%% (*Power Dissipation*, je nach Kühlung) sein

Wird der Transistor voll durchgesteuert entspricht die Spannung %%U_{CE}%% der Sättigungsspannung %%U_{CE Sat}%%. Die
Sättigungspsannung ist stark abhängig von Temperatur, Übersteuerungsfaktor und dem Strom %%I_C%%. Sie wird über Kennlinien
im Datenblatt ermittelt. Für kleine Ströme %%I_C%% (<100mA) wird sie oft mit 0.1 Volt angenommen.

Die Verlustleistung am Transistor besteht aus zwei Komponenten:

* Über die Basis fließt der Basisstrom, wobei die Basisspannung %%U_{BE}%% abfällt
* Über den Kollektor fließt der Kollektorstrom, wobei die Sättingungsspannung abfällt

Daraus ergibt sich für die Gesamtleistung %%P_{Transistor}=I_B \cdot U_{BE} + I_C \cdot U_{CE Sat}%%. Da der Anteil über die
Basisdiode viel kleiner ist gilt %%P_{Transistor} \approx I_C \cdot U_{CE Sat}%%.

## Berechnung des Basiswiderstand
<figure><img src="{filename}transistor_npn_esb.svg"><figcaption>Vereinfachtes Ersatzschaltbild (Bild: <a href="https://commons.wikimedia.org/wiki/File:Simplified_Transportmodel_of_Bipolartransistor.svg">Biezl</a> Gemeinfrei)</figcaption></figure>

Um den Basiswiderstand zu berechnen hilft das vereinfachte Ersatzschaltbild des Transistors. Dieses zeigt für die Basis
einen Spannungsabfall über eine Diode. Der Kollektorstrom %%I_C%% wird durch eine Stromquelle dargestellt, welche mittels
%%I_C=B_N \cdot I_B%% gesteuert wird.

Würde man nun %%I_B%% mittels %%I_C/B%% berechnen, würde der Transistor gerade so durchgeschaltet, dass der Kollektorstrom
fließen kann. Bauteilstreuungen und ein großer Umgebungstemperaturbereich führen dazu, dass der Transistor in vielen Fällen
nicht durchgesteuert sein wird. Um dies sicherzustellen wird ein *Übersteuerungsfaktor* genutzt. Dabei wird der berechnete Basisstrom
einfach um einen Faktor höher angenommen als er idealerweise sein müsste.

Für die Berechnung wird zuerst der Basisstrom ausgerechnet, um dann den Widerstand %%R_B%% ermitteln zu können:

 %%I_B=\frac{I_C}{B} \cdot \textrm{\"u}%% mit %%\textrm{\"u}=2 \ldots 5%%

 %%R_B=\frac{U_E-U_{BE}}{I_B}%%
