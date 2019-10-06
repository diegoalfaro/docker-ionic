FROM beevelop/ionic
LABEL maintainer=dhalfaro

# Update PATH environment variable
ENV PATH="/opt/android/bin:/opt/android/tools/bin:${PATH}"

# Configure Android SDK Manager
RUN yes | sdkmanager --update
RUN yes | sdkmanager --licenses

WORKDIR /project

EXPOSE 8100