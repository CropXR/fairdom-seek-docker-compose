#!/bin/bash

# FAIRDOM-SEEK Docker Setup Script
# This script sets up the complete SEEK environment

set -e

echo "🚀 Setting up FAIRDOM-SEEK with Docker..."

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p mysql-init seek-config backups

# Generate secret key if not exists
if [ ! -f .env ]; then
    echo "🔑 Generating secret key..."
    SECRET_KEY=$(openssl rand -hex 64)
    cat > .env << EOF
SECRET_KEY_BASE=$SECRET_KEY
EOF
    echo "Secret key saved to .env file"
fi

# Copy database configuration
echo "📄 Setting up database configuration..."
cp database.yml ./database.yml

# Create initial database setup script
cat > mysql-init/01-init.sql << 'EOF'
-- Create SEEK database and user
CREATE DATABASE IF NOT EXISTS seek_development CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS seek_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS seek_production CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges
GRANT ALL PRIVILEGES ON seek_development.* TO 'seek_user'@'%';
GRANT ALL PRIVILEGES ON seek_test.* TO 'seek_user'@'%';
GRANT ALL PRIVILEGES ON seek_production.* TO 'seek_user'@'%';

-- Create additional user for backups
GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER ON *.* TO 'seek_user'@'%';

FLUSH PRIVILEGES;
EOF

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update the SECRET_KEY_BASE in docker-compose.yml with the value from .env"
echo "2. Run: docker-compose up --build"
echo "3. Wait for the build to complete (this may take 10-15 minutes)"
echo "4. Once running, create an admin user with:"
echo "   docker-compose exec seek bundle exec rake seek:create_admin_user"
echo ""
echo "🌐 SEEK will be available at: http://localhost:3000"
