""" test_aoc_06.py

    Test for Advent of Code 2016
"""

import aoc_06
import aoc_06_input

TEST_INPUT = """eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar"""


def test_given_data():
    given_data = TEST_INPUT.split('\n')
    actual = aoc_06.get_word(given_data, 1)
    expected = 'easter'

    assert actual == expected


def test_given_data_2():
    given_data = TEST_INPUT.split('\n')
    actual = aoc_06.get_word(given_data, 2)
    expected = 'advent'

    assert actual == expected
