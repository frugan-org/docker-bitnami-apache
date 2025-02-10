#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose

#https://docs.bitnami.com/bch/apps/wordpress/configuration/enable-modules/
if [ -n "${APACHE_REWRITE_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*rewrite_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_LDAP_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*mod_authnz_ldap\)/\1/' \
		-e 's/^#\(LoadModule .*mod_ldap\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_EVASIVE_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*evasive20_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
else
	sed -i \
		-e 's/^\(LoadModule .*evasive20_module\)/#\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_SUBSTITUTE_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*substitute_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

# W3TC -> Page Cache and Browser Cache
if [ -n "${APACHE_DEFLATE_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*deflate_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_ENV_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*env_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_EXPIRES_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*expires_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_EXT_FILTER_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*ext_filter_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_FILTER_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*filter_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_HEADERS_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*headers_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_MIME_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*mime_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_SETENVIF_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*setenvif_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi
if [ -n "${APACHE_REMOTEIP_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*remoteip_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

#https://community.bitnami.com/t/unable-to-enable-http-2-support/67229/7
if [ -n "${APACHE_HTTP2_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*http2_module\)/\1/' \
		-e 's/^\(LoadModule .*mpm_prefork_module\)/#\1/' \
		-e 's/^#\(LoadModule .*mpm_event_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

if [ -n "${APACHE_SECURITY3_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*security3_module\)/\1/' \
		-e 's/^#\(LoadModule .*unique_id_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf

	sed -i \
		-e 's/\/var\/log\/modsec_audit\.log/\/opt\/bitnami\/apache\/logs\/modsec_audit\.log/' \
		/opt/bitnami/apache/conf/modsecurity.conf

	ln -sf /dev/stdout /opt/bitnami/apache/logs/modsec_audit.log
fi

#https://support.cloudflare.com/hc/en-us/articles/360029696071-Restoring-original-visitor-IPs-Option-2-Installing-mod-remoteip-with-Apache
#https://community.traefik.io/t/restoring-cloudflare-real-ip-on-traefik/7675
#https://stackoverflow.com/a/63380213/3929620
if [ -n "${APACHE_PAGESPEED_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(Include .*pagespeed\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

if [ -n "${APACHE_AUTOINDEX_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*alias_module\)/\1/' \
		-e 's/^#\(LoadModule .*authz_core_module\)/\1/' \
		-e 's/^#\(LoadModule .*authz_host_module\)/\1/' \
		-e 's/^#\(LoadModule .*autoindex_module\)/\1/' \
		-e 's/^#\(Include .*httpd-autoindex\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

#https://github.com/BytemarkHosting/docker-webdav
#https://github.com/uGeek/docker-webdav
#https://github.com/idelsink/webdav-docker
if [ -n "${APACHE_DAV_MODULE_ENABLED:-}" ]; then
	sed -i \
		-e 's/^#\(LoadModule .*alias_module\)/\1/' \
		-e 's/^#\(LoadModule .*auth_digest_module\)/\1/' \
		-e 's/^#\(LoadModule .*authn_core_module\)/\1/' \
		-e 's/^#\(LoadModule .*authn_file_module\)/\1/' \
		-e 's/^#\(LoadModule .*authz_core_module\)/\1/' \
		-e 's/^#\(LoadModule .*authz_user_module\)/\1/' \
		-e 's/^#\(LoadModule .*dav_module\)/\1/' \
		-e 's/^#\(LoadModule .*dav_fs_module\)/\1/' \
		-e 's/^#\(LoadModule .*setenvif_module\)/\1/' \
		/opt/bitnami/apache/conf/httpd.conf
fi

#### h5bp
REPO_NAME="h5bp/server-configs-apache"
REPO_URL="https://github.com/$REPO_NAME.git"
REPO_RAW_URL="https://raw.githubusercontent.com/$REPO_NAME/master"
FALLBACK_DIR="${APACHE_H5BP_FALLBACK_DIR:-/app/conf/$REPO_NAME}"
FILE_SRC="dist/.htaccess"
FILE_DEST="/opt/bitnami/apache/conf/h5bp.conf"

#https://stackoverflow.com/a/2717395/3929620
if wget -O "$FILE_DEST" "$REPO_RAW_URL/$FILE_SRC"; then
	if [ -d "$FALLBACK_DIR" ]; then
		cd "$FALLBACK_DIR"
		git pull >/dev/null 2>&1 || true
	else
		git clone "$REPO_URL" "$FALLBACK_DIR"
	fi

	#if [ -f "$FALLBACK_DIR/$FILE_SRC" ]; then
	#	cp "$FALLBACK_DIR/$FILE_SRC" "$FILE_DEST"
	#fi
fi

####

#https://stackoverflow.com/a/46433245/3929620
# shellcheck source=/dev/null
. /opt/bitnami/scripts/apache/entrypoint.sh
