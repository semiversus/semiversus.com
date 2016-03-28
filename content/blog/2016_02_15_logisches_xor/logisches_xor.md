title: Wieso gibt es kein logisches XOR in C?
date: 2016-02-15
tags: Programmieren, C

In C gibt es vier bitweise Operatoren (Details dazu im [Skriptum]({filename}/dic/mikrocontroller/bitmanipulation.md)):

* *UND* Verknüpfung - `&`
* *ODER* Verknüpfung - `|`
* *Exklusiv ODER* Verküpfung - `^`
* *INVERTIERUNG* - `~`

Neben den bitweisen Operatoren gibt es noch die logische, die den bitweisen entsprechen:

* *UND* Verknüpfung - `&&`
* *ODER* Verknüpfung - `||`
* *INVERTIERUNG* - `!`

Hier fehlt offensichtlich die Exklusive *ODER* Verknüpfung - wieso gibt es kein `^^`?

Eine gute Antwort findet sich auf dieser [Seite](http://benpfaff.org/writings/clc/logical-xor.html){: class="external" }
von Ben Pfaff. Und hier eine kurze Zusammenfassung:

* Eine logische *Exklusiv ODER* Verknüpfung ist sehr selten.
* Die Kurzschlussauswertung wird nicht ermöglicht - Ist bei einer *UND* Verknüpfung der erste Term falsch muss der zweite nicht
mehr überprüft werden. Das gleiche gilt bei *ODER* mit dem ersten Term wahr. Bei *Exklusiv ODER* geht dies nicht.

## Und wenn ich es doch mal benötige?
Eine logische *Exklusiv ODER* Verknüpfung lässt sich wie folgt realisieren:

    #!c
    if (!a != !b) {
      ...
    }

Mittels logischer Invertierung `!` wird der entsprechende Term auf 0 (falsch) oder 1 (wahr) gebracht. Wenn diese logischen
Terme unterschiedlich sind ist die Gesamtaussage wahr.
