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



#!/bin/bash

# Define the .env content for Service 1
ENV_CONTENT1='DB_HOST="localhost"
DB_PORT="5432"
DB_USER="admin"
DB_PASSWORD="password"
DB_NAME="mydatabase"

REDIS_HOST="localhost"
REDIS_PORT="6379"

PORT="3000"'

# Define the .env content for Service 2
ENV_CONTENT2='DB_HOST="localhost"
DB_PORT="5432"
DB_USER="admin"
DB_PASSWORD="password"
DB_NAME="mydatabase"

REDIS_HOST="localhost"
REDIS_PORT="6379"

PORT="8080"'

# Define the target locations (relative to the project root)
TARGET1="backend/service1/.env"
TARGET2="backend/service2/.env"

# Function to create .env file in a location
create_env_file() {
    local target_path=$1
    local content=$2

    # Go to the project root (assumes the script is inside the project)
    PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")"
    FULL_PATH="$PROJECT_ROOT/$target_path"

    # Ensure the target directory exists
    mkdir -p "$(dirname "$FULL_PATH")"

    # Write the .env content
    echo "$content" > "$FULL_PATH"

    # Confirm success and print the full path
    if [ -f "$FULL_PATH" ]; then
        echo "✅ .env file successfully created at: $(realpath "$FULL_PATH")"
    else
        echo "❌ Failed to create .env at $FULL_PATH" >&2
        exit 1
    fi
}

# Create .env files at both locations with their respective content
create_env_file "$TARGET1" "$ENV_CONTENT1"
create_env_file "$TARGET2" "$ENV_CONTENT2"

echo "🚀 All .env files successfully added!"
