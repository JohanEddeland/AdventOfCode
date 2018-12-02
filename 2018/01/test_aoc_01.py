""" test_aoc_01.py

    Test for Advent of Code 2018
"""

import aoc_01


def test_given_task1_1():
    test_input = ['+1', '-2', '+3', '+1']

    expected = 3
    actual = aoc_01.get_answer(test_input, 0)

    assert actual == expected


def test_given_task1_2():
    test_input = ['+1', '+1', '+1']

    expected = 3
    actual = aoc_01.get_answer(test_input, 0)

    assert actual == expected


def test_given_task1_3():
    test_input = ['+1', '+1', '-2']

    expected = 0
    actual = aoc_01.get_answer(test_input, 0)

    assert actual == expected


def test_given_task1_4():
    test_input = ['-1', '-2', '-3']

    expected = -6
    actual = aoc_01.get_answer(test_input, 0)

    assert actual == expected


def test_given_task2_1():
    test_input = ['+1', '-2', '+3', '+1']

    expected = 2
    actual = aoc_01.get_answer_part_2(test_input)

    assert actual == expected


def test_given_task2_2():
    test_input = ['+1', '-1']

    expected = 0
    actual = aoc_01.get_answer_part_2(test_input)

    assert actual == expected


def test_given_task2_3():
    test_input = ['+3', '+3', '+4', '-2', '-4']

    expected = 10
    actual = aoc_01.get_answer_part_2(test_input)

    assert actual == expected


def test_given_task2_4():
    test_input = ['-6', '+3', '+8', '+5', '-6']

    expected = 5
    actual = aoc_01.get_answer_part_2(test_input)

    assert actual == expected


def test_given_task2_5():
    test_input = ['+7', '+7', '-2', '-7', '-4']

    expected = 14
    actual = aoc_01.get_answer_part_2(test_input)

    assert actual == expected
