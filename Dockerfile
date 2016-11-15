FROM ubuntu:16.04

MAINTAINER KITAGAWA Tatsuya

# yatatsu/android

# sudo
RUN apt-get update \
  && apt-get -y install sudo \
  && useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# 32bit
RUN sudo apt-get -y install lib32stdc++6 lib32z1

# jdk
RUN apt-get install -y software-properties-common curl \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk

# download Android SDK
RUN sudo apt-get -y install wget \
  && cd /usr/local \
  && wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
  && tar zxvfo android-sdk_r24.4.1-linux.tgz \
  && rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz

# env
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

# update
RUN echo y | android update sdk --no-ui --all --filter "android-24,build-tools-24.0.1" \
  && echo y | android update sdk --no-ui --all --filter "extra-google-m2repository,extra-android-m2repository"