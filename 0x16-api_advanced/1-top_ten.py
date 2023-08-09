#!/usr/bin/python3
"""Defines a function, `number_of_subscribers`"""


def top_ten(subreddit):
    """
    Return the number of subscribers (not active users, total
    subscribers) for a given subreddit
    Args:
        subreddit (str) - subreddit
    """
    import requests

    headers = {"User-Agent": "Python/requests"}
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    res = requests.get(url, headers=headers, allow_redirects=False)
    if res.status_code == 200:
        for i in res.json()['data']['children']:
            print(i['data']['title'])
    else:
        print(None)
