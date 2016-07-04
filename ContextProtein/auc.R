library(AUC)

predict_path <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam-p1.pred.txt"
test_path <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam_1.test.cat"

predict <- read.csv(predict_path,header=FALSE, sep=" ")
test <- read.csv(test_path,header=FALSE, sep=" ")

test$V1 <- factor(test$V1)

auc(roc(predict$V2,test$V1))

