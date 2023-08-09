#!/usr/bin/python3
"""Defines a function, `number_of_subscribers`"""
import requests


def number_of_subscribers(subreddit):
    """
    Return the number of subscribers (not active users, total
    subscribers) for a given subreddit
    """

    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    res = requests.get(url)
    if res.status_code == 200:
        return res.json()["data"]["subscribers"]
    return 0
