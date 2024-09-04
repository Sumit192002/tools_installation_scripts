FROM ubuntu:20.04

USER root

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    sudo \
    vim \
    wget \
    curl \
    python3-dev \
    python3-pip \
    libffi-dev \
    gcc \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libmysqlclient-dev \
    libpq-dev \
    libsqlite3-dev \
    python3-venv \
    python3-setuptools \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Set up DevStack
RUN useradd -s /bin/bash -d /opt/stack -m stack && echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN git clone https://opendev.org/openstack/devstack /opt/stack/devstack

# Set up DevStack configuration
RUN echo -e "ADMIN_PASSWORD=secret\nDATABASE_PASSWORD=secret\nRABBIT_PASSWORD=secret\nSERVICE_PASSWORD=secret\nHOST_IP=127.0.0.1" > /opt/stack/devstack/local.conf

# Set permissions
RUN chown -R stack:stack /opt/stack/devstack

# Set working directory
WORKDIR /opt/stack/devstack

USER stack

