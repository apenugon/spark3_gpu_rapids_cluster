#!/bin/bash
docker build -t akul/spark3rapids:base .
docker build -t akul/spark3rapids:jupyter jupyter
docker build -t akul/spark3rapids:master -f spark_master/Dockerfile spark_master 
docker build -t akul/spark3rapids:worker -f spark_worker/Dockerfile spark_worker
