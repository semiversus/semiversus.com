title: Hardwareabstraktion
parent: uebersicht.md

# Allgemeines
Der erste naive Ansatz Firmware für Mikrocontroller zu entwickeln wird nach den ersten Erfolgen schnell durch die
wachsende Komplexität gebremst. Man kann den Quellcode in mehrere Dateien (bzw. C Module) unterteilen. Hängen diese
aber zu stark von einander ab steigt die Komplexität durch diese Aufteilung weiter an.

Ein erster wichtiger Schritt hin zu strukturierten Softwareentwicklung ist die Einführung von Abstraktionen. 

!!! panel-info "Definition *Abstraktion (Informatik)* durch Wikipedia"
    Der Begriff Abstraktion wird in der Informatik sehr häufig eingesetzt und beschreibt die Trennung zwischen Konzept
    und Umsetzung. Strukturen werden dabei über ihre Bedeutung definiert, während die detaillierten Informationen über
    die Funktionsweise verborgen bleiben. Abstraktion zielt darauf ab, die Details der Implementierung nicht zu
    berücksichtigen und daraus ein allgemeines Schema zur Lösung des Problems abzuleiten. Ein Computerprogramm kann so
    unterschiedliche Abstraktionsebenen aufweisen, wobei auf jeder Ebene ein anderer Grad des Informationsgehaltes dem
    Programmierer preisgegeben wird. Eine Abstraktion auf niedriger Stufe beinhaltet Details zur Hardware, auf der das 
    Programm läuft. Höher liegende Abstraktionsebenen beschäftigen sich dagegen mit der Geschäftslogik der Software.


