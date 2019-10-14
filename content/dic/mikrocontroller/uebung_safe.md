title: Übung Safe
parent: uebersicht.md

# Übungsaufgabe

!!! panel-info "In dieser Übung wird die Megacard verwendet"

In diesem Beispiel soll ein Tresor (engl. *Safe*) implementiert werden. Dazu werden die vier Tasten *S0*-*S3* genutzt,
um den Code einzutippen ( *S0* entspricht Ziffer '1', *S1* entspricht '2', usw.).

# Vorbereitung

* [Projektordner]({filename}embedded_uebung_safe.compress){: class="download" } herunterladen und entpacken
* Projekt <code>safe.avrgccproj</code> öffnen

# Spezifikation

* Der Code hat vier Stellen (mit den Ziffern 1 bis 4)
* Nach dem Reset ist der Code "1234"
* Zustand <code>CLOSED</code>:
    * Nach dem Reset befindet sich die Applikation im Zustand <code>CLOSED</code>
    * Das Display zeigt den Text "CLOSED" in der ersten Zeile, die zweite Zeile ist leer
* Wird einer der Taster *S0* bis *S3* gedrückt wird der entsprechende Tastendruck *gespeichert* und pro Ziffer ein <code>*</code> in der zweiten Zeile angezeigt
* Nach dem vierten Tastendruck wird der eingegebene Code ausgewertet
* Bei falscher Codeeingabe:
    * In der ersten Zeile wird "WRONG" und der zweiten Zeile "CODE" ausgegeben
    * Nach zwei Sekunden oder einem Tastendruck wird in den Zustand <code>CLOSED</code> gewechselt
* Bei richtiger Codeeingabe
    * In der ersten Zeile wird "OPENED" ausgegeben, die zweiten Zeile ist leer
    * Nach drei Sekunden wird in den Zustand <code>CLOSED</code> gewechselt
    * Wird innerhalb der drei Sekunden ein Taster gedrückt wird dies als erste Ziffer für den neuen Code verwendet und ein neuer Code kann eingegeben werden
* Eingabe eines neuen Codes:
    * In der ersten Zeile steht "NEW CODE", die zweite Zeile zeigt den bisher eingegebenen Code (z.B. "41")
    * Sind alle vier Ziffern eingegeben wechselt die Applikation nach zwei Sekunden in den Zustand <code>CLOSED</code>

# Hinweise zur Implementierung
## Speicherung des Codes
Der vierstellige Code kann auf verschiedene Arten gespeichert werden. Es bieten sich zwei Möglichkeiten an: Speicherung
im Array und Speicherung als Integer.

### Speicherung im Array
Es wird ein Array der Länge vier genutzt, um die einzelnen Ziffern zu speichern. Es werden zwei Arrays benötigt: eines
zur Speicherung des geforderten Codes und eines, das den Code während der Eingabe speichert. Der  und entsprechend mit
dem Standardcode initialisiert ("1234").

    #!c
    uint8_t code_stored[4]={1,2,3,4};
    uint8_t code_actual[4];

Tippt der Anwender den Code ein wird jede Ziffer an der entsprechenden Stelle im Array gespeichert:

    #!c
    code_actual[index]=key; // index gibt die aktuelle Codepostion an, key die zu speichernde Ziffer

Um den Code anschließend zu vergleichen:

    #!c
    if (code_actual[0]==code_stored[0] && code_actual[1]==code_stored[1] && code_actual[2]==code_stored[2] &&
        code_actual[3]==code_stored[3])
    {
      // Code ist richtig
    }
    else {
      // Code ist falsch
    }

!!! panel-warning "Beim Array Vergleich muss jeder Wert einzeln geprüft werden"
    Es funktioniert **nicht** einen Vergleich von <code>code_actual==code_stored</code> zu machen. Da <code>code_actual</code> und
    <code>code_stored</code> jeweils Arrays und damit Zeiger auf eine Speicherstelle sind werden auch nur diese Zeiger verglichen.
    Und diese werden immer auf unterschiedliche Positionen im Speicher zeigen!

### Speicherung als Integer
Der Code kann aber auch direkt als Integer gespeichert werden. Wieder sind zwei Variablen notwendig: eine zur Speicherung
des geforderten Codes und eine, die den Code während der Eingabe speichert.

    #!c
    uint16_t code_stored=1234;
    uint16_t code_actual;

Die größte zu darzustellende Zahl ist 4444, welche mit einem 16 Bit Integer dargestellt werden kann (%%2^{16}=65535%%).

Tippt der Anwender eine neue Ziffer ein wird die aktuelle Zahl mit 10 multipliziert und die eingetippte Ziffer
hinzuaddiert. Durch die Multiplikation mit 10 wird der bisher eingegebene Code um eine Dezimalstelle nach links geschoben.

    #!c
    code_actual=code_actual*10+key; // key beinhaltet die zu speichernde Ziffer

Die Überprüfung des Codes wird nun wesentlich einfacher:

    #!c
    if (code_actual==code_stored)
    {
      // Code ist richtig
    }
    else {
      // Code ist falsch
    }

## Ausgaben am LC Display
Eine LCD Ausgabe entweder je nach Zustand bei jedem <code>safe_process</code> gemacht werden oder bei einem Zustandswechsel.

Im folgenden Beispiel sieht man die Ausgabe des Zustands <code>WRONG_CODE</code>. Bei jedem <code>safe_process</code> wird über
<code>hal_lcd_printf</code> die Ausgabe "WRONG CODE" gemacht. Das Leerzeichen hinter "WRONG" ist beabsichtigt, da zuvor in dieser
Zeile "CLOSED" steht und dies um einen Buchstaben länger ist als "WRONG". Das Leerzeichen überschreibt somit den letzten
Buchstaben von "CLOSED".

Wenn eine Taste gedrückt wurde oder der Timer abgelaufen ist wird das Display mittels <code>hal_lcd_clear</code> gelöscht.

    #!c
    void safe_process(void) {
      uint8_t key=hal_key_get(); // handle keys (0 - no key is pressed, 1 to 4 - corresponding key was pressed)

      switch (safe_state) {
        // ... other cases
        case WRONG_CODE:
          hal_lcd_printf(0,0,"WRONG ");
          hal_lcd_printf(1,0,"CODE");
          if (key || timer_safe==0) {
            safe_state=CLOSED;
            hal_lcd_clear();
          }
          break;
      }


# Musterlösung
Ein Implementierung dieser Übung befindet sich hier zum Download:

* [Musterlösung]({filename}embedded_uebung_safe_loesung.compress){: class="download" }

