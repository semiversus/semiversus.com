title: Python Unittest Übung
parent: uebersicht.md

# Unittests

Vorbereitungen:

1. Neues Verzeichnis erstellen (Name <code>unittests</code>)
1. Dieses Verzeichnis mit VS Code öffnen
1. In VS Code das Terminal öffnen und <code>python -m venv .venv</code> ausführen
1. VS Code sollte nun die virtuelle Umgebung erkennen und fragen, ob man es auswählen will -> Dies mit "Ja" (bzw. "Yes") bestätigen
1. Das Paket pytest mittels <code>python -m pip install pytest</code> installieren

## Übung Durchschnittsalter
* Dateiname: <code>average_age.py</code>
* Funktion: <code>def get_average_age(persons_dict: dict) -> float:</code>

Der Funktion wird ein *Dictionary* übergeben. Die *Keys* sind Personennamen (*Strings*) und die *Values* sind das Alter.

Beispiel:

    #!python
    >>> get_average_age({'Klaus': 17, 'Hubert': 19, 'Otto': 20})
    18.666666666666668

### Unittest
* Dateiname: <code>test_average_age.py</code>

* Der Unittest soll die Funktion <code>get_average_age</code> sinvoll testen.
* Sind die Anforderungen vollständig definiert?

## Übung Median
* Dateiname: <code>median.py</code> bzw. <code>test_median.py</code>
* Funktion: <code>def calc_median(numbers: list) -> float:</code>

Der Funktion wird eine Liste an Zahlen übergeben. Zurückgegeben wird der sogenannte [Median](https://de.wikipedia.org/wiki/Median) -> die Zahl, die in der Mitte steht, wenn die Liste sortiert ist.

Beispiel:

    #!python
    >>> calc_median([3, 1, 6, 10 ,2])
    3

Auch in dieser Übung ist der entsprechende Unittest zu entwerfen

## Übung Progressive Steuern
* Dateiname: <code>progressive_tax.py</code> bzw. <code>test_progressive_tax.py</code>
* Funktion: <code>def calc_tax(earnings: float) -> float:</code>

Implementiere eine Funktion die die progressiven Steuern laut [Österreichischer Einkommenssteuertabelle](https://www.finanz.at/steuern/lohnsteuertabelle/) berechnet.

Beispiel:

    #!python
    >>> calc_tax(700)
    0
    >>> calc_tax(2000)
    252.734

## Übung Zinseszins
* Dateiname: <code>compound_interest.py</code> bzw. <code>test_compound_interest.py</code>
* Funktion: <code>def calc_compound_interest(value: float, years: int, interest: float) -> float:</code>

Wir berechnen den [Zinseszins](https://de.wikipedia.org/wiki/Zinseszins). Dazu starten wir mit einem Kapital (<code>value</code>), legen es für eine bestimmte Anzahl an Jahren (<code>years</code>) an zu einem bestimmten Zinssatz in Prozent (<code>interest</code>).

Beispiel:

    #!python
    >>> calc_compound_interest(1000, 1, 1)
    1010
    >>> calc_compount_interest(1, 2000, 0.5)
    21484.41

## Übung Elemente zählen
* Dateiname: <code>enumerate_list.py</code> bzw. <code>test_enumerate_list.py</code>
* Funktion: <code>def enumerate_list(elements: list) -> dict:</code>

Aus einer Liste an Elemente soll ein Dictionary erstellt werden, welches die Anzahl der enthaltenen Elemente angibt.

Beispiel:

    #!python
    >>> enumerate_list(['A', 'B', 'B', 'C', 'A', 'A'])
    {'A': 3, 'B': 2, 'C': 1}
    >>> enumerate_list([1, 0, 2, 2, 0, 0, 1, 2])
    {1: 2, 0: 3, 2: 3}

## Übung Gemeinsamkeiten
* Dateiname: <code>common_list.py</code> bzw. <code>test_common_list.py</code>
* Funktion: <code>def get_common_elements(list1: list, list2: list) -> list:</code>

Die Funktion ermittelt die Elemente, die in beiden Listen sind. Die Ausgabe ist selbst wieder
eine Liste, deren Sortierung aber beliebig sein kann.

Beispiel:

    #!python
    >>> get_common_elements([1, 2, 3, 4, 1], [2, 1])
    [1, 2]
    >>> get_common_elements(['A', 1, 'A', 0, 'B'], ['C', 'D'])
    []

## Übung Wörter durcheinander würfeln
* Dateiname: <code>shuffle.py</code> bzw. <code>shuffle.py</code>
* Funktion: <code>def shuffle_words(message: str) -> str:</code>

Ein String bestehend aus mehreren Wörtern soll wortweise durcheinander gewürfelt werden. Dabei
soll jeweils der erste und letzte Buchstabe eines Wortes unverändert bleiben.

Beispiel:

    #!python
    >>> shuffle_words('Hier wohnt Herr Schuster')
    'Heir wnoht Hrer Steuschr'

Hinweise:

* Um einen String zufällig zu sortieren seht ihr hier in der ersten Antwort ein Beispiel: [Stackoverflow](https://stackoverflow.com/a/2668366/166605)
* Beim Testen wird es auch etwas schwieriger, weil ihr überprüfen müsst, ob das Resultat gültig ist. [sorted()](https://docs.python.org/3/library/functions.html#sorted) kann hier hilfreich sein!
* Im String kommen keine Satzzeichen vor (<code>.</code>, <code>,</code>, ...)

## Übung Niedrigster Preis
* Dateiname: <code>lowest_price.py</code> bzw. <code>test_lowest_price.py</code>
* Funktion: <code>def lowest_price(items: dict) -> list:</code>

Der Funktion wird ein Dictionary mit Artikelnamen und deren Preisen gegeben. Zurückgegeben werden soll eine Liste mit den drei günstigsten Artikeln.

Beispiel:

    #!python
    >>> get_cheapest_articles({'Allegro': 17.5, 'Adagio': 3.5, 'Forte': 15, 'Largo': 5, 'Legato': 18})
    ['Adagio', 'Largo', 'Forte']

Hinweis:

* Das Wörterbuch enthält immer mindestens drei Einträge
