""" aoc_06_input.py

    The purpose is to return a properly formatted input to aoc_06.py
"""

import re


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    all_lines = []
    with open('input') as input_file:
        for line in input_file:
            # First, remove line breaks from the line
            line = line.replace('\n', '')

            # Then, append to our list
            all_lines.append(line)

    return all_lines
