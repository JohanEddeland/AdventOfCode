""" aoc_02.py

    Solution for Advent of Code 2016
"""

import aoc_02_input


def get_digit_from_coords(coords, array_to_use):
    digit = array_to_use[coords[0]][coords[1]]

    return digit


def move_within_range(coords_at_start, new_coords, array_to_use):
    # We assume that array_to_use is SQUARE
    # Therefore, len() gives both the width and the height of the array
    array_width = len(array_to_use)

    # First, we move the coords within range of the array
    if new_coords[0] < 0:
        new_coords[0] = 0

    if new_coords[0] > array_width - 1:
        new_coords[0] = array_width - 1

    if new_coords[1] < 0:
        new_coords[1] = 0

    if new_coords[1] > array_width - 1:
        new_coords[1] = array_width - 1

    # Next, we check that there is an actual element at the new coords
    digit = get_digit_from_coords(new_coords, array_to_use)

    if digit is None:
        # There is no real element at the new coords - use coords at start
        return coords_at_start
    else:
        return new_coords


def get_new_coords(current_coords, instruction, array_to_use):
    # First, load the current coords
    new_coords = current_coords.copy()

    # Now, change the correct coords
    if instruction == 'U':
        new_coords[0] -= 1
    elif instruction == 'R':
        new_coords[1] += 1
    elif instruction == 'D':
        new_coords[0] += 1
    elif instruction == 'L':
        new_coords[1] -= 1

    # Make sure coords are within range before returning them
    new_coords = move_within_range(current_coords, new_coords, array_to_use)
    return new_coords


def calculate_row(row, current_coords, array_to_use):
    '''Calculates the digit for one row of instructions

    :param row: A string of instructions.
    :param current_coords: Where to start in the array (on the numpad)
    :param array_to_use: How the array (numpad) looks. A square list of lists.
    :return:
    '''

    for letter in row[0]:
        new_coords = get_new_coords(current_coords, letter, array_to_use)
        current_coords = new_coords

    # Loop has finished, we have arrived at the final number for this row
    digit = get_digit_from_coords(current_coords, array_to_use)
    return [digit, current_coords]


def calculate_password(aoc_input, task_number):
    password = ''

    if task_number == 1:
        '''Task 1. The array looks like this:
        1 2 3
        4 5 6
        7 8 9'''
        array_to_use = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']]

        # Start at number 5
        # The first element of the coords is the ROW of the 3x3 array
        # The second element of the coords is the COLUMN of the 3x3 array
        current_coords = [1, 1]

    elif task_number == 2:
        '''Task 2. The array looks like this:
             
                1
              2 3 4
            5 6 7 8 9
              A B C
                D'''
        row1 = [None, None, '1', None, None]
        row2 = [None, '2', '3', '4', None]
        row3 = ['5', '6', '7', '8', '9']
        row4 = [None, 'A', 'B', 'C', None]
        row5 = [None, None, 'D', None, None]
        array_to_use = [row1, row2, row3, row4, row5]

        # Start at number 5
        # The first element of the coords is the ROW of the 5x5 array
        # The second element of the coords is the COLUMN of the 5x5 array
        current_coords = [2, 0]

    for row in aoc_input:
        [digit, current_coords] = calculate_row(row, current_coords, array_to_use)
        password += digit
    return password


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_02_input.get_input()

    password = calculate_password(aoc_input, 1)
    password2 = calculate_password(aoc_input, 2)

    print('Part 1: {}'.format(password))
    print('Part 2: {}'.format(password2))


if __name__ == '__main__':
    main()
