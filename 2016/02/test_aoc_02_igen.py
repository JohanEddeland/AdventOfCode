'''
Test for something
'''

import aoc_02

TEST_INPUT = [['ULL'], ['RRDDD'], ['LURDL'], ['UUUUD']]


def test_aoc_02_task1():
    expected = '1985'
    actual = aoc_02.calculate_password(TEST_INPUT, 1)

    assert expected == actual


def test_aoc_02_task2():
    expected = '5DB3'
    actual = aoc_02.calculate_password(TEST_INPUT, 2)

    assert expected == actual