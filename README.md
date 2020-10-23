# spark3_gpu_rapids_cluster
A working Docker build configuration to run Spark 3 with Nvidia's RAPIDS accelerator plugin to run spark on GPUs, locally.

# Motivation
With the release of Spark 3, Spark now has GPU support. NVidia further supports this with an accelerator [plugin](https://databricks.com/session_na20/deep-dive-into-gpu-support-in-apache-spark-3-x) using RAPIDS for even better memory management. This set of dockerfiles provides a plug-and-play setup that will get you a GPU-powered Spark standalone cluster working - even with Windows Subsystem for Linux 2.

# Prerequisites

* An Nvidia GPU
* If using WSL, WSL 2 with CUDA are installed
* Docker installed and running (note that if you're using WSL 2 with CUDA, Docker should be installed in Linux NOT Windows)

# Installation

1. Clone the repo
2. Run `build.sh`
3. Run `start-cluster-jupyter.sh` to start a standalone cluster with 1 worker and a shared volume, and start a pyspark notebook

# Usage

Navigate to `localhost:8888`, where you will see a JupyterLab instance. Create a new notebook, and start with these configuration options:

	import pyspark
	from pyspark import SparkContext
	from pyspark.sql import SparkSession

	conf = pyspark.SparkConf()
	conf.setMaster('spark://master:7077')
	conf.set('spark.executor.extraClassPath', '/opt/sparkRapidsPlugin/cudf-0.15-cuda11.jar:/opt/sparkRapidsPlugin/rapids-4-spark_2.12-0.2.0.jar')
	conf.set('spark.driver.extraClassPath','/opt/sparkRapidsPlugin/cudf-0.15-cuda11.jar:/opt/sparkRapidsPlugin/rapids-4-spark_2.12-0.2.0.jar')
	#conf.set('spark.rapids.sql.concurrentGpuTasks','1')
	conf.set('spark.executor.memory','2G')
	conf.set('spark.plugins', 'com.nvidia.spark.SQLPlugin')
	conf.set('spark.executor.resource.gpu.amount', '1')
	conf.set('spark.rapids.sql.enabled', 'true')
	conf.set('spark.rapids.memory.gpu.allocFraction', '.5')
	conf.set('spark.rapids.memory.gpu.maxAllocFraction', '.7')
	conf.set('spark.rapids.python.memory.gpu.maxAllocFraction', '.15')
	conf.set('spark.rapids.memory.gpu.reserve', '1G')
	conf.set('spark.rapids.memory.pinnedPool.size', '0')
	conf.set('spark.rapids.memory.host.spillStorageSize', '1G')
	conf.set('spark.locality.wait', '0s')
	conf.set('spark.task.resource.gpu.amount', '.1')
	conf.set('spark.task.cpus', '1')
	conf.set('spark.executor.cores', '10')
	conf.set('spark.executor.instances', '1')
	conf.set('spark.sql.files.maxPartitionBytes', '512m')
	conf.set('spark.sql.shuffle.partitions','10')
	sc = SparkContext(conf=conf)
	spark = SparkSession(sc)

And that's it! This will get a spark instance up and running for you. You may want to change some of those config optinos depending on your own setup - see the [Spark docs](http://spark.apache.org/docs/latest/configuration.html) and the [Rapids accelerator docs](https://nvidia.github.io/spark-rapids/docs/configs.html) for more details.

# Notes

You will notice a file `getGpusResources.sh` in the `spark_worker` folder. This script tells the worker how many GPUs exist in the system. The file in this repo clearly just echos a static response of 1 GPU with an address of 0. This is because WSL 2 does not support Nvidia-smi as of October 2020, and so this is a hack to get this to work in WSL. If you want to use this outside of WSL, I would recommend using the actual recommended `getGpusResources.sh` file which you can find [here](https://github.com/apache/spark/blob/master/examples/src/main/scripts/getGpusResources.sh). Just replace the file in spark_worker with that one and run build.
