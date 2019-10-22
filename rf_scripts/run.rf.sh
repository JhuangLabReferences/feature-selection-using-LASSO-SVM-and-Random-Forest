#!/bin/bash -l
echo "=========================================================="
echo "Starting on : $(date)"
echo "Running on node : $(hostname)"
echo "Current directory : $(pwd)"
echo "Current job ID : $JOB_ID"
echo "Current job name : $JOB_NAME"
echo "Task index number : $SGE_TASK_ID"
echo "=========================================================="


module load python/3.6.2
script=$1
pop=$2
model=$3
metric=$4
ntree=$5

jname=$pop.m$model.$metric.$ntree.tree

echo $jname

fn_qlog=/m$model/result/$jname.qlog
cmd="$script $pop $model $metric $ntree"

# the script will only work with 28 cores otherwise it will stop unfinished without errors
qsubcmd="qsub -P casa -j y -o $fn_qlog  -pe omp 28 -l h_rt=120:00:00 -N $jname -S $(which python) -V $cmd"
echo $qsubcmd
eval $qsubcmd



echo "=========================================================="
echo "Finished on : $(date)"
echo "=========================================================="

# -l mem_per_core=18G -pe omp 28 -l h_rt=200:00:00 
