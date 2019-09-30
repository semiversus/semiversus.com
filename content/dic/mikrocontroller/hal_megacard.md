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

Die globale Interruptfreigabe wird durch bei der Initialisierung gesetzt (mittels <code>sei()</code>).

# Ansteuerung der LEDs

Zur Ansteuerung der LEDs gibt es zwei Funktionen.

## Einzelne LED steuern

    #!c
    void hal_led_set(uint8_t index, uint8_t value);

* <code>index</code> wählt die gewünschte LED aus (zwischen <code>0</code> und <code>7</code>)
* Ist <code>index</code> größer 7 wird der Zustand der LEDs nicht verändert
* <code>value</code> schaltet bei dem Wert <code>0</code> die LED aus, bei jedem anderen Wert ein

## Alle LEDs steuern

    #!c
    void hal_leds_set(uint8_t value);

* Der 8 Bit Wert <code>value</code> gibt das Muster vor, mit dem die LEDs leuchten sollen (z.B. 0xFF für alle ein)

# Auswerten der Tasten
Die Tasten *S0* bis *S3* werden durch die Hardwareabstraktion automatisch entprellt.

    #!c
    uint8_t hal_key_get();

* Diese Funktion gibt <code>0</code> zurück, wenn keine Taste gedrückt wurde
* Der Rückgabewert ungleich <code>0</code> beschreibt die Taste, die gedrückt (genauer losgelassen) wurde
* Wurden mehrere Tasten gleichzeitig losgelassen, wird beim ersten Aufruf die niedrigste Nummer zurückgeben, danach die nächsthöhere usw.

# Ausgabe von Tönen

Zur Ausgabe von Tönen wird innerhalb der HAL der Timer 1 verwendet.

    #!c
    void hal_sound_play(uint16_t frequency);

* Die Frequenz wird über <code>frequency</code> in Hertz angegeben
* Um die Ausgabe abzuschalten wird als Argument für <code>frequency</code> <code>0</code> verwendet

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
entsprechend der vergangen Zeit herunter, bis sie schlussendlich auf <code>0</code> angekommen sind.

## Verwendung
Die Applikation kann die Timervariable auswerten, um zu uberprüfen, ob die gewünschte Zeit bereits vergangen ist. Ist
der Wert ungleich <code>0</code> ist die Zeit noch nicht vergangen.

Es gibt drei Makros, um das Setzen der Variable auf die gewünschte Zeitdauer lesbarer zu machen:

* <code>TIMER_MSEC(val)</code> multipliziert den Wert mit Tausend (entspricht dann Millisekunden)
* <code>TIMER_SEC(val)</code> multipliziert den Wert mit einer Million (entspricht dann Sekunden)
* <code>TIMER_MINUTE(val)</code> multipliziert den Wert mit einer sechzig Million (entspricht dann Minuten)

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

Wird ein Timer nicht verwendet, gibt es den speziellen Wert <code>TIMER_DISABLED</code> (entspricht dem Wert <code>-1</code>). Damit wird
signalisiert, dass die Timervariable im Moment nicht genutzt wird.

## Registrierung
Um die Timer in der Applikation zu registrieren wird das Makro <code>TIMERS</code> verwenden. Es ist im Template bereits in der
Datei <code>main.c</code> vorbereitet.

Angenommen es gibt zwei Timer: <code>timer_led</code> und <code>timer_off</code>. Dann werden diese wie folgt registriert:

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

* <code>line</code> gibt die gewünschte Zeile an (0 oder 1)
* <code>pos</code> gibt die gewünschte Position an (zwischen 0 oder 7)
* Sind <code>line</code> oder <code>pos</code> außerhalb des Bereichs wird am Displayinhalt nicht verändert
* <code>fmt</code> und falls erforderlich die nachfolgenden Argumente entsprechen der Verwendung von <code>printf</code>

Folgende Platzhalter sind definiert:

* <code>%d</code> gibt einen (16Bit) Integer mit Vorzeichen als Dezimalzahl aus
* <code>%u</code> gibt einen (16Bit) Integer ohne Vorzeichen als Dezimalzahl aus
* <code>%x</code> und <code>%X</code> geben einen (16Bit) Integer als Hexadezimalzahl aus (<code>%x</code> gibt Buchstaben als Kleinbuchstaben aus)
* <code>%c</code> gibt ein einzelnes Zeichen aus
* <code>%s</code> gibt einen String aus
* <code>%%</code> gibt das Prozentzeichen aus

Es kann auch eine fixe Breite definiert werden, so werden bei <code>%4d</code> vier Stellen reserviert. Ist die auszugebende Zahl
von der Breite her kleiner werden links Leerzeichen eingefügt. Um <code>0</code> einzufügen wird eine <code>0</code> beim Platzhalter
eingefügt: <code>%04d</code>.

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

