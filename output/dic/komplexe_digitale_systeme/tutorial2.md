title: Tutorial 2 - Einstieg in die Shell
parent: uebersicht.md
next: tutorial3.md

!!! panel-info "Unterlagen der Tuxcadamy"
    Dieses Tutorial baut auf den Unterlagen der [Tuxcadamy](https://www.tuxcademy.org/){: class="external" } auf. Auch Aufgabenstellungen
    sind teilweise dort übernommen worden. Die Unterlagen stehen unter der [CC-BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/){: class="external" }
    Lizenz und somit auch dieses Tutorial.

    Eine Kopie der Unterlagen kann man [hier]({filename}grd1-de-manual.pdf){: class="download" } herunterladen.

# Allgemeines

!!! panel-info Definition durch Wikipedia - [Shell](https://de.wikipedia.org/wiki/Shell_(Betriebssystem)){: class="external" }
  In der Informatik bezeichnet man als **Shell** die Software, die den Benutzer mit dem Computer verbindet. Die Shell
  ermöglicht zum Beispiel, Kerneldienste zu nutzen und sich über Systemkomponenten zu informieren oder sie zu bedienen.
  Der Begriff „Shell“ (englisch für „Hülle“ oder „Außenhaut“) stammt von Muschelschalen und beschreibt eine Oberfläche
  zwischen dem Anwender und dem Inneren (den Kernel-Komponenten).

  Bei Betriebssystemen gibt es zwei Arten von Shells, die Kommandozeile (englisch **C**ommand-**L**ine **I**nterface CLI)
  und die grafischen Benutzeroberflächen (englisch **G**raphical **U**ser **I**nterface GUI). Jedoch ist in der
  Umgangssprache meist der Kommandozeileninterpreter als Shell gemeint.

# Vorbereitung
Starte [DICbian]({filename}dicbian.md) und logge dich mittels dem Benutzernamen <code>dic</code> und dem Passwort <code>dic</code> ein.

![DICbian nach dem Login]({filename}dicbian_shell.png)

# Übung

Arbeite dich durch die Kapitel 3 (Seite 39 bis 45), Kapitel 4 (Seite 47 bis 54) und Kapitel 6 (Seite 71 bis 98) und
beantworte die jeweiligen Übungen.

<figure><img src="{filename}tutorial_uebung.png"><figcaption>Beispiel für eine Übung aus den Unterlagen (Bild: Tuxcadamy CC BY-SA 4.0)</figcaption></figure>

## Editor
Ein einfacher Editor für Linux ist <code>nano</code>. Dieser ist auf den meisten Linux Systemen installiert und lässt sich leicht
über die Kombinationen mit <kbd>STRG</kbd> bedienen. Weiter Infos über <code>nano</code> gibt es [hier](https://wiki.ubuntuusers.de/Nano/){: class="external" }.

Die wichtigsten Tastenkombinationen für <code>nano</code>:

* <kbd>STRG</kbd>+<kbd>o</kbd> bzw. <kbd>F3</kbd> - Datei speichern
* <kbd>STRG</kbd>+<kbd>x</kbd> bzw. <kbd>F2</kbd> - Datei schließen

<figure><img src="{filename}tutorial_nano.png"><figcaption>Nano Editor im Einsatz (Bild: <a href="https://wiki.ubuntuusers.de/Nano/">ubuntuusers.de</a> CC BY-NC-SA 2.0 DE)</figcaption></figure>

## System herunterfahren
Wenn man DICbian in der Virtualbox herunterfahren möchte muss man sich erst als *Superuser* anmelden. Dies wird mittels
<code>su</code> gemacht (Passwort ist <code>htl</code>). Anschließend kann man mittels <code>poweroff</code> das System herunterfahren.

<figure><img src="{filename}tutorial_poweroff.png"><figcaption>Herunterfahren von DICbian</figcaption></figure>

