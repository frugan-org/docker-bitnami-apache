#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose


#https://docs.bitnami.com/bch/apps/wordpress/configuration/enable-modules/
if [ ! -z "${APACHE_REWRITE_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*rewrite_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_LDAP_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*mod_authnz_ldap\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ldap\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_EVASIVE_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*evasive20_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
else
  sed -i \
    -e 's/^\(LoadModule .*evasive20_module\)/#\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi

# W3TC -> Page Cache and Browser Cache
if [ ! -z "${APACHE_DEFLATE_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*deflate_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_ENV_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*env_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_EXPIRES_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*expires_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_EXT_FILTER_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*ext_filter_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_FILTER_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*filter_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_HEADERS_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*headers_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_MIME_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*mime_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi
if [ ! -z "${APACHE_SETENVIF_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*setenvif_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi

#https://community.bitnami.com/t/unable-to-enable-http-2-support/67229/7
if [ ! -z "${APACHE_HTTP2_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*http2_module\)/\1/' \
    -e 's/^\(LoadModule .*mpm_prefork_module\)/#\1/' \
    -e 's/^#\(LoadModule .*mpm_event_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi

if [ ! -z "${APACHE_SECURITY3_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(LoadModule .*security3_module\)/\1/' \
    -e 's/^#\(LoadModule .*unique_id_module\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;

  sed -i \
    -e 's/\/var\/log\/modsec_audit\.log/\/opt\/bitnami\/apache\/logs\/modsec_audit\.log/' \
    /opt/bitnami/apache/conf/modsecurity.conf;

  ln -sf /dev/stdout /opt/bitnami/apache/logs/modsec_audit.log;
fi


#https://support.cloudflare.com/hc/en-us/articles/360029696071-Restoring-original-visitor-IPs-Option-2-Installing-mod-remoteip-with-Apache
#https://community.traefik.io/t/restoring-cloudflare-real-ip-on-traefik/7675
#https://stackoverflow.com/a/63380213/3929620
if [ ! -z "${APACHE_PAGESPEED_MODULE_ENABLED:-}" ]; then
  sed -i \
    -e 's/^#\(Include .*pagespeed\)/\1/' \
    /opt/bitnami/apache/conf/httpd.conf;
fi


#### h5bp

wget -O /opt/bitnami/apache/conf/h5bp.conf https://raw.githubusercontent.com/h5bp/server-configs-apache/master/dist/.htaccess;


####

#https://stackoverflow.com/a/46433245/3929620
. /opt/bitnami/scripts/apache/entrypoint.sh
