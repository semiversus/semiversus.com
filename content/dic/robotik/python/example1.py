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

