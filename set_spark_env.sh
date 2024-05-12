#!/bin/bash

set -o pipefail
set -e  

git checkout Bug29351

# ======================================== 1. Set Java ===========================================
sudo apt update

sudo apt install openjdk-8-jdk -y

update-alternatives --config java   
# copy the path it shows here: /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

# ======================================== 2. Compile Spark ===========================================
echo "Compiling Spark...."
./build/mvn -DskipTests clean package &> spark_compile_output.tx

echo "export SPARK_HOME=/mnt/spark-exp/spark_bug_reproduce" >> ~/.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin" >> ~/.bashrc

source ~/.bashrc

# ======================================== 3. Install dbt ===========================================
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x99E82A75642AC823" | sudo apt-key add

sudo apt-get update
sudo apt-get install sbt -y

# ======================================== 4. Install python package ===========================================
cd ..
sudo apt install python3-pip -y
pip3 install matplotlib

# ======================================== 5. Start Master & Slave ===========================================

cd spark_bug_reproduce
./sbin/start-master.sh

./sbin/start-slave.sh spark://0.0.0.0:7077