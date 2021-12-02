title: Reaktionsspiel
toc: False
next: keyboard.md
parent: uebersicht.md

# Kurzbeschreibung
Mittels Megacard wird ein Reaktionsspiel implementiert.

# Stufe 1
* Nach dem Reset wird für 10 Sekunden gewartet
* Nach dieser Wartezeit werden alle LEDs eingeschaltet
* Der Spieler, der zuerst auf seine Taste drückt, gewinnt
* Wenn ein Spieler vor Ablauf der 10 Sekunden drückt, verliert er und es gewinnt automatisch der andere
* Gewinnt Spieler 1, leuchtet LED 0 (alle anderen sind aus). Gewinnt Spieler 2, leuchtet LED 1.

# Stufe 2
Erweiterung von Stufe 1

* Beim Start des Spiels wird
  * eine kurze Animation mittels LEDs gezeigt (z.B. drei Mal blinken aller LEDs)
  * mittels Lautsprecher eine Tonfolge ausgegeben (tiefer Ton, hoher Ton)
* Die Wartezeit ist zufällig zwischen 3 und 30 Sekunden
* Wenn ein Spieler zu früh drückt wird eine abfallende Tonfolge ausgegeben (hoher Ton, tiefer Ton)
* Bei einem Druck nach der Wartezeit werden zwei hohe Töne ausgegeben
* Der Sieger wird für 5 Sekunden angezeigt, danach startet ein neues Spiel.

# Stufe 3
Erweiterung von Stufe 2

* Es können vier Spieler mitspielen.
* Drückt ein Spieler zu früh, werden die anderen drei als Gewinner gewertet
* Auf einem externen Display wird der jeweilige Punktestand angezeigt
