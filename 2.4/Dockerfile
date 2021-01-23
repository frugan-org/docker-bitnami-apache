FROM bitnami/apache:2.4

#https://forums.docker.com/t/unable-to-find-user-root-no-matching-entries-in-passwd-file/26545/2
# Required to perform privileged actions
USER 0

RUN install_packages \
        vim \
        wget \
    ;

#https://github.com/docker-library/php/issues/389
#https://askubuntu.com/a/147065/543855
#https://github.com/docker-library/php/issues/97
#https://itsecureadmin.com/2018/03/running-apache-2-under-ubuntu-16-04-on-docker/
#https://httpd.apache.org/docs/2.4/mod/core.html#define
#https://rskuipers.com/entry/different-settings-for-dev-and-live-in-your-htaccess
#http://jennyandlih.com/using-apaches-ifdefine-dev-and-production-environments
#https://medium.com/@william.b/setting-dynamic-environmental-variables-in-apache-from-the-os-1d5c1e2e9e6c
#https://stackoverflow.com/a/39462219
#https://httpd.apache.org/docs/2.4/expr.html#functions
#RUN echo "export APACHE_ARGUMENTS='-D ${ENV}'" >> /opt/bitnami/apache/bin/envvars;

#https://docs.bitnami.com/bch/apps/wordpress/configuration/enable-modules/
RUN sed -i \
    -e 's/^#\(LoadModule .*http2_module\)/\1/' \
    -e 's/^#\(LoadModule .*rewrite_module\)/\1/' \
    \
    #https://github.com/bitnami/bitnami-docker-apache/issues/101#issuecomment-638688639
    -e 's/^#\(Include .*pagespeed\)/\1/' \
    \
    # W3TC -> Page Cache and Browser Cache
    -e 's/^#\(LoadModule .*deflate_module\)/\1/' \
    -e 's/^#\(LoadModule .*env_module\)/\1/' \
    -e 's/^#\(LoadModule .*expires_module\)/\1/' \
    -e 's/^#\(LoadModule .*ext_filter_module\)/\1/' \
    -e 's/^#\(LoadModule .*filter_module\)/\1/' \
    -e 's/^#\(LoadModule .*headers_module\)/\1/' \
    -e 's/^#\(LoadModule .*mime_module\)/\1/' \
    -e 's/^#\(LoadModule .*setenvif_module\)/\1/' \
    \
    /opt/bitnami/apache/conf/httpd.conf

RUN echo 'ModPagespeedMemcachedServers memcached:11211\n\
ModPagespeedCreateSharedMemoryMetadataCache "/opt/bitnami/apache/var/cache/mod_pagespeed/" 51200\n\
ModPagespeedEnableFilters remove_comments,collapse_whitespace,insert_dns_prefetch,insert_ga,inline_google_font_css,move_css_to_head\n\
ModPagespeedEnableCachePurge on\n\
ModPagespeedUsePerVhostStatistics on\n'\
    >> /opt/bitnami/apache/conf/pagespeed.conf


#### h5bp

RUN wget -O /opt/bitnami/apache/conf/extra/h5bp.conf https://raw.githubusercontent.com/h5bp/server-configs-apache/master/dist/.htaccess; \
    #https://unix.stackexchange.com/a/77278/81288
    #https://stackoverflow.com/a/54177138/3929620
    echo '<IfModule mod_rewrite.c>\n\
    RewriteEngine On\n\
    RewriteCond %{REQUEST_FILENAME} !-f\n\
    RewriteRule ^(.+)\.(\w+)\.(avifs?|bmp|css|cur|gif|ico|jpe?g|m?js|a?png|svgz?|webp|webmanifest)$ $1.$3 [L]\n\
</IfModule>\n'\
    >> /opt/bitnami/apache/conf/extra/h5bp.conf


# Revert to the original non-root user
USER 1001
