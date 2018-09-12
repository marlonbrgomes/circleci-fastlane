FROM circleci/node:9
LABEL maintainer="marlonbrgomes@gmail.com"

RUN sudo apt-get update \
	&& sudo apt-get install -y \
		ruby ruby-dev \
	&& sudo rm -rf /var/lib/apt/lists/*

RUN sudo gem install bundler

RUN apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean
