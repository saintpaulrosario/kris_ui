# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.44.7 AS build

WORKDIR /app

COPY . /app

RUN flutter --version

RUN flutter pub get

RUN flutter pub run build_runner build --delete-conflicting-outputs

RUN flutter build web

# Stage 2: Serve with nginx
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]