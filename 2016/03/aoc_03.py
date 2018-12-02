""" aoc_03.py

    Solution for Advent of Code 2016
"""

import aoc_03_input


def triangle_is_possible(triangle):
    side1 = int(triangle[0])
    side2 = int(triangle[1])
    side3 = int(triangle[2])

    side1_possible = (side1 < side2 + side3)
    side2_possible = (side2 < side1 + side3)
    side3_possible = (side3 < side1 + side2)

    return side1_possible and side2_possible and side3_possible


def calculate_number_of_possible_triangles(triangle_list):
    total_possible = 0
    for triangle in triangle_list:
        if triangle_is_possible(triangle):
            total_possible += 1

    return total_possible


def calculate_number_of_possible_triangles_task2(triangle_list):
    total_possible = 0
    for k in range(0, len(triangle_list), 3):
        # k is every third row in triangle_list
        row1 = triangle_list[k]
        row2 = triangle_list[k+1]
        row3 = triangle_list[k+2]

        triangle1 = [row1[0], row2[0], row3[0]]
        triangle2 = [row1[1], row2[1], row3[1]]
        triangle3 = [row1[2], row2[2], row3[2]]

        if triangle_is_possible(triangle1):
            total_possible += 1

        if triangle_is_possible(triangle2):
            total_possible += 1

        if triangle_is_possible(triangle3):
            total_possible += 1

    return total_possible


def main():
    """ main()

        Main function that use the input from Advent of Code and print the
        answer to the problems for day one.
    """
    aoc_input = aoc_03_input.get_input()

    total_triangles_possible = calculate_number_of_possible_triangles(aoc_input)
    total_triangles_possible_task2 = calculate_number_of_possible_triangles_task2(aoc_input)

    print('Part 1: {}'.format(total_triangles_possible))
    print('Part 2: {}'.format(total_triangles_possible_task2))


if __name__ == '__main__':
    main()
