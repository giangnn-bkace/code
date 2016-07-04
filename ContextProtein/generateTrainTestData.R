TRAIN_POSITIVE <- 1
TRAIN_NEGATIVE <- 2
TEST_POSITIVE <- 3
TEST_NEGATIVE <- 4

POSITIVE <- 1
NEGATIVE <- 0

OVERSAMPLING_RATIO <- 50

trainPath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam_1.train"
testPath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam_1.test"

castPath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam_1.cast"
seqPath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/SCOP95.csv"

# read category file
cast <- read.csv(castPath, header=TRUE, sep="\t", row.names=1)
# read sequence file
data <- read.csv(seqPath, header=FALSE, sep=",", quote="\"", stringsAsFactors=FALSE, row.names=1)

numTask <- ncol(cast)
nsam <- nrow(cast)

for (i in 1) {
	nTrainPositive <- sum(cast[,i]==TRAIN_POSITIVE)
	nTrainNegative <- sum(cast[,i]==TRAIN_NEGATIVE)
	nTestPositive <- sum(cast[,i]==TEST_POSITIVE)
	nTestNegative <- sum(cast[,i]==TEST_NEGATIVE)
	
	train <- matrix('', nTrainPositive * OVERSAMPLING_RATIO + nTrainNegative, 3)
	test <- matrix ('', nTestPositive + nTestNegative, 2)
	ctrain <- 0
	ctest <- 0	

	for (si in 1: nsam) {
		if (cast[si,i] == TRAIN_POSITIVE) {
			for (os in 1:OVERSAMPLING_RATIO) {			
				ctrain <- ctrain + 1
				train[ctrain,1] <- ctrain
				train[ctrain,2] <- data[si,1]
				train[ctrain,3] <- POSITIVE
			}
		} else if (cast[si,i] == TRAIN_NEGATIVE) {
			ctrain <- ctrain + 1
			train[ctrain,1] <- ctrain
			train[ctrain,2] <- data[si,1]
			train[ctrain,3] <- NEGATIVE
		} else if (cast[si,i] == TEST_POSITIVE) {
			ctest <- ctest + 1
			test[ctest,1] <- data[si,1]
			test[ctest,2] <- POSITIVE
		} else {
			ctest <- ctest + 1
			test[ctest,1] <- data[si,1]
			test[ctest,2] <- NEGATIVE
		}
	}
	
	dtrain <- data.frame(train)
	dtrain[,1] <- strtoi(dtrain[,1])
	dtrain <- dtrain[sample(dtrain[,1]),]
	
	ptrain <- dtrain[,2:3]	
		
	write.table(ptrain,trainPath,row.name=FALSE,col.names=FALSE,sep=',')
	write.table(test,testPath,row.name=FALSE,col.names=FALSE,sep=',')		
}

