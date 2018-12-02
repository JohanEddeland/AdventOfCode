""" aoc_05.py

    Solution for Advent of Code 2016
"""

import aoc_05_input
import hashlib


def is_ok_to_put_new_char(hex_string, password):
    """
    This function takes a hex string, and then checks if the sixth element specifies a place in the given password
    where a new character can be inserted.
    It is considered ok to insert if
     - the sixth element is numeric (i.e. 0-9)
     - the sixth element is less than 8 (otherwise it is out of range for the password)
     - the corresponding place in the password is ' ' (i.e. its empty)

    :param hex_string:
    :return:
    """
    ok_to_put_new_char = False

    place_to_put_new_char = hex_string[5]
    is_numeric = place_to_put_new_char.isnumeric()

    if is_numeric:
        place_to_put_new_char = int(place_to_put_new_char)
        not_too_long = place_to_put_new_char < 8
        if not_too_long:
            place_empty = password[place_to_put_new_char] is ' '
            if place_empty:
                ok_to_put_new_char = True

    return ok_to_put_new_char


def get_hash_starting_from_index(aoc_input, index, password, task_number):
    found_hash_for_this_count = False

    while not found_hash_for_this_count:
        # Create a hashing object
        hasher = hashlib.md5()

        # Create the bytes object used to hash
        # For example, if input is 'abc' and counter is 5, the string is 'abc5' and it is casted to byte object
        string_to_use = aoc_input + str(index)
        bytes_object = string_to_use.encode()

        # Update and digest the hasher - this will give the hexadecimal hash as a string
        hasher.update(bytes_object)
        hex_string = hasher.hexdigest()

        if hex_string[0:5] == '00000':
            found_hash_for_this_count = True
            print('Interesting hash at {}'.format(index))

            if task_number == 1:
                password += hex_string[5]
                print('Password: ' + password)

            else:
                if is_ok_to_put_new_char(hex_string, password):
                    password[int(hex_string[5])] = hex_string[6]
                    print('Password: ' + ''.join(password))

        index += 1

        if index % 1000000 == 0:
            print(index)

    return [index, password]


def get_password(aoc_input, task_number):
    index = 0
    if task_number == 1:
        # For task 1, we start with an empty password and append each new character
        password = ''

        for counter in range(8):
            [index, password] = get_hash_starting_from_index(aoc_input, index, password, 1)

    elif task_number == 2:
        # For task 2, we start with 8 slots in the password, and then we fill them up
        password = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

        while ' ' in password:
            # This while-loop keeps going until we fill all places (i.e. until there are no spaces left)
            [index, password] = get_hash_starting_from_index(aoc_input, index, password, 2)

    return password


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = 'uqwqemis'
    password_1 = get_password(aoc_input, 1)
    password_2 = get_password(aoc_input, 2)

    print('Part 1: {}'.format(password_1))
    print('Part 2: {}'.format(''.join(password_2)))


if __name__ == '__main__':
    main()
