title:micro:bit Rust
toc: False
next: rust.md
parent: uebersicht.md

# Kurzbeschreibung
Mithilfe des [BBC micro:bit](https://microbit.org/) soll die Programmiersprache [Rust](https://www.rust-lang.org/) ausprobiert werden. Statt der Dokumentation soll ein Tutorial zur Inbetriebnahme entstehen.

# Stufe 1
* Entwicklungsumgebung in Betrieb nehmen und erstes Beispiel zum Laufen bringen mittels [microbit Crate](https://github.com/nrf-rs/microbit).

# Stufe 2
Das Tutorial soll um folgende Beispiele erweitert werden:

* Tasteneingabe
* Ausgabe über LEDs
* Temperatursensor

# Stufe 3
* Ein einfacher Timer soll implementiert werden
* Der Timer startet nach Tastendruck und läuft für 99 Sekunden
* Wenn die verbleibende Zeit > 9 Sekunden ist, wird am Display die Zehnerstelle dargestellt
* Bei <= 9 Sekunden wird die Einerstelle angezeigt