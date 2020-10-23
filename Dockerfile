FROM rapidsai/rapidsai-dev:0.15-cuda11.0-devel-ubuntu18.04-py3.8

# Install Java
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt install openjdk-8-jdk-headless -y

# Install Scala
RUN wget https://downloads.lightbend.com/scala/2.12.12/scala-2.12.12.deb
RUN dpkg -i scala-2.12.12.deb && apt install -f

# Install Spark
RUN wget https://downloads.apache.org/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
RUN tar -xzvf spark-3.0.1-bin-hadoop3.2.tgz
RUN mv spark-3.0.1-bin-hadoop3.2 /
ENV SPARK_HOME=/spark-3.0.1-bin-hadoop3.2
ENV PATH=$PATH:$SPARK_HOME/bin

#env vars
ENV PATH=$PATH:/usr/lib/scala/bin

# Install Spark-Rapids
RUN mkdir /opt/sparkRapidsPlugin
RUN cd /opt/sparkRapidsPlugin && wget https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark_2.12/0.2.0/rapids-4-spark_2.12-0.2.0.jar
RUN cd /opt/sparkRapidsPlugin && wget https://repo1.maven.org/maven2/ai/rapids/cudf/0.15/cudf-0.15-cuda11.jar

# Env variables
ENV SPARK_RAPIDS_DIR=/opt/sparkRapidsPlugin
ENV SPARK_CUDF_JAR=${SPARK_RAPIDS_DIR}/cudf-0.15-cuda11.jar
ENV SPARK_RAPIDS_PLUGIN_JAR=${SPARK_RAPIDS_DIR}/rapids-4-spark_2.12-0.2.0.jar
#RUN source .bash_profile

ENV SPARK_NO_DAEMONIZE=true
