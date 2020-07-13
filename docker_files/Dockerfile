FROM debian:stable-slim
RUN apt update
RUN apt install -y python3 git ssh cron python3-requests gitweb lighttpd
COPY . /
COPY docker_files/github_mirrorer.cronjob /etc/cron.d/github_mirrorer
COPY docker_files/github.pubkey /root/.ssh/known_hosts
COPY docker_files/gitweb.conf /etc/gitweb.conf
RUN chmod 0644 /etc/cron.d/github_mirrorer
RUN crontab /etc/cron.d/github_mirrorer
RUN touch /var/log/cron.log


VOLUME "/repos"

#ENTRYPOINT cd /github_mirrorer/ && ./get_repos.py  && bash
#ENTRYPOINT cd / && ./get_repos.py && ./mirror_repos.sh && cron
ENTRYPOINT /docker_files/entrypoint.sh

