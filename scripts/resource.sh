#!/bin/bash

# Set environment variables (Modify as needed)
POSTGRES_CONTAINER="postgres_container"
REDIS_CONTAINER="redis_container"
POSTGRES_IMAGE="postgres:latest"
REDIS_IMAGE="redis:latest"
POSTGRES_USER="admin"
POSTGRES_PASSWORD="password"
POSTGRES_DB="mydatabase"
POSTGRES_PORT="5432"
REDIS_PORT="6379"

# Check if PostgreSQL container is already running
if [ "$(docker ps -q -f name=$POSTGRES_CONTAINER)" ]; then
    echo "PostgreSQL container is already running."
else
    echo "Starting PostgreSQL container..."
    docker run -d --name $POSTGRES_CONTAINER \
        -e POSTGRES_USER=$POSTGRES_USER \
        -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
        -e POSTGRES_DB=$POSTGRES_DB \
        -p $POSTGRES_PORT:5432 \
        -v pg_data:/var/lib/postgresql/data \
        --restart unless-stopped \
        $POSTGRES_IMAGE
fi

# Check if Redis container is already running
if [ "$(docker ps -q -f name=$REDIS_CONTAINER)" ]; then
    echo "Redis container is already running."
else
    echo "Starting Redis container..."
    docker run -d --name $REDIS_CONTAINER \
        -p $REDIS_PORT:6379 \
        -v redis_data:/data \
        --restart unless-stopped \
        $REDIS_IMAGE
fi

echo "PostgreSQL and Redis are running."
