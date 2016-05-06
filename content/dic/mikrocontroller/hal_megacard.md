title: Hardwareabstraktion für die Megacard
parent: uebersicht.md

# Allgemeines

* Download des [Megacard Templates]({filename}embedded_template_hal.compress){: class="download" }

Die Verwendung der Hardwareabstraktion (kurz *HAL* für engl. *Hardware Abstraction Layer*) wird im folgenden erläutert.

Folgende Hardwareeinheiten werden von der HAL angesteuert:

* LEDs (Port C)
* Taster S0-S3 (Port A0..3)
* Lautsprecher (Port A4)
* Timer0 für 800 Mikrosekunden Basis
* Timer1 für Soundausgabe
* LCD (Port A und Port B)

Die globale Interruptfreigabe wird durch bei der Initialisierung gesetzt (mittels `sei()`).

# Ansteuerung der LEDs

Zur Ansteuerung der LEDs gibt es zwei Funktionen.

## Einzelne LED steuern

    #!c
    void hal_led_set(uint8_t index, uint8_t value);

* `index` wählt die gewünschte LED aus (zwischen `0` und `7`)
* Ist `index` größer 7 wird der Zustand der LEDs nicht verändert
* `value` schaltet bei dem Wert `0` die LED aus, bei jedem anderen Wert ein

## Alle LEDs steuern

    #!c
    void hal_leds_set(uint8_t value);

* Der 8 Bit Wert `value` gibt das Muster vor, mit dem die LEDs leuchten sollen (z.B. 0xFF für alle ein)

# Auswerten der Tasten
Die Tasten *S0* bis *S3* werden durch die Hardwareabstraktion automatisch entprellt.

    #!c
    uint8_t hal_key_get();

* Diese Funktion gibt `0` zurück, wenn keine Taste gedrückt wurde
* Der Rückgabewert ungleich `0` beschreibt die Taste, die gedrückt (genauer losgelassen) wurde
* Wurden mehrere Tasten gleichzeitig losgelassen, wird beim ersten Aufruf die niedrigste Nummer zurückgeben, danach die nächsthöhere usw.

# Ausgabe von Tönen

Zur Ausgabe von Tönen wird innerhalb der HAL der Timer 1 verwendet.

    #!c
    void hal_sound_play(uint16_t frequency);

* Die Frequenz wird über `frequency` in Hertz angegeben
* Um die Ausgabe abzuschalten wird als Argument für `frequency` `0` verwendet

!!! panel-warning "Tonausgabe und Ansteuerung des LC Displays ist nicht gemeinsam möglich"
    Es ist leider nicht möglich diese beiden Komponenten gleichzeitig zu verwenden, da sie einen gemeinsamen Pin des
    Mikrocontrollers benutzen.

# Timerabstraktion
## Allgemeines
Ein großer Teil an Funktionen innerhalb einer Anwendung sind durch Zeiten definiert. Da die Anzahl an hardwarebasierten
Timern begrenzt ist müssen Timer mehrfachverwendet werden. Innerhalb der Hardwareabstraktion wird ein Timer verwendet,
um für die Applikation beliebig viele abstrahierte Timervariablen zur Verfügung zu stellen.

Alle verwendeten Timervariablen werden in einem Array über Zeiger registriert. Die Timervariablen werden durch die
Applikation auf eine gewünschte *Zeit* gesetzt (in Mikrosekunden). Die Hardwareabstraktion zählt diese Timervariablen
entsprechend der vergangen Zeit herunter, bis sie schlussendlich auf `0` angekommen sind.

## Verwendung
Die Applikation kann die Timervariable auswerten, um zu uberprüfen, ob die gewünschte Zeit bereits vergangen ist. Ist
der Wert ungleich `0` ist die Zeit noch nicht vergangen.

Es gibt drei Makros, um das Setzen der Variable auf die gewünschte Zeitdauer lesbarer zu machen:

* `TIMER_MSEC(val)` multipliziert den Wert mit Tausend (entspricht dann Millisekunden)
* `TIMER_SEC(val)` multipliziert den Wert mit einer Million (entspricht dann Sekunden)
* `TIMER_MINUTE(val)` multipliziert den Wert mit einer sechzig Million (entspricht dann Minuten)

Das folgende Beispiel zeigt die Verwendung:

    #!c
    #include "hal.h"
    timer_var_t timer_app=TIMER_SEC(3);

    void app_process(void) {
      if (timer_app) {
        return; // Zeit ist noch nicht abgelaufen
      }
      // ...
    }

Wird ein Timer nicht verwendet, gibt es den speziellen Wert `TIMER_DISABLED` (entspricht dem Wert `-1`). Damit wird
signalisiert, dass die Timervariable im Moment nicht genutzt wird.

## Registrierung
Um die Timer in der Applikation zu registrieren wird das Makro `TIMERS` verwenden. Es ist im Template bereits in der
Datei `main.c` vorbereitet.

Angenommen es gibt zwei Timer: `timer_led` und `timer_off`. Dann werden diese wie folgt registriert:

    #!c
    TIMERS(&timer_led, &timer_off);

# LC Display
## Löschen der Anzeige
Beim Löschen der Anzeige werden alle Zeichen des 8x2 Displays gelöscht (genauer gesagt wird überall ein Leerzeichen
ausgegeben).

    #!c
    void hal_lcd_clear(void);

## Ausgabe eines Textes

    #!c
    void hal_lcd_printf(uint8_t line, uint8_t pos, char *fmt, ...);

* `line` gibt die gewünschte Zeile an (0 oder 1)
* `pos` gibt die gewünschte Position an (zwischen 0 oder 7)
* Sind `line` oder `pos` außerhalb des Bereichs wird am Displayinhalt nicht verändert
* `fmt` und falls erforderlich die nachfolgenden Argumente entsprechen der Verwendung von `printf`

Folgende Platzhalter sind definiert:

* `%d` gibt einen (16Bit) Integer mit Vorzeichen als Dezimalzahl aus
* `%u` gibt einen (16Bit) Integer ohne Vorzeichen als Dezimalzahl aus
* `%x` und `%X` geben einen (16Bit) Integer als Hexadezimalzahl aus (`%x` gibt Buchstaben als Kleinbuchstaben aus)
* `%c` gibt ein einzelnes Zeichen aus
* `%s` gibt einen String aus
* `%%` gibt das Prozentzeichen aus

Es kann auch eine fixe Breite definiert werden, so werden bei `%4d` vier Stellen reserviert. Ist die auszugebende Zahl
von der Breite her kleiner werden links Leerzeichen eingefügt. Um `0` einzufügen wird eine `0` beim Platzhalter
eingefügt: `%04d`.

## Beispiele

    #!c
    hal_lcd_printf(0, 0, "Test"); // gibt "Test" aus
    hal_lcd_printf(0, 0, "%d", -117); // gibt "-117" aus
    hal_lcd_printf(0, 0, "%3dX%3d", 2, 17); // gibt "  2X 17" aus

Die Ausgabe von Floatzahlen wird nicht direkt unterstützt, es kann aber emuliert werden:

    #!c
    float temperature=27.82;
    hal_lcd_printf(0, 0, "%d.%02d", (int16_t)temperature, (int16_t)((temperature*100)%100)); // gibt "27.82" aus

Alternativ kann in solchen Fällen auch ganz auf Float verzichtet werden, indem man einfach mit Integer in entsprechender
Dezimaldarstellung rechnet. In diesem Beispiel wird statt in Grad Celsius in 1/100 Grad Celsius gerechnet

    #!c
    int16 temperature=2782; // entspricht 27.82 Grad Celsius
    hal_lcd_printf(0, 0, "%d.%02d", temperature/100, temperature%100); // gibt "27.82" aus

