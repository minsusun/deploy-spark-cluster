FROM alpine:3.10

ENV ENABLE_INIT_DAEMON false
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV BASE_URL=https://archive.apache.org/dist/spark/
ENV SPARK_VERSION=3.3.0
ENV HADOOP_VERSION=3

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

#COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css

# Setup SCALA_HOME
ENV SCALA_HOME=/usr/share/scala

# Install Scala 2.12.3
RUN SCALA_VERSION=2.12.3 && \
      apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
      apk add --no-cache bash && \
      cd "/tmp" && \
      wget "http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
      tar xzf "scala-${SCALA_VERSION}.tgz" && \
      mkdir "${SCALA_HOME}" && \
      rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
      mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
      ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
      apk del .build-dependencies && \
      rm -rf "/tmp/"*

RUN apk add --no-cache curl bash openjdk8-jre openjdk8-dbg python3 py-pip nss libc6-compat coreutils procps maven \
      && ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2 \
      && chmod +x *.sh \
      && wget ${BASE_URL}/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /

RUN cd / \
      && wget https://github.com/async-profiler/async-profiler/releases/download/v3.0/async-profiler-3.0-linux-x64.tar.gz \
      && tar -xzvf async-profiler-3.0-linux-x64.tar.gz \
      && mv async-profiler-3.0-linux-x64 asprof \
      && rm async-profiler-3.0-linux-x64.tar.gz
RUN chmod +x /asprof/bin/asprof

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

# Add JDK binaries
RUN apk add openjdk8
ENV PATH="$PATH:/usr/lib/jvm/default-jvm/bin"

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1
