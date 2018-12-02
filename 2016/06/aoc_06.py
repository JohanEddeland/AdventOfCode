""" aoc_06.py

    Solution for Advent of Code 2016
"""

import aoc_06_input


def get_key_with_max_value(some_dict):
    dict_values = list(some_dict.values())
    dict_keys = list(some_dict.keys())
    return dict_keys[dict_values.index(max(dict_values))]


def get_key_with_min_value(some_dict):
    dict_values = list(some_dict.values())
    dict_keys = list(some_dict.keys())
    return dict_keys[dict_values.index(min(dict_values))]


def get_letter(aoc_input, letter_number, task_number):
    letter_dict = dict()

    for line in aoc_input:
        this_letter = line[letter_number]
        letter_dict[this_letter] = letter_dict.get(this_letter, 0) + 1

    # We have a letter dictionary that counts the occurrence of each letter
    if task_number == 1:
        # We get the key with maximum value
        letter = get_key_with_max_value(letter_dict)
    elif task_number == 2:
        # We get the key with minimum value
        letter = get_key_with_min_value(letter_dict)

    return letter


def get_word(aoc_input, task_number):
    word = ''

    line_length = len(aoc_input[0])
    for letter_number in range(line_length):
        next_letter = get_letter(aoc_input, letter_number, task_number)
        word += next_letter

    return word


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_06_input.get_input()

    word = get_word(aoc_input, 1)
    word_2 = get_word(aoc_input, 2)

    print('Part 1: {}'.format(word))
    print('Part 2: {}'.format(word_2))


if __name__ == '__main__':
    main()
