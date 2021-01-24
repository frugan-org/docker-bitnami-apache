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
    -e 's/^#\(LoadModule .*remoteip_module\)/\1/' \
    -e 's/^#\(LoadModule .*rewrite_module\)/\1/' \
    -e 's/^#\(LoadModule .*security3_module\)/\1/' \
    -e 's/^#\(LoadModule .*unique_id_module\)/\1/' \
    \
    #TODO - https://docs.bitnami.com/bch/apps/wordpress/configuration/enable-modules/
    #- LDAP
    #- Mod_evasive
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


#### remoteip
#https://support.cloudflare.com/hc/en-us/articles/360029696071-Restoring-original-visitor-IPs-Option-2-Installing-mod-remoteip-with-Apache

RUN echo '<IfModule remoteip_module>\n\
    RemoteIPHeader CF-Connecting-IP\n\
    \n\
    RemoteIPTrustedProxy 173.245.48.0/20\n\
    RemoteIPTrustedProxy 103.21.244.0/22\n\
    RemoteIPTrustedProxy 103.22.200.0/22\n\
    RemoteIPTrustedProxy 103.31.4.0/22\n\
    RemoteIPTrustedProxy 141.101.64.0/18\n\
    RemoteIPTrustedProxy 108.162.192.0/18\n\
    RemoteIPTrustedProxy 190.93.240.0/20\n\
    RemoteIPTrustedProxy 188.114.96.0/20\n\
    RemoteIPTrustedProxy 197.234.240.0/22\n\
    RemoteIPTrustedProxy 198.41.128.0/17\n\
    RemoteIPTrustedProxy 162.158.0.0/15\n\
    RemoteIPTrustedProxy 104.16.0.0/12\n\
    RemoteIPTrustedProxy 172.64.0.0/13\n\
    RemoteIPTrustedProxy 131.0.72.0/22\n\
    RemoteIPTrustedProxy 2400:cb00::/32\n\
    RemoteIPTrustedProxy 2606:4700::/32\n\
    RemoteIPTrustedProxy 2803:f800::/32\n\
    RemoteIPTrustedProxy 2405:b500::/32\n\
    RemoteIPTrustedProxy 2405:8100::/32\n\
    RemoteIPTrustedProxy 2a06:98c0::/29\n\
    RemoteIPTrustedProxy 2c0f:f248::/32\n\
    \n\
    <IfModule log_config_module>\n\
        LogFormat "%a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined\n\
        LogFormat "%a %l %u %t \"%r\" %>s %b" common\n\
        \n\
        <IfModule logio_module>\n\
            LogFormat "%a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio\n\
        </IfModule>\n\
    </IfModule>\n\
</IfModule>\n'\
    >> /opt/bitnami/apache/conf/remoteip.conf

RUN echo 'Include "/opt/bitnami/apache/conf/remoteip.conf"\n' >> /opt/bitnami/apache/conf/httpd.conf


#### pagespeed
#https://github.com/bitnami/bitnami-docker-apache/issues/101#issuecomment-638688639
#https://github.com/apache/incubator-pagespeed-mod/issues/596#issuecomment-90120790
#https://community.bitnami.com/t/mod-pagespeed-running-but-not-working-no-permission-to-rewrite-errors/76650/2

RUN sed -i \
    -e 's/^#\(Include .*pagespeed\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf; \
    \
    echo '<IfModule pagespeed_module>\n\
    ModPagespeedMemcachedServers memcached:11211\n\
    ModPagespeedCreateSharedMemoryMetadataCache "/opt/bitnami/apache/var/cache/mod_pagespeed/" 51200\n\
    ModPagespeedEnableFilters remove_comments,collapse_whitespace,insert_dns_prefetch,insert_ga,inline_google_font_css,move_css_to_head\n\
    ModPagespeedEnableCachePurge on\n\
    ModPagespeedUsePerVhostStatistics on\n\
    \n\
    <Location /pagespeed>\n\
        SetHandler pagespeed_admin\n\
        <IfModule mod_rewrite.c>\n\
            RewriteEngine Off\n\
        </IfModule>\n\
        <IfModule mod_authn_file.c>\n\
            AuthName "PageSpeed"\n\
            AuthType Basic\n\
            AuthUserFile /app/conf/.htpasswd\n\
            AuthGroupFile /app/conf/.htgroup\n\
        </IfModule>\n\
        <Limit GET POST>\n\
            require valid-user\n\
        </Limit>\n\
    </Location>\n\
</IfModule>\n'\
    >> /opt/bitnami/apache/conf/pagespeed.conf


#### h5bp

RUN wget -O /opt/bitnami/apache/conf/h5bp.conf https://raw.githubusercontent.com/h5bp/server-configs-apache/master/dist/.htaccess; \
    \
    #https://unix.stackexchange.com/a/77278/81288
    #https://stackoverflow.com/a/54177138/3929620
    echo '<IfModule mod_rewrite.c>\n\
    RewriteEngine On\n\
    RewriteCond %{REQUEST_FILENAME} !-f\n\
    RewriteRule ^(.+)\.(\w+)\.(avifs?|bmp|css|cur|gif|ico|jpe?g|m?js|a?png|svgz?|webp|webmanifest)$ $1.$3 [L]\n\
</IfModule>\n'\
    >> /opt/bitnami/apache/conf/h5bp.conf


# Revert to the original non-root user
USER 1001
