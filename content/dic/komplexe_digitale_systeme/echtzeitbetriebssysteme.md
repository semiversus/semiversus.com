title: Echtzeitbetriebsssysteme Übersicht
parent: uebersicht.md

# Allgemeines

Ein *Echtzeitbetriebssystem* ist ein Betriebssystem, dass speziell für "Echtzeit"-Anwendungen entwickelt und verwendet wird. Der Schlüsselkriterium eines Echtzeitbetriebssystems (engl. RTOS für Real Time Operating System) ist die Einhaltung der Zeitbedingungen und die Vorhersagbarkeit des Prozessverhaltens.

# Begriffe
## Echtzeit
Abhängig von den Folgen wird manchmal zwischen *harter Echtzeit* (engl. hard real-time), weicher Echtzeit (engl. soft real-time) und fester Echtzeit unterschieden. Hierfür gelten jeweils unterschiedliche Echtzeitanforderungen.

**Harte Echtzeitanforderungen**: Eine Überschreitung der Antwortzeit wird als ein Fehler gewertet. Echtzeitsysteme (sollten) das korrekte Ergebnis immer innerhalb der vorgegebenen Zeitschranken liefern. Um diese Bedingungen einhalten zu können sind genaue Kenntnisse der Resourcenverteilung während des Betriebs schon in der Entwicklungsphase notwendig, um die entsprechenden Vorkehrungen zu treffen.

**Weiche Echtzeitanforderungen**: Solche Systeme arbeiten typischerweise alle ankommenden Eingaben schnell genug ab. Die Antwortzeit erreicht beispielsweise einen akzeptablen Mittelwert oder ein anderes statistisches Kriterium. Die Zeitanforderungen sind hier als Richtlinien zu sehen. Ein Überschreiten der Zeitanforderung muss nicht als Fehler gewertet werden. Zum einen kann die Zeit häufig überschritten werden, solange sie sich noch in einem Toleranzbereich befindet.

**Feste Echtzeitanforderungen**: Bei festen Echtzeitanforderungen droht kein unmittelbarer Schaden. Nach Ablauf der Zeitanforderungen ist das Ergebnis der Berechnung jedoch nutzlos und kann verworfen werden.

Die DIN-Norm 44300 definiert unter Echtzeitbetrieb (dort Realzeitbetrieb genannt) den Betrieb eines Rechnersystems, bei dem Programme zur Verarbeitung anfallender Daten ständig betriebsbereit sind, derart, dass die Verarbeitungsergebnisse innerhalb einer vorgegebenen Zeitspanne verfügbar sind. Diese Begriffsnorm hat sich in der Praxis als alleinig akzeptierte Definition nicht durchsetzen können, es dominieren die Begriffe aus dem englischen Sprachraum.

## Prozess
Ein Prozess beschreibt ein für sich lauffähiges Programm (bei Desktopsystemen) oder vereinfacht einer Funktion. Einem Prozess wird durch den *Prozesskontext* beschrieben. Dieser wird vom Betriebssystem verwaltet und beinhaltet vom Prozess belegte Ressourcen (Speicher, usw.). Vom Betriebssystem zur Verfügung gestellte Ressourcen stehen ausschließlich diesem Prozess zur verfügung.

Der Prozesskontext beinhaltet meist auch, welchem Prozess dieser Prozess zugeordnet ist (sprich, welcher Prozess diesen Prozess gestartet hat). Durch diese Abhängigkeiten ergibt sich eine Prozesshierarchie.

## Prozessmodell
Da ein Prozessor immer nur einen Prozess pro Zeiteinheit bearbeiten kann, werden verschiedene Prozesszustände verwendet, um die Bearbeitung zu ermöglichen:

* *BEREIT*: Der Prozess besitzt alle Ressourcen und wartet auf die Zuteilung von Prozessorzeit.
* *LAUFEND*: Der Prozess wird aktuell durch den Prozessor bearbeitet.
* *WARTEND*: Der Prozess wartet auf die Zuteilung einer Ressource.

Meistens werden auch die Zustände *ERZEUGT* und *BEENDET* beschrieben, die ein Prozess bei der Erzeugung beziehungsweise beim Beenden einnimmt.

## Nebenläufigkeit
*Nebenläufigkeit* (engl. concurrency) liegt vor, wenn mehrere Ereignisse in keiner kausalen Beziehung zueinander stehen, sich also nicht beeinflussen. Bei einem Betriebssystem will man diese Nebenläufigkeit für die Abarbeitung der Prozesse erreichen. Aus der Sicht eines Prozesses sollte es im Idealfall keinen Rolle spielen, ob es der einzige Prozess im System ist oder ob am System mehrere Prozesse laufen.
