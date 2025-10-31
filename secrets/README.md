# Docker Secrets

This directory contains the secret files used by Docker Compose.

## Secret Files

- `mysql_database.txt` - MySQL database name
- `mysql_user.txt` - MySQL user for WordPress
- `mysql_password.txt` - Password for MySQL user
- `mysql_root_password.txt` - MySQL root password
- `mysql_admin_user.txt` - MySQL admin user
- `mysql_admin_password.txt` - Password for MySQL admin user

## Important Notes

1. **Update passwords**: Make sure to change the default passwords in these files before deploying to production
2. **File permissions**: Keep these files secure with appropriate permissions (e.g., `chmod 600 *.txt`)
3. **Git**: These files are ignored by git (configured in `.gitignore`)
4. **Docker secrets**: These files are mounted as secrets in `/run/secrets/` inside the containers

## How Docker Secrets Work

Docker Compose will mount these files inside containers at `/run/secrets/<secret_name>`.
For example, `mysql_password.txt` will be available at `/run/secrets/mysql_password` inside the container.

The secrets are read-only and only accessible to services that explicitly declare them in the docker-compose.yml file.
