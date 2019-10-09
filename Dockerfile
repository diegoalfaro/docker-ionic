FROM beevelop/ionic
LABEL maintainer=dhalfaro

# Configurating Android SDK Manager
ENV PATH='/opt/android/bin:/opt/android/tools/bin:${PATH}'
RUN yes | sdkmanager --update
RUN yes | sdkmanager --licenses

# Installing cordova-res
RUN npm i -g cordova-res --unsafe-perm

WORKDIR /project

EXPOSE 8100