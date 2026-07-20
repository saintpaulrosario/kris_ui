# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.29.3 AS build

# Set the working directory
WORKDIR /app

# Copy the Flutter project files into the container
COPY . /app

# Ensure Flutter dependencies are up-to-date
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs

# Build the Flutter app (for web) with the active profile
# Default profile if none is provided
# ARG ACTIVE_PROFILE=local
# RUN flutter build web --dart-define=ACTIVE_PROFILE=$ACTIVE_PROFILE

RUN flutter build web

# Stage 2: Set up Nginx to serve the Flutter web app
FROM nginx:alpine

# Copy the build output to Nginx's default HTML location
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]