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