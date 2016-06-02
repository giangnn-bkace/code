
dataPath=/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/
dataName=SCOP95_supfam_fam

for iter in 1; do 
  #---  Step 1. Generate vocabulary
  echo Generaing vocabulary from training data ... 
  vocab_fn=${dataPath}${dataName}.voc
  input_fn=${dataPath}${dataName}_${iter}.train.tok
  
  /usr/local/src/Staistics/conText-v2.00a/bin/prepText gen_vocab input_fn=$input_fn vocab_fn=$vocab_fn \
                  max_vocab_size=10000


  #---  Step 2. Generate region files (data/*.xsmatvar) and target files (data/*.y) for training and testing CNN.  
  #     We generate region vectors of the convolution layer and write them to a file, instead of making them 
  #     on the fly during training/testing.  
  echo 
  echo Generating region files ... 

  pch_sz=9  # region size
  for set in train test; do 
    rnm=${dataPath}${dataName}_${iter}.${set}-p${pch_sz}
    /usr/local/src/Staistics/conText-v2.00a/bin/prepText gen_regions \
      region_fn_stem=$rnm \
      input_fn=${dataPath}${dataName}_${iter}.${set} text_fn_ext=.tok label_fn_ext=.cat \
      vocab_fn=$vocab_fn label_dic_fn=${dataPath}${dataName}.dic \
      patch_size=$pch_sz patch_stride=1 padding=$((pch_sz-1))
  done
done


 
