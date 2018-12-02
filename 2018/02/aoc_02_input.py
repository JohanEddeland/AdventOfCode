""" aoc_02_input.py

    The purpose is to return a properly formatted input to aoc_02.py
"""


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver. The input strings are each on a separate line.
    """
    all_lines = []
    with open('input') as input_file:
        for line in input_file:
            all_lines.append(line)

    return all_lines