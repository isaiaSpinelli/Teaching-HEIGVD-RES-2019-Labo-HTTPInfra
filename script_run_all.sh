#!/bin/bash

# 1 kill les 3
docker kill apache_static
docker kill express_dynamic
docker kill apache_rp
# 2 kill stopped
# docker rm `docker ps -qa`
docker rm $(docker ps -a -q)

# 3 rebuild
bash ./images-docker/apache-php-image/script_build.sh
bash ./images-docker/apache-reverse-proxy/script_build.sh
bash ./images-docker/express-image/script_build.sh

# run static apache
# http://demo.res.ch:8080/
docker run -d --name apache_static res_apache_php
# run dynamic express
# http://demo.res.ch:8080/api/animals/
docker run -d --name express_dynamic res_express
# run proxy reverse
docker run -d -p 8080:80 --name apache_rp res/apache_rp

# docker inspect <ID_docker_ps ou name> | grep "IPA"
docker inspect apache_static | grep "IPA"
docker inspect express_dynamic | grep "IPA"
docker inspect apache_rp | grep "IPA"