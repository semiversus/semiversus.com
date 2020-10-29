title: Erstes Beispiel
parent: uebersicht.md
next: datentypen.md

## Beispiel 1

Starten wir direkt mit einem Beispiel, welches über <code>Hello, World!</code> hinausgeht. Was macht das folgende Programm?
Was fällt auf im Vergleich zu anderen Programmiersprachen?

    #!python
    word_list = ['Warthog', 'Hedgehog', 'Badger', 'Drake', 'Eft', 'Fawn', 'Gibbon']

    VOWELS = 'aeiou'

    result_string = ''
    result_number = 0

    for word in word_list:
        vowels_number = 0

        for letter in word:
            if letter in VOWELS:
                vowels_number += 1

        if vowels_number > result_number:
            result_number = vowels_number
            result_string = word

    print(result_string)

Beispiel als [Download]({filename}example1.py)

Das Programm iteriert über eine Liste mit Wörtern und findet das Wort mit den meisten Selbstlauten.

Was fällt im Vergleich zu anderen Programmiersprachen auf?

* Python nutzt dynamische Typisierung (d.h. beim Einführen von Variablen muss kein Datentyp angegeben werden)
* Es werden keine Klammern für Blöcke benötigt. Sie werden durch Einrückungen definiert

## Beispiel2

Zum Ausprobieren gibt es das Beispiel auch hier: [Online Python Beispiel](https://onlinegdb.com/B19ue-gOH)

    #!python
    from random import randint

    UPPER_NUMBER_LIMIT = 100

    number_to_guess = randint(1, UPPER_NUMBER_LIMIT)
    guessed_number = None

    print('I will choose a number between 1 and ' + str(UPPER_NUMBER_LIMIT) + '.')

    while number_to_guess != guessed_number:
        user_input = input('What number are you guessing? number: ')

        guessed_number = int(user_input)

        if guessed_number > number_to_guess:
            print('Your guessed number is too high!')
        elif guessed_number < number_to_guess:
            print('Your guessed number is too low!')

    print('Your guess was correct!')

# Aufgaben
* Füge eine Anzeige hinzu, wieviele Versuche notwendig waren. Dies sollte dann in etwa so aussehen: <code>Your guess was correct! It took 3 attempts.</code>
* Füge eine Abfrage des oberen Limits ein. Dazu sollte folgende Abfrage am Anfang erscheinen: <code>What should be the upper limit? number: </code>
