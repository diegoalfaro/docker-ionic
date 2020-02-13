FROM beevelop/android
LABEL maintainer=dhalfaro

USER root

# Environment variables
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"
ENV ANDROID_SDK_ROOT="/opt/android"
ENV ANDROID_HOME="${ANDROID_SDK_ROOT}"
ENV ANDROID_TOOLS_HOME="${ANDROID_SDK_ROOT}/tools"
ENV NODEJS_VERSION=10.16.3
ENV CORDOVA_VERSION 9.0.0
ENV IONIC_VERSION 5.2.3

# Fix for non ASCII characters and gradle
RUN apt update
RUN apt install -y locales
RUN locale-gen en_US.UTF-8

# Configurating Android SDK Manager
ENV PATH="${ANDROID_HOME}:${ANDROID_HOME}/bin:${ANDROID_TOOLS_HOME}:${ANDROID_TOOLS_HOME}/bin:${ANDROID_HOME}/platform-tools:${PATH}"
RUN chmod 777 $ANDROID_HOME
RUN chmod 777 -R $ANDROID_HOME
RUN yes | sdkmanager --update
RUN yes | sdkmanager --licenses

# Installing NodeJS
WORKDIR /opt/node
RUN apt-get update && apt-get install -y curl git ca-certificates --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
ENV PATH="/opt/node/bin:${PATH}"

# Installing Apache Cordova
RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION}

# Installing Cordova resources package
RUN npm i -g --unsafe-perm cordova-res

# Installing Ionic
RUN apt-get update && apt-get install -y git bzip2 openssh-client && \
    npm i -g --unsafe-perm ionic@${IONIC_VERSION} && \
    ionic --no-interactive config set -g daemon.updates false && \
    rm -rf /var/lib/apt/lists/* && apt-get clean

# Change workdir
WORKDIR /project

# Expose development server default port
EXPOSE 8100