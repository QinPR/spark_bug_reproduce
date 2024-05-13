#!/bin/bash

set -o pipefail
set -e  

git checkout Bug29351_fix

# ======================================== 1. Compile Spark ===========================================
echo "Compiling Spark...."
./build/mvn -DskipTests clean package &> spark_compile_output.tx


# ======================================== 5. Start Master & Slave ===========================================

cd /mnt/spark-exp/spark_bug_reproduce
./sbin/start-master.sh

./sbin/start-slave.sh spark://0.0.0.0:7077