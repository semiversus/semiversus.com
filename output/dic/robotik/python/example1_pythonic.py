VOWELS = 'aeiou'

word_list = ['Warthog', 'Hedgehog', 'Badger', 'Drake', 'Eft', 'Fawn', 'Gibbon']

print(sorted(word_list, key=lambda word: sum(map(word.count, VOWELS)))[-1])

