# Inception

A Docker infrastructure project that sets up a complete web application stack using Docker Compose. The project implements a WordPress website with multiple services running in separate containers, following 42 School requirements.

## Project Description

This project creates a small infrastructure composed of different services under specific rules. Each service runs in a dedicated Docker container built from Alpine Linux (version 3.20/3.21.4). The entire infrastructure is orchestrated using Docker Compose and includes both mandatory and bonus services.

## Architecture

The infrastructure uses a custom Docker network (`inception`) to enable communication between containers. All services are configured to automatically restart in case of crashes.

## Services

### Mandatory Services

#### 1. NGINX (Port 443)
- **Image:** Alpine 3.21.4
- **Purpose:** Web server and reverse proxy
- **Configuration:**
  - TLSv1.2 and TLSv1.3 support
  - SSL/HTTPS only
  - Proxies requests to PHP-FPM
- **Port:** `443:443` (HTTPS)

#### 2. WordPress + PHP-FPM (Port 9000)
- **Image:** Alpine 3.21.4
- **Purpose:** WordPress CMS with PHP-FPM
- **Configuration:**
  - WordPress latest version
  - PHP 8.3 with FPM
  - WP-CLI for management
  - Two users configured (admin + author)
  - Redis object caching integration
- **Port:** `9000` (internal)

#### 3. MariaDB (Port 3306)
- **Image:** Alpine 3.21.4
- **Purpose:** Database server for WordPress
- **Configuration:**
  - MariaDB latest version
  - Two users configured
  - Persistent data storage
- **Port:** `3306` (internal)

### Bonus Services

#### 4. Redis Cache (Port 6379)
- **Image:** Alpine 3.20
- **Purpose:** Object caching for WordPress
- **Configuration:**
  - 256MB memory limit
  - LRU eviction policy
  - Improves WordPress performance
- **Port:** `6379` (internal)

#### 5. FTP Server (Ports 21, 21000-21010)
- **Image:** Alpine 3.20
- **Purpose:** File transfer access to WordPress files
- **Configuration:**
  - vsftpd server
  - Passive mode support
  - Direct access to WordPress volume
- **Ports:** `21:21`, `21000-21010:21000-21010`
- **Credentials:** `ftpuser` / `ftppass`

#### 6. Static Website (Port 8080)
- **Image:** Alpine 3.20
- **Purpose:** Simple static HTML/CSS/JavaScript website
- **Configuration:**
  - Nginx web server
  - Interactive dashboard with JavaScript
  - Service status display
- **Port:** `8080:80`

#### 7. Adminer (Port 8081)
- **Image:** Alpine 3.20
- **Purpose:** Database management web interface
- **Configuration:**
  - PHP 8.3 + Nginx
  - Lightweight database administration
  - Direct access to MariaDB
- **Port:** `8081:80`

#### 8. Portainer (Ports 9000, 9443)
- **Image:** Alpine 3.20
- **Purpose:** Docker container management UI
- **Configuration:**
  - Visual container management
  - Real-time monitoring
  - Log viewer and console access
- **Ports:** `9000:9000` (HTTP), `9443:9443` (HTTPS)

## Ports Summary

| Service | Port(s) | Protocol | Access |
|---------|---------|----------|--------|
| NGINX | 443 | HTTPS | External |
| WordPress/PHP | 9000 | FastCGI | Internal |
| MariaDB | 3306 | MySQL | Internal |
| Redis | 6379 | Redis | Internal |
| FTP | 21, 21000-21010 | FTP | External |
| Static Website | 8080 | HTTP | External |
| Adminer | 8081 | HTTP | External |
| Portainer | 9000, 9443 | HTTP/HTTPS | External |

## Volumes

All data is persisted in the following directories on the host:

- `/home/jramos-a/data/db` - MariaDB database files
- `/home/jramos-a/data/wp` - WordPress website files
- `/home/jramos-a/data/portainer` - Portainer configuration

## Domain Configuration

- **Domain:** Configurable via environment variable `DOMAIN_NAME`
- **Default:** `jramos-a.42.fr`
- **IP:** Points to local machine (127.0.0.1)
- **Configuration:** Add to `/etc/hosts`: `127.0.0.1 your-domain.42.fr`

## Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Key variables:
- `DOMAIN_NAME` - Your domain name (default: jramos-a.42.fr)
- `MARIADB_ROOT_PASSWORD` - MariaDB root password
- `MARIADB_DATABASE` - WordPress database name
- `MARIADB_USER` / `MARIADB_PASSWORD` - Database user credentials
- `WP_ADMIN_USER` / `WP_ADMIN_PASSWORD` - WordPress admin credentials
- `WP_USER` / `WP_USER_PASSWORD` - WordPress second user credentials

## Network

All containers communicate through a custom Docker bridge network named `inception`.

## Security Features

- TLS/SSL encryption (HTTPS only)
- Self-signed SSL certificates
- No passwords in Dockerfiles (use environment variables)
- Isolated container networking
- Automatic restart on failure

## WordPress Configuration

- **Admin User:** Configured via environment variables (not named "admin")
- **Second User:** Author role with separate credentials
- **Database:** Two users with appropriate permissions
- **Caching:** Redis object cache for improved performance

## Usage

```bash
# Copy and configure environment variables
cp .env.example .env
# Edit .env with your settings

# Build and start all services
make bonus

# Stop all services
make down

# Clean up containers and images
make clean

# Complete cleanup including volumes
make fclean

# Rebuild everything
make re
```

## Access Points

After starting the infrastructure (replace with your `DOMAIN_NAME`):

- **WordPress:** https://your-domain.42.fr or https://localhost
- **Static Website:** http://localhost:8080
- **Adminer:** http://localhost:8081
- **Portainer:** http://localhost:9000
- **FTP:** `ftp://ftpuser:ftppass@localhost:21`

## Requirements

- Docker
- Docker Compose
- Make
- Root/sudo access (for volume creation)


