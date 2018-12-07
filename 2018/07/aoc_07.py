""" aoc_07.py

    Solution for Advent of Code 2018
"""

import aoc_07_input


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_07_input.get_input()
    # aoc_input = {'A': ['C'], 'B': ['A'], 'C': [], 'D': ['A'], 'E': ['B', 'D', 'F'], 'F': ['C']}

    # Aoc input is a dict
    # Key: The one we want finished
    # Value: The one that must be finished first

    answer = ''

    while aoc_input:
        # New try
        letters_to_work_on = []
        for key in aoc_input:
            if not aoc_input[key]:
                letters_to_work_on.append(key)

        letters_to_work_on.sort()

        # The following is for task 1
        value_to_add_to_string = letters_to_work_on[0]

        answer += value_to_add_to_string

        for key in aoc_input:
            # value_to_add_to_string has now been finished
            # remove it from the dict in all lists
            if value_to_add_to_string in aoc_input[key]:
                aoc_input[key].remove(value_to_add_to_string)

        # Finally, remove the key that we used from the dict
        aoc_input.pop(value_to_add_to_string, 'None')

    # TASK 2
    num_workers = 5  # 2 for test, 5 for real task
    time_remaining = {}
    time_to_add = 60  # 0 for test, 60 for real task
    # task2_input = {'A': ['C'], 'B': ['A'], 'C': [], 'D': ['A'], 'E': ['B', 'D', 'F'], 'F': ['C']}
    task2_input = aoc_07_input.get_input()
    worker_dict = {}

    answer2 = ''
    for letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
        time_remaining[letter] = time_to_add + ord(letter) - 64

    for worker in range(num_workers):
        worker_dict[worker] = ''

    total_time = 0
    while task2_input:
        total_time += 1
        letters_to_work_on = []
        for key in task2_input:
            if not task2_input[key]:
                letters_to_work_on.append(key)

        letters_to_work_on.sort(reverse=True)  # Reverse to we can "pop" the first alphabetical element
        busy_letters = list(worker_dict.values())

        for letter in busy_letters:
            if letter:
                letters_to_work_on.remove(letter)

        # Check which ones are working right now
        working_string_to_print = ''
        for k in range(num_workers):

            if worker_dict[k]:
                # worker k is busy
                this_letter = worker_dict[k]
            else:
                # worker k is NOT busy
                if letters_to_work_on:
                    this_letter = letters_to_work_on.pop()
                    worker_dict[k] = this_letter
                else:
                    working_string_to_print += '.'
                    continue

            working_string_to_print += this_letter
            time_remaining[this_letter] -= 1

            if time_remaining[this_letter] == 0:
                # Finished work on the letter!!
                worker_dict[k] = ''
                answer2 += this_letter
                for key in task2_input:
                    # remove it from the dict in all lists
                    if this_letter in task2_input[key]:
                        task2_input[key].remove(this_letter)

                # Finally, remove the key that we used from the dict
                task2_input.pop(this_letter, 'None')

        print(working_string_to_print)

    print('Part 1: {}'.format(answer))
    print('Part 2: {}'.format(total_time))


if __name__ == '__main__':
    main()
