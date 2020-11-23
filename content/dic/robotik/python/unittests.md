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
```python
>>> get_average_age({'Klaus': 17, 'Hubert': 19, 'Otto': 20})
18.666666666666668
```

### Unittest
Dateiname: <code>test_average_age.py</code>

* Der Unittest soll die Funktion <code>get_average_age</code> sinvoll testen.
* Sind die Anforderungen vollständig definiert?

## Übung Median
* Dateiname: <code>median.py</code> bzw. <code>test_median.py</code>
* Funktion: <code>def calc_median(numbers: list) -> float:</code>

Der Funktion wird eine Liste an Zahlen übergeben. Zurückgegeben wird der sogenannte [Median](https://de.wikipedia.org/wiki/Median) -> die Zahl, die in der Mitte steht, wenn die Liste sortiert ist.

Beispiel:
```python
>>> calc_median([3, 1, 6, 10 ,2])
3
```

Auch in dieser Übung ist der entsprechende Unittest zu entwerfen

## Übung Progressive Steuern
* Dateiname: <code>progressive_tax.py</code> bzw. <code>test_progressive_tax.py</code>
* Funktion: <code>def calc_tax(earnings: float) -> float:</code>

Implementiere eine Funktion die die progressiven Steuern laut [Österreichischer Einkommenssteuertabelle](https://www.finanz.at/steuern/lohnsteuertabelle/) berechnet.

Beispiel:
```python
>>> calc_tax(700)
0
>>> calc_tax(2000)
252.734
```

## Übung Zinseszins
* Dateiname: <code>compund_interest.py</code> bzw. <code>test_compound_interest.py</code>
* Funktion: <code>def calc_compound_interest(value: float, years: int, interest: float) -> float:</code>

Wir berechnen den [Zinseszins](https://de.wikipedia.org/wiki/Zinseszins). Dazu starten wir mit einem Kapital (<code>value</code>), legen es für eine bestimmte Anzahl an Jahren (<code>years</code>) an zu einem bestimmten Zinssatz in Prozent (<code>interest</code>).

Beispiel:
```python
>>> calc_compound_interest(1000, 1, 1)
1010
>>> calc_compount_interest(1, 2000, 0.5)
21484.41
```
