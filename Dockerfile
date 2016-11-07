FROM ubuntu:16.04
MAINTAINER Joseph Salisbury <salisbury.joseph@gmail.com>

RUN apt-get -y update

RUN apt-get -y install \
    apt-transport-https=1.2.10ubuntu1 \
    ca-certificates=20160104ubuntu1

RUN apt-key adv \
    --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list

RUN apt-get -y update

RUN apt-get -y install \
    build-essential=12.1ubuntu2 \
    curl=7.47.0-1ubuntu2.2 \
    dnsutils=1:9.10.3.dfsg.P4-8ubuntu1.2 \
    docker-engine=1.11.1-0~xenial \
    git=1:2.7.4-0ubuntu1 \
    iputils-ping=3:20121221-5ubuntu2 \
    sudo=1.8.16-0ubuntu1 \
    tmux=2.1-3build1 \
    vim=2:7.4.1689-3ubuntu1.1 \
    wget=1.17.1-1ubuntu1.1

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
