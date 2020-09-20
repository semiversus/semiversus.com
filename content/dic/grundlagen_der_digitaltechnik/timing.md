title: Timing in der Digitaltechnik
parent: uebersicht.md

# Allgemeines
Bisher wurden die Elemente der kombinatorischen Schaltnetze und der sequentiellen Schaltwerke so betrachtet, dass jede Änderung eines diskreten Zustandes (logisch 0 oder 1) unmittelbar zu einer Änderung führt. Für reale Bauelemente gilt dies nicht, da jede Änderung mit einer bestimmten Verzögerung behaftet ist. Diese Verzögerungen kommen teils durch die Ausbreitungsgeschwindigkeit selbst oder durch Ladevorgänge innerhalb der Bauteile.

## Ausbreitungsgeschwindigkeit
Die Ausbreitungsgeschwindigkeit von Licht im Vakuum ist 299 792 458 Meter pro Sekunde. Elektronen bzw. genauer gesagt die Auswirkung einer Elektronenbewegung innerhalb eines Leiters bewegt sich annähernd mit Lichtgeschwindigkeit. So benötigt ein Impuls ca. 0.33 Nanosekunden für eine Strecke von 10 Zentimeter.

## Gatterlaufzeit
Die Verzögerung durch ein einzelnes logisches Gatter wird *Gatterlaufzeit* (oder Englisch "*propagation delay*") genannt und bewegt sich je nach verwendeter Technologie des Bausteins zwischen etwa 100ps bis 100ns.

| Logikfamilie | Leistung pro Gatter | Gatterlaufzeit |
| :--- | :---: | :---: |
|Low-Power-Schottky-TTL (LS-TTL) | 2mW | 10ns |
|Advanced-Low-Power-Schottky-TTL (ALS-TTL) | 1mW | 4ns |
|Emittergekoppelte Logik (ECL) | 35mW | 2ns |
|High-Speed-ECL | 50mW | 0.4ns |
|High-Speed CMOS (HC) | 0.5mW/MHz | 10ns (spannungsabhängig) |

## Kritischer Pfad

Der kritische Pfad ist jener Pfad, der die größte Gesamtverzögerung aufweist. Im folgenden ist dieser Pfad rot eingezeichnet:

![Kritischer Pfad bei einer kombinatorischen Schaltung]({filename}kritischer_pfad.png)

Der kritische Pfad weist hier eine Verzögerung von 2ns + 5ns + 5ns, also 12ns auf.

# Definitionen im Timingdiagramm

![Timingdiagramm]({filename}timing_diagramm.svg)

## Anstiegs- und Abfallzeiten
Die *Signalanstiegszeit* (engl. *Rise Time*) beschreibt die Dauer eines Wechsels von logisch 0 auf logisch 1. Die Zeit wird gemessen zwischen dem Durchgang bei 10 und 90 Prozent Pegel des *High*-Pegels. Das gleiche gilt für die *Signalabfallzeit* (engl. *Fall Time*). Da je nach Technologie der Wechsel von logisch 0 auf 1 langsamer oder schneller als der umgekehrte Wechsel sein kann, werden diese Zeiten auch getrennt angegeben.

## Verzögerungszeiten
Die *Verzögerungszeit* (engl. *Propagation Delay*) beschreibt die Zeit zwischen einer Änderung am Eingang und der dazugehörigen Änderung am Ausgang des Gatters. Die Zeit wird zwischen den beiden 50 Prozent Durchgängen gemessen.

# Hazards
Bei einem *Hazard* handelt es sich um einen Störimpuls, der durch Verzögerungen der Signalausbreitung innerhalb einer kombinatorischen Schaltung entsteht. Je nach Ursache unterscheidet man zwischen *Logik-Hazards* und *Funktions-Hazards*. Wenn die Ursache für den Hazard gefunden ist, kann dieser durch entsprechende Maßnahmen beseitigt werden.

## Logik Hazards
> **Definition:**
>
> Falls bei einer kombinatorischen Schaltung die Änderung eines einzigen Einganges zu einem Störimpuls am Ausgang führt, spricht man von einem *logischen Hazard*.

### Beispiel Multiplexer

![Hazard bei einem Multiplexer]({filename}hazard_mux.svg)

Am Beispiel eines Multiplexers sieht man das Auftreten eines *Static-1* Hazards. Ein *Static-1* Hazard ist ein Störimpuls bei einem Signal, welches rein kombinatorisch bei einer bestimmten Änderung eines Einganges vor und nach der Änderung logisch 1 ist. Der Hazard tritt nur auf, wenn <code>A</code> und <code>B</code> logisch 1 sind und <code>S</code> von logisch 1 auf 0 wechselt.

Die Schaltung ist mittels Disjunktiver Normalform aufgebaut. Zuerst werden die einzelnen Minterme mittels *AND*-Verknüpfung gebildet und diese werden dann mittels *OR*-Verknüpfung zusammengefasst.

Zeichnet man das KV-Diagramm auf, ergibt sich folgendes Bild:

![KV-Diagramm des Multiplexers]({filename}hazard_mux_kv.svg)

Man sieht die zwei unabhängige Minterme %%A\overline{S}%% und %%BS%%. Wird das Signal S gewechselt, wechseln auch die zuständigen Minterme. Dies ist ein Zeichen dafür, dass ein Hazard auftreten **kann**.

Damit ein logischer Hazard überhaupt auftreten kann, müssen folgende drei Bedingungen erfüllt sein:

- Das Eingangssignal muss sich in mindestens zwei Pfade auftrennen.
- Die verschiedenen Pfade müssen unterschiedliche Laufzeiten aufweisen.
- Die Pfade müssen über logische Verknüpfungen wieder an einem Ausgang zusammengefasst werden.

Durch zusätzliche Gatter können logische Hazards abgefangen werden. Wir haben gesehen, dass der Hazard beim Wechsel zwischen den beiden Mintermen auftritt (bei A und B gleich logisch 1). Um nun diesen Fall abzufangen fügen wir einen weiteren Minterm <code>AB</code> hinzu:

![KV-Diagramm des Hazard-freien Multiplexers]({filename}hazard_free_mux_kv.svg)

Dieser zusätzliche Primimplikant ist aus rein kombinatorischer Sicht redundant, er verhindert aber den *Logik-Hazard*.

## Funktionaler Hazard
> **Definition:**
>
> Falls bei einer kombinatorischen Schaltung die gleichzeitige Änderung an zwei oder mehr Eingängen zu einem Störimpuls am Ausgang führt, spricht man von einem *funktionalen Hazard*.

Wenn wir in unserem Beispiel den Eingang A auf logisch 1 setzen und dann die Eingänge B und C gleichzeitig von 0 auf 1 ändern, kann es zu einem funktionalen Hazard kommen. Im KV-Diagramm sieht man diesen Wechsel. Der Weg kann über eine logische 0 oder 1 führen.

![Zustandsänderung bei einem funktionalen Hazard]({filename}funktionaler_hazard.png)

Funktionale Hazards kann man in den meiste Fällen nicht durch Hinzufügen von redundanten Schaltelementen vermeiden.
