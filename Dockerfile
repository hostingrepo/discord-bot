FROM ubuntu:18.04

MAINTAINER David Razdolski, <admin@unreliable.site>

    # Initial update & upgrade
RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && useradd -d /home/container -m container
    
    # Grant sudo permissions to container user for commands
RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo


    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # Python 2 & 3
RUN apt -y install python python-pip python3 python3-pip python3.7

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

USER docker
CMD ["/bin/bash", "/entrypoint.sh"]
