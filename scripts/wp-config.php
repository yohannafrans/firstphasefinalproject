<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpdb' );

/** MySQL database username */
define( 'DB_USER', 'wpuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'abc' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
	define('AUTH_KEY',         'd|.)|:)*F0%mT%up.+V,)Q{(dlf;%DB6]Tuhq]g37K!;-lwmiI7CJL4Ap,pQpnH5');
	define('SECURE_AUTH_KEY',  '3hAx^dD*%K,>ON#IqO9*|n|#9]gUc>Cj+3@#iWAT:9$yx{RY6fFA`<,4K]f1kVCC');
	define('LOGGED_IN_KEY',    'k<+/ahaSNuI6Fg-@bCFlyu939IE+K<pD`H6|1SSk-4.wlg^;$TH`+:_h$kv~dWw]');
	define('NONCE_KEY',        'd?.S2S<@/`&rn7XTv1fIM_HtJagX+lF?a]ch|!I_XOG 2t+)LWL|O#XVYK2He.?q');
	define('AUTH_SALT',        '_Z|?DDz?*5s=H{,l4L%ZcSCrT-p]%*`KDiH03_{wXu?]z(2$9LKj*XiI0($]S[@g');
	define('SECURE_AUTH_SALT', 'SHW/09+D;U8_AY{v$c+UuIZc$|6dN&F.! %]}V=moO32MCwSDlph[UrT/S)=g*<*');
	define('LOGGED_IN_SALT',   'FVK<bR;YHq%N+H&j^5OP]_mC<TB!&m/3 1;XI=(K(]bOdwN=`GA>`pQpu:;oz4`f');
	define('NONCE_SALT',       '-4]ZQSCF(tqtX,{iR:jOg5-FP@d*_bbCb|cK 9^d$ `>)X$@.<-EKeFI0fZc07|[');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );