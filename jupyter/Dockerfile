FROM akul/spark3rapids:base

RUN echo 'export PYSPARK_PYTHON=/opt/conda/envs/rapids/bin/python3' >> /opt/conda/envs/rapids/etc/conda/activate.d/env_vars.sh
RUN echo 'export PYSPARK_DRIVER_PYTHON=/opt/conda/envs/rapids/bin/python3' >> /opt/conda/envs/rapids/etc/conda/activate.d/env_vars.sh

RUN /opt/conda/envs/rapids/bin/pip install pyspark
