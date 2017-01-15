title: LTI Systeme
parent: uebersicht.md
next: faltung.md

#Allgemeines

In der Nachrichtentechnik versteht man ein System als eine Anordnung von verbundenen Komponenten zur Realisierung einer
Aufgabenstellung. Ein System kann im mathematischen Sinne als Funktion(en) verstanden werden, die einen Zusammenhang
zwischen Ein- und Ausgängen herstellt.

![Systeme]({filename}system.svg.tex)

Je nachdem nach welcher der drei Komponenten (Eingang, Ausgang oder System) gesucht wird unterscheidet man:

* **Systemanalyse** - Das Ausgangssignal wird gesucht, gegeben ist das Eingangssignal und das System
* **Systemsynthese** - Das System wird gesucht, gegeben ist das Ein- und Ausgangssignal
* **Meßtechnik** - Das Eingangssignal wird gesucht, gegeben ist das System und das Ausgangssignal

# Einordnung von Systemen
## Lineare Systeme
*Linearität* bedeutet, dass der Zusammenhang des Eingangs und des Ausgangs eines Systems eine *Lineare Abbildung* ist.

!!! panel-info "Linearität"
    Wenn der Eingang %%x_1[n]%% zum Ausgang %%y_1[n]%% führt und %%x_2[n]%% zum Ausgang %%y_2[n]%% führt, dann muss der
    *addierte* und *skalierte* Eingang %%a_1 x_1[n]+ a_2 x_2[n]%% zum addierten und skalierten Ausgang
    %%a_1 y_1[n]+ a_2 y_2[n]%% führen.

Die Linearität ist eine sehr wichtige Systemeigenschaft, den dadurch wird es mögliche komplexe Eingangssignale in
einfachere Teilsignale zu zerlegen und die resultierenden Ausgangssignale zu berechnen.

Ein lineares System setzt voraus, dass beim Eingangssignal %%x[n]=0%% das Ausgangssignal %%y[n]=0%% ist, d.h. es darf
keinen konstanten Term in der Systemgleichung geben (z.B. %%y[n]=x[n]+2%% ist ein nichtlineares System).

## Zeitinvariante Systeme
*Zeitinvarianz* bedeutet, dass egal zu welchem Zeitpunkt ein Eingangssignal an ein System angelegt wird, das
Ausgangssignal (bis auf die zeitliche Verzögerung) ident ist.

Ein lineares System ist zeitinvariant, wenn die Koeffizienten der linearen Differentialgleichung konstant sind. In diesem
Fall spricht man von *LTI*- (engl. für *Linear Time Invariant*) Systemen.

LTI Systeme sind mittels Digitaltechnik einfach zu realisieren. Bei Analogtechnik gibt hier z.B. Probleme bei der
Alterung von Bauteilen oder Temperaturabhängigkeiten.

## Länge der Impulsantwort
Die Impulsantwort enthält die vollständige Information um ein zeitdiskretes LTI System zu beschreiben. Je nach Art
des Systems gibt es zwei Möglichkeiten:

* **FIR** - engl. für *Finite Impuls Response*, also endliche Impulsantwort
* **IIR** - engl. für *Infinite Impuls Response*, also unendliche Impulsantwort

### FIR
In einem FIR System hat die Impulsantwort %%h[n]%% endlich viele Werte ungleich Null. Die Antwort
eines solchen *FIR*-Systems kann einfach mittels Faltung des Eingangssignals und der Impulsantwort berechnet werden.

Ein FIR System lässt sich wie folgt beschreiben:

%%y[n]=h[0]\cdot x[n] + h[1]\cdot x[n-1] + h[2]\cdot x[n-2] + \ldots + h[N]\cdot x[n-N]=\sum\limits_{k=0}^N h[k] \cdot x[n-k]%%

### IIR
Ein IIR System liefert eine unendliche lange Impulsantwort. Dies kann der Fall sein, wenn z.B. durch eine Rückkopplung
der Ausgang zum Zeitpunkt %%y[n]%% von %%y[n-1]%% abhängig ist.

%%y[n]=\sum\limits_{k=0}^\infty h[k] \cdot x[n-k]%%

## Speicher
Der Ausgang eines speicherlosen Systems ist nur vom aktuellen Eingangswert abhängig. Um eine Abhängigkeit von
vorangegangenen Eingangswerten zu ermöglichen benötigt das System einen Speicher, um diese Werte entsprechend
vorzuhalten.

Ein speicherloses LTI System kann den Eingangswert nur multiplizieren:

%%y[n]=a x[n]%%

Wenn das System einen Speicher besitzt, können auch %%N%% *frühere* Eingangswerte berücksichtigt werden:

%%y[n]=a_0 x[n] + a_1 x[n-1] + a_2 x[n-2] + \ldots = \sum\limits_{k=0}^N a_k x[n-k]%%

Ein System mit einem Speicher nennt man auch ein *dynamisches* System.

## Kausalität
Ein System ist *kausal*, wenn es nur von *aktuellen* oder *früheren* Eingangswerten abhängt, aber keinen *zukünftigen*.

Beim folgende System ist jeder Ausgangswert das arithmetische Mittel dreier Eingangswerte:

%%y[n]=\frac{1}{3}(x[n-1]+x[n]+x[n+1])%%

Dieses System ist *nicht kausal*, da der Ausgangswert zum Zeitpunkt %%n%% von einem Eingangswert zum Zeitpunkt %%n+1%%
abhängt.

Das System mit der Eigenschaft der Mittelung von drei Werten lässt sich aber auch *kausal* formulieren:

%%y[n]=\frac{1}{3}(x[n-2]+x[n-1]+x[n])%%

## Stabilität
Ein System gilt als stabil, wenn das Ausgangssignal bei beschränktem Eingangssignal nicht über alle Grenzen anwächst.

Zur Definition von Stabilität gibt es verschiedene Methoden, wobei in der Systemtheorie die sogenannte *BIBO*-Stabilität
üblich ist. BIBO steht für engl. *bounded input, bounded output* (beschränkter Eingang, beschränkter Ausgang)

In einem LTI System lässt sich die BIBO Stabilität über die Impulsantwort ausdrücken, wenn diese absolut integrierbar
ist:

%%\sum\limits_{n=0}^\infty \left|h[n]\right|\ < \infty%%

Jedes FIR System ist BIBO stabil, da die Summe über die Absolutwerte der Impulsantwort kleiner Unendlich ist (solange
kein Koeffizient unendlich ist). Bei einem IIR System ist es möglich nicht BIBO stabil zu sein.

So ist die ein IIR System mit der Impulsantwort %%h[n]=u[n]%% (Einheitssprung) nicht BIBO stabil, da die Summe der Werte des
Ausgangssignals von 0 bis Unendlich gleich Unendlich ist.

Als Gegenbeispiel ist ein System mit der Impulsantwort %%h[n]=e^{-n}%% (für n größer gleich 0) BIBO stabil, obwohl
die Impulsantwort unendlich lang ist, sie sich aber 0 immer weiter annähert und daher die Summe kleiner Unendlich ist.
