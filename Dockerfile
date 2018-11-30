FROM circleci/node:8
LABEL maintainer="marlonbrgomes@gmail.com"

RUN sudo apt-get update \
	&& sudo apt-get install -y \
		ruby ruby-dev \
    && sudo apt-get install apt-utils \
	&& sudo rm -rf /var/lib/apt/lists/*

RUN sudo gem install bundler

# Setup JAVA_HOME
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Install Oracle JDK (Java SE Development Kit) 8u192 with Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files for JDK/JRE 8
RUN JAVA_VERSION=8 && \
    JAVA_UPDATE=192 && \
    JAVA_BUILD=12 && \
    JAVA_PATH=750e1c8617c5452694857ad95c3ee230 && \
    JAVA_SHA256_SUM=6d34ae147fc5564c07b913b467de1411c795e290356538f22502f28b76a323c2 && \
    JCE_SHA256_SUM=f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59 && \ 
    sudo apt-get update && \
    sudo apt-get -y install wget unzip && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    echo "${JAVA_SHA256_SUM}" "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" | sha256sum -c - && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" && \
    echo "${JCE_SHA256_SUM}" "jce_policy-${JAVA_VERSION}.zip" |sha256sum -c - && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    sudo mkdir -p "/usr/lib/jvm" && \
    sudo mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    sudo ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    sudo ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    sudo unzip -jo -d "$JAVA_HOME/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" && \    
    sudo apt-get -y clean