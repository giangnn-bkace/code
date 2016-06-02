# transform sequences in to sentences of words and seperate data file to sequence file and category file
WORD_SIZE <- 1
STEP <- 1


filePath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/superfarm-farm/SCOP95_supfam_fam"

setType <- c("train", "test")

for (i in 1) {
	for (ext in setType) {
		dataPath <- paste(filePath, "_", i, ".", ext, sep='')
		tokPath <- paste(dataPath, ".tok", sep='')
		castPath <- paste(dataPath, ".cat", sep='')
		
		data <- read.csv(dataPath, header=FALSE, sep=",", stringsAsFactors=FALSE)
		numSam <- nrow(data)
		tok <- matrix("",numSam,1)
		cast <- matrix("",numSam,1)

		for (iter in 1:numSam) {
			seq <- data[iter,1]
			seqLength <- nchar(seq)
			tokSeq <- ""
			pos <- 1
			while (pos + WORD_SIZE - 1 <= seqLength) {
				tokSeq <- paste(tokSeq,substr(seq,pos,pos+WORD_SIZE-1),sep=" ")
				pos <- pos + STEP
			}
			tokSeq <- substr(tokSeq,2,nchar(tokSeq))
			
			tok[iter,1] <- tokSeq
			cast[iter,1] <- data[iter,2]
		}
		
		write.table(tok,tokPath,row.name=FALSE,col.names=FALSE,sep=',', quote=FALSE)
		write.table(cast,castPath,row.name=FALSE,col.names=FALSE,sep=',', quote=FALSE)
	}
}

