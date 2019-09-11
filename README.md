# kill-stuck-spark-executor

Bash script to kill stuck Apache Spark executors.

# Background

From time to time I find my Spark jobs stuck, the CPU usage is 0-1% and there's no progress. I have spent a lot of time investigating the issue but didn't find any solution.  

The only thing that solves the problem is killing the Executor, this script is created to help automate the process.

In healthy case Spark executor would use 100% of available CPU cores (the CPU usage would be 3200% for 32-core machine). In unhealthy state the usage would be very close to 0% (in range 0-5%, instead of 3200% in the example I have used).

# Usage

Script can be executed as the user that's running Spark Executor, it works when only single Executor per machine is used

# Installation

```
curl https://raw.githubusercontent.com/wlk/kill-stuck-spark-executor/master/kill-stuck-spark-executor.sh > ~/kill-stuck-spark-executor.sh
chmod +x ~/kill-stuck-spark-executor.sh
```

# Run in cron

Script can be executed in cron, for example:

```
echo "30 * * * *  spark /home/spark/kill-stuck-spark-executor.sh" >  /etc/cron.d/kill-stuck-spark-executor
```