#!/bin/bash

sudo echo "-master http://34.128.100.199:8080/jenkins -password admin -username admin"| sudo docker secret create jenkins-v1 -
docker service create \
--mode=global \
--name jenkins-swarm-agent \
-e LABELS=docker-prod \
--mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
--mount "type=bind,source=/tmp/,target=/tmp/" \
--secret source=jenkins-v1,target=jenkins \
vfabric/jenkins-swarm-agent