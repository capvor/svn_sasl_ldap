FROM debian:buster

# https://github.com/osixia/docker-openldap
# https://github.com/zom-bi/docker-saslauthd/blob/master/Dockerfile
# https://www.cyrusimap.org/sasl/
# https://github.com/bgpat/docker-saslauthd-ldap
# https://docs.couchbase.com/server/current/manage/manage-security/configure-saslauthd.html

# RUN \
#     sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
#     sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN \
    chown root:root /docker-entrypoint.sh && \
    chmod 755 /docker-entrypoint.sh && \
    apt-get -q -y update && \
    apt-get install -q -y sasl2-bin && \
    apt-get install -q -y subversion && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3690
VOLUME ["/var/opt/svn"]
WORKDIR /var/opt/svn

ENTRYPOINT ["/docker-entrypoint.sh"]
