#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

# Go to the folder where docker-compose.yaml is
cd /home/ec2-user

# Pull latest images
docker-compose -f docker-compose.yaml pull

# Start or restart containers
docker-compose -f docker-compose.yaml up -d

# Show status
docker-compose -f docker-compose.yaml ps

echo "Deployment successful ✅"
