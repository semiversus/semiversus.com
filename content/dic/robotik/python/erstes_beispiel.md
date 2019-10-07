title: Erstes Beispiel
parent: uebersicht.md

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

    print('You guess was correct!')

# Aufgaben
* Füge eine Anzeige hinzu, wieviele Versuche notwendig waren. Dies sollte dann in etwa so aussehen: <code>You guess was correct! It took 3 attempts.</code>
* Füge eine Abfrage des oberen Limits ein. Dazu sollte folgende Abfrage am Anfang erscheinen: <code>What should be the upper limit? number: </code>
