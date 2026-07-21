FROM ubuntu:24.04 AS build

RUN apt update && apt install -y \
    git curl unzip xz-utils zip libglu1-mesa

RUN git clone https://github.com/flutter/flutter.git \
    -b 3.44.2 /flutter

ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:$PATH"

RUN flutter --version

WORKDIR /app

COPY . .

RUN flutter pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN flutter build web --release

ARG ACTIVE_PROFILE=local
RUN flutter build web --dart-define=ACTIVE_PROFILE=$ACTIVE_PROFILE

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]