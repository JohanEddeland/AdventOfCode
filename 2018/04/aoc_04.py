""" aoc_04.py

    Solution for Advent of Code 2018
"""

import aoc_04_input
import re
import operator


def get_guards_sleeping_dict(aoc_input: list) -> (int, dict):
    """ get_guards_sleeping_dict()

        This function takes the input list and stores how many times each guard sleeps each minute. It also calculates
        and returns which guard sleeps the most overall.

    :param aoc_input: A list containing each input line given in the task.
    :return: The guard number of the guard that sleeps the most, and a dictionary containing information about how much
             each guard sleeps each minute.
    """
    # Keys: (id, minute)
    # Keeps track of how many times each guard has slept every minute
    guards_sleeping_dict = dict()

    # Key: id
    # Keeps track of how much each guard has slept in total
    total_sleeping_dict = dict()

    # Initialize variables
    guard_number = 0
    minute_started_sleeping = 0

    for line in aoc_input:
        # Parse the current minute to an int
        current_minute = re.findall(':\d+', line)
        current_minute = current_minute[0]
        current_minute = current_minute[1:]
        current_minute = int(current_minute)

        if 'Guard' in line:
            # Parse the guard number to an int
            guard_number = re.findall('#\d+', line)
            guard_number = guard_number[0]
            guard_number = guard_number[1:]
            guard_number = int(guard_number)

        elif 'asleep' in line:
            # Store the current minute as the minute that the current guard starts sleeping
            minute_started_sleeping = current_minute

        elif 'wakes' in line:
            # For all minutes between start time and current time, store the information that the guard is sleeping
            for minute in range(minute_started_sleeping, current_minute):
                guards_sleeping_dict[(guard_number, minute)] = guards_sleeping_dict.get((guard_number, minute), 0) + 1

            total_sleeping_dict[guard_number] = total_sleeping_dict.get(guard_number, 0) + (current_minute - minute_started_sleeping)

        else:
            raise ValueError('The given input line is not as expected!')

    # Get the guard which sleeps to maximum TOTAL amount
    sleepy_guard = max(total_sleeping_dict.items(), key=operator.itemgetter(1))[0]

    return sleepy_guard, guards_sleeping_dict


def solve_tasks(sleepy_guard: int, guards_sleeping_dict: dict) -> (int, int):
    """ solve_tasks()

        Solves both task 1 and 2. Given the guard that sleeps the most, calculates which of the minutes he sleeps
        the most.

    :param sleepy_guard: Number of the guard that sleeps the most in total.
    :param guards_sleeping_dict: Dictionary with information about how much each guard sleeps each minute.
    :return: Answers to task 1 and 2.
    """
    most_sleep = 0
    sleep_index = -1

    for minute in range(60):
        if (sleepy_guard, minute) in guards_sleeping_dict:
            this_sleep = guards_sleeping_dict[(sleepy_guard, minute)]
            if this_sleep > most_sleep:
                most_sleep = this_sleep
                sleep_index = minute

    # Get the guard which sleeps the most for one specific minute
    (sleepy_guard2, minute2) = max(guards_sleeping_dict.items(), key=operator.itemgetter(1))[0]

    # Calculate the answers by multiplying guard number with the given minutes
    answer1 = sleepy_guard * sleep_index
    answer2 = sleepy_guard2 * minute2

    return answer1, answer2


def main():
    """ main()

        Main function that calculates the answer for day 4.
    """
    aoc_input = aoc_04_input.get_input('input')

    (sleepy_guard, guards_sleeping_dict) = get_guards_sleeping_dict(aoc_input)

    (answer1, answer2) = solve_tasks(sleepy_guard, guards_sleeping_dict)

    print('Part 1: {}'.format(answer1))
    print('Part 2: {}'.format(answer2))


if __name__ == '__main__':
    main()
