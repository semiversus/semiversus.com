title: Bipolarer Transistor
parent: uebersicht.md

# Allgemeines
Bei einem Bipolartransistor (engl. *bipolar junction transistor* oder kurz *BJT*) werden negativ geladene Elektronen sowie positiv geladene Defektelektronen zum Ladungsträgertransport durch den Transistor genutzt. Dies steht im Gegensatz zum unipolaren Transistor (auch Feldeffekttransistor), bei dem immer nur eine Ladungsträgerart am Ladungsträgertransport durch den Transistor beteiligt ist.

Auch wenn der Feldeffekttransistor wesentlich früher theoretisch beschrieben wurde, war es der Bipolartransistor, der ab den 50er Jahren zu einer Revolution der Miniaturisierung geführt hat.

Ein wichtiges Grundkonzept bei der Arbeit mit Transistoren ist der Umgang mit Modellen. Je nach verwendetem Modell lassen sich bestimmte Vorgänge einfach erklären, andere wiederum nicht. Dazu ist es erforderlich die Modelle zu verstehen und auch zu wissen, für welche Anwendung man welches Modell heranzieht. Im folgenden lernen wir die wesentlichen Modelle kennen: Das Halbleitermodell, das vereinfachte Ersatzschaltbild, das statische Kleinsignal Ersatzschaltbild sowie die Arbeit mit dem Kennlinienfeld.

# Halbleitermodell
Der Bipolartransistor besteht aus drei abwechselnden Schichten aus p- und n-dotierten Halbleiterschichten. Daher spricht man auch von NPN- und PNP-Transistoren. Die drei Bereiche werden *Kollektor* (C), *Basis* (B) und *Emitter* (E) genannt. Die Basis ist besonders dünn und liegt zwischen Emitter und Kollektor. Kollektor und Emitter sind unterschiedlich stark dotiert. Dieser asymmetrische Aufbau bewirkt ein unterschiedliches Verhalten im Normal- und Inversbetrieb.

Die beiden pn-Übergänge lassen sich auch als Dioden darstellen, wobei sich aus diesem Dioden Modell nicht die Funktionsweise ableiten lässt. Im folgenden Bild sieht man die Schaltsymbole und den Aufbau symbolisiert durch zwei Dioden.

<figure><img src="{filename}transistor_diode_npn_pnp.svg"><figcaption>Schaltbilder (Bild: <a href="https://commons.wikimedia.org/wiki/File:Transistor-diode-npn-pnp.svg">Biezl</a> Gemeinfrei)</figcaption></figure>

## Aufbau
Aufgrund von Optimierungen sind Bipolartransistoren heutzutage aus mehr als drei Schichten aufgebaut, die zusätzlichen Schichten sind nicht in Form von weiteren p-n-Übergängen zusammengesetzt, sondern die drei Hauptschichten sind in Zonen unterschiedlicher Dotierungsdichte gegliedert. Die Kollektorzone besteht hierbei immer aus mindestens zwei unterschiedlich stark dotierten Zonen. Die Bezeichnungen npn und pnp beziehen sich nur auf den aktiven inneren Bereich, jedoch nicht den tatsächlichen Aufbau.

<figure><img src="{filename}transistor_npn_schema.svg"><figcaption>Schematischer Aufbau eines NPN Transistors (Bild: <a href="https://commons.wikimedia.org/wiki/File:NPN_BJT_(Planar)_Cross-section.svg">Inductiveload</a> Gemeinfrei)</figcaption></figure>

Paare von npn- und pnp-Transistoren nennt man komplementär, wenn deren elektrische Daten bis auf das Vorzeichen ähnlich sind. Solche auf gute Übereinstimmung der Parameter selektierte „Transistorpärchen“ (entscheidend sind Stromverstärkung sowie Basis-Emitterspannung) werden z. B. in sogenannten Gegentaktschaltungen wie Verstärker-Endstufen eingesetzt, um Verzerrungen niedrig zu halten.

Sind große Ströme gefordert, können mehrere Transistoren parallelgeschaltet werden. Die Übereinstimmung deren Parameter ist hier ebenfalls wichtig, dennoch muss durch Emitterwiderstände dafür gesorgt werden, dass sich die Ströme gleichmäßig auf alle parallelen Transistoren aufteilen.

## Funktionsweise
<figure><img src="{filename}transistor_npn_basic_operation.svg"><figcaption>NPN Halbleitermodell (Bild: <a href="https://commons.wikimedia.org/wiki/File:NPN_BJT_Basic_Operation_(Active)_DE.svg">Inductiveload</a> Gemeinfrei)</figcaption></figure>

Beim Bipolartransistor im analogen / linearen Betrieb wird durch einen elektrischen Strom %%I_{B}%% zwischen Basis und Emitter ein stärkerer Strom %%I_{C}%% zwischen Kollektor und Emitter gesteuert. Das Verhältnis der beiden Ströme, das im Bereich von etwa 4 bis 1000 liegt, ist vom Transistortyp und vom Absolutbetrag des Kollektorstromes abhängig und wird als statischer Stromverstärkungsfaktor %%B%% bezeichnet.

Dieses Verhalten ist vergleichbar mit einem flussabhängigen Ventil bei einem Wasserkanal-Modell. Dieses Modell ist stark vereinfacht und dient nur zur generellen Veranschaulichung der fließenden Ströme, da für die Erklärung der realen Verhältnisse und der Funktionsweise des Bipolartransistors sowohl Elektronen als auch Defektelektronen (Löcher) verantwortlich sind.
Ein Bipolartransistor wird durch drei Schichten unterschiedlicher Dotierung gebildet, die zwei p-n-Übergänge bilden. Die in der Mitte befindliche Basiszone ist die dünnste Schicht.
Im Folgenden wird am Beispiel eines npn-Transistors die generelle Funktionsweise eines Bipolartransistors im Vorwärtsbetrieb (%%U_{BE}>0%%, %%U_{CB}>0%%) dargestellt.

Werden nur Kollektor und Emitter angeschlossen (Spannung %%U_{CE}>0%%), entspricht dies schaltungstechnisch zwei entgegengesetzt geschalteten Dioden, von denen eine (die Basis-Kollektor-Diode) immer gesperrt ist. Es fließt nur ein kleiner Strom, der betragsgleich mit dem Sperrstrom der Basis-Kollektor-Diode ist. Die angelegte Spannung verkleinert zwar die Basis-Emitter-Sperrschicht, die *Raumladungszone* (RLZ) zwischen Basis und Emitter, vergrößert jedoch die Basis-Kollektor-Sperrschicht.

Durch Schließen des Basis-Emitter-Stromkreises (Spannung %%U_{BE}>U_{D}%% (%%U_{D}%% entspricht der Diffusionsspannung), für Silizium %%U_{BE}>0,7V%%) wird die Basis-Emitter-Diode leitend. Wie bei der einfachen pn-Diode werden Defektelektronen aus der Basis (p-dotiert) in den Emitter (n-dotiert) *injiziert* (engl. inject). Es fließt ein kleiner Basisstrom %%I_{BE1}%%. Im Emittergebiet klingt der Minoritätsladungsträgerüberschuss, in diesem Fall Defektelektronen, mit der Diffusionslänge ab, die Defektelektronen rekombinieren mit den Elektronen. Analog dazu werden Elektronen aus dem Emitter (lat. emittere = aussenden) in die Basis injiziert. Aufgrund der geringen Weite der Basis, die kleiner als die Diffusionslänge der Ladungsträger sein muss, rekombinieren jedoch nur wenige der Elektronen mit den Defektelektronen. Die meisten Elektronen (ca. 99 %) diffundieren durch die Basis in die Kollektor-Basis-Sperrschicht, der Basis-Kollektor-Übergang wird in Sperrrichtung betrieben. Dort driften sie wegen des großen Potentialabfalls (%%U_{CB}>0%%) in den Kollektor (lat. colligere = sammeln). In Form des Kollektorstroms IC fließen somit Elektronen vom Emitter in den Kollektor.

Die Anzahl der in das Basisgebiet injizierten Elektronen bzw. der in den Emitter injizierten Defektelektronen ändert sich mit der Flussspannung UBE der Basis-Emitter-Diode. Obwohl nur eine verhältnismäßig kleine Anzahl an Elektronen in der Basis rekombinieren, ist dieser Teil für die Funktion des Bipolartransistors wesentlich. Eine große Anzahl von Elektronen erhöht die Wahrscheinlichkeit, dass ein Elektron auf ein Loch trifft und rekombiniert. Die rekombinierenden Defektelektronen werden über den Basiskontakt in Form eines Teils des Basisstroms nachgeliefert. Durch Ändern des Basisstromes %%I_{B}%% kann demzufolge der Kollektoremitterstrom %%I_{C}%% gesteuert werden. Es wird durch den kleinen Basisstrom, verursacht durch die Defektelektronen, ein viel größerer Kollektorstrom (Elektronenstrom) gesteuert.

<figure><img src="{filename}transistor_npn_spannungen.svg"><figcaption>Spannungen und Ströme am NPN Transistor (Bild: <a href="https://commons.wikimedia.org/wiki/File:Bipolartransistor_(elektrische_Spannungen).svg">Cepheiden</a> GNU FDL 1.0)</figcaption></figure>

Die Wirkungsweise eines pnp-Transistors ist dazu analog, jedoch sind die Vorzeichen umzudrehen, um der entgegengesetzten Dotierung der beiden Sperrschichten Rechnung zu tragen.

# Vereinfachtes Ersatzschaltbild
<figure><img src="{filename}transistor_npn_esb.svg"><figcaption>Vereinfachtes Ersatzschaltbild (Bild: <a href="https://commons.wikimedia.org/wiki/File:Simplified_Transportmodel_of_Bipolartransistor.svg">Biezl</a> Gemeinfrei)</figcaption></figure>

Das einfachste Modell besteht aus der Basis-Emitter-Diode und der durch den Basisstrom %%I_{B}%% gesteuerten Stromquelle (genauer gesagt einer Stromsenke, da keine Energieerzeugung erfolgt) hin zum Kollektor %%I_{C}%%. Der Transistor verstärkt den Basisstrom um den Faktor %%B%%. Voraussetzungen für die Gültigkeit des Modells sind: Die Basis-Emitter-Diode muss in Durchlassrichtung gepolt sein und die Basis-Kollektor-Diode in Sperrrichtung.

Dieses vereinfachte Modell leitet sich aus dem [Ebers-Moll-Modell](https://de.wikipedia.org/wiki/Ebers-Moll-Modell){: class="external" } ab und vereinfacht dieses durch Vernachlässigung von Sperrströmen und dynamischen Effekten. Die grundlegensde Eigenschaft der Verstärkung ergibt sich in diesem Modell durch %%I_{C}=I_{B} \cdot B_{N}%%, wobei %%B_{N}%% die Verstärkung im Normalbetrieb ist.

Eine Anwendung des vereinfachten Ersatzschaltbildes ist zum Beispiel der Betrieb des Transistors als Schalter (wobei hier nicht das dynamische Verhalten beschrieben werden kann).

# Statisches Kleinsignal Ersatzschaltbild
<figure><img src="{filename}transistor_npn_ksesb.svg"><figcaption>Kleinsignal Ersatzschaltbild (Bild: <a href="https://commons.wikimedia.org/wiki/File:BJT_Kleinsignalmodell.svg">Biezl</a> Gemeinfrei)</figcaption></figure>

Das statische Kleinsignalmodell beschreibt das Kleinsignalverhalten bei niedrigen Frequenzen und wird deshalb auch als Gleichstrom-Kleinsignalersatzschaltbild (oder kurz *GS-KSESB*) bezeichnet.

Die Ermittlung der Parameter erfolgt im Arbeitspunkt also unter definierten Randbedingungen. Der differentielle Widerstand der Basis-Emitter-Strecke %%r_{BE}%% entspricht der Tangente zur Diodenkennlinie für den Arbeitspunkt. Der differentielle Kollektor-Emitter-Widerstand %%r_{CE}%% entspricht der Steigung der Ausgangskennlinie bedingt durch den Early-Effekt. Der differentielle Stromverstärkungsfaktor β vervollständigt die Beschreibung des elektrischen Verhaltens. (Der Datenblattwert %%h_{FE}%% entspricht dabei β.)

Unmittelbar mit dem Kleinsignalmodell verwandt sind die Vierpolparameter des Transistors.
Das Großsignalmodell umfasst den gesamten Spannungsbereich, der für das betrachtete Bauteil zulässig ist. Das Kleinsignalmodell gilt nur in einem eng begrenzten Bereich um den Arbeitspunkt. Eine weitere Unterteilung erfolgt in statische und dynamische Modelle. Letztere sind komplexer, denn sie berücksichtigen die kapazitiven Eigenschaften der Sperrschichten und eignen sich daher für mittlere bis hohe Frequenzen.

Für das Kleinsignalersatzschaltbild gilt:

* %%u_{BE} = i_{B} \cdot r_{BE}%%
* %%i_{C} = \beta \cdot i_{B} + \frac{1}{r_{CE}} \cdot u_{CE}%%

Um die differentiellen Werte %%r_{BE}%%, %%r_{CE}%% und %%\beta%% zu erhalten bedient man sich dem Kennlinienfeld des Transistors.

# Kennlinienfeld
Kennlinienfelder dienen der grafischen Darstellung zweier oder mehrerer voneinander abhängiger physikalischen Größen. Sie dienen zur Charakterisierung und Veranschaulichung der elektrischen Eigenschaften/Verhalten des Bauelements. Für die Beschreibung eines Bipolartransistors (als elektrischen Schalter oder in Verstärkerschaltungen) reichen vier grundlegende Kennlinien aus: das Eingangs-, das Ausgangs-, das Stromsteuer- und das Spannungsrückwirkungskennlinienfeld. Werden die Kennlinien gemeinsam dargestellt spricht man auch von Vierquadrantenkennlinienfeld.

<figure><img src="{filename}transistor_npn_kennlinienfeld.svg"><figcaption>Kennlinienfeld (Bild: <a href="https://commons.wikimedia.org/wiki/File:Kombiniertes_Kennlinienfeld_Transistor_2.svg">Biezl</a> Gemeinfrei)</figcaption></figure>

Beim **Eingangskennlinienfeld** wird der Basisstrom %%I_{B}%% gegen die Basisspannung %%U_{BE}%% aufgetragen. Da es sich hierbei nur um den Basis-Emitter-pn-Übergang handelt, entspricht die Kennlinie der einer pn-Diode.

Das **Ausgangkennlinienfeld** stellt die Abhängigkeit des Kollektorstroms %%I_{C}%% von der Kollektor-Emitterspannung %%U_{CE}%% bei ausgewählten Basissteuerströmen %%I_{B}%% dar.

Beim **Stromsteuerkennlinienfeld** (auch Übertragungskennlinienfeld) wird die Abhängigkeit des Kollektorstroms %%I_{C}%% vom ansteuernden Basisstrom %%I_{B}%% bei konstanter Kollektor-Emitterspannung %%U_{CE}%% dargestellt. In der Regel hat sie den Verlauf einer Geraden (annähernd linear) durch den Ursprung, wobei die Steigung dem Stromverstärkungsfaktor %%\beta%% entspricht.

Das **Spannungsrückwirkungskennlinienfeld** (auch Rückwirkungskennlinienfeld genannt) stellt die Rückwirkung der Ausgangsspannung %%U_{CE}%% auf den Eingang (Basis bzw. Basisspannung %%U_{BE}%%) dar.

# Arbeitsbereiche
Der Bipolartransistor besteht aus zwei pn-Übergängen. Indem man entsprechende Spannungen anlegt, kann man beide Übergänge unabhängig voneinander sperren oder durchschalten. Dadurch ergeben sich vier mögliche Arbeitsbereiche, in denen der Transistor ein je eigenes Verhalten zeigt.
## Sperrbereich
Im Sperrbereich (engl. cut-off region) oder Sperrbetrieb sperren beide Übergänge, d. h. die Kollektor- und die Emitterdiode. In diesem Betriebszustand leitet der Transistor theoretisch keinen Strom. Der Transistor entspricht damit einem geöffneten Schalter. Praktisch fließt auch im Sperrbetrieb ein geringer Strom, der Transistor im Sperrbetrieb stellt also einen nichtidealen Schalter dar.

## Verstärkungsbereich
Der Verstärkungsbereich (engl. forward region) tritt im sogenannten Normalbetrieb auf. Hierbei wird die Emitterdiode in Flussrichtung und die Kollektordiode in Sperrrichtung betrieben. Im Verstärkungsbereich gilt näherungsweise die Formel %%I_{C}=\beta \cdot I_{B}%%. Da %%\beta%% relativ groß ist, führen hier kleine Änderungen des Basisstroms %%I_{B}%% zu großen Änderungen des Kollektorstroms %%I_{C}%%. Transistoren werden in diesem Bereich betrieben, um Signale zu verstärken. Im Normalbetrieb wird der Transistor üblicherweise nur in dem Bereich betrieben, in dem die Verstärkung näherungsweise linear gemäß obiger Formel verläuft.

## Sättigungsbereich
Der Sättigungsbereich wird auch Sättigungsbetrieb oder Sättigung genannt. Beide pn-Übergänge leiten, in der Basiszone befinden sich jedoch mehr Ladungsträger als für den Kollektorstrom benötigt werden. Der Kollektorstrom %%I_{C}%% ist unabhängig vom Basisstrom %%I_{B}%%. Der Transistor entspricht einem geschlossenen Schalter mit konstantem Durchgangswiderstand (Linker Bereich im Ausgangskennlinienfeld). Sofern sich der Arbeitspunkt eines Linearverstärkers nicht weit genug entfernt vom Sättigungsbereich befindet oder die Amplitude des Signals zu hoch ist, tritt Übersteuerung ein, der Verstärker begrenzt das Signal und es treten Verzerrungen auf. Das Sperren der Basis-Kollektor-Strecke verzögert sich, da erst alle überschüssigen Ladungsträger aus der Basiszone abfließen müssen.

## Quasi-Sättigungsbereich
Dieser Bereich liegt zwischen Verstärkungsbereich und Sättigungsbereich. Der Transistor wird nicht gesättigt betrieben, wodurch sich Ausschaltzeit und damit die Ausschaltverlustleistung gegenüber dem Betrieb in vollständiger Sättigung deutlich vermindern, was für Schalt-Anwendungen wichtig ist. Erkauft wird dieser Vorteil jedoch durch höhere Durchlassverluste, da die Durchlassspannung um ca. 0,4 V höher liegt.

## Inverser Verstärkungsbereich
Der inverse Verstärkungsbereich (engl. reverse region) wird auch Inversbetrieb genannt. Dabei werden der Basis-Kollektor-Übergang in Durchlassrichtung und der Basis-Emitter-Übergang in Sperrrichtung betrieben. Dieser Bereich funktioniert ähnlich wie der normale Verstärkungsbereich, jedoch mit umgekehrten Vorzeichen der Spannungen. Der Stromverstärkungsfaktor ist deutlich kleiner. Die maximale Sperrspannung der Basis-Emitterdiode beträgt nur einige Volt.
