""" aoc_01.py

    Solution for Advent of Code 2016 day 01
"""

import aoc_01_input


def change_direction(current_direction, input_turn):
    """

    Changes the direction

    :param current_direction: A string which is 'N', 'E', 'S' or 'W'
    :param input_turn: 'R' (right) or 'L' (left)
    :return:
    """
    possible_directions = ['N', 'E', 'S', 'W']

    index_of_direction = possible_directions.index(current_direction)

    if input_turn == 'R':
        new_index = index_of_direction + 1
    else:
        new_index = index_of_direction - 1

    # The new index can be out of bounds (-1 or 4)
    # Fix this with modulo operator
    new_index %= 4

    return possible_directions[new_index]


def check_all_coords(all_coords_list, current_coords, hq_coords):
    """

    :param all_coords_list:
    :param current_coords:
    :return:
    """

    if hq_coords is None:
        # We have not found HQ yet
        # Check if current coords are in list or not
        if current_coords in all_coords_list:
            hq_coords = current_coords

        all_coords_list.append(current_coords)
    return [all_coords_list, hq_coords]


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_01_input.get_input()

    current_direction = 'N'
    steps_north = 0
    steps_east = 0

    # For part 2: Store all the coords visited in a list
    all_coords_list = []
    # A variable to save HQ coordinates in
    hq_coords = None

    for instruction in aoc_input:
        # One instruction is eg 'R2' or 'L44'
        input_turn = instruction[0]
        input_steps = int(instruction[1:])

        current_direction = change_direction(current_direction, input_turn)

        if current_direction == 'N':

            for k in range(input_steps):
                current_coords = [steps_north + k, steps_east]
                [all_coords_list, hq_coords] = check_all_coords(all_coords_list, current_coords, hq_coords)

            steps_north += input_steps

        elif current_direction == 'E':

            for k in range(input_steps):
                current_coords = [steps_north, steps_east + k]
                [all_coords_list, hq_coords] = check_all_coords(all_coords_list, current_coords, hq_coords)

            steps_east += input_steps

        elif current_direction == 'S':

            for k in range(input_steps):
                current_coords = [steps_north - k, steps_east]
                [all_coords_list, hq_coords] = check_all_coords(all_coords_list, current_coords, hq_coords)

            steps_north -= input_steps

        else:

            for k in range(input_steps):
                current_coords = [steps_north, steps_east - k]
                [all_coords_list, hq_coords] = check_all_coords(all_coords_list, current_coords, hq_coords)

            steps_east -= input_steps

        current_coords = [steps_north, steps_east]

    total_distance = abs(steps_north) + abs(steps_east)

    total_distance_part2 = abs(hq_coords[0]) + abs(hq_coords[1])

    print('Part 1: {}'.format(total_distance))
    print('Part 2: {}'.format(total_distance_part2))

    # print('Part 1: {}'.format(get_root(aoc_input[:])['name']))
    # print('Part 2: {}'.format(find_imbalance(aoc_input[:])))


if __name__ == '__main__':
    main()
