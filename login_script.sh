#!/bin/sh

$(aws ecr get-login --no-include-email --region eu-central-1) 
docker run -p 80:8080 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo