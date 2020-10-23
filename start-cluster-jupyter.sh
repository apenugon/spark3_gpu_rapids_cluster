#!/bin/bash

# Master
docker run --rm --name master --mount source=notebook,target=/rapids/notebooks/notebook --network spark-network -p 8080:8080 -d akul/spark3rapids:master

# Worker
docker run --rm --gpus all --name worker --network spark-network --mount source=notebook,target=/rapids/notebooks/notebook -p 8081:8081 -d akul/spark3rapids:worker

# Jupyter
docker run --rm -it --name jupyter --network spark-network --mount source=notebook,target=/rapids/notebooks/notebook -p 8888:8888 -p 4040:4040 -d akul/spark3rapids:jupyter
