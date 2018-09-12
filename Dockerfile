FROM circleci/node:9
LABEL maintainer="marlonbrgomes@gmail.com"

RUN sudo apt-get update \
	&& sudo apt-get install -y \
		ruby ruby-dev \
	&& sudo rm -rf /var/lib/apt/lists/*

RUN sudo gem install bundler

RUN sudo add-apt-repository ppa:webupd8team/java -y && \
    sudo apt-get update && \
    sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    sudo apt-get install -y oracle-java8-installer && \
    sudo apt-get clean
