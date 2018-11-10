#使用centos官方的image當source
FROM centos:6.8
#安裝需要的PHP環境
RUN yum install -y initscripts.x86_64 php.x86_64 php-gd.x86_64 php-mysql.x86_64 php-snmp.x86_64 php-mbstring.x86_64 php-pdo.x86_64 vim-enhanced.x86_64 net-tools.x86_64 php-devel.x86_64 gcc wget.x86_64 openssh-clients.x86_64 openssh-server.x86_64;mkdir -p /root/.ssh

#調整Aapche設定檔
RUN sed -i 's/^AddDefaultCharset UTF-8/#AddDefaultCharset UTF-8/g' /etc/httpd/conf/httpd.conf

#安裝xdebug
# Setup the Xdebug version to install
ENV XDEBUG_VERSION 2.2.4
## 安裝Xdebug Install Xdebug
RUN set -x \
    && curl -SL "https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz" -o xdebug.tgz \
    && mkdir -p /usr/src/xdebug \
    && tar -xf xdebug.tgz -C /usr/src/xdebug --strip-components=1 \
    && rm xdebug.* \
    && cd /usr/src/xdebug \
    && phpize \
    && ./configure --enable-xdebug \
    && make install

EXPOSE 80
#啟用Apache
#CMD ["apachectl","-D","FOREGROUND"]
CMD ["httpd","-D","FOREGROUND"]
