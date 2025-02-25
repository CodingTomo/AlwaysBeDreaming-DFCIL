
# process inputs
DEFAULTGPU=0
GPUID=${1:-$DEFAULTGPU}
DEFAULTDR="datasets"
DATAROOT=${2:-$DEFAULTDR}

# benchmark settings
SPLIT=20
OUTDIR=outputs/abd/tiny/10_task


###############################################################

# make save directory
mkdir -p $OUTDIR

# load saved models
OVERWRITE=0

# number of tasks to run
MAXTASK=-1

# hard coded inputs
REPEAT=3
SCHEDULE="30 60 80 90 100"
PI=10000
MODELNAME=resnet18
BS=64
WD=0.0001
MOM=0.9
OPT="SGD"
LR=0.1
 
# #########################
# #         OURS          #
# #########################

# Full Method
 python -u run_dfcil.py --dataset TinyImageNet --train_aug --rand_split --gpuid $GPUID --repeat $REPEAT --dataroot /Scratch/Magistri/cl_data \
     --first_split_size $SPLIT --other_split_size $SPLIT --schedule $SCHEDULE --schedule_type decay --batch_size $BS \
     --optimizer $OPT --lr $LR --momentum $MOM --weight_decay $WD \
     --mu 1e-1 --memory 0 --model_name $MODELNAME --model_type resnet \
     --learner_type datafree --learner_name AlwaysBeDreaming \
     --gen_model_name TINYIMNET_GEN --gen_model_type generator \
     --beta 1 --power_iters $PI --deep_inv_params 1e-3 5e1 1e-3 1e3 1 \
     --overwrite $OVERWRITE --max_task $MAXTASK --log_dir ${OUTDIR}/abd

