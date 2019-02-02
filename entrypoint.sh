#!/usr/bin/env bash
if [ ! -f /key/hexo.pub.key ]
then
    if [ ! -d /key ]
    then
        mkdir /key
    fi
    ssh-keygen -t rsa -N "${PASSPHRASE}" -f /key/hexo.key
fi

if [ -f /cert/cert.cer ] && [ -f /cert/cert.key ]
then
    echo "ssl configured"
    if [ ! -f /etc/nginx/dhparam.pem ]
    then
        openssl dhparam -out /etc/nginx/dhparam.pem 4096
    fi
    ln -sf /conf/default.ssl.conf /etc/nginx/conf.d/default.conf
else
    echo "no ssl configured"
    ln -sf /conf/default.conf /etc/nginx/conf.d/default.conf
fi

mkdir /root/.ssh
ln -sf /key/hexo.pub.key /root/.ssh/
cat /key/hexo.key.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
chmod 700 /root/.ssh
PASSWD=$(sha256sum /root/.ssh/authorized_keys | cut -d " " -f 1)
echo -e "${PASSWD}\n${PASSWD}" | (passwd root)
service ssh start
ln -sf /data /usr/share/nginx/html
exec "$@"