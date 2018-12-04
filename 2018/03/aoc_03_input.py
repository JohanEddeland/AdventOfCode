""" aoc_03_input.py

    The purpose is to return a properly formatted input to aoc_03.py
"""


import re


def get_input(filename):
    """ get_input()
        Formats the input in a way aoc_03.py expects. For this particular day, it does quite much.

    :return: dict_of_fabric is a dict with (x, y)-coordinates as keys, that says which claims have been laid to that
             coordinate.
             potential_non_overlapping_claim is a list that keeps track of all the claim_ids we have, so that the
             solver can loop over them and remove ones that have conflicting claims with other id's.
    """
    dict_of_fabric = dict()
    potential_non_overlapping_claim = []

    with open(filename) as input_file:
        for line in input_file:
            # Regex to get the claim_id in the line, we want it as an int
            claim_id = re.findall('#\d+', line)
            claim_id = claim_id[0].replace('#', '')
            claim_id = int(claim_id)

            # We load (x, y) as strings
            start_coords = re.findall('\d+,\d+', line)
            [x, y] = start_coords[0].split(',')

            # We load the dimensions as strings (dimensions are e.g. 15x41 in the line)
            dimensions = re.findall('\d+x\d+', line)
            [width, height] = dimensions[0].split('x')

            # Convert coordinates and dimensions to int
            x = int(x)
            y = int(y)
            width = int(width)
            height = int(height)

            # Append the claim_id as a potential candidate for non-overlapping
            potential_non_overlapping_claim.append(claim_id)

            # For all coordinates in the claimed area, add them as claimed in the dict_of_fabric dictionary
            for x_counter in range(x, x+width):
                for y_counter in range(y, y+height):
                    if (x_counter, y_counter) in dict_of_fabric.keys():
                        dict_of_fabric[(x_counter, y_counter)].append(claim_id)
                    else:
                        dict_of_fabric[(x_counter, y_counter)] = [claim_id]

    return dict_of_fabric, potential_non_overlapping_claim
