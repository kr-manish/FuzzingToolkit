FROM ubuntu:20.04

LABEL maintainer="Manish Kumar"

USER root

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    vim \
    wget

RUN apt-get install -y \
    curl \
    make \
    whois \
    python \
    python3 python3-pip \
    perl \
    clang-6.0 \
    && rm -rf /var/lib/apt/lists/*

# Install python-pip
WORKDIR /root
RUN curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
RUN python get-pip.py

# This is for tzdata module which asks for user input but hangs after providing data
# To avoid user interaction
ENV DEBIAN_FRONTEND="noninteractive"

# AFL
RUN apt-get update && apt-get install -y \
	clang-6.0 llvm-6.0-dev libssl-dev cgroup-tools sudo \
	autopoint bison gperf autoconf texinfo gettext \
	libtool pkg-config libz-dev openssh-server \
	man manpages-posix-dev lldb gdb

RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata


# RUN apt-get install -y afl
RUN git clone https://github.com/google/AFL.git && cd AFL && make && make install

RUN mkdir targets

CMD /bin/bash
