""" test_aoc_04.py

    Test for Advent of Code 2018
"""

import aoc_04
import aoc_04_input


def test_task1():
    test_input = aoc_04_input.get_input('test_input')

    (sleepy_guard, guards_sleeping_dict) = aoc_04.get_guards_sleeping_dict(test_input)

    (actual, _) = aoc_04.solve_tasks(sleepy_guard, guards_sleeping_dict)

    expected = 240

    assert actual == expected


def test_task2():
    test_input = aoc_04_input.get_input('test_input')

    (sleepy_guard, guards_sleeping_dict) = aoc_04.get_guards_sleeping_dict(test_input)

    (_, actual) = aoc_04.solve_tasks(sleepy_guard, guards_sleeping_dict)

    expected = 4455

    assert actual == expected
