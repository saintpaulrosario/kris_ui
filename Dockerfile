FROM ubuntu:24.04 AS build

# Install dependencies
RUN apt update && apt install -y \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git \
    -b 3.44.2 \
    --depth 1 \
    /flutter

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:$PATH"

# Enable web support
RUN flutter config --enable-web
RUN flutter precache --web

RUN flutter --version

WORKDIR /app

# Copy application
COPY . .

# Install packages
RUN flutter pub get

# Generate code (json_serializable, retrofit, etc.)
RUN dart run build_runner build --delete-conflicting-outputs

# Build arguments
ARG ACTIVE_PROFILE=local
ARG KRIS_BASE_URL=https://dev-kris.onrender.com

# Build Flutter web
RUN flutter build web \
    --release \
    --dart-define=ACTIVE_PROFILE=${ACTIVE_PROFILE} \
    --dart-define=KRIS_BASE_URL=${KRIS_BASE_URL}


# Production nginx image
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]