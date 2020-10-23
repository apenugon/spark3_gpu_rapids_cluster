#!/bin/bash

export SPARK_HOME="/spark-3.0.1-bin-hadoop3.2"

$SPARK_HOME/sbin/start-slave.sh spark://master:7077 \
#--num-executors 1 \
--conf spark.worker.resource.gpu.amount=1 \
--conf spark.worker.resource.gpu.discoveryScript=./getGpusResources.sh \
--conf spark.eventLog.enabled=true \
--conf spark.eventLog.dir=logs \
--files getGpusResources.sh \
