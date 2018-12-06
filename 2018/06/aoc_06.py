""" aoc_06.py

    Solution for Advent of Code 2018
"""

import aoc_06_input


def get_shortest_manhattan(list_of_points, x, y):

    min_distance = 100000
    key_of_min = 0
    is_tied = False
    for (dict_x, dict_y) in list_of_points:
        this_dist = abs(x - dict_x) + abs(y - dict_y)

        if this_dist < min_distance:
            is_tied = False
            key_of_min = (dict_x, dict_y)
            min_distance = this_dist
        elif this_dist == min_distance:
            is_tied = True

    return key_of_min, is_tied


def get_total_distance(aoc_input, x, y):
    total_distance = 0

    for (list_x, list_y) in aoc_input:
        this_dist = abs(x - list_x) + abs(y - list_y)
        total_distance += this_dist

    return total_distance


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_06_input.get_input()
    #aoc_input = [(1, 1), (1, 6), (8, 3), (3, 4), (5, 5), (8, 9)]

    most_left = 10000
    most_right = -10000
    most_up = -10000
    most_down = 10000

    for (x, y) in aoc_input:
        if x < most_left:
            most_left = x

        if x > most_right:
            most_right = x

        if y > most_up:
            most_up = y

        if y < most_down:
            most_down = y

    # Create a list with non-infinite points
    non_infinite_points = dict()
    for (x, y) in aoc_input:
        if x > most_left and x < most_right and y < most_up and y > most_down:
            non_infinite_points[(x, y)] = 0

    list_of_areas_on_border = []
    for x in range(most_left, most_right):
        for y in range(most_down, most_up):
            (dict_key, is_tied) = get_shortest_manhattan(aoc_input, x, y)

            if not is_tied:
                if x == most_left or x == most_right or y == most_up or y == most_down:
                    if dict_key not in list_of_areas_on_border:
                        list_of_areas_on_border.append(dict_key)
            if not is_tied and dict_key in non_infinite_points:
                non_infinite_points[dict_key] += 1

    for dict_key in list_of_areas_on_border:
        non_infinite_points[dict_key] = 0

    maximum_area = max(non_infinite_points, key=non_infinite_points.get)

    # Task 2
    total_region_area = 0
    for x in range(most_left- 10, most_right + 10):
        #print(x)
        for y in range(most_down - 10, most_up + 10):
            this_dist = get_total_distance(aoc_input, x, y)
            if this_dist < 10000:
                total_region_area += 1

    print('Part 1: {}'.format(non_infinite_points[maximum_area]))
    print('Part 2: {}'.format(total_region_area))


if __name__ == '__main__':
    main()
