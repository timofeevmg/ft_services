#!/bin/sh

# Configuration of PHP7
export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_FPM_LISTEN_MODE="0660"
export PHP_MEMORY_LIMIT="512M"
export PHP_MAX_UPLOAD="50M"
export PHP_MAX_FILE_UPLOAD="200"
export PHP_MAX_POST="100M"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
export PHP_CGI_FIX_PATHINFO=0

sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf #uncommenting line

sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

# chown -R www:www /www/wordpress/

#install wp without disclosing admin_password
wp core install --url=http://192.168.99.101:5050/ --title=Top\ Secret --admin_user=admin --admin_email=admin@mail.com  --prompt=admin_password < wp_adm_pswd.txt
# wp core install --admin_user=admin --admin_email=admin@mail.com  --prompt=admin_password < wp_adm_pswd.txt

# create post
# wp post delete $(wp post list --post_type='post' --format=ids) --force
# wp post delete 1 --force
# wp post create --post_type=post --post_status=publish --post_title='Epilar was here'


#create users from csv
wp user import-csv /users.csv

/usr/bin/supervisord -c /etc/supervisord.conf