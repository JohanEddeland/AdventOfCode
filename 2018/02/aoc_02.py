""" aoc_02.py

    Solution for Advent of Code 2018
"""

import aoc_02_input


def get_difference_between_strings(string1: str, string2: str) -> [int, list]:
    """ get_difference_between_strings()

        Calculate the "total difference" between strings, i.e. how many letter differ between them. Also return
        all the letter that are common in the two strings.

    :param string1: The first string
    :param string2: The second string
    :return: A list where the first element is the number of differences, and the second element is a list containing
        the common numbers
    """
    num_diffs = 0
    same_letters = []
    for letter_index in range(len(string1)):
        letter1 = string1[letter_index]
        letter2 = string2[letter_index]

        if letter1 == letter2:
            same_letters.append(letter1)
        else:
            num_diffs += 1

    return [num_diffs, same_letters]


def solve_task1(aoc_input: list) -> int:
    """ solve_task1

        In task 1, check the input and calculate the number of times that we have lines with double and triple
        occurrences of letters, respectively. Return the product of these two numbers.

    :param aoc_input: A list of strings; the input provided
    :return: total_count: The product of the two numbers (double and triple counts)
    """
    # Initialize counters to keep track of occurrences of double and triple letters
    total_double = 0
    total_triple = 0

    for line in aoc_input:
        # letter_dict is a counting dictionary - the keys are letters, and the values are the number of occurrences
        # of that letter
        letter_dict = dict()

        for letter in line:
            letter_dict[letter] = letter_dict.get(letter, 0) + 1

        if 2 in letter_dict.values():
            total_double += 1

        if 3 in letter_dict.values():
            total_triple += 1

    total_count = total_double * total_triple
    return total_count


def solve_task2(aoc_input: list) -> str:
    """ solve_task2

        Check every line in the input against each other. Find the two lines that only have ONE letter difference
        between them. Return all the common letters in these two lines (i.e. remove the one letter different)

    :param aoc_input: A list of strings; the input provided
    :return: A string with all the common letters in the two lines
    """
    for line_number in range(len(aoc_input)):
        for line_number2 in range(len(aoc_input)):
            if not line_number == line_number2:
                line1 = aoc_input[line_number]
                line2 = aoc_input[line_number2]
                [num_diffs, same_letters] = get_difference_between_strings(line1, line2)

                if num_diffs == 1:
                    return ''.join(same_letters)


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_02_input.get_input()

    task_1_answer = solve_task1(aoc_input)
    task_2_answer = solve_task2(aoc_input)

    print('Part 1: {}'.format(task_1_answer))
    print('Part 2: {}'.format(task_2_answer))


if __name__ == '__main__':
    main()
