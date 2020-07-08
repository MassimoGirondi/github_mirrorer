#!/usr/bin/env python3
import requests
import json
import sys

from pathlib import Path
Path("repos").mkdir(parents=True, exist_ok=True)

#URL="https://api.github.com/user/repos"
URL="https://api.github.com/user/repos"

with open("SECRET") as secret_file:
    user,token=secret_file.read().strip().split(":")


r=requests.get(URL, auth=(user,token),
        params={"sort": "updated",
            "per_page": 100})
repos=r.json()

# If there is pagination, requests all the pages
while 'next' in r.links.keys():
  r=requests.get(r.links['next']['url'],
          auth=(user,token))
  repos.extend(r.json())


# First argument can contain a path
if len(sys.argv) == 2:
    path=sys.argv[1]
else:
    path="."

with open(path+"/repos/repos.list", "w") as repos_list:
    for r in repos:
        line= r["full_name"] + " " + r["ssh_url"]
        print(line)
        repos_list.write(line+"\n")
        

