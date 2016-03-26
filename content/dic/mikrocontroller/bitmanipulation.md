title: Bitmanipulation mit C
parent: uebersicht.md

# Allgemeines

!!! panel-info "Übungsblatt"
    Zu diesem Teil gibt es ein [Übungsblatt]({filename}uebung_bitmanipulation.pdf){: class="download" }

Um bitweise Verknüpfungen zu machen gibt es unter C im wesentlichen vier Operatoren: `&` (für bitweises *AND*), `|` (für bitweises *OR*), `^` (für bitweises *XOR*) und `~` (für bitweise *NOT*). Die ersten drei Operatoren benötigen immer zwei Operanden, z.B. `var_a = var_a & var_b;`. Die bitweise Invertierung kann nur auf einen Operanden angewendet werden, z.B. `vara = ~varb;`.

Für Zuweisungen gibt es eine Kurzschreibweise, die den Operator vor das Gleichheitszeichen setzt. So bedeutet `var_a &= 0x03;` das gleiche wie `var_a = var_a & 0x03;`.

C versteht Zahlen in dezimaler Schreibweise (z.B. `1203`) und hexadezimaler Schreibweise (z.B. `0xB2F`). Die Oktale Schreibweise (zur Basis 8) wird sehr selten benutzt (durch führende Null gekennzeichnet z.B. `0433`). Die binäre Schreibweise wird nur von bestimmten Compilern unterstützt, z.B. `0b01010011`.

# Bits auf 1 setzen
Mittels ver*ODER*ung:

* `A OR 0=A` (Neutralitätsgesetz)
* `A OR 1=1` (Extremalgesetz)

## Beispiel
Im Register PORTB sollen die unteren zwei Bits auf eins gesetzt werden, die anderen sollen ihren Zustand behalten:

    #!c
    PORTB |= 0x03; // 0x03->0b00000011

# Bits auf 0 setzen
Mittels ver*UND*ung:

* `A AND 0=0` (Extremalgesetz)
* `A AND 1=A` (Neutralistätsgesetz)

Das Bitmuster, welches vorgibt, welche Bits auf 0 gesetzt werden und welche auf ihrem ursprünglichen Wert bleiben wird auch *Maske* genannt. Diese Maskierung wird sehr oft bei Abfragen verwendet, weil man nur den Zustand bestimmter Bits kennen möchte.

## Beispiel 1
Im Register PORTC soll das Bit 5 auf 0 gesetzet werden, die anderen sollen ihren Zustand behalten:

    #!c
    PORTC &= 0xDF; // 0xDF->0b11011111

Hilfreich bzw. übersichtlicher ist auch manchmal die Invertierung der Maske.

    #!c
    PORTC &= ~0x20; // 0x20->0b00100000

Weiters kann der Schiebeoperator genutzt werden, um eine 1 auf die richtige Position zu schieben. Der Wert `0x20` lässt sich damit so darstellen: `1<<5` (1 um 5 stellen nach links geschoben, also auf Position von Bit 5).

    #!c
    PORTC&=~(1<<5);

## Beispiel 2
Eine Anweisung soll nur ausführt werden, wenn Bit 1 im Register `PINA` auf 1 ist. Bei if wird immer der True Zweig ausgeführt wenn die Bedingung ungleich 0 ist.

    #!c
    if (PINA&0x02) { // 0x02->0b00000010
      // Answeisung
    }

# Bits invertieren
Mittels ver*XOR*ung:

* `A XOR 0=A` (Neutralitätsgesetz)
* `A XOR 1=NOT A`

## Beispiel
Die unteren 4 Bits von PORTA sollen invertiert werden, die anderen Bits sollen ihren Zustand behalten

    #!c
    PORTA^=0x0F; // 0x0F->0b00001111
