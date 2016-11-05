FROM ubuntu:16.04
MAINTAINER Joseph Salisbury <salisbury.joseph@gmail.com>

RUN apt-get -y update

RUN apt-get -y install \
    curl=7.47.0-1ubuntu2.2 \
    dnsutils=1:9.10.3.dfsg.P4-8ubuntu1.2 \
    git=1:2.7.4-0ubuntu1 \
    iputils-ping=3:20121221-5ubuntu2 \
    sudo=1.8.16-0ubuntu1 \
    vim=2:7.4.1689-3ubuntu1.1

RUN curl -sS https://storage.googleapis.com/kubernetes-release/release/v1.4.3/bin/linux/amd64/kubectl -o /bin/kubectl \
    && chmod +x /bin/kubectl

RUN useradd -ms /bin/bash joseph

COPY ./config/bash/bashrc /home/joseph/.bashrc
COPY ./config/bash/git_prompt.sh /home/joseph/.git_prompt.sh

COPY ./config/git/gitconfig /home/joseph/.gitconfig
COPY ./config/git/gittemplate /home/joseph/.gittemplate

COPY ./config/sudo/joseph /etc/sudoers.d/joseph

RUN chown -R joseph:joseph /home/joseph/
ENV HOME /home/joseph/
USER joseph

ENTRYPOINT ["/bin/bash"]
