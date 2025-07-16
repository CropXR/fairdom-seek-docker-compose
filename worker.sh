#!/bin/bash
set -e

echo "Waiting for database to be ready..."
while ! mysqladmin ping -h ${DATABASE_HOST} -u ${DATABASE_USERNAME} -p${DATABASE_PASSWORD} --silent; do
    echo "Database not ready, waiting..."
    sleep 5
done

echo "Database is ready!"

echo "Waiting for main application to be ready..."
sleep 30

echo "Starting background job worker..."
exec bundle exec rake jobs:work
