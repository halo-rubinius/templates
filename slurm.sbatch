#!/bin/bash

# 任务名称，可以修改jobname
#SBATCH --job-name=MT

# 输出所导向的文件，可以修改output.log
#SBATCH --output=output.log

# MPI所需的总进程数，可以按需修改
#SBATCH --ntasks=10

# 每个节点分配的最大进程数，按需设置这个数值
# 集群1个节点20个CPU，所以这个值理想状态应不大于20
# 也可以不设置，就把下面这行删掉，让slurm根据总进程数自动分配
##SBATCH --ntasks-per-node=10

#SBATCH --nodes=1

# 没有OpenMP，所以只需要1个主线程，无需修改
#SBATCH --cpus-per-task=2

# 指定在哪些节点上运行
#    单个节点:     node26
#    多个相邻节点   node31-34
#    混合形式:     node[26,31-34,38]
# 如果不指定节点，可以由slurm自动分配，那么删除下面这行
##SBATCH --nodelist=node[26,38]


module purge > /dev/null 2>&1

echo "程序开始时间: `date`"
echo "节点: `hostname`"
echo "程序工作目录: `pwd`"
echo -e "\n"

source ~/Desktop/llb/vars.sh

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# 程序的名称，根据自己程序的名称修改TEST
mpirun ~/Desktop/llb/MPI_ModEM/MT -I LBFGS wkpinv.MTmodel ZTMTinv.dat control.inv control.fwd wkp.cov

echo -e "\n"
echo "程序结束时间: `date`"
