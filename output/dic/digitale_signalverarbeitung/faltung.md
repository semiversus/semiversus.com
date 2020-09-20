title: Faltung
parent: uebersicht.md

# Allgemeines

Um die Antwort eines LTI Systems auf eine beliebige Eingangsfolge zu bekommen nutzt man die Eigenschaften der Linearität
und der Zeitinvarianz. Da sich jedes Eingangssignal %%x[t]%% als Linearkombination von Einheitspulsen darstellen lässt,
kann für das Ausgangssignal eine Linearkombination der entsprechenden Impulsantworten verwendet werden.

# Berechnung
Ein beliebiges Eingangssignal %%x[n]%% lässt sich wie folgt darstellen:

%%x[n]=\ldots + x[-1]\cdot\delta[n+1] + x[0]\cdot\delta[n] + x[1]\cdot\delta[n-1] + \ldots=\sum\limits_{k=-\infty}^{\infty} x[k]\cdot \delta[n-k]%%

Durch die Impulsantwort wird vollständig festgelegt, wie die Reaktion eines LTI Systems auf ein beliebiges Eingangssignal
ist.

Die Gleichung zur Berechnung des Ausgangssignals ausgehend von einem Eingangssignal wird als *diskrete Faltung* des
Eingangssignals mit der Impulsantwort bezeichnet. Der Operator der Faltung heißt Faltungsstern (%%\ast%%):

%%x[n]\ast h[n]=\sum\limits_{k=-\infty}^{\infty}x[k]\cdot h[n-k]%%

## Visuelle Darstellung
<figure><img src="{filename}convolution1.gif"><figcaption>Faltung eines Rechtecksignals mit einem Rechteck (Bild: <a href="https://commons.wikimedia.org/wiki/File:Convolution_of_box_signal_with_itself.gif">Brian Amberg</a> CC BY-SA 3.0)</figcaption></figure>

Das zweite Beispiel zeigt ein System mit Tiefpasseigenschaft. Die Impulsantwort eines Tiefpasssystems ist %%e^{-t}%% für %%t\geq 0%%.

<figure><img src="{filename}convolution2.gif"><figcaption>Faltung eines Rechtecksignals mit einer Exponentialfunktion (Bild: <a href="https://commons.wikimedia.org/wiki/File:Convolution_of_spiky_function_with_box2.gif">Brian Amberg/Tinos</a> CC BY-SA 3.0)</figcaption></figure>

## Berechnung nach Wozny
Eine einfache Art zur Durchführung der diskreten Faltung ist die Berechnung nach Wozny. Im folgenden Youtube Video findet
sich eine [Anleitung](https://youtu.be/kVSUnbgul7g?t=24m4s){: class="external" }.
