
library(ggplot2)

args = commandArgs(trailingOnly=TRUE)

mydata <- read.table(args[1], sep = "\t", header = F, stringsAsFactors = FALSE)

colnames(mydata) <- c("LG","pos","p1","p2","haplotypes")

reshaped_data <- data.frame(rbind(cbind(mydata$pos,mydata$p1,"p1"),cbind(mydata$pos,mydata$p2,"p2")))
colnames(reshaped_data) <- c("physical","genetic","parent")
reshaped_data$physical <- as.numeric(as.character( reshaped_data$physical ))
reshaped_data$genetic <- as.numeric(as.character( reshaped_data$genetic ))
reshaped_data$parent <- factor(as.character( reshaped_data$parent ))


reshaped_data$genetic <- reshaped_data$genetic # * (50/192)
reshaped_data$physical <- reshaped_data$physical/1000000


myplot <- ggplot(data=reshaped_data, aes(x=physical, y=genetic, colour = parent)) +
	theme_classic() +
	geom_point(size=0.2) +
	theme(strip.background = element_blank()) +
	theme(axis.text.x = element_text(colour = "black")) +
	theme(axis.text.y = element_text(colour = "black")) +
	xlab("physical position [Mbp]") +
	ylab("genetic position") +
	ggtitle(mydata$LG[1]) +
	theme(legend.position = c(0.1, 0.8))
	
	
pdf(paste(args[1],".Marey_plot.pdf",sep=""), width = 4, height = 3) # # A4 size print measures 8.27 x 11.69 inches ; 2/3 A4 width = 2.64 inch
plot(myplot)
dev.off()

