ARG JDXI_MANAGER_VERSION=0.5.0

FROM debian:latest AS builder
MAINTAINER David Wozniak

ENV JDXI_MANAGER_URL http://jdxi-manager.linuxtech.net/files/jdxi_manager-linux.zip

# Install prerequisites
RUN apt-get update && \
    apt-get -y install \
        bsdtar \
        build-essential \
        curl \
        libasound2-dev \
        libconfig-simple-perl \
        libgd-perl \
        libtime-hr-perl \
        libwww-perl \
        perl-tk && \
    rm -rf /var/lib/apt/lists/*

RUN PERL_MM_USE_DEFAULT=1 cpan -fi MIDI::ALSA

# Download and unzip 
RUN curl -o /tmp/jdxi_manager.zip -L "${JDXI_MANAGER_URL}" && \
    mkdir /opt/jdxi_manager && cd /opt/jdxi_manager  && \
    bsdtar --strip-components=1 -xvf /tmp/jdxi_manager.zip

CMD [ "/opt/jdxi_manager/jdxi_manager.pl" ]
