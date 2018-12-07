""" test_aoc_05.py

    Test for Advent of Code 2018
"""

import aoc_05
import aoc_05_input


TEST_INPUT = 'dabAcCaCBAcCcaDA'


def test_task1():
    expected = 10
    actual = aoc_05.replace_all_polymer(TEST_INPUT)

    assert len(actual) == expected


def test_task2():
    expected = 4
    (actual, _) = aoc_05.solve_task2(TEST_INPUT)

    assert actual == expected
