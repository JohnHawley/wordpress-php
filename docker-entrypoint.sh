#!/bin/sh

set -eo pipefail

if [ -n "$PHP_SENDMAIL_PATH" ]; then
     sed -i 's@^;sendmail_path.*@'"sendmail_path = ${PHP_SENDMAIL_PATH}"'@' /etc/php7/php.ini
fi


#if [ -n "$PROD_SITEURL" ]; then
#     echo "define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST'] . str_replace(DIRECTORY_SEPARATOR, '/', str_replace(realpath($_SERVER['DOCUMENT_ROOT']), '', dirname(__FILE__))));" >> /var/www/html/wp-config.php
#     echo "define('LIVE_SITEURL', '${PROD_SITEURL}');" >> /var/www/html/wp-config.php
#fi

if [ "$PHP_XDEBUG_ENABLED" -eq "1" ]; then
     sed -i 's/^;zend_extension.*/zend_extension = xdebug.so/' /etc/php7/conf.d/00_xdebug.ini
fi

exec php-fpm
