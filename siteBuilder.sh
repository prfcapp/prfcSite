#!/bin/bash

# Set variables
IMAGE_NAME="profile-website"
CONTAINER_NAME="profile-website-container"
HOST_PORT=8080
DOCKERFILE_PATH="./Dockerfile"
SRC_PATH="./src"

# Function to build the Docker image
build_image() {
    echo "Building Docker image..."
    sudo docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .
}

# Function to run the Docker container
run_container() {
    echo "Running Docker container..."
    sudo docker run -d -p $HOST_PORT:80 --name $CONTAINER_NAME $IMAGE_NAME
}

# Function to stop and remove the Docker container
stop_container() {
    echo "Stopping and removing Docker container..."
    sudo docker stop $CONTAINER_NAME
    sudo docker rm $CONTAINER_NAME
}

# Function to refresh the Docker container
refresh_container() {
    echo "Refreshing Docker container..."
    stop_container
    build_image
    run_container
}

# Parse command line arguments
BUILD=false
STOP=false
REFRESH=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --build) BUILD=true ;;
        --stop) STOP=true ;;
        --refresh) REFRESH=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Execute build if flag is set
if [ "$BUILD" = true ]; then
    build_image
fi

# Stop container if stop flag is set
if [ "$STOP" = true ]; then
    stop_container
    exit 0
fi

# Refresh container if refresh flag is set
if [ "$REFRESH" = true ]; then
    refresh_container
    exit 0
fi

# Run the container
run_container