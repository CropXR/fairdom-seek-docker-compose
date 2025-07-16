#!/bin/bash

# Complete FAIRDOM-SEEK Docker Setup
set -e

echo "Completing FAIRDOM-SEEK setup..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "ERROR: .env file not found. Please run ./startup.sh first"
    exit 1
fi

# Build and start services
echo "Building and starting services (this will take 10-15 minutes)..."
docker compose up --build -d

echo "Waiting for services to start..."
sleep 30

# Wait for database to be ready
echo "Waiting for database to be ready..."
while ! docker compose exec -T db mysqladmin ping -h localhost -u root -pseek_root_password --silent 2>/dev/null; do
    echo "Database not ready, waiting..."
    sleep 5
done

echo "Database is ready!"

# Wait for SEEK to be ready
echo "Waiting for SEEK application to be ready..."
sleep 60

# Setup database
echo "Setting up database..."
docker compose exec -T seek bundle exec rake db:migrate || echo "Migration completed or no pending migrations"

# Create admin user
echo "Creating admin user..."
docker compose exec -T seek bundle exec rails runner "
person = Person.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@seek.com'
)

user = User.create!(
  login: 'admin',
  password: 'password123',
  password_confirmation: 'password123',
  person: person
)

user.activate
user.save!

puts 'Admin user created successfully!'
"

echo "Setup complete!"
echo ""
echo "SEEK is now available at: http://localhost:3000"
echo "Login with: admin / password123"
echo ""
echo "To view logs: docker compose logs -f seek"
echo "To restart: docker compose restart"
echo "To stop: docker compose down"