# FAIRDOM-SEEK Docker Setup

Complete Docker setup for FAIRDOM-SEEK research data management platform.

## Quick Start

1. **Clone this repository:**
   ```bash
   git clone ...
   cd fairdom-seek-docker
   ```

2. **Run the setup scripts:**
   ```bash
   ./startup.sh
   ./complete_setup.sh
   ```

3. **Access SEEK:**
   - **Web Interface:** http://localhost:3000
   - **Username:** admin
   - **Password:** password123

## What's Included

- **SEEK Application** - Main Rails application (port 3000)
- **MySQL Database** - Data storage (port 3306)
- **Redis** - Caching and background jobs (port 6379)
- **Background Worker** - Processes async tasks
- **Automated Setup** - Database creation and admin user

## File Structure

```
fairdom-seek-docker/
├── docker-compose.yml      # Main service configuration
├── Dockerfile              # SEEK application build
├── database.yml            # Database configuration
├── start.sh                # Application startup script
├── worker.sh               # Background worker script
├── startup.sh              # Initial setup script
├── complete_setup.sh       # Complete automated setup
├── mysql-init/             # Database initialization
│   └── 01-init.sql
├── seek-config/            # Custom SEEK configuration
└── backups/                # Database backups
```

## Configuration

### Environment Variables
Key settings in `docker-compose.yml`:
- `SECRET_KEY_BASE` - Rails encryption key
- `DATABASE_*` - Database connection settings
- `REDIS_*` - Redis connection settings

### Custom Configuration
Place custom Ruby configuration files in `seek-config/` directory.

## Development

### Rebuilding After Changes
```bash
docker compose down
docker compose up --build -d
```

### Scaling Workers
```bash
docker compose up -d --scale seek_worker=3
```

### Custom SEEK Version
Edit `Dockerfile` line:
```dockerfile
git checkout v1.16.2  # Change to desired version
```

## Backup and Restore

### Automated Backups
Uncomment the `db_backup` service in `docker-compose.yml` for scheduled backups.

### Manual Backup
```bash
# Create backup
docker compose exec db mysqldump -u root -pseek_root_password seek_production > backup_$(date +%Y%m%d).sql

# Restore backup
docker compose exec -T db mysql -u root -pseek_root_password seek_production < backup_20250716.sql
```

## Default Login Credentials

After setup completion, login to SEEK with:
- **Username:** admin
- **Password:** password123
- **Email:** admin@seek.com

**Change the admin password after first login for security!**

## Default Credentials

- **Admin User:** admin / password123
- **Database:** seek_user / seek_password
- **Root DB:** root / seek_root_password

**Change these for production use!**
