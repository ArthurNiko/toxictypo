#!/bin/sh

aws ecr get-login-password | docker login --username AWS --password-stdin 760836743460.dkr.ecr.eu-central-1.amazonaws.com
docker run -p 80:8080 760836743460.dkr.ecr.eu-central-1.amazonaws.com/toxictypo