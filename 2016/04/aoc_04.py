""" aoc_04.py

    Solution for Advent of Code 2016
"""

import aoc_04_input
import re


def separate_id_and_checksum(id_and_checksum):
    id_list = re.findall('\d+', id_and_checksum)
    sector_id = id_list[0]

    checksum_list = re.findall('[a-z]+', id_and_checksum)
    checksum = checksum_list[0]

    return [sector_id, checksum]


def create_room_dictionary(room):
    all_strings = room.split('-')

    # The last string is the sector ID and the checksum - remove these
    id_and_checksum = all_strings.pop()

    [sector_id, checksum] = separate_id_and_checksum(id_and_checksum)

    room_dict = dict()

    for word in all_strings:
        for letter in word:
            room_dict[letter] = room_dict.get(letter, 0) + 1

    return [room_dict, sector_id, checksum]


def check_room(room):
    """
    Example room: aaaaa-bbb-z-y-x-123[abxyz]

    :param room:
    :return:
    """
    [room_dictionary, sector_id, checksum] = create_room_dictionary(room)

    # To check the checksum, we check each count for each letter, and make sure that it is less than or equal than
    # the previous one.
    # If the are equal, we must make sure that they are in alphabetical order
    previous_count = float('inf')
    previous_ascii_value = 0
    is_real_room = True

    for letter in checksum:
        letter_count = room_dictionary.get(letter, 0)

        # If there is no occurrence of the checksum letter in the room, it is a decoy room
        if letter_count == 0:
            is_real_room = False

        # If there are increasing occurences in letters, it is a decoy room
        if letter_count > previous_count:
            is_real_room = False

        # If there is a tie and the letters are not alphabetically ordered, it is a decoy room
        ascii_value_of_letter = ord(letter)
        if letter_count == previous_count:
            if ascii_value_of_letter < previous_ascii_value:
                is_real_room = False

        previous_count = letter_count
        previous_ascii_value = ascii_value_of_letter

    return [is_real_room, sector_id]


def get_sum_of_real_rooms(aoc_input):
    total_sector_id_sum = 0

    for room in aoc_input:
        [is_real_room, sector_id] = check_room(room)
        if is_real_room:
            total_sector_id_sum += int(sector_id)

    return total_sector_id_sum


def shift_letter(letter, number_of_times_to_shift):
    # 'a' is 97 in ascii
    # 'z' is 122 in ascii
    # In other words, 122 + 1 should be 97
    ascii_code = ord(letter)

    # We create a "temporary" ascii code, where 'a' = 0 and 'z' = 25
    temporary_ascii_value = ascii_code - 97

    # Now, we can add the shift-value, and then take modulo 26 to get the new "temporary ascii" value we want
    temporary_ascii_value = (temporary_ascii_value + number_of_times_to_shift) % 26

    # We transfer back to ordinary ascii values by adding 97
    shifted_ascii_code = temporary_ascii_value + 97

    # Return the letter corresponding to this ascii value
    return chr(shifted_ascii_code)


def decrypt_one_room(room):
    decrypted_room = ''

    [room_dictionary, sector_id, checksum] = create_room_dictionary(room)

    for letter in room:
        if letter == '-':
            decrypted_room += ' '

        else:
            number_of_times_to_shift = int(sector_id)

            new_letter = shift_letter(letter, number_of_times_to_shift)
            decrypted_room += new_letter

    return [decrypted_room, sector_id]


def find_north_pole_storage(aoc_input):

    for room in aoc_input:
        [decrypted_room, sector_id] = decrypt_one_room(room)

        if 'north' in decrypted_room:
            return sector_id


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_04_input.get_input()
    total_sum_of_real_rooms = get_sum_of_real_rooms(aoc_input)

    sector_id = find_north_pole_storage(aoc_input)

    print('Part 1: {}'.format(total_sum_of_real_rooms))
    print('Part 2: ' + sector_id)


if __name__ == '__main__':
    main()
