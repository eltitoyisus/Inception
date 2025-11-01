<?php

define( 'DB_NAME', file_exists('/run/secrets/mysql_database') ? trim(explode("\n", file_get_contents('/run/secrets/mysql_database'))[1]) : 'wordpress' );
define( 'DB_USER', file_exists('/run/secrets/mysql_database') ? trim(explode("\n", file_get_contents('/run/secrets/mysql_database'))[2]) : 'wpuser' );
define( 'DB_PASSWORD', file_exists('/run/secrets/mysql_password') ? trim(file_get_contents('/run/secrets/mysql_password')) : 'wppassword' );
define( 'DB_HOST', getenv('MARIADB_HOST') ?: 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
