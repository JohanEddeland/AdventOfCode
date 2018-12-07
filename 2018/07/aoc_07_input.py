""" aoc_07_input.py

    The purpose is to return a properly formatted input to aoc_07.py
"""


import re


def get_input():
    """ get_input()
        Return the content of the input as expected by the solver.
    """
    # Key:
    # value: Must be finished first
    nodes = dict()
    with open('input') as input_file:
        for line in input_file:
            first_part = re.findall('Step [A-Z]', line)[0]
            first_letter = first_part[-1]

            second_part = re.findall('step [A-Z]', line)[0]
            second_letter = second_part[-1]

            # Make sure to add all letters to the dict
            if first_letter not in nodes:
                nodes[first_letter] = []

            if second_letter in nodes:
                if first_letter not in nodes[second_letter]:
                    nodes[second_letter].append(first_letter)

            else:
                nodes[second_letter] = [first_letter]

    return nodes
