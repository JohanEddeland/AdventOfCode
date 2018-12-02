""" test_aoc_02.py

    Test for Advent of Code 2018
"""

import aoc_02


def test_given_part1():
    test_input = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']

    expected = 12
    actual = aoc_02.solve_task1(test_input)

    assert actual == expected


def test_given_part2():
    test_input = ['abcde', 'fghij', 'klmno', 'pqrst', 'fguij', 'axcye', 'wvxyz']

    expected = 'fgij'
    actual = aoc_02.solve_task2(test_input)

    assert actual == expected
