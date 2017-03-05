FROM ubuntu:16.04
# LTS - Xenial Xerus
MAINTAINER Joseph Salisbury <salisbury.joseph@gmail.com>

RUN apt-get -y update

RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    software-properties-common

RUN apt-key adv \
    --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
RUN add-apt-repository --yes ppa:masterminds/glide

RUN apt-get -y update

RUN apt-get -y install \
    bash-completion=1:2.1-4.2ubuntu1.1 \
    build-essential=12.1ubuntu2 \
    command-not-found=0.3ubuntu16.04.2 \
    curl=7.47.0-1ubuntu2.2 \
    dnsutils=1:9.10.3.dfsg.P4-8ubuntu1.5 \
    docker-engine=1.11.1-0~xenial \
    git=1:2.7.4-0ubuntu1 \
    glide=0.12.3~xenial \
    iputils-ping=3:20121221-5ubuntu2 \
    sudo=1.8.16-0ubuntu1 \
    tmux=2.1-3build1 \
    unzip=6.0-20ubuntu1 \
    vim=2:7.4.1689-3ubuntu1.2 \
    wget=1.17.1-1ubuntu1.1

RUN wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz -qO- | tar xzf - \
    && mv ./go /usr/local/

RUN useradd -ms /bin/bash joseph

RUN curl -sS https://storage.googleapis.com/kubernetes-release/release/v1.4.3/bin/linux/amd64/kubectl -o /bin/kubectl \
    && chmod +x /bin/kubectl
RUN wget https://github.com/coreos/etcd/releases/download/v3.0.16/etcd-v3.0.16-linux-amd64.tar.gz -qO- | tar xzf - etcd-v3.0.16-linux-amd64/etcdctl \
    && chmod +x ./etcd-v3.0.16-linux-amd64/etcdctl \
    && mv ./etcd-v3.0.16-linux-amd64/etcdctl /bin/etcdctl \
    && rm -rf ./etcd-v3.0.16-linux-amd64
RUN wget https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz -qO- | tar xzf - hub-linux-amd64-2.2.9/bin/hub hub-linux-amd64-2.2.9/etc/hub.bash_completion.sh \
    && chmod +x ./hub-linux-amd64-2.2.9/bin/hub && mv ./hub-linux-amd64-2.2.9/bin/hub /bin/hub \
    && mv ./hub-linux-amd64-2.2.9/etc/hub.bash_completion.sh /home/joseph/.hub-completion.bash \
    && rm -rf ./hub-linux-amd64-2.2.9/

RUN curl -sS https://raw.githubusercontent.com/git/git/1310affe024fba407bff55dbe65cd6d670c8a32d/contrib/completion/git-completion.bash -o /home/joseph/.git-completion.bash \
    && chmod +x /home/joseph/.git-completion.bash

COPY ./config/bash/bashrc /home/joseph/.bashrc
COPY ./config/bash/git_prompt.sh /home/joseph/.git_prompt.sh

COPY ./config/git/gitconfig /home/joseph/.gitconfig
COPY ./config/git/gittemplate /home/joseph/.gittemplate

COPY ./config/sudo/joseph /etc/sudoers.d/joseph

COPY ./config/tmux/tmux.conf /home/joseph/.tmux.conf

COPY ./config/vim/vimrc /home/joseph/.vimrc

RUN chown -R joseph:joseph /home/joseph/
ENV HOME /home/joseph/
USER joseph

ENTRYPOINT ["/usr/bin/tmux"]

