""" aoc_03.py

    Solution for Advent of Code 2018
"""

import aoc_03_input


def solve_task_1(aoc_input: dict) -> int:
    """ solve_task_1()

        Calculates the total number of coordinates that have more than one claims to them.

    :param aoc_input: A dict with coordinates as keys and claims as values.
    :return: Total number of overlapping claims.
    """
    counter_of_overlap = 0

    for list_of_claim_id in aoc_input.values():
        if len(list_of_claim_id) > 1:
            counter_of_overlap += 1

    return counter_of_overlap


def solve_task_2(aoc_input: dict, potential_non_overlapping_claims: list) -> int:
    """ solve_task_2()

        Starts with a list of all claim id's, and sequentially narrows it down by iterating over all coordinates and
        removing all claim id's that are conflicting with other id's.

    :param aoc_input: A dict with coordinates as keys and claims as values.
    :param potential_non_overlapping_claims: A list of all claim id's.
    :return: The only claim id that is not conflicting with another id.
    """
    for item in aoc_input:
        if len(aoc_input[item]) > 1:
            # Remove all claim_ids here from potential non-overlapping list
            for claim_id in aoc_input[item]:
                if claim_id in potential_non_overlapping_claims:
                    potential_non_overlapping_claims.remove(claim_id)

    # There is now only one item left in the list
    # Return it
    return potential_non_overlapping_claims[0]


def main():
    """ main()

        Main function used to solve the problem for day 3. Actually, much work is done by aoc_03_input for this day.
        It gives a dict with claims, where the keys are (x, y)-coordinates. This functions loops over all coordinates
        to check which ones are overlapping or not. We also get a list of all claim-id's, so that we can find out
        which one is not conflicting with another claim id.
    """
    (aoc_input, potential_non_overlapping_claims) = aoc_03_input.get_input('input')

    number_of_overlaps = solve_task_1(aoc_input)
    non_overlapping_claim = solve_task_2(aoc_input, potential_non_overlapping_claims)

    print('Part 1: {}'.format(number_of_overlaps))
    print('Part 2: {}'.format(non_overlapping_claim))


if __name__ == '__main__':
    main()
