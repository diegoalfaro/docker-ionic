FROM beevelop/ionic
LABEL maintainer=dhalfaro

# Configurating Android SDK Manager
ENV PATH='/opt/android/bin:/opt/android/tools/bin:${PATH}'
RUN yes | sdkmanager --update
RUN yes | sdkmanager --licenses

# Installing cordova-res
RUN npm i -g cordova-res --unsafe-perm

# Fix for non ASCII characters and gradle
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

WORKDIR /project

EXPOSE 8100