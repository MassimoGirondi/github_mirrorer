FROM debian:stable-slim
RUN apt update
RUN apt install -y python3 git ssh cron python3-requests
COPY . /
COPY github_mirrorer.cronjob /etc/cron.d/github_mirrorer
COPY github.pubkey /root/.ssh/known_hosts

RUN chmod 0644 /etc/cron.d/github_mirrorer
RUN crontab /etc/cron.d/github_mirrorer


VOLUME "/repos"
#VOLUME "/repos.list"
#VOLUME "/root/.ssh/id_rsa"
#VOLUME "/SECRET"

#ENTRYPOINT cd /github_mirrorer/ && ./get_repos.py  && bash
ENTRYPOINT cd / && ./get_repos.py && ./mirror_repos.sh && cron

