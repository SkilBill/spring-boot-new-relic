#!/bin/bash -e

mvn install package
docker build -t hello -f Dockerfile .
