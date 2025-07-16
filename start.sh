#!/bin/bash
#!/bin/bash
set -e

export PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"

echo "Waiting for database to be ready..."
while ! mysqladmin ping -h ${DATABASE_HOST} -u ${DATABASE_USERNAME} -p${DATABASE_PASSWORD} --silent; do
    echo "Database not ready, waiting..."
    sleep 5
done

echo "Database is ready!"

echo "Starting SEEK application..."
exec bundle exec rails server -b 0.0.0.0 -p 3000