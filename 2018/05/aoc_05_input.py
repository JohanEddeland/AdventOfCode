""" aoc_05_input.py

    The purpose is to return a properly formatted input to aoc_05.py
"""


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    polymer = ''
    with open('input') as input_file:
        for line in input_file:
            # Inputs are separated by comma
            polymer += line

    return polymer