""" aoc_04_input.py

    The purpose is to return a properly formatted input to aoc_04.py
"""


def get_input(filename):
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    times = []
    with open(filename) as input_file:
        for line in input_file:
            times.append(line)

    # Return a SORTED list, needed for the assignment
    times.sort()

    return times
