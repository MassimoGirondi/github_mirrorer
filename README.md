# GitHub repositories mirrorer

A simple script to mirror your GitHub repositories to the local disk.
This script create a full copy of your repositories, maintaining two copies (to avoid losses in case of errors).

# Setup

Create a `SECRET` file in this directory with your username and token.

The token can be obtained at [this page](https://github.com/settings/tokens).
Select the `repo` option.

Example of the SECRET file:
```
MassimoGirondi:GitHub_personal_access_token
```

Your SSH agent must be configured to access to GitHub with a public ssh key.
[Read more here](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).


# Usage

* Execute `get_repos.py` to obtain the list of your repositories (both public, private and repos to which you have access)
* Execute `mirror_repos.sh` to mirror all your repositories

## Crontab example

You can automatize the scripts with crontab. For example, to have a backup every hour and an update to the repositories list once a day:

```
@daily cd your_path && ./get_repos.py >> log.txt'
@hourly cd your_path && ./mirror_repos.sh >> log.txt'
```

# Docker 

A docker version is provided to run everything in a standalone container.

* Create the `SECRET` file as above
* Copy (or better, generate with `ssh-keygen -f github_mirrorer`) a SSH key and copy the private one in this directory.
* `docker-compose build` will generate the container image (if you don't want to pull mine :P)
* `docker-compose up` will start the container

The file `github.pubkey` contains the public key of GitHub published [here](https://docs.github.com/en/github/authenticating-to-github/githubs-ssh-key-fingerprints). This is needed to verify that the client is talking with the legitimate GitHub server.


# License

The code on this repository is licensed under the GNU Public License v3, see [LICENSE](LICENSE) to know more.

