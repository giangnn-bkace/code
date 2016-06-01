#read fasta file line by line an create csv file
#fasta file structure:
#	first line: amino acid sequence's name
#	second line: amino acid sequence

dataPath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/SCOP95.fasta"
savePath <- "/home/giang/Experiments/Context-Protein/Data/SCOP95/SCOP95.csv"

data <- readLines(dataPath)

nline <- length(data)
nrow <- round(nline/2)

newData <- matrix('',nrow,2)

for (i in 1:nrow) {
	newData[i,1] <- data[i*2-1]
	newData[i,2] <- data[i*2] 
}

write.table(newData,savePath,row.name=FALSE,col.names=FALSE,sep=',')

