""" aoc_03_input.py

    The purpose is to return a properly formatted input to aoc_03.py
"""

import re


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    triangles = []
    with open('input') as input_file:
        for line in input_file:
            # Inputs are separated by comma
            this_triangle = re.findall('\d+', line)
            triangles.append(this_triangle)

    return triangles
