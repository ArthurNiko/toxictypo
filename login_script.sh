#!/bin/sh

$(aws ecr get-login --no-include-email --region eu-central-1)
docker pull 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo
docker run -d -p 80:8080 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo
sleep 3
echo "-------------------------"
echo "Up and Running :)"