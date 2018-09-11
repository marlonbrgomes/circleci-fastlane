FROM circleci/node:9
LABEL maintainer="marlonbrgomes@gmail.com"

RUN sudo apt-get update \
	&& sudo apt-get install -y \
		ruby ruby-dev \
	&& sudo rm -rf /var/lib/apt/lists/*

RUN sudo gem install bundler
