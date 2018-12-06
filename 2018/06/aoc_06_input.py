""" aoc_06_input.py

    The purpose is to return a properly formatted input to aoc_06.py
"""


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    coords = []
    with open('input') as input_file:
        for line in input_file:
            (x, y) = line.split(',')
            x = int(x)
            y = int(y)
            coords.append((x, y))

    return coords
