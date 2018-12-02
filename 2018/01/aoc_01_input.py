""" aoc_01_input.py

    The purpose is to return a properly formatted input to aoc_01.py
"""


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    frequencies = []
    with open('input') as input_file:
        for line in input_file:
            frequencies.append(line)

    return frequencies
