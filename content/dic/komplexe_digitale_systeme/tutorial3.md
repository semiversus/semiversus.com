title: Tutorial 3 - Reguläre Ausdrücke
parent: uebersicht.md
next: tutorial4.md

!!! panel-info "Unterlagen der Tuxcadamy"
    Dieses Tutorial baut auf den Unterlagen der [Tuxcadamy](https://www.tuxcademy.org/){: class="external" } auf. Auch Aufgabenstellungen
    sind teilweise dort übernommen worden. Die Unterlagen stehen unter der [CC-BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/){: class="external" }
    Lizenz und somit auch dieses Tutorial.

    Eine Kopie der Unterlagen kann man [hier]({filename}grd1-de-manual.pdf){: class="download" } herunterladen.

# Vorbereitung

Für die folgende Übung benötigen wir die Datei [frosch.txt]({filename}frosch.txt){: class="download" } auf der virtuellen Maschine.

Dazu gibt es zwei Möglichkeiten: Download mittels `wget` oder Einrichten eines gemeinsamen Ordners. Es wird also nur
ein Weg der zwei genannten benötigt.

## Download mittels `wget`
`wget` ist ein Kommandozeilentool um Dateien mittels <samp>http://</samp> Protokoll herunterzuladen. `wget` hat einen riesigen
Funktionsumfang, wir benötigen aber nur das notwendigste:

    #!bash
    wget http://semiversus.com/dic/komplexe_digitale_systeme/frosch.txt

Wenn eine Internetverbindung besteht sollte die Datei heruntergeladen werden und im aktuellen Verzeichnis abgelegt werden.

![Download mittels wget]({filename}tutorial_wget.png)

## Einrichten eines gemeinsamen Ordners

Im VirtualBox Manager wird <samp>DICbian</samp> ausgewählt und in der Toolbar auf <samp>Ändern</samp> geklickt. Unter dem Punkt
*Gemeinsame Ordner* wird ein entsprechender Eintrag hinzugefügt. 

![Gemeinsamer Ordner]({filename}tutorial_shared_folder.png)

* DICbian neu starten
* Einloggen als normaler Nuter (`dic` mit Passwort `dic`)
* Superuser werden (mittels `su` in der Kommandozeile und Passwort `htl`)
* Gemeinsamen Ordner *mounten* mittels `mount -t vboxsf dic /mnt` (wobei `dic` der Name des Eintrags für den gemeinsamen Ordner ist
* Nun ist der gemeinsame Ordner unter `/mnt` verfügbar
* Wechsle in das entsprechende Verzeichnis und kopiere die Datei ins *Home*-Verzeichnis (`~`)

# Übung

Arbeite dich durch das Kapitel 7 (Seite 99 bis 104) und beantworte die jeweiligen Übungen. 
