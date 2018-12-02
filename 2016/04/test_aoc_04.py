""" test_aoc_04.py

    Test for Advent of Code 2016
"""

import aoc_04
import aoc_04_input

TEST_INPUT = """SOMETHING"""


def test_rooms():
    room_1 = 'aaaaa-bbb-z-y-x-123[abxyz]'
    room_2 = 'a-b-c-d-e-f-g-h-987[abcde]'
    room_3 = 'not-a-real-room-404[oarel]'
    room_4 = 'totally-real-room-200[decoy]'

    all_rooms = [room_1, room_2, room_3, room_4]

    actual = aoc_04.get_sum_of_real_rooms(all_rooms)
    expected = 1514

    assert actual == expected


def test_room_decryption():
    room = 'qzmt-zixmtkozy-ivhz-343[abcde]'
    decrypted_room = aoc_04.decrypt_one_room(room)

    expected = 'very encrypted name'

    assert decrypted_room == expected
