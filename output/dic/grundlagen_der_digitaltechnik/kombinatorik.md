title: Kombinatorik
parent: uebersicht.md

# Allgemeines
Bei einer kombinatorischen Schaltung handelt es sich um eine Digital-Schaltung deren Ausgänge eindeutig durch die Eingänge bestimmt sind. Um dies zu erreichen darf die Schaltung keine speichernden Elemente aufweisen, d.h. die Schaltung ist *Zustandslos*. Ein weiteres Kennzeichen von kombinatorischen Schaltungen ist die *Zyklenfreiheit*. Eine Schaltung besitzt einen *Zyklus*, wenn der Ausgang eines Gatters auf den Eingang des selbigen rückwirken kann.

Ein solches Schaltnetz kann durch die elementaren logischen Schaltglieder (*Gatter*) dargestellt werden: <code>AND</code>, <code>OR</code>, <code>XOR</code> und <code>NOT</code>. Darstellungsformen sind unter anderem *Boolesche Funktionen*, *Wahrheitstabellen* oder zeichnerische Verknüpfungen von logischen Schaltglieder.

Bei den Schaltnetzen im folgenden Kapitel werden die Schaltverzögerungen durch Gatterlaufzeiten bzw. Signallaufzeiten nicht betrachtet.

# Logische Gatter
Zu den gebräuchlichsten Logikgattern zählen <code>AND</code>, <code>OR</code>, <code>NOT</code> und <code>XOR</code>. Die Gatter <code>NAND</code>, <code>NOR</code> und <code>XNOR</code> können durch Kombination von <code>AND</code>, <code>OR</code> bzw. <code>XOR</code> mit einem <code>NOT</code> Gatter gebildet werden.

## <code>AND</code>-Gatter
Ein <code>AND</code>- bzw. zu deutsch <code>UND</code>-Gatter hat zwei oder mehr Eingänge und einen Ausgang. Die <code>AND</code>-Verknüpfung kann in booleschen Funktionen als "•" (Mal), "&" oder mittels "%%\land%%" dargestellt werden. In der klassischen Logik wird eine Aussage, die nur dann wahr ist, wenn zwei oder mehr Aussagen wahr sind als *Konjunktion* bezeichnet.

Die Wahrheitstabelle für ein Gatter mit zwei Eingängen:

%%A%%|%%B%%|%%A \land B%%
:-:|:-:|:-:
0|0|0
0|1|0
1|0|0
1|1|1

Der Ausgang ist also auf logisch 1 wenn A **und** B auf logisch 1 sind.

!!! panel-info "Der Ausgang eines <code>AND</code> Gatter ist nur dann logisch 1, wenn alle Eingänge logisch 1 sind."

Betrachtet man die logisch 0 am Eingang stellt sich auch eine Besonderheit heraus:

!!! panel-info "Der Ausgang eines <code>AND</code> Gatter ist logisch 0, wenn mindestens ein Eingang logisch 0 ist."

## <code>OR</code>-Gatter
Ein <code>OR</code>- bzw. <code>ODER</code>-Gatter hat zwei oder mehr Eingänge und einen Ausgang. In booleschen Funktionen wird die <code>OR</code>-Verknüpfung als "+" oder als "%%\lor%%" dargestellt. Eine *Disjunktion* ist in der klassischen Logik eine Aussage, die dann wahr ist, wenn mindestens eine Teil-Aussage wahr ist.

Die Wahrheitstabelle für ein <code>OR</code>-Gatter mit zwei Eingängen:

%%A%%|%%B%%|%%A \lor B%%
:-:|:-:|:-:
0|0|0
0|1|1
1|0|1
1|1|1

Der Ausgang ist auf logisch 1 wenn A **oder** B auf logisch 1 sind. In der klassischen Logik gibt die Unterscheidung zwischen der ausschließenden und der nicht-ausschließenden Disjunktion. Bei einer ausschließenden Disjunktion können nicht beide Teilaussagen wahr sein, z.B.:"Wir gehen nach Italien oder nach Schweden". Das <code>OR</code>-Gatter bedient sich der nicht-ausschließenden Disjunktion.

Allgemein gilt für ein <code>OR</code>-Gatter:

!!! panel-info "Der Ausgang eines <code>OR</code> Gatter ist logisch 1, wenn mindestens ein Eingang logisch 1 ist."

Betrachtet man die logisch 0 am Eingang kommt man auf folgende Aussage:

!!! panel-info "Der Ausgang eines <code>OR</code> Gatter ist nur dann logisch 0, wenn alle Eingänge logisch 0 sind."

## <code>NOT</code>-Gatter
Das <code>NOT</code>-Gatter hat einen Eingang und einen Ausgang. Der Ausgang stellt die Invertierung (auch *Komplement* genannt) des Einganges dar. In booleschen Funktionen wird es mittels "%%\neg%%" dargestellt. In der klassischen Logik stellt es eine Verneinung einer Aussage dar.

Oft sieht man auch die Darstellung mittels Überstrich (z.B. %%\overline{\overline{A} \land {B}}%%)

Wahrheitstabelle:

%%A%%|%%\neg A%%
:-:|:-:
0|1
1|0

# Weitere Verknüpfungen
## <code>NAND</code>- und <code>NOR</code> Gatter
Bei den <code>NAND</code>- und <code>NOR</code>-Gatter handelt es sich jeweils um ein <code>AND</code>- bzw. <code>OR</code>-Gatter dem ein <code>NOT</code>-Gatter nachgeschalten ist. Durch Kombination mehrerer <code>NAND</code>-Gatter (oder auch Kombination mehrer <code>NOR</code>-Gatter) lassen sich alle logischen Verknüpfungen realisieren.

%%A%%|%%B%%|%%\overline{A \land B}%%|%%\overline{A \lor B}%%
:-:|:-:|:-:|:-:
0|0|1|1
0|1|1|0
1|0|1|0
1|1|0|0

Am Beispiel des <code>NAND</code>-Gatters zeigt das folgende Bild die Möglichkeiten der Substitution:

![Gatter Substitution]({filename}gatter_substitution.svg)

## XOR-Gatter
Das XOR-Gatter (von engl. *e**X**clusive **OR***) hat meist zwei (oder auch mehr) Eingänge und einem Ausgang. Bei einem XOR-Gatter mit zwei Eingängen ist der Ausgang auf logisch 1, wenn einer der beiden Eingänge auf logisch 1 ist, aber nicht beide gleichzeitig. Dies entspricht der ausschließenden Disjunktion. Für zwei oder mehr Eingänge ist der Ausgang auf logisch 1, wenn an einer ungerade Anzahl von Eingängen eine logische 1 anliegt.

In booleschen Funktionen wird die XOR Verknüpfung mittels "%%\oplus%%" dargestellt.

Wahrheitstabelle:

%%A%%|%%B%%|%%A \oplus B%%
:-:|:-:|:-:
0|0|0
0|1|1
1|0|1
1|1|0

!!! panel-info "Der Ausgang eines <code>XOR</code> Gatter ist logisch 1, wenn an einer ungeraden Anzahl an Eingängen eine 1 anliegt."

## Darstellungsformen
![Gatter Darstellungsformen]({filename}gatter.svg)

Im europäischen Raum wird für die Darstellung von Schaltsymbolen die Norm IEC 60617 verwendet. In Schaltplänen findet man auch recht häufig die im amerikanischen Raum verbreitete Darstellungsform nach der Norm US ANSI 91-1984. Die Darstellung nach DIN 40700 ist veraltet.

# Rechengesetze
Für die Operatoren der booleschen Algebra gilt die folgende Rangfolge (in absteigender Wertigkeit):

1. Negation (%%\neg%%)
2. Konjunktion (%%\land%%)
3. Disjunktion (%%\lor%%)

Name | AND | OR
-----|-----|----
Kommutativgesetz | %%a \land b = b \land a%% | %%a \lor b = b \lor a%%
Assoziativgesetz | %%( a \land b ) \land c = a \land ( b \land c )%% | %%(a \lor b) \lor c = a \lor (b \lor c)%%
Idempotenzgesetz | %%a \land a=a%% | %%a \lor a=a%%
Distributivgesetz | %%a \land (b \lor c) = (a \land b) \lor (a \land c)%% | %%a \lor (b \land c) = (a \lor b) \land (a \lor c)%%
Neutralitätsgesetz | %%a \land 1 = a%% | %%a \lor 0 = a%%
Extremalgesetz | %%a \land 0 = 0%% | %%a \lor 1 = 1%%
Doppelnegationsgesetz | %%\overline{ \overline{a} } = a%%
De Morgansche Gesetz | %%\overline{ a \land b } = \overline{ a } \lor \overline{b}%% | %%\overline{a \lor b} = \overline{a} \land \overline{b}%%
Komplementärgesetz | %%a \land \overline{a} = 0%% | %%a \lor \overline{a} = 1%%
Dualitätsgesetz | %%\overline{0} = 1%% | %%\overline{1} = 0%%
Absorptionsgesetz | %%a \lor (a \land b) = a%% | %%a \land (a \lor b) = a%%
