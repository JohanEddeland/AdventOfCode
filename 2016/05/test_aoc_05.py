""" test_aoc_05.py

    Test for Advent of Code 2016
"""

import aoc_05
import aoc_05_input

TEST_INPUT = """SOMETHING"""


def test_password_1():
    input = 'abc'

    actual = aoc_05.get_password(input, 1)
    expected = '18f47a30'

    assert actual == expected


def test_password_2():
    input = 'abc'

    actual = aoc_05.get_password(input, 2)
    expected = '05ace8e3'

    assert actual == expected

