FROM php:fpm-alpine

# all 3rd party stuff first (better caching ;-)
RUN apk add caddy zsh

# various minor setup
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"  &&  \
    sed -i -e 's/short_open_tag = Off/short_open_tag = On/' "$PHP_INI_DIR/php.ini" 

# now deal with our repo
WORKDIR /usr/share/caddy/
COPY . .

# start services - run php-fpm in background, and nginx in foreground
CMD  sh -c "php-fpm -D  &&  caddy run"
