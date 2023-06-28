#!/bin/bash

# Job
#SBATCH -p 3090
##A100-80GB 3090
# Tasks
#SBATCH --ntasks 1
#SBATCH --ntasks-per-node 1

# GPUs+
#SBATCH --gres=gpu:1

## node 지정하기
##SBATCH --nodelist=n1 # specify nodelist
#SBATCH --nodes=1 # number of nodes

# CMDs
echo "Start: `date`"

# GPU Setting
echo "UUID GPU List - original"
nvidia-smi -L # 실제 할당받은 gpu

UUIDLIST=$(nvidia-smi -L | cut -d '(' -f 2 | awk '{print$2}' | tr -d ")" | paste -s -d, -)
GPULIST=\"device=${UUIDLIST}\"

# Our Docker Setting
docker build -t pah_cut .
docker stop pah_cut_run
docker rm pah_cut_run
docker run --rm --name pah_cut_run --shm-size 16G --gpus ${GPULIST} -v /home2/ych000/data/PAH_CMCNU/checkpoints:/data/checkpoints -v /home2/ych000/data/PAH_CMCNU/dataset:/data/dataset -v /home2/ych000/data/PAH_CMCNU/results:/data/nnUNet/results pah_cut


##sinfo -O "Partition:12,Nodes:5,Nodelist:20,Gres:22,GresUsed:34,features_act:25"