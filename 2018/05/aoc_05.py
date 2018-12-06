""" aoc_05.py

    Solution for Advent of Code 2018
"""

import aoc_05_input


def replace_all_polymer(aoc_input):
    aoc_input = aoc_input.replace('\n', '')
    finished_loop = False

    while not finished_loop:
        replace_in_this_loop = 0

        if len(aoc_input) == 0:
            finished_loop = True
        for k in range(1, len(aoc_input)):
            if k > len(aoc_input) - 1:
                break
            previous_letter = aoc_input[k - 1]
            this_letter = aoc_input[k]
            if same_type_different_polarity(this_letter, previous_letter):
                aoc_input = replace_one_substring(aoc_input, k)

                replace_in_this_loop += 1

        if replace_in_this_loop == 0:
            finished_loop = True

    return aoc_input


def same_type_different_polarity(letter1, letter2):
    letter_difference = ord(letter1) - ord(letter2)
    if abs(letter_difference) == 32:
        return True
    else:
        return False


def replace_one_substring(string_to_replace, letter_index):
    if letter_index == len(string_to_replace):
        new_string = string_to_replace[0:letter_index - 1]
    else:
        new_string = string_to_replace[0:letter_index - 1] + string_to_replace[letter_index + 1:]

    return new_string


def is_this_letter(lowercase_letter, letter):
    if lowercase_letter == letter:
        return True
    elif ord(letter) - ord(lowercase_letter) == -32:
        return True
    else:
        return False


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_05_input.get_input()

    answer1 = replace_all_polymer(aoc_input)

    shortest_result = 10000000
    shortest_letter = '\x00'
    for letter_counter in range(65, 91):
        print('Checking ' + chr(letter_counter))

        input_with_removed_letter = aoc_input.replace(chr(letter_counter), '')
        input_with_removed_letter = input_with_removed_letter.replace(chr(letter_counter + 32), '')
        final_result = replace_all_polymer(input_with_removed_letter)

        if len(final_result) < shortest_result:
            shortest_result = len(final_result)
            shortest_letter = chr(letter_counter)

    print('Part 1: {}'.format(len(answer1)))
    print('Part 2: {}'.format(shortest_result))
    print(shortest_letter)


if __name__ == '__main__':
    main()
