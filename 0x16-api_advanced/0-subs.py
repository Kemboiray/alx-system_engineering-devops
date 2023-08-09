#!/usr/bin/python3
"""Defines a function, `number_of_subscribers`"""
import requests


def number_of_subscribers(subreddit):
    """
    Return the number of subscribers (not active users, total
    subscribers) for a given subreddit
    """
    headers = {"User-Agent": "Python/requests"}
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    res = requests.get(url, headers=headers, allow_redirects=False)
    if res.status_code == 200:
        return res.json()["data"]["subscribers"]
    return 0
