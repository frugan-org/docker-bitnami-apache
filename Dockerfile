ARG APACHE_TAG
ARG ENV

ENV APACHE_TAG=${APACHE_TAG:-latest}
    ENV=${ENV:-develop}

FROM bitnami/apache:${APACHE_TAG}

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


#### h5bp

RUN wget -O /opt/bitnami/apache/conf/extra/h5bp.conf https://raw.githubusercontent.com/h5bp/server-configs-apache/master/dist/.htaccess


#### mod_pagespeed
#https://github.com/bitnami/bitnami-docker-wordpress/issues/145#issuecomment-434983025
#https://docs.bitnami.com/bch/apps/wordpress/administration/use-pagespeed/
#https://stackoverflow.com/a/56431245

#RUN install_packages \
#    g++ \
#    python \
#    subversion \
#    gperf \
#    make \
#    devscripts \
#    fakeroot \
#    git \
#    curl \
#    zlib1g-dev && \
#    mkdir -p ~/bin && \
#    cd ~/bin && \
#    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
#    export PATH=$PATH:~/bin/depot_tools && \
#    cd ~ && \
#    git clone -b latest-stable --recursive https://github.com/apache/incubator-pagespeed-mod.git && \
#    cd ~/mod_pagespeed && \
#    python build/gyp_chromium --depth=. && \
#    make BUILDTYPE=Release mod_pagespeed_test pagespeed_automatic_test && \
#    export SSL_CERT_DIR=/etc/pki/tls/certs && \
#    export SSL_CERT_FILE=/etc/pki/tls/cert.pem && \
#    ./out/Release/mod_pagespeed_test && \
#    ./out/Release/pagespeed_automatic_test && \
#    cd ~/mod_pagespeed/src && \
#    make AR.host=`pwd`/build/wrappers/ar.sh AR.target=`pwd`/build/wrappers/ar.sh BUILDTYPE=Release && \
#    cd install && \
#    APXS_BIN=/opt/bitnami/apache/bin/apxs ./install_apxs.sh


# Revert to the original non-root user
USER 1001
