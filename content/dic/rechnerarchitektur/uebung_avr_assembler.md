title: Übung AVR Assembler
parent: uebersicht.md

# Allgemeines
Die Übungen sollten gut kommentiert werden. Ein Programm kann hinsichtlich Programmgröße oder Ausführungsgeschwindigkeit
optimiert werden. Als Hilfe eignet sich die [Kurzübersicht]({filename}avr_assembler_befehle.pdf){: class="download" }
der AVR Assembler Befehle.

# Daten vertauschen
Daten liegen im SRAM ab Adresse 0x60 bis zur Adresse 0x15F. Ziel des Assembler Programmes ist es, diesen Datenbereich zu
"drehen" -> Der Wert in Adresse 0x60 wird mit dem Wert in Adresse 0x15F vertauscht, anschließend der Wert in Adresse
0x61 mit dem Wert in Adresse 0x15E, usw. .

## Hinweise
* Nutze die Register X und Y zur indirekten Adressierung
* Funktioniert das Programm auch, wenn man das Ende des Datenbereiches (0x15F) nach hinten oder vorne verschiebt?
* Beachte den Fall, dass eine ungerade Anzahl von Bytes vertauscht werden!
* Wie groß ist das Programm und wie viel Taktzyklen werden für die Ausführung benötigt?

# Multiplikation aller Elemente eines Arrays
Im SRAM liegen ab Adresse 0x60 insgesamt 32 16-Bit Werte (auf 0x60 liegt das höherwertigere Byte). Diese sollen alle mit
5 mulitpliziert werden und an der ursprünglichen Stelle im SRAM wieder abgelegt werden.

## Hinweise
* Nutze das Y oder Z Register zur indirekten Adressierung (Anwendung von ldd)
* Für die Multiplikation <code>m=n*5</code> gilt <code>m=n*4+n</code>, wobei sich Multiplikationen mit dem Faktor zwei durch linksschieben lösen lassen
* Das Schieben und Addieren von 16 Bit Werten wird aufgeteit in zwei 8 Bit Operationen mit Berücksichtigung des Übertrags
* Wie groß ist das Programm und wie viel Taktzyklen werden für die Ausführung benötigt?

# Alarmanlage
An Port A sind drei Alarmsensoren angeschlossen (Bit 0 - 2). Wird ein Alarm ausgelöst, soll die entsprechende LED an
Port C (Bit 0 - 2, High-aktiv) aufleuchten, um den Sensor zu signalisieren. Der Alarm wird mittels einem Taster auf
Port A (Bit 3) zurückgesetzt. Der Taster sowie die Alarmsensoren benötigen einen aktivierten Pull-Up am Eingang und sind
aktiv (bzw. sollen den Alarm auslösen), wenn sie auf Massepotential sind (Low-aktiv).

## Hinweise
* Nutze eine Main-Loop um die Eingänge dauernd zu überprüfen
* Weise die Funktion im Simulator und auf der Megacard nach
* Wenn ein Sensor ausgelöst hat und später ein zweiter auslöst soll auch dieser angezeigt werden.
* Erweiterung 1: Der Alarm soll nur zurückgesetzt werden können, wenn kein Alarmsensor mehr aktiv ist
* Erweiterung 2: An Port C (Bit 3) wird ein Relais angesteuert (High-aktiv), um einen Alarmsirene anzusteuern. Wird einmal Alarm ausgelöst, soll dieses Relais anziehen. Beim Deaktivieren des Alarms soll es wieder abfallen.

# Expertenaufgabe: Fibonacci
Erstelle eine Subroutine, die rekursiv die n-te Fibonacci Zahl berechnet. Dabei gilt:

* fib(0)=1
* fib(1)=1
* fib(n)=fib(n-1)+fib(n-2)

## Hinweise
* Nutze den Stack um die Parameter und Ergebnisse zu übertragen
* Nutze das Register Y als Kopie des Stackpointers, um auf Daten relativ zum Stackpointer zuzugreifen (sog. Stackframe-Pointer)
* Mittels Displacment Adressierung kannst du nun auf die Parameter, die am Stack liegen zugreifen

# Analyse 1
    .include "m16def.inc"

      clr R16
    loop:
      out PORTB, R16
      inc R16
      mov R17, R16
      andi R17, 0x0F
      cpi R17, 0x0A
      brlo loop
      ldi R17, 0x06
      add R16, R17
      cpi R16, 0xA0
      brlo loop
    end:
      rjmp end

Was macht das Programm, wieviele Takte benötigt es für die Ausführung (bis zum Label <code>end</code>) und wie groß ist das Programm?

## Hinweise
* Das Programm nutzt die BCD (Binary Coded Decimals) Darstellung einer Zahl
* Bei der Laufzeitanalyse ist wichtig, die genau Anzahl der Schleifendurchläufe zu kennen
* Beachte, dass die *branch*-Befehle je nach Erfüllung der Bedingung unterschiedlich viele Taktzyklen benötigt

# Analyse 2
    .include "m16def.inc"

      clr XH
      ldi XL, 0x60
      clr R17
      ldi R18, 8
    loop:
      cpi R18, 0
      breq end
      dec R18
      ld R16, X+
      cp R16, R17
      brlo loop
      mov R17, R16
      rjmp loop
    end:
      rjmp end

Der Speicherinhalt vor der Ausführung des Programmes:

0x5F | 0x60 | 0x61 | 0x62 | 0x63 | 0x64 | 0x65 | 0x66 | 0x67 | 0x68 | 0x69
-|-|-|-|-|-|-|-|-|-|-
0x00 | 0x03 | 0x01 | 0x0e | 0x03 | 0x05 | 0x16 | 0x00 | 0x05 | 0x15 | 0x20

Wie groß ist das Programm und wie viel Taktzyklen benötigt es? Wie schaut der Speicher nach der Durchführung aus?
Was machen die Register R16, R17 und R18? Versuche in einem Satz zu formulieren, was das Programm macht.

# Analyse 3
    .include "m16def.inc"

      clr XH
      ldi XL, 0x60
      clr R17
    start:
      ld R16, X+
      cpi R16, 0x00
      breq end
      cpi R16, 0x61
      breq vowelcount
      cpi R16, 0x65
      breq vowelcount
      cpi R16, 0x69
      breq vowelcount
      cpi R16, 0x6F
      breq vowelcount
      cpi R16, 0x75
      brne start
    vowelcount:
      inc R17
      rjmp start
    end:
      rjmp end

Der Speicherinhalt vor der Ausführung des Programmes:

0x5F | 0x60 | 0x61 | 0x62 | 0x63 | 0x64 | 0x65 | 0x66 | 0x67 | 0x68
-|-|-|-|-|-|-|-|-|-
0x00 | 0x70 | 0x6C | 0x61 | 0x74 | 0x65 | 0x61 | 0x75 | 0x00 | 0xAA

Wie groß ist das Programm und wie viel Taktzyklen benötigt es? Wie schaut der Speicher nach der Durchführung aus?
Beschreibe in einem Satz die Funktion. Welchen Wert hat nach der Ausführung das Register R16, R17 und X?

## Hinweis
Das Programm nutzt die [ASCII Darstellung](https://de.wikipedia.org/wiki/Ascii#ASCII-Tabelle){: class="external" } von Zeichen.
