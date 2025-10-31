<?php
// ** MySQL settings - You can get this info from your .env file ** //
define( 'DB_NAME', getenv('MYSQL_DATABASE') ?: 'wpdatabase' );
define( 'DB_USER', getenv('MYSQL_USER') ?: 'wpuser' );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') ?: 'wppassword' );
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
