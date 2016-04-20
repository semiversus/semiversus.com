title: Scheduling
parent: uebersicht.md

# Allgemeines
Unter Scheduling (englisch für „Zeitplanerstellung“), versteht man das Erstellen eines Ablaufplanes (schedule), der
Prozessen zeitlich begrenzt Ressourcen zuteilt. Dem Scheduler stehen als Entscheidungsbasis die anstehenden Aufgaben zur
Verfügung.

# Kriterien
Ein gutes Scheduling-Verfahren zeichnet sich dadurch aus, dass es die folgenden Kriterien optimiert:

* **Durchsatz**: Möglichst viele Prozesse werden in möglichst kurzer Zeit abgearbeitet.
* **Effizienz**: Die zur Verfügung stehenden Ressourcen werden möglichst vollständig ausgelastet.
* **Fairness**: Die Ressourcen werden den Prozessen gerecht zugeteilt, das heißt kein Prozess wird dauerhaft vernachlässigt. Man sagt auch, das Verfahren vermeide das „Verhungern“ (starvation) von Prozessen.
* **Echtzeit**: Prozesse, die zu einem bestimmten Zeitpunkt beendet sein müssen, werden so geplant, dass der Zeitpunkt eingehalten wird.
* **Verweilzeit**: Prozesse sollten möglichst schnell beendet sein.
* **Einfach und schnell**: Für Implementierungen kann es sinnvoll sein, möglichst wenig Ressourcen im Scheduler selbst zu verbrauchen.

# Präemptiv und Nicht-Präemptiv 
Beim nicht-präemptiven Verfahren übergibt ein Prozess die benötigten Ressourcen selbstständig, wenn diese nicht mehr benötigt werden. Dies gilt insbesondere für die Prozessorzeit. Wenn einem Prozess also Prozessorzeit zugeteilt wird kann dieser Prozess frei entscheiden, wann er die Kontrolle an das Betriebssystem zurück gibt. Dieses Verfahren wird auch kooperatives Verfahren genannt. Wenn ein Prozess durch einen Fehler die Kontrolle nicht zurück gibt bleibt das ganze System *hängen*. Dieses Verfahren kann aber große Vorteile bei Echtzeitbetriebssystemen haben, da es möglich ist, die Ressourcen sehr gut zu nutzen.

Das präemtive (engl. preemptive) Verfahren hat die Möglichkeit, dem Prozess die Zuteilung des Prozessors zu entziehen. Dieses Verfahren wird meist mit festen Zeitschlitzen implementiert, nach deren Ende jeweils ein Prozesswechsel vollzogen wird.

# Scheduling Strategien
Das größte Problem des Schedulers ist die Tatsache, dass die benötigten Betriebsmittel für die einzelnen Prozesse meist nicht im Vorfeld bekannt sind. Es lässt sich also im Allgemeinen keine optimale Planung erstellen, sondern der Scheduler muss dynamisch auf geänderte Anforderungen reagieren. Dabei können (abhängig vom Scheduler) verschiedene Zuteilungsstrategien zum Einsatz kommen.

## First In – First Out (FIFO), First-Come First-Served (FCFS)
Hierbei werden alle Prozesse in der Reihenfolge ihres Eingangs bearbeitet. Eine Neuzuteilung der Prozesse findet erst statt, wenn der laufende Prozess zu warten beginnt oder seine Ausführung beendet ist. Diese Strategie erzielt eine gute Auslastung bezüglich der CPU, allerdings nicht bezüglich Ressourcen, die längere Zeit für eine Anforderung benötigen können, wie z. B. Ein-/Ausgabe oder Massenspeicher. Für Mehrbenutzersysteme ist die Strategie darüber hinaus wenig geeignet, da einzelne Benutzer so ggf. für längere Zeit (nämlich bei aufwendigen Prozessen anderer Benutzer) ausgeschlossen werden.

Beispiel mit kooperativem Scheduling

&nbsp; | Startzeit | Dauer
:-:|:-:|:-:
Job A | 0 | 4
Job B | 1 | 3
Job C | 2 | 2
Job D | 5 | 1

Ausführung:

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| A | A | A | A | B | B | B | C | C | D |

## Shortest-Job-Next (SJN), Shortest Job First (SJF), Shortest Processing Time (SPT)
Ein weiteres Verfahren, das nicht für Mehrbenutzersysteme geeignet ist. Es lässt sich in Fällen einsetzen, in denen die benötigte Rechenzeit für einzelne Aufgaben aus Erfahrungswerten gut vorhergesagt werden kann. Ein Nachteil ist, dass große Prozesse u. U. niemals die CPU zugeteilt bekommen, wenn sich immer kürzere Jobs vordrängeln. Können Prozesse unterbrochen werden, das heißt ein Prozesswechsel wird durchgeführt, wenn ein neu ankommender Prozess eine kürzere Ausführungszeit aufweist, als die verbleibende Ausführungszeit des aktuellen Prozesses, so spricht man von Shortest-Remaining-Time (SRT) oder Shortest-Remaining-Processing-Time (SRPT).

Ausführung (gleiche Angaben wie Beispiel davor):

0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
A | A | A | A | C | C | D | B | B | B

## Earliest Due Date (EDD)
Bei dieser Strategie werden diejenigen Prozesse zuerst ausgeführt, welche die geringste Deadline haben. Voraussetzung dafür sind statische Deadlines und gleichzeitiges Eintreffen voneinander unabhängiger Tasks. Dieses nichtunterbrechende Verfahren ist ideal, um die maximale Verspätung zu minimieren. Wenn Prozesse unterbrochen werden können spricht man von einer Terminabhängigen Ablaufplanung, Planen nach Fristen oder Earliest Deadline First (EDF). Diese Strategie kommt hauptsächlich in Echtzeitsystemen vor, da es damit möglich ist, eine definierte Antwortzeit für bestimmte Prozesse zu garantieren.

## Round Robin, Zeitscheibenverfahren
Einem Prozess wird die CPU für eine bestimmte (kurze) Zeitspanne zugeteilt. Danach wird der Prozess wieder hinten in die Warteschlange eingereiht. Sind die einzelnen Zeitspannen unterschiedlich groß, so spricht man von Weighted Round Robin (WRR).

Round-Robin behandelt alle Prozesse gleich, so dass einerseits kein Prozess unfair behandelt wird oder gar verhungert, es aber andererseits auch nicht möglich ist, Prozesse mit höherer Dringlichkeit bevorzugt abzuarbeiten. Der Durchsatz dieses Scheduling-Verfahrens ist im Allgemeinen weder besonders niedrig noch besonders hoch. Die Verwendung von Zeitschlitzen fester Länge macht Round-Robin unflexibel und führt dazu, dass Ressourcen häufig ungenutzt bleiben.

Beispiel mit präemptivem Scheduling:

&nbsp; | Startzeit | Dauer
:-:|:-:|:-:
Job A | 0 | 4
Job B | 0 | 3
Job C | 0 | 2
Job D | 3 | 1

Ausführung:

0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
A | B | C | A | B | C | D | A | B | A 

## Lotterie-Scheduling
Hierbei handelt es sich um ein Wahrscheinlichkeits-Scheduling-Verfahren. Prozesse bekommen alle eine bestimmte Anzahl von Losen zugewiesen und der Prozess-Scheduler zieht ein Zufallslos, um den nächsten Prozess auszuwählen. Die Aufteilung der Lose muss nicht gleich sein. Wenn man einem Prozess mehr Lose zuweist, erhöht das seine relativen Chancen, ausgewählt zu werden. Diese Technik kann man benutzen, um sich anderen Scheduling-Verfahren, wie zum Beispiel dem Shortest-Job-Next-Verfahren und dem Fair-Share-Scheduling, anzunähern.
Lotterie-Scheduling löst das Problem des Verhungerns. Wenn man jedem Prozess mindestens ein Los gibt, garantiert dies, dass es eine Wahrscheinlichkeit von über 0 % gibt, dass dieser Prozess bei der jeweils nächsten Scheduling-Operation ausgewählt wird.

# Prioritätsscheduling
Bei diesen Strategien wird jedem Prozess eine Priorität zugeordnet. Die Abarbeitung erfolgt dann in der Reihenfolge der Prioritäten.

* **Rate Monotonic Scheduling** (RMS): Die Priorität wird aus der Periodenlänge berechnet (Prozesse mit kürzeren Perioden haben höhere Priorität).
* **Deadline Monotonic Scheduling** (DMS): Die Priorität wird aus der relativen Deadline berechnet (Prozesse mit größeren Deadlines haben höhere Priorität.
* Man kann auch mehreren Prozessen die gleiche Priorität geben, sie werden dann in Eingangsreihenfolge ausgeführt, oder mit einem untergeordneten Zeitscheibenverfahren innerhalb der gleichen Priorität abgewechselt (zum Beispiel Multilevel Feedback Queue Scheduling oder Shortest-Elapsed-Time (SET) )
* Die Prioritäten können auch dynamisch sein, wobei sich die Priorität eines Prozesses mit der Zeit erhöht, damit auch niedrig priorisierte Prozesse irgendwann bearbeitet werden und nicht ständig von höher priorisierten Prozessen verdrängt werden.

## Prioritätsinversion
An einer Prioritätsinversion sind mehrere Prozesse mit unterschiedlicher Priorität und eine Ressource beteiligt. Die Ressource wird hierbei mit wechselseitigem Ausschluss exklusiv belegt (etwa einem Semaphor).

Ein Prozess mit hoher Priorität will auf eine Ressource zugreifen, kann dies aber nicht, da die Ressource bereits von einem niedriger priorisierten Prozess belegt ist. Der hoch priorisierte Prozess muss warten, bis der andere Prozess die Ressource wieder freigibt. Dadurch sind die Prozess-Prioritäten in einer ersten Form der Prioritätsinversion vertauscht.

Existiert nun ein Prozess mit mittlerer Priorität, der die fragliche Ressource nicht verwendet, kann dieser mittel priorisierte Prozess den niedrig priorisierten verdrängen, d.h. der mittel priorisierte Prozess wird anstelle des niedrig priorisierten Prozesses ausgeführt. Der niedrig priorisierte Prozess kann die Ressource nun nicht mehr freigeben, so dass der hoch priorisierte Prozess nicht zur Ausführung kommt. Damit hindert der mittel priorisierte Prozess indirekt auch den hoch priorisierten Prozess an der Ausführung, was er nach dem Prinzip des Prioritäts-Schedulings nicht darf. Die Priorität des hoch priorisierten Prozesses und des mittel priorisierten Prozesses sind somit in einer zweiten Form der Prioritätsinversion vertauscht.

## Aushungern
Zur Aushungerung von Prozssen (engl. Starvation) kommt es, wenn niederpriore Prozesse nie zur Ausführung kommen, da immer höher priore Prozesse an die Reihe kommen. Ein Mittel zur Vermeidung von Aushungerung ist das *Priority Aging*. Dabei wird die Priorität eines Prozess während der Laufzeit erhöht, wenn er nicht zur Ausführung kommt. Irgendwann ist diese dynamische Priorität höher als die der anderen Prozesse und der Prozess kommt zur Ausführung. *Priority Aging* ist auch eine mögliche Lösung zur Prioritätsinversion.
