
### You need several libraries
library(circlize)
library(migest)
library(dplyr)
#filename <- "igH_prePCR.txt"
#filename <- "igH_postPCR.txt"
filename <- "igH.P2.circos.txt"
# Select a file and read the data into a data-frame
my_data <- read.csv(filename, sep="\t", header=TRUE)
# if this gives an error, make sure you have followed the steps above to set your working directory to the folder that contains the file you are trying to open

head(my_data)

# Rename the columns so we can plot things more easily without looking up which column is which
names(my_data)[1:5] <- c("count","frequency","vgene","jgene", "vj")

# At any time, you can see what your data looks like using the head() function:
head(my_data)

my_data$frequency <- my_data$frequency * 10000

#############     Now let's take a closer look at our data     ###############
# We can see how big our data is:
dim(my_data)
# We can ask our data some questions:
summary(my_data)
# We can break these down by column to see more:
summary(my_data$count)



# We can even make a new column by doing math on the other columns
#my_data$size = my_data$stop - my_data$start

# So now there's a new column
#head(my_data)

# Basic statistics:
#summary(my_data$size)

#mean(my_data$size)
#sd(my_data$size)

#median(my_data$size)
#max(my_data$size)
#min(my_data$size)

#my_data$vgene

#sum(my_data[my_data$vj %in% c("V1-J1"),]$count)


#my_data <- my_data[my_data$type %in% c("1_Active_Promoter","4_Strong_Enhancer","8_Insulator"),]
#get into m format
m <- data.frame(order = 1:17,
                country = c("IgHV1", "IgHV2", "IgHV3", "IgHV4", "IgHV5", "IgHV6", "IgHV7", "IgHV8", "IgHV9", "IgHV10", "IgHV11","IgHV12", "IgHV15", "J1", "J2", "J3","J4"),
                V1= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V1-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V1-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V1-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V1-J4"),]$frequency)+0.00001),
                V2= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V2-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V2-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V2-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V2-J4"),]$frequency)+0.00001),
                V3= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V3-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V3-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V3-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V3-J4"),]$frequency)+0.00001),
                V4= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V4-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V4-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V4-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V4-J4"),]$frequency)+0.00001),
                V5= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V5-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V5-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V5-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V5-J4"),]$frequency)+0.00001),
                V6= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V6-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V6-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V6-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V6-J4"),]$frequency)+0.00001),
                V7= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V7-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V7-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V7-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V7-J4"),]$frequency)+0.00001),
                V8= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V8-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V8-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V8-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V8-J4"),]$frequency)+0.00001),
                V9= c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V9-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V9-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V9-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V9-J4"),]$frequency)+0.00001),
                V10=c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V10-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V10-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V10-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V10-J4"),]$frequency)+0.00001),
                V11=c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V11-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V11-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V11-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V11-J4"),]$frequency)+0.00001),
                V12=c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V12-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V12-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V12-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V12-J4"),]$frequency)+0.00001),
                V15=c(1,1,1,1,1,1,1,1,1,1,1,1,1,sum(my_data[my_data$vj %in% c("V15-J1"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V15-J2"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V15-J3"),]$frequency)+0.00001,sum(my_data[my_data$vj %in% c("V15-J4"),]$frequency)+0.00001),
                J1= c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                J2= c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                J3= c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                J4= c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                r = c(255, 255,  218, 220,  123, 106,  0,  0,   0,   255, 255,  255,255,      220,  0,    210, 0),
                g = c(182, 105,   112, 20,  104, 90,    0,  0,  0,   255, 215, 218,160,        20,  0,   105, 128),
                b = c(193, 180,  214, 60,   238, 205, 255,139, 128,   0,   0,    185,122,       60, 205, 30,  0),
                stringsAsFactors = FALSE)

df1 <- m[, c(1,2, 20:22)]  #modifiesd
m <- m[,-(1:2)]/1e04
m <- as.matrix(m[,c(1:17)])  #modified
dimnames(m) <- list(orig = df1$country, dest = df1$country)
#Sort order of data.frame and matrix for plotting in circos
df1 <- arrange(df1, order)
df1$country <- factor(df1$country, levels = df1$country)
m <- m[levels(df1$country),levels(df1$country)]


### Define ranges of circos sectors and their colors (both of the sectors and the links)
df1$xmin <- 0
df1$xmax <- rowSums(m) + colSums(m)
n <- nrow(df1)
df1$rcol<-rgb(df1$r, df1$g, df1$b, max = 255)
df1$lcol<-rgb(df1$r, df1$g, df1$b, alpha=200, max = 255)

### Plot sectors (outer part)
par(mar=rep(0,4))
circos.clear()

### Basic circos graphic parameters
circos.par(cell.padding=c(0,0,0,0), track.margin=c(0,0.15), start.degree = 90, gap.degree =4)

### Sector details
circos.initialize(factors = df1$country, xlim = cbind(df1$xmin, df1$xmax))

### Plot sectors
circos.trackPlotRegion(ylim = c(0, 1), factors = df1$country, track.height=0.1,
                       #panel.fun for each sector
                       panel.fun = function(x, y) {
                         #select details of current sector
                         name = get.cell.meta.data("sector.index")
                         i = get.cell.meta.data("sector.numeric.index")
                         xlim = get.cell.meta.data("xlim")
                         ylim = get.cell.meta.data("ylim")
                         
                         #text direction (dd) and adjusmtents (aa)
                         theta = circlize(mean(xlim), 1.3)[1, 1] %% 360
                         dd <- ifelse(theta < 90 || theta > 270, "clockwise", "reverse.clockwise")
                         aa = c(1, 0.5)
                         if(theta < 90 || theta > 270)  aa = c(0, 0.5)
                         
                         #plot country labels
                         circos.text(x=mean(xlim), y=1.7, labels=name, facing = dd, cex=0.6,  adj = aa)
                         
                         #plot main sector
                         circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2], ytop=ylim[2], 
                                     col = df1$rcol[i], border=df1$rcol[i])
                         
                         #blank in part of main sector
                         circos.rect(xleft=xlim[1], ybottom=ylim[1], xright=xlim[2]-rowSums(m)[i], ytop=ylim[1]+0.3, 
                                     col = "white", border = "white")
                         
                         #white line all the way around
                         circos.rect(xleft=xlim[1], ybottom=0.3, xright=xlim[2], ytop=0.32, col = "white", border = "white")
                         
                         #plot axis
                         circos.axis(labels.cex=0.6, direction = "outside", major.at=seq(from=0,to=floor(df1$xmax)[i],by=5), 
                                     minor.ticks=1, labels.away.percentage = 0.15)
                       })

### Plot links (inner part)
### Add sum values to df1, marking the x-position of the first links
### out (sum1) and in (sum2). Updated for further links in loop below.
df1$sum1 <- colSums(m)
df1$sum2 <- numeric(n)

### Create a data.frame of the flow matrix sorted by flow size, to allow largest flow plotted first
df2 <- cbind(as.data.frame(m),orig=rownames(m),  stringsAsFactors=FALSE)
df2 <- reshape(df2, idvar="orig", varying=list(1:n), direction="long",
               timevar="dest", time=rownames(m),  v.names = "m")
df2 <- arrange(df2,desc(m))

### Keep only the largest flows to avoid clutter
df2 <- subset(df2, m > quantile(m,0.6))

### Plot links
for(k in 1:nrow(df2)){
  #i,j reference of flow matrix
  i<-match(df2$orig[k],df1$country)
  j<-match(df2$dest[k],df1$country)
  
  #plot link
  circos.link(sector.index1=df1$country[i], point1=c(df1$sum1[i], df1$sum1[i] + abs(m[i, j])),
              sector.index2=df1$country[j], point2=c(df1$sum2[j], df1$sum2[j] + abs(m[i, j])),
              col = df1$lcol[i])
  
  #update sum1 and sum2 for use when plotting the next link
  df1$sum1[i] = df1$sum1[i] + abs(m[i, j])
  df1$sum2[j] = df1$sum2[j] + abs(m[i, j])
}
