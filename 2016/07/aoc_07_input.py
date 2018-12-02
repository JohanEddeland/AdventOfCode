""" aoc_07_input.py

    The purpose is to return a properly formatted input to aoc_07.py
"""

def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    nodes = []
    with open('input') as input_file:
        for line in input_file:
            # Inputs are separated by comma
            nodes = line.split(',')

    return nodes