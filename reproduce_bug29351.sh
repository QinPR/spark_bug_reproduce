#!/bin/bash

set -o pipefail
set -e  


# ======================================== 1. Run Reproduction cases ===========================================

# submit (10000)
/mnt/spark-exp/spark_bug_reproduce/bin/spark-submit --conf "spark.executor.extraJavaOptions=-XX:+UseG1GC"   --class Bug29351   --master spark://0.0.0.0:7077   --num-executors 256   --executor-cores 1   --conf "spark.dynamicAllocation.enabled=false"   /mnt/spark-exp/spark_bug_reproduce/Bug_tests_jobs/bug29351_2.11_10000-0.1.jar &> output_10000.txt

# submit (50000)
/mnt/spark-exp/spark_bug_reproduce/bin/spark-submit --conf "spark.executor.extraJavaOptions=-XX:+UseG1GC"   --class Bug29351   --master spark://0.0.0.0:7077   --num-executors 256   --executor-cores 1   --conf "spark.dynamicAllocation.enabled=false"   /mnt/spark-exp/spark_bug_reproduce/Bug_tests_jobs/bug29351_2.11_50000-0.1.jar &> output_50000.txt

# submit (100000)
/mnt/spark-exp/spark_bug_reproduce/bin/spark-submit --conf "spark.executor.extraJavaOptions=-XX:+UseG1GC"   --class Bug29351   --master spark://0.0.0.0:7077   --num-executors 256   --executor-cores 1   --conf "spark.dynamicAllocation.enabled=false"   /mnt/spark-exp/spark_bug_reproduce/Bug_tests_jobs/bug29351_2.11_100000-0.1.jar &> output_100000.txt


# ======================================== 2. Plot the graph ===========================================
python3 plot_Chart.py