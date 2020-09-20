title: Einführung C Programmierung
parent: uebersicht.md

# Übersicht
Einen guten Übersicht über C Programmierung bietet das Open Book [C von A bis Z](http://openbook.rheinwerk-verlag.de/c_von_a_bis_z/) aus dem Verlag Galileo Computing und das Wikibook [C-Programmierung](https://de.wikibooks.org/wiki/C-Programmierung){: class="external" }.

Um die allgemeinen Beispiele leicht testen zu können, stehen Online Compiler zur Verfügung:

* [Sourcelair](https://www.sourcelair.com/home){: class="external" }
* [Codepad](http://codepad.org){: class="external" }
* [IDEOne](http://www.ideone.com){: class="external" }

Die Übungen mit der Megacard werden mittels AVR Studio 5 durchgeführt. Das Installationspaket kann über die [Atmel](http://www.atmel.com/Images/as5installer-full-5.0.1223.exe){: class="external" }-Homepage heruntergeladen werden.

# "Hello World" Beispiel

    #!c
    #include <stdio.h>

    int main() {
      printf("Hello World!");
      return 0;
    }

Jedes Programm benötigt eine Funktion mit dem Namen <code>main</code>. Diese Funktion gibt einen Wert zurück, der den Erfolg der Ausführung anzeigt. Der Wert 0 wird meist als erfolgreiche Ausführung interpretiert, andere Werte können Fehler oder vorzeitige Abbrüche darstellen.

Der Funktion <code>main</code> können vom Betriebssystem auch Parameter mitgegeben werden . Bei Microcontroller-Anwendungen ist dies üblicherweise nicht der Fall.

Die Funktion <code>printf</code> wird verwendet um Ausgaben auf die <code>Standardausgabe</code> zu machen. Die Standardausgabe ist abhängig von der Art des Programmes. Bei Kommandozeilenprogrammen wird die Ausgabe direkt auf der Kommandozeile angezeigt. Bei Microcontrollern ist dies Implementierungsabhängig. Hier kann die serielle Schnittstelle oder ein Display genutzt werden.

Um dieses Quellcode nun auszuführen bedarf es mehrerer Schritte, welche grob so zusammengefasst werden können:

1. **Präprozessor**: Anweisungen an den Präprozessor werden *Direktiven* genannt und haben ein '#' vorangstellt. Im obigen Beispiel wird mittels <code>#include <stdio.h></code> die Datei stdio.h in diese Datei hineinkopiert.
2. **Kompilierung**: Die Ausgabe des Präprozessors wird nun kompiliert, d.h. der C Quellcode wird in Maschinensprache übersetzt. Das Ergebnis wird Objektcode genannt.
3. **Linken**: Da jede C Quellcode-Datei einzeln in eine Objektcode-Datei umgewandelt wurde, wird nun durch das Linken eine ausführbare Datei erstellt, die die einzelnen Funktionen und Verweise der Objektcode-Dateien zu einer gemeinsamen Datei zusammenführt.
4. **Ausführen**: Beim Ausführen ruft das Betriebssystem oder der Startup-Code des Microcontrollers die Funktion <code>main</code> auf.

In der Literatur sieht man oft als Ergebnis der Kompilierung eine Assemblerdatei. Der Assembler setzt diese Assemblerdatei dann in Maschinencode um. Die meisten aktuellen Compiler machen diesen Zwischenschritt nur mehr indirekt.

# Präprozessor Direktiven
## <code>#include</code> Direktive
Mittels <code>#include</code> werden Dateien an der Stelle der <code>#include</code> Anweisung eingefügt. Die <code>#include</code> Anweisung ermöglicht das unter C übliche Modulkonzept, um Teile eines Programmes gekapselt in einem Modul zu verwalten. Ein Modul besteht dabei aus einer "<code>.c</code>" Datei (*Source*), die die Implementierung enthält und einer dazugehörigen "<code>.h</code>" Datei (*Header*), die die Funktionen und Variablen definiert, die das Modul exportiert, d.h. an andere Programmteile zur Verfügung stellt.

## <code>#define</code> Direktive
<code>#define</code> hat verschiedene Anwendungen. Es wird verwendet um *Symbole*, *Konstanten* und *Makros* zu definieren.

Die Unterscheidung, ob man auf eine Lösung mittels <code>#define</code> Direktive zurückgreift oder es mittels C Konstrukten außerhalb des Präprozessors löst, ist nicht einfach zu beantworten und erst mit der Erfahrung sieht man sinnvolle Einsatzmöglichkeiten.

### Symbol
Ein Symbol kann definiert werden um es für eine bedingte Kompilierung zu nutzen. Dazu werden die Direktiven <code>#ifdef</code>, <code>#ifndef</code>, <code>#else</code> und <code>#endif</code> verwendet.

    #!c
    #define DEBUG

    #ifdef DEBUG
      // Code der kompiliert wird, wenn DEBUG definiert wurde
    #else
      // Code der kompiliert wird, wenn DEBUG nicht definiert wurde
    #endif

### Konstante
Durch die Definition einer Konstante wird einem *Bezeichner* eine *Konstante* zugewiesen. Der Präprozessor ersetzt dann bei jedem Vorkommen des Bezeichners diesen durch die Konstante.

    #!c
    #define PI 3.1415
    #define MESSAGE "Hello World!"

    float angle=PI;
    printf(MESSAGE);

Konstanten können auch ohne Präprozessor mittels <code>const</code> erzeugt werden.

### Makro
Ein Makro ist eine Ersetzung mittels einer Funktion und deren Argumente.

    #!c
    #define MEAN (a,b) ( (a+b)/2 )
    printf("Der Durchschnitt von 5 und 11 ist %d.", MEAN(5,11) );

Das Makro <code>MEAN</code> ist unabhängig vom Datentyp, da es sich um eine reine Textersetzung handelt. Dieses Makro kann auch mit einer C Funktion implementiert werden. Der Unterschied ist das Laufzeitverhalten, da ein Funktionsaufruf zusätzlich Zeit benötigt. Trotzdem ist die Verwendung von Makros nur für Programmierer mit Praxiserfahrung empfehlenswert.

Ersetzung mittels C Funktion (mittels <code>int</code> Datentypen):

    #!c
    int mean(int a, int b) {
      return (a+b)/2;
    }

# Variablen
Um innerhalb eines Programmes mit Variablen arbeiten zu können, müssen diese *definiert* werden. Bei der Definition wird einem Bezeichner ein Datentyp zugewiesen.

## Ganzzahlen
Um Ganzzahlen (Zahlen ohne Nachkomma) zu definieren, gibt es in C folgende Datentypen:

* <code>char</code>: üblicherweise 1 Byte
* <code>short int</code> bzw. <code>short</code>: kleinerer Zahlenbereich als <code>int</code>
* <code>int</code>: meist 16 oder 32 Bit
* <code>long int</code> bzw. <code>long</code>: größerer Zahlenbereich als <code>int</code>

Eine Variable kann vorzeichenbehaftet sein oder vorzeichenlos sein. Um eine vorzeichenlose Variable zu definieren muss <code>unsigned</code> vorgestellt werden (z.B. <code>unsigned int</code>). Durch <code>signed</code> kann eine Variable explizit vorzeichenbehaftet definiert werden. Wenn eine Variable nicht explizit mittels <code>signed</code> oder <code>unsigned</code> ausgezeichnet wird, ist die Variable vorzeichenbehaftet.

Die Größe des Zahlenbereichs der einzelnen Datentypen ist Plattform- und Compilerabhängig. So kann ein <code>int</code> 16 Bit (0-65535) oder 32 Bit (0-4294967295) groß sein. Die tatsächliche Größe eines Typs ist in der Datei <code>limits.h</code> abgelegt.

Beispiele:

    #!c
    int c;
    // c ist ein (vorzeichenbehafteter) Integer

    unsigned long speed = 0;
    // speed ist ein vorzeichenloser long Integer und wird mit 0 initialisiert.

    char minimum, maximum = 10;
    // minimum und maximum sind Variablen vom Datentyp char.
    // maximum wird mit 10 initialisiert (minimum ist uninitialisiert).

### Plattformunabhängigkeit
Steht ein *C99* kompatibler C-Compiler zur Verfügung (gilt mittlerweile für den Großteil der Compiler) hilft die Verwendung der Datei <code>stdint.h</code>. Mittels <code>#include <stdint.h></code> werden neue Datentypen definiert, die eine bestimmte Größe haben.

Dadurch werden unter anderem folgende Datentypen zur Verfügung gestellt:

* <code>uint8_t</code>, <code>uint16_t</code>, <code>uint32_t</code> und <code>uint64_t</code>: Vorzeichenlose Datentypen mit 8, 16, 32 bzw. 64 Bit
* <code>int8_t</code>, <code>int16_t</code>, <code>int32_t</code> und <code>int64_t</code>: Vorzeichenbehaftete Datentypen mit 8, 16, 32 bzw. 64 Bit

## Fließkommazahlen
Fließkommazahlen sind Zahlen mit Nachkommastellen bzw. sehr große Zahlen. Intern wird die Mantisse und der Exponent getrennt gespeichert. C stellt dafür folgende zwei Datentypen zur Verfügung:

* <code>float</code>: Zahlen mit einfacher Genauigkeit (32Bit)
* <code>double</code>: Zahlen mit doppelter Genauigkeit (64Bit)

Fließkommazahlen sind immer vorzeichenbehaftet. Fließkommazahlen können auch die Sonderwerte *positiv unendlich*, *negativ unendlich* und *NaN* (*Not a Number*) annehmen.
