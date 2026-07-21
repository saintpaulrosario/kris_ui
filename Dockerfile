FROM ubuntu:24.04 AS build

RUN apt update && apt install -y \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flutter/flutter.git \
    -b 3.44.2 \
    --depth 1 \
    /flutter

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:$PATH"

RUN flutter --version

WORKDIR /app

# Copy the Flutter project files into the container
COPY . /app

RUN flutter pub get

COPY . .

RUN dart run build_runner build --delete-conflicting-outputs

ARG ACTIVE_PROFILE=develop
ARG ENVIRONMENT=web
ARG KRIS_BASE_URL=https://dev-kris.onrender.com

RUN flutter build web \
    --dart-define=ACTIVE_PROFILE=${ACTIVE_PROFILE} \
    --dart-define=ENVIRONMENT=${ENVIRONMENT} \
    --dart-define=KRIS_BASE_URL=${KRIS_BASE_URL}

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]