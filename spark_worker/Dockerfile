FROM akul/spark3rapids:base

COPY spark-local.sh $SPARK_HOME/bin/spark-local.sh
COPY getGpusResources.sh /opt/sparkRapidsPlugin/getGpusResources.sh
RUN mkdir /rapids/notebooks/logs

RUN cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
RUN echo "SPARK_WORKER_OPTS=\"-Dspark.worker.resource.gpu.amount=1 -Dspark.worker.resource.gpu.discoveryScript=/opt/sparkRapidsPlugin/getGpusResources.sh\"" >> $SPARK_HOME/conf/spark-env.sh
ENTRYPOINT ["/spark-3.0.1-bin-hadoop3.2/sbin/start-slave.sh", "spark://master:7077"]
