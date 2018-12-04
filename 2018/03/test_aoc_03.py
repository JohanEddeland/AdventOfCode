""" test_aoc_03.py

    Test for Advent of Code 2018
"""

import aoc_03
import aoc_03_input


def test_task1():
    (aoc_input, potential_non_overlapping_claims) = aoc_03_input.get_input('test_input')

    expected = 4
    actual = aoc_03.solve_task_1(aoc_input)

    assert actual == expected


def test_task2():
    (aoc_input, potential_non_overlapping_claims) = aoc_03_input.get_input('test_input')

    expected = 3
    actual = aoc_03.solve_task_2(aoc_input, potential_non_overlapping_claims)

    assert actual == expected
