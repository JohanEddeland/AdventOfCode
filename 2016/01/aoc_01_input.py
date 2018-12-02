""" aoc_01_input.py
    Its sole purpose is to return the input of todays problem in a the format
    the solution expects.
"""

def get_input():
    """ get_input()
        Return the content of the intput as expected by the solver.
    """
    nodes = []
    with open('input') as input_file:
        for line in input_file:
            line = line.replace(' ', '')
            nodes = line.split(',')

    return nodes