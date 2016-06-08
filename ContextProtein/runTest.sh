  #---  Example of a fully-connected layer above a convolution layer 

gpu=-1  # <= change this to, e.g., "gpu=0" to use a specific GPU. 
dataPath=/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm
dataName=SCOP95_supfam_fam
pch_sz=9
 
for iter in 1; do
  #---  Step 3. Training and test using GPU
  logfile=${dataPath}/log-${iter}
  #---  layer-1 is fully-connected. 
  echo 
  echo a fully-connected layer above a convolution layer ... see $logfile
  /usr/local/src/Staistics/conText-v2.00a/bin/conText $gpu cnn LessVerbose test_interval=25 random_seed=1 save_interval=300 save_fn=${dataPath}/${dataName}-p${iter}.mod \
    datatype=sparse trnname=${dataName}_${iter}.train-p${pch_sz} tstname=${dataName}_${iter}.test-p${pch_sz} x_ext=.xsmatvar y_ext=.y data_dir=$dataPath \
    layers=4 0nodes=10 0pooling_type=Max 0num_pooling=100 activ_type=Rect \
    0resnorm_width=500 0resnorm_type=Cross 0resnorm_alpha=1 0resnorm_beta=0.5 \
    1nodes=10 1patch_size=3 1patch_stride=1 1padding=2 1pooling_type=Avg 1pooling_size=3 1pooling_stride=2 \
    2nodes=10 2patch_size=3 2patch_stride=1 2padding=2 2pooling_type=Avg 2pooling_size=3 2pooling_stride=2 \
    3nodes=100 \
    loss=Square mini_batch_size=100 momentum=0.5 reg_L2=1e-4 step_size=0.1 top_dropout=0 \
    num_iterations=300 step_size_scheduler=Few step_size_decay=0.1 step_size_decay_at=250 \
    focus_layers=0-1-2-3-0_0-1-2-3-top > $logfile
done
