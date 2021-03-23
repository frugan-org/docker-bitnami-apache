FROM bitnami/apache:2.4

#https://forums.docker.com/t/unable-to-find-user-root-no-matching-entries-in-passwd-file/26545/2
# Required to perform privileged actions
USER 0


#https://jtreminio.com/blog/running-docker-containers-as-current-host-user/#ok-so-what-actually-works
RUN if [ ${USER_ID} -ne 0 ] && [ ${GROUP_ID} -ne 0 ]; then \
        userdel -f daemon; \
        if getent group daemon; then \
            groupdel daemon; \
        fi \
        groupadd -g ${GROUP_ID} daemon; \
        useradd -l -u ${USER_ID} -g daemon daemon; \
        install -d -m 0755 -o daemon -g daemon /home/daemon; \
    fi


RUN install_packages \
        gcc \
        git \
        #https://stackoverflow.com/a/50072645/3929620
        libc6-dev \
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
RUN if [ "${ENV}" = "develop" ]; then \
        echo "export APACHE_ARGUMENTS='-D ${ENV}'" >> /opt/bitnami/apache/bin/envvars; \
    fi


#### mod_evasive
#https://docs.bitnami.com/bch/apps/wordpress/configuration/enable-modules/

RUN set -ex; \
    cd /tmp; \
    git clone https://github.com/jzdziarski/mod_evasive/; \
    cd mod_evasive; \
    cp mod_evasive20.c mod_evasive24.c; \
    sed s/remote_ip/client_ip/g -i mod_evasive24.c; \
    apxs -i -a -c mod_evasive24.c; \
    cd ..; \
    rm -Rf mod_evasive;


####

COPY entrypoint.sh /

#https://github.com/docker-library/postgres/issues/296#issuecomment-308735942
RUN chmod +x /entrypoint.sh

# Revert to the original non-root user
USER 1001

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/apache/run.sh" ]
