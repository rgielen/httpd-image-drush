FROM rgielen/httpd-image-php5:latest
MAINTAINER "Rene Gielen" <rgielen@apache.org>

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
            php-pear git wget php5-curl libssh2-php php5-mysql php5-pgsql \
      && a2enmod rewrite php5

RUN wget http://files.drush.org/drush.phar \
      && php drush.phar core-status \
      && chmod +x drush.phar \
      && mv drush.phar /usr/local/bin/drush \
      && drush init \
      && echo "check_certificate=off" > ~/.wgetrc

ADD scripts/fix-drupal-permissions.sh /usr/local/bin/

ENV BASE_DIR /var
ENV DRUPAL_PROJECT_NAME drupal
ENV DRUPAL_DIR ${BASE_DIR}/${DRUPAL_PROJECT_NAME}
ENV DRUPAL_MODULES_DIR ${DRUPAL_DIR}/sites/all/modules
ENV DRUPAL_THEMES_DIR ${DRUPAL_DIR}/sites/all/themes
ENV DRUPAL_FILES_DIR ${DRUPAL_DIR}/sites/default/files
ENV DRUPAL_USER drupal

RUN groupadd -r ${DRUPAL_USER} && useradd -r -g ${DRUPAL_USER} ${DRUPAL_USER}

