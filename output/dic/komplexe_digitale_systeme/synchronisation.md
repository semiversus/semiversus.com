title: Synchronisation
parent: uebersicht.md

# Allgemeines
Unter *Prozesssynchronisation* (oder kurz Synchronisation) versteht man die Koordinierung des zeitlichen Ablaufs mehrerer nebenläufiger Prozesse.

Der Zweck der Koordinierung ist zumeist einer der folgenden:

* Gemeinsamer Zugriff auf Daten. Dabei muss verhindert werden, dass durch gleichzeitigen Zugriff Inkonsistenzen in den Daten entstehen. Dies wird durch Mutex-Verfahren zum gegenseitigen Ausschluss realisiert.
* Gemeinsame Nutzung beschränkter Betriebsmittel wie zum Beispiel von Peripheriegeräten. Hierbei können ebenfalls Mutex-Verfahren eingesetzt werden, häufig werden aber komplexere Methoden des Schedulings benötigt.
* Übergabe von Daten bzw. Nachrichten von einem Prozess an einen Anderen, also Interprozesskommunikation.
* Steuerung von Unterprozessen durch Signale, insbesondere das Abbrechen von Prozessen oder das Warten darauf, dass sie terminieren.

# Semaphor
Ein Semaphor ist eine Datenstruktur, die aus einer Ganzzahl und den Nutzungsoperationen „Reservieren/Probieren“ und „Freigeben“ besteht. Sie eignet sich insbesondere zur Verwaltung beschränkter (zählbarer) Ressourcen, auf die mehrere Prozesse zugreifen sollen, wie etwa Erzeuger und Verbraucher.

Meist wird die Ganzzahl (Zähler) beim Start des Semaphors mit dem Zahlenwert der maximal verfügbaren Ressourcen initialisiert bzw. der maximalen Zahl der Prozesse, die gleichzeitig die Ressource nutzen können. Ein Prozess, der auf die Ressource zugreifen will, muss vorher die Operation „Reservieren/Probieren“ aufrufen, und danach, wenn er die Ressource nicht mehr benötigt, die Operation „Freigeben“. Bei jeder Reservierung wird der Zähler um 1 heruntergezählt, bei Freigabe wird er wieder um 1 erhöht. Der Zähler darf nicht unter 0 fallen: Wenn eine Reservierung bei Zählerstand 0 erfolgt, wartet der reservierende Prozess, bis ein anderer Prozess Ressourcen freigegeben hat. Es gibt auch Implementierungen, die ins Negative zählen, „wie viele Interessenten aktuell warten“.

## Kritischer Abschnitt
Mit Hilfe von Semaphoren lassen sich auch kritische Abschnitte realisieren. Darunter wird ein Abschnitt eines Programms bezeichnet, in dem Ressourcen (z.B. Datenstrukturen, Verbindungen, Geräte usw.) verändert werden und der nicht parallel oder zeitlich verzahnt zu Programmabschnitten anderer Prozesse/Threads ausgeführt werden darf, in denen die gleichen Ressourcen ebenfalls verändert werden. Andernfalls kommt es zu inkonsistenten Zuständen der Betriebsmittel.

Das folgende Beispiel zeigt die Inkrementierung einer Variable <code>s</code> durch zwei Prozesse. Dazu wird eine Kopie von <code>s</code> in ein Register geladen, um eins erhöht und wieder zurückgeschrieben. Im linken Teil wird der erste Prozess unterbrochen und der zweite Prozess kommt zur Ausführung. Die Variable ist nun nicht auf 2 sondern auf 1. Im rechten Teil sind die kritischen Abschnitte atomar ausgeführt (sprich nicht unterbrechbar).

<figure><img src="{filename}kritischer_abschnitt.svg"><figcaption>Kritischer Abschnitt (Bild: <a href="https://commons.wikimedia.org/wiki/File:Kritischer_abschnitt.svg">miracula_de</a> CC0 1.0)</figcaption></figure>

## Deadlock
Deadlock oder Verklemmung bezeichnet einen Zustand, bei dem ein oder mehrere Prozesse auf Betriebsmittel warten, die dem Prozess selbst oder einem anderen beteiligten Prozess zugeteilt sind.

Der Zustand eines Deadlocks kann folgendermaßen definiert werden: Eine Menge von Prozessen befindet sich in einem Deadlock, wenn jeder dieser Prozesse auf ein Ereignis wartet, das nur ein anderer Prozess aus dieser Menge verursachen kann.

Es müssen vier Kriterien erfüllt werden, damit es in einem System zu einem Deadlock kommen kann:

1. Die Betriebsmittel werden ausschließlich durch die Prozesse freigegeben (Da Ressourcenzugriff eines Prozesses nicht unterbrochen werden kann. No Preemption).
2. Die Prozesse fordern Betriebsmittel an, behalten aber zugleich den Zugriff auf andere (Hold and Wait).
3. Der Zugriff auf die Betriebsmittel ist exklusiv (Mutual Exclusion).
4. Mindestens zwei Prozesse besitzen bezüglich der Betriebsmittel eine zirkuläre Abhängigkeit (Circular Wait).

Bekannt und beschrieben wird dieses Problem auch als [Philosophenproblem](https://de.wikipedia.org/wiki/Philosophenproblem){: class="external" }.
