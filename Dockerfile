FROM rgielen/httpd-image-php5:latest
MAINTAINER "Rene Gielen" <rgielen@apache.org>

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
        php-pear \
        git \
        wget
RUN wget http://files.drush.org/drush.phar \
      && php drush.phar core-status \
      && chmod +x drush.phar \
      && mv drush.phar /usr/local/bin/drush \
      && drush init
