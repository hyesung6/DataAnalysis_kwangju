data_JJ <- data_JJ[,c(1, 2, 5, 11, 10, 7, 14, 20, 19, 16)]
names(data_JJ) <- c("TIMESTAMP", "RECORD", 
                    "UP1CalBLU", "UP1CalNIR", "UP1CalRED", "UP1CalGRN", 
                    "DN1CalBLU", "DN1CalNIR", "DN1CalRED", "DN1CalGRN")

a_JJ <- data_JJ[,1]

a_JJ.split <- str_split(a_JJ, " ", simplify = T)

a_JJ.split.date <- data.frame(str_split(a_JJ.split[,1], "-", simplify = T))
a_JJ.split.time <- data.frame(str_split(a_JJ.split[,2], ":", simplify = T))

names(a_JJ.split.date) <- c("Year", "Month", "Date")
names(a_JJ.split.time) <- c("Hour", "Minute")
View(a_JJ.split.time)
data_JJ.mod2 <- cbind(a_JJ.split.date, a_JJ.split.time, data_JJ[,-1])

data_JJ.mod3 <- subset(data_JJ.mod2, subset = Hour == 11 & Minute <= 20)

for(i in 1:length(data_JJ.mod3)){
  imsi_JJ = as.numeric(data_JJ.mod3[,i])
  imsi_JJ[is.na(imsi_JJ)] <- 0     #해당 열에서 NA 값이 있을 경우 0으로 변환
  data_JJ.mod3[,i] <- imsi_JJ
}


new.data_JJ.list <- list(name = "data_JJ.col.means.by.date")
for(j in 2021:2022){
  data_JJ.mod3.j <- subset(data_JJ.mod3, subset = Year == j)
  for(k in 1:12){
    data_JJ.mod3.j.k <- subset(data_JJ.mod3.j, subset = Month == k)
    for(l in 1:31){
      data_JJ.mod3.j.k.l <- subset(data_JJ.mod3.j.k, subset = Date == l)
      col.mean_JJ <- data.frame(t(colMeans(data_JJ.mod3.j.k.l[,-1:-6])))
      new.data_JJ <- cbind(data_JJ.mod3.j.k.l[1,1:3], col.mean_JJ)
      new.data_JJ.list <- c(new.data_JJ.list, list(new.data_JJ))
    }
  }
}

new.data_JJ.frame <- do.call(rbind.data.frame, new.data_JJ.list)
new.data_JJ.frame <- new.data_JJ.frame[complete.cases(new.data_JJ.frame[,]), ]
new.data_JJ.frame <- new.data_JJ.frame[-1,]

for(m in 1:length(new.data_JJ.frame)){
  imsi1_JJ = as.numeric(new.data_JJ.frame[,m])
  new.data_JJ.frame[,m] <- imsi1_JJ
}

Ref_BLU_JJ <- data.frame(new.data_JJ.frame$DN1CalBLU/new.data_JJ.frame$UP1CalBLU)
Ref_GRN_JJ <- data.frame(new.data_JJ.frame$DN1CalGRN/new.data_JJ.frame$UP1CalGRN)
Ref_RED_JJ <- data.frame(new.data_JJ.frame$DN1CalRED/new.data_JJ.frame$UP1CalRED)
Ref_NIR_JJ <- data.frame(new.data_JJ.frame$DN1CalNIR/new.data_JJ.frame$UP1CalNIR)
NDVI_JJ <- data.frame((Ref_NIR_JJ-Ref_RED_JJ)/(Ref_NIR_JJ+Ref_RED_JJ))

Ref_JJ <- cbind(Ref_BLU_JJ, Ref_GRN_JJ, Ref_RED_JJ, Ref_NIR_JJ, NDVI_JJ)
names(Ref_JJ) <- c("Ref_BLU", "Ref_GRN", "Ref_RED", "Ref_NIR", "NDVI")

final.data_JJ <- cbind(new.data_JJ.frame, Ref_JJ)
View(final.data_JJ)