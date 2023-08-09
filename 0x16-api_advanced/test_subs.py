#!/bin/python3
"""Tests 0-subs.py"""
subs = __import__('0-subs')


def test():
    import sys

    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <subreddit>")
        exit(1)

    print(subs.number_of_subscribers(sys.argv[1]))


if __name__ == "__main__":
    test()
