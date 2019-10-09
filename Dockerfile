FROM beevelop/ionic
LABEL maintainer=dhalfaro

# Configurating npm-global path
RUN mkdir /npm-global
RUN chmod 777 -R /npm-global
RUN npm config set prefix '/npm-global'

# Installing cordova-res
RUN npm i -g cordova-res --unsafe-perm

# Update PATH environment variable
ENV PATH='/npm-global/bin:/opt/android/bin:/opt/android/tools/bin:${PATH}'

# Configurating Android SDK Manager
RUN yes | sdkmanager --update
RUN yes | sdkmanager --licenses

WORKDIR /project

EXPOSE 8100