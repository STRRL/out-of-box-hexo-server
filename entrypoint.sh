#!/usr/bin/env bash
if [ ! -f /key/hexo.pub.key ]
then
    if [ ! -f /key ]
    then
        mkdir /key
    fi
    ssh-keygen -t rsa -N "${PASSPHRASE}" -f /key/hexo.key
fi
mkdir /root/.ssh
ln -sf /key/hexo.pub.key /root/.ssh/
cat /key/hexo.key.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
chmod 700 /root/.ssh
PASSWD=$(sha256sum /root/.ssh/authorized_keys | cut -d " " -f 1)
echo -e "${PASSWD}\n${PASSWD}" | (passwd root)
service ssh start
exec "$@"