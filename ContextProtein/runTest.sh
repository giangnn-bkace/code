  #---  Example of a fully-connected layer above a convolution layer 
#1nodes=10 1patch_size=7 1patch_stride=1 1padding=6 1pooling_type=Max 1pooling_size=3 1pooling_stride=2 \
 #   2nodes=10 2patch_size=5 2patch_stride=1 2padding=4 2pooling_type=Max 2pooling_size=3 2pooling_stride=2 \
 #   3nodes=10 3patch_size=3 3patch_stride=1 3padding=2 3pooling_type=Max 3pooling_size=3 3pooling_stride=2 \
gpu=-1  # <= change this to, e.g., "gpu=0" to use a specific GPU. 
dataPath=/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm
dataName=SCOP95_supfam_fam
pch_sz=9
 
for iter in 1; do
  #---  Step 3. Training and test using GPU
  logfile=${dataPath}/log-${iter}1
  #---  layer-1 is fully-connected. 
  echo 
  echo a fully-connected layer above a convolution layer ... see $logfile
  /usr/local/src/Staistics/conText-v2.00a/bin/conText $gpu cnn LessVerbose test_interval=100 random_seed=1 save_interval=300 save_fn=${dataPath}/${dataName}-p${iter}.mod \
    datatype=sparse trnname=${dataName}_${iter}.train-p${pch_sz} tstname=${dataName}_${iter}.test-p${pch_sz} x_ext=.xsmatvar y_ext=.y data_dir=$dataPath \
    layers=7 0nodes=1 0pooling_type=Max 0num_pooling=100 activ_type=Log \
    1nodes=10 1patch_size=7 1patch_stride=1 1padding=6 1pooling_type=Max 1pooling_size=3 1pooling_stride=2 \
    2nodes=10 2patch_size=5 2patch_stride=1 2padding=4 2pooling_type=Max 2pooling_size=3 2pooling_stride=2 \
    3nodes=10 3patch_size=3 3patch_stride=1 3padding=2 3pooling_type=Max 3pooling_size=3 3pooling_stride=2 \
    4nodes=100 \
    5nodes=100 \
    6nodes=100 \
    loss=Square mini_batch_size=100 momentum=0.9 step_size=0.1 top_dropout=0.5 \
    num_iterations=30000 focus_layers=0-1-2-3_0-1-2-3-4-5-6-top > $logfile
done
