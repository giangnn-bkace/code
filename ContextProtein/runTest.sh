  #---  Example of a fully-connected layer above a convolution layer 

gpu=-1  # <= change this to, e.g., "gpu=0" to use a specific GPU. 
dataPath=/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/
dataName=SCOP95_supfam_fam
pch_sz=9
 
for iter in 1; do
  #---  Step 3. Training and test using GPU
  logfile=log_output/log-${iter}
  #---  layer-1 is fully-connected. 
  echo 
  echo a fully-connected layer above a convolution layer ... see $logfile
  /usr/local/src/Staistics/conText-v2.00a/bin/conText $gpu cnn LessVerbose test_interval=25 random_seed=1 \
    datatype=sparse trnname=${dataName}.train-p${pch_sz} tstname=${dataName}.test-p${pch_sz} x_ext=.xsmatvar y_ext=.y data_dir=$dataPath \
    layers=2 0nodes=500 0pooling_type=Max 0num_pooling=1 0activ_type=Rect \
    0resnorm_width=500 0resnorm_type=Cross 0resnorm_alpha=1 0resnorm_beta=0.5 \
    1nodes=100 1activ_type=Rect \
    loss=Square mini_batch_size=100 momentum=0.9 reg_L2=1e-4 step_size=0.25 \
    num_iterations=60 step_size_scheduler=Few step_size_decay=0.1 step_size_decay_at=55 > $logfile
done
