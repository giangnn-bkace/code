  #--- Example of saving a model and using cnn_predict 

  gpu=-1  # <= change this to, e.g., "gpu=0" to use a specific GPU. 
  dataPath=/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm
  dataName=SCOP95_supfam_fam
  focus=lbl0-1-2-3-4-5-6-top.
  ite=300
  pch_sz=9

for iter in 1; do
  #---  text output (slower)
  /usr/local/src/Staistics/conText-v2.00a/bin/conText $gpu cnn_predict model_fn=${dataPath}/${dataName}-p${iter}.mod.${focus}ite${ite} \
    prediction_fn=${dataPath}/${dataName}-p${iter}.pred.txt WriteText \
    datatype=sparse tstname=${dataName}_${iter}.test-p${pch_sz} x_ext=.xsmatvar data_dir=$dataPath
done
