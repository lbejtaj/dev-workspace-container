FROM ubuntu:16.10
MAINTAINER Joseph Salisbury <salisbury.joseph@gmail.com>

RUN apt-get -y update

RUN apt-get -y install curl=7.50.1-1ubuntu1.1
RUN apt-get -y install dnsutils=1:9.10.3.dfsg.P4-10.1ubuntu1.1
RUN apt-get -y install git=1:2.9.3-1
RUN apt-get -y install iputils-ping=3:20150815-2ubuntu3
RUN apt-get -y install sudo=1.8.16-0ubuntu3
RUN apt-get -y install vim=2:7.4.1829-1ubuntu2

RUN curl https://storage.googleapis.com/kubernetes-release/release/v1.4.3/bin/linux/amd64/kubectl -o /bin/kubectl \
    && chmod +x /bin/kubectl

RUN useradd -ms /bin/bash joseph
RUN mkdir /home/joseph/bin/

COPY ./config/bash/bashrc /home/joseph/.bashrc
COPY ./config/bash/git_prompt.sh /home/joseph/.git_prompt.sh

COPY ./config/git/gitconfig /home/joseph/.gitconfig
COPY ./config/git/gittemplate /home/joseph/.gittemplate

COPY ./config/sudo/joseph /etc/sudoers.d/joseph

RUN chown -R joseph:joseph /home/joseph/
ENV HOME /home/joseph/
USER joseph

ENTRYPOINT ["/bin/bash"]
