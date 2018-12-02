""" aoc_01.py

    Solution for Advent of Code 2018
"""

import aoc_01_input


def get_answer(aoc_input: list, start_freq: int) -> int:
    """ get_answer
        Calculate the end frequency after going through all the steps in the given input.

    :param aoc_input: A list of strings with the frequency changes as inputs.
    :param start_freq: The frequency to start from.
    :return: The end frequency, where we end up after applying all the steps.
    """
    current_freq = start_freq
    for freq in aoc_input:
        current_freq += int(freq)

    return current_freq


def get_answer_part_2(aoc_input: list) -> int:
    """ get_answer_part_2
        By looping through the given input steps over and over, find the first frequency which we visit twice.

    :param aoc_input: A list of strings with the frequency changes as inputs.
    :return: The frequency which is the first frequency to be reached twice.
    """
    reached_frequencies = {0}
    current_freq = 0

    while True:
        for freq in aoc_input:
            current_freq += int(freq)

            if current_freq in reached_frequencies:
                return current_freq

            reached_frequencies.add(current_freq)


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_01_input.get_input()

    # First, just start from zero and run list once
    freq_1 = get_answer(aoc_input, 0)

    # Second, keep looping through list until one is found twice
    freq_2 = get_answer_part_2(aoc_input)

    print('Part 1: {}'.format(freq_1))
    print('Part 2: {}'.format(freq_2))


if __name__ == '__main__':
    main()
