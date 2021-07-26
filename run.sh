#!/bin/bash
envup() {
    local file=$([ -z "$1" ] && echo ".env" || echo ".env.$1")

    if [ -f $file ]; then
        set -a
        source $file
        set +a
    else
        echo "No $file file found" 1>&2
        return 1
    fi
}

envup

hostName=(${VIRTUAL_HOST//./ })
hostName="${hostName[0]}Lb"

echo "events {}" >nginx.conf
echo "http {" >>nginx.conf
echo "" >>nginx.conf
echo "    upstream $hostName {" >>nginx.conf

for i in $(echo $NODES | tr "," "\n"); do
    # process
    echo "        server $i:$PORT;" >>nginx.conf
done

echo "    }" >>nginx.conf
echo "" >>nginx.conf
echo "    server {" >>nginx.conf
echo "        listen 80;" >>nginx.conf
echo "        server_name $VIRTUAL_HOST;" >>nginx.conf
echo "        location / {" >>nginx.conf
echo "            proxy_pass http://$hostName;" >>nginx.conf
echo "        }" >>nginx.conf
echo "    }" >>nginx.conf
echo "}" >>nginx.conf

cat nginx.conf
rm /etc/nginx/nginx.conf
cp ./nginx.conf /etc/nginx/

nginx -t
service nginx restart
sleep infinity
