#####Sentinel-2 Band별 데이터 정리####
dataset <- data.frame(read.csv("S2 band data path here")) # 데이터셋 로드
dataset <- subset(dataset, select = c("system.index", "B2", "B3", "B4", "B8", "ndvi", "BUFF_DIST", "Location"))  # 사용할 컬럼만 추출
names(dataset)[1] <- c("Date")  # column 이름 변경
names(dataset)[2] <- c("BLU")
names(dataset)[3] <- c("GRN")
names(dataset)[4] <- c("RED")
names(dataset)[5] <- c("NIR")
dataset[1] <- substr(dataset$Date, 1, 8)  # Date 필드값 8글자까지만 사용

dataset[dataset < 0] <- NA
dataset[2] <- dataset[2] * 0.0001
dataset[3] <- dataset[3] * 0.0001
dataset[4] <- dataset[4] * 0.0001
dataset[5] <- dataset[5] * 0.0001

#### GBK, AMD, WD, HC, PYC, SC, JJ, GCK, HAWS1 별로 분리 ####
### GBK Code ###
GBK <- dataset[intersect(
  which(dataset$Location == 'GBK'),
  which(dataset$ndvi > 0.0001)),] # 해당 Location의 ndvi 값이 있는 row만 추출

GBK_5M <- GBK[GBK$BUFF_DIST == 5, 1:6]
GBK_10M <- GBK[GBK$BUFF_DIST == 10, 1:6]
GBK_15M <- GBK[GBK$BUFF_DIST == 15, 1:6]
GBK_20M <- GBK[GBK$BUFF_DIST == 20, 1:6]
GBK_25M <- GBK[GBK$BUFF_DIST == 25, 1:6]
GBK_30M <- GBK[GBK$BUFF_DIST == 30, 1:6]

names(GBK_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(GBK_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(GBK_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(GBK_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(GBK_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(GBK_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### AMD Code ###
AMD <- dataset[intersect(
  which(dataset$Location == 'AMD'),
  which(dataset$ndvi > 0.0001)),] 

AMD_5M <- AMD[AMD$BUFF_DIST == 5, 1:6]
AMD_10M <- AMD[AMD$BUFF_DIST == 10, 1:6]
AMD_15M <- AMD[AMD$BUFF_DIST == 15, 1:6]
AMD_20M <- AMD[AMD$BUFF_DIST == 20, 1:6]
AMD_25M <- AMD[AMD$BUFF_DIST == 25, 1:6]
AMD_30M <- AMD[AMD$BUFF_DIST == 30, 1:6]

names(AMD_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(AMD_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(AMD_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(AMD_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(AMD_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(AMD_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### WD Code ###
WD <- dataset[intersect(
  which(dataset$Location == 'WD'),
  which(dataset$ndvi > 0.0001)),] 

WD_5M <- WD[WD$BUFF_DIST == 5, 1:6]
WD_10M <- WD[WD$BUFF_DIST == 10, 1:6]
WD_15M <- WD[WD$BUFF_DIST == 15, 1:6]
WD_20M <- WD[WD$BUFF_DIST == 20, 1:6]
WD_25M <- WD[WD$BUFF_DIST == 25, 1:6]
WD_30M <- WD[WD$BUFF_DIST == 30, 1:6]

names(WD_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(WD_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(WD_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(WD_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(WD_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(WD_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### HC Code ###
HC <- dataset[intersect(
  which(dataset$Location == 'HC'),
  which(dataset$ndvi > 0.0001)),] 

HC_5M <- HC[HC$BUFF_DIST == 5, 1:6]
HC_10M <- HC[HC$BUFF_DIST == 10, 1:6]
HC_15M <- HC[HC$BUFF_DIST == 15, 1:6]
HC_20M <- HC[HC$BUFF_DIST == 20, 1:6]
HC_25M <- HC[HC$BUFF_DIST == 25, 1:6]
HC_30M <- HC[HC$BUFF_DIST == 30, 1:6]

names(HC_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(HC_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(HC_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(HC_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(HC_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(HC_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### PYC Code ###
PYC <- dataset[intersect(
  which(dataset$Location == 'PYC'),
  which(dataset$ndvi > 0.0001)),]

PYC_5M <- PYC[PYC$BUFF_DIST == 5, 1:6]
PYC_10M <- PYC[PYC$BUFF_DIST == 10, 1:6]
PYC_15M <- PYC[PYC$BUFF_DIST == 15, 1:6]
PYC_20M <- PYC[PYC$BUFF_DIST == 20, 1:6]
PYC_25M <- PYC[PYC$BUFF_DIST == 25, 1:6]
PYC_30M <- PYC[PYC$BUFF_DIST == 30, 1:6]

names(PYC_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(PYC_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(PYC_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(PYC_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(PYC_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(PYC_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### SC Code ###
SC <- dataset[intersect(
  which(dataset$Location == 'SC'),
  which(dataset$ndvi > 0.0001)),] 

SC_5M <- SC[SC$BUFF_DIST == 5, 1:6]
SC_10M <- SC[SC$BUFF_DIST == 10, 1:6]
SC_15M <- SC[SC$BUFF_DIST == 15, 1:6]
SC_20M <- SC[SC$BUFF_DIST == 20, 1:6]
SC_25M <- SC[SC$BUFF_DIST == 25, 1:6]
SC_30M <- SC[SC$BUFF_DIST == 30, 1:6]

names(SC_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(SC_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(SC_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(SC_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(SC_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(SC_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### JJ Code ###
JJ <- dataset[intersect(
  which(dataset$Location == 'JJ'),
  which(dataset$ndvi > 0.0001)),]

JJ_5M <- JJ[JJ$BUFF_DIST == 5, 1:6]
JJ_10M <- JJ[JJ$BUFF_DIST == 10, 1:6]
JJ_15M <- JJ[JJ$BUFF_DIST == 15, 1:6]
JJ_20M <- JJ[JJ$BUFF_DIST == 20, 1:6]
JJ_25M <- JJ[JJ$BUFF_DIST == 25, 1:6]
JJ_30M <- JJ[JJ$BUFF_DIST == 30, 1:6]

names(JJ_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(JJ_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(JJ_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(JJ_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(JJ_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(JJ_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### GCK Code ###
GCK <- dataset[intersect(
  which(dataset$Location == 'GCK'),
  which(dataset$ndvi > 0.0001)),]

GCK_5M <- GCK[GCK$BUFF_DIST == 5, 1:6]
GCK_10M <- GCK[GCK$BUFF_DIST == 10, 1:6]
GCK_15M <- GCK[GCK$BUFF_DIST == 15, 1:6]
GCK_20M <- GCK[GCK$BUFF_DIST == 20, 1:6]
GCK_25M <- GCK[GCK$BUFF_DIST == 25, 1:6]
GCK_30M <- GCK[GCK$BUFF_DIST == 30, 1:6]

names(GCK_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(GCK_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(GCK_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(GCK_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(GCK_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(GCK_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")

### HAWS1 Code ###
HAWS1 <- dataset[intersect(
  which(dataset$Location == 'HAWS1'),
  which(dataset$ndvi > 0.0001)),] 

HAWS1_5M <- HAWS1[HAWS1$BUFF_DIST == 5, 1:6]
HAWS1_10M <- HAWS1[HAWS1$BUFF_DIST == 10, 1:6]
HAWS1_15M <- HAWS1[HAWS1$BUFF_DIST == 15, 1:6]
HAWS1_20M <- HAWS1[HAWS1$BUFF_DIST == 20, 1:6]
HAWS1_25M <- HAWS1[HAWS1$BUFF_DIST == 25, 1:6]
HAWS1_30M <- HAWS1[HAWS1$BUFF_DIST == 30, 1:6]

names(HAWS1_5M) <- c("Date", "BLU_5M", "GRN_5M", "RED_5M", "NIR_5M", "NDVI_5M")
names(HAWS1_10M) <- c("Date", "BLU_10M", "GRN_10M", "RED_10M", "NIR_10M", "NDVI_10M")
names(HAWS1_15M) <- c("Date", "BLU_15M", "GRN_15M", "RED_15M", "NIR_15M", "NDVI_15M")
names(HAWS1_20M) <- c("Date", "BLU_20M", "GRN_20M", "RED_20M", "NIR_20M", "NDVI_20M")
names(HAWS1_25M) <- c("Date", "BLU_25M", "GRN_25M", "RED_25M", "NIR_25M", "NDVI_25M")
names(HAWS1_30M) <- c("Date", "BLU_30M", "GRN_30M", "RED_30M", "NIR_30M", "NDVI_30M")



##### 4S 데이터 정리 #####
GBK36<-read_excel("4S data path here")
GBK26<-read_excel("4S data path here")
GCK<-read_excel("4S data path here")
HAWS1<-read_excel("4S data path here")
HC<-read_excel("4S data path here")
PYC<-read_excel("4S data path here")
WD<-read_excel("4S data path here")


head(GBK36)
names(GBK36)

#1자리수를 2자리수로 변환하는 명령어
#sprintf("%02d",GBK36$Month)

Date_4S_GBK36 <- paste0(GBK36$Year, sprintf("%02d",GBK36$Month), 
                        sprintf("%02d",GBK36$Date))
Date_4S_GBK26 <- paste0(GBK26$Year, sprintf("%02d",GBK26$Month), 
                        sprintf("%02d",GBK26$Date))
Date_4S_GCK <- paste0(GCK$Year, sprintf("%02d",GCK$Month), 
                      sprintf("%02d",GCK$Date))
Date_4S_HAWS1 <- paste0(HAWS1$Year, sprintf("%02d",HAWS1$Month), 
                        sprintf("%02d",HAWS1$Date))
Date_4S_HC <- paste0(HC$Year, sprintf("%02d",HC$Month), 
                     sprintf("%02d",HC$Date))
Date_4S_PYC <- paste0(PYC$Year, sprintf("%02d",PYC$Month), 
                      sprintf("%02d",PYC$Date))
Date_4S_WD <- paste0(WD$Year, sprintf("%02d",WD$Month), 
                     sprintf("%02d",WD$Date))


GBK36.mod <- cbind(Date_4S_GBK36, GBK36[,-1:-14])
GBK26.mod <- cbind(Date_4S_GBK26, GBK26[,-1:-14])
GCK.mod <- cbind(Date_4S_GCK, GCK[,-1:-14])
HAWS1.mod <- cbind(Date_4S_HAWS1, HAWS1[,-1:-14])
HC.mod <- cbind(Date_4S_HC, HC[,-1:-14])
PYC.mod <- cbind(Date_4S_PYC, PYC[,-1:-14])
WD.mod <- cbind(Date_4S_WD, WD[,-1:-14])

names(GBK36.mod) <- c("Date", names(GBK36.mod[-1]))
names(GBK26.mod) <- c("Date", names(GBK26.mod[-1]))
names(GCK.mod) <- c("Date", names(GCK.mod[-1]))
names(HAWS1.mod) <- c("Date", names(HAWS1.mod[-1]))
names(HC.mod) <- c("Date", names(HC.mod[-1]))
names(PYC.mod) <- c("Date", names(PYC.mod[-1]))
names(WD.mod) <- c("Date", names(WD.mod[-1]))

#head(GBK36.mod)
#head(WD.mod)


##### 파일합치기 #####
GBK36_total <- inner_join(GBK_5M, GBK_10M, by=c("Date"))%>%
  inner_join(., GBK_15M, by=c("Date"))%>%
  inner_join(., GBK_20M, by=c("Date"))%>%
  inner_join(., GBK_25M, by=c("Date"))%>%
  inner_join(., GBK_30M, by=c("Date"))%>%
  inner_join(., GBK36.mod, by=c("Date"))

rownames(GBK36_total) <- NULL

names(GBK36_total) <- c("Date", names(GBK_5M[-1]), names(GBK_10M[-1]),
                        names(GBK_15M[-1]), names(GBK_20M[-1]),
                        names(GBK_25M[-1]), names(GBK_30M[-1]),
                        names(GBK36.mod[-1]))

GBK26_total <- inner_join(GBK_5M, GBK_10M, by=c("Date"))%>%
  inner_join(., GBK_15M, by=c("Date"))%>%
  inner_join(., GBK_20M, by=c("Date"))%>%
  inner_join(., GBK_25M, by=c("Date"))%>%
  inner_join(., GBK_30M, by=c("Date"))%>%
  inner_join(., GBK26.mod, by=c("Date"))

rownames(GBK26_total) <- NULL

names(GBK26_total) <- c("Date", names(GBK_5M[-1]), names(GBK_10M[-1]),
                        names(GBK_15M[-1]), names(GBK_20M[-1]),
                        names(GBK_25M[-1]), names(GBK_30M[-1]),
                        names(GBK26.mod[-1]))

GCK_total <- inner_join(GCK_5M, GCK_10M, by=c("Date"))%>%
  inner_join(., GCK_15M, by=c("Date"))%>%
  inner_join(., GCK_20M, by=c("Date"))%>%
  inner_join(., GCK_25M, by=c("Date"))%>%
  inner_join(., GCK_30M, by=c("Date"))%>%
  inner_join(., GCK.mod, by=c("Date"))

rownames(GCK_total) <- NULL

names(GCK_total) <- c("Date", names(GCK_5M[-1]), names(GCK_10M[-1]),
                      names(GCK_15M[-1]), names(GCK_20M[-1]), names(GCK_25M[-1]),
                      names(GCK_30M[-1]), names(GCK.mod[-1]))

HAWS1_total <- inner_join(HAWS1_5M, HAWS1_10M, by=c("Date"))%>%
  inner_join(., HAWS1_15M, by=c("Date"))%>%
  inner_join(., HAWS1_20M, by=c("Date"))%>%
  inner_join(., HAWS1_25M, by=c("Date"))%>%
  inner_join(., HAWS1_30M, by=c("Date"))%>%
  inner_join(., HAWS1.mod, by=c("Date"))

rownames(HAWS1_total) <- NULL

names(HAWS1_total) <- c("Date", names(HAWS1_5M[-1]), names(HAWS1_10M[-1]),
                        names(HAWS1_15M[-1]), names(HAWS1_20M[-1]), names(HAWS1_25M[-1]),
                        names(HAWS1_30M[-1]), names(HAWS1.mod[-1]))

HC_total <- inner_join(HC_5M, HC_10M, by=c("Date"))%>%
  inner_join(., HC_15M, by=c("Date"))%>%
  inner_join(., HC_20M, by=c("Date"))%>%
  inner_join(., HC_25M, by=c("Date"))%>%
  inner_join(., HC_30M, by=c("Date"))%>%
  inner_join(., HC.mod, by=c("Date"))

rownames(HC_total) <- NULL

names(HC_total) <- c("Date", names(HC_5M[-1]), names(HC_10M[-1]),
                     names(HC_15M[-1]), names(HC_20M[-1]), names(HC_25M[-1]),
                     names(HC_30M[-1]), names(HC.mod[-1]))

PYC_total <- inner_join(PYC_5M, PYC_10M, by=c("Date"))%>%
  inner_join(., PYC_15M, by=c("Date"))%>%
  inner_join(., PYC_20M, by=c("Date"))%>%
  inner_join(., PYC_25M, by=c("Date"))%>%
  inner_join(., PYC_30M, by=c("Date"))%>%
  inner_join(., PYC.mod, by=c("Date"))

rownames(PYC_total) <- NULL

names(PYC_total) <- c("Date", names(PYC_5M[-1]), names(PYC_10M[-1]),
                      names(PYC_15M[-1]), names(PYC_20M[-1]), names(PYC_25M[-1]),
                      names(PYC_30M[-1]), names(PYC.mod[-1]))

WD_total <- inner_join(WD_5M, WD_10M, by=c("Date"))%>%
  inner_join(., WD_15M, by=c("Date"))%>%
  inner_join(., WD_20M, by=c("Date"))%>%
  inner_join(., WD_25M, by=c("Date"))%>%
  inner_join(., WD_30M, by=c("Date"))%>%
  inner_join(., WD.mod, by=c("Date"))

rownames(WD_total) <- NULL

names(WD_total) <- c("Date", names(WD_5M[-1]), names(WD_10M[-1]),
                     names(WD_15M[-1]), names(WD_20M[-1]), names(WD_25M[-1]),
                     names(WD_30M[-1]), names(WD.mod[-1]))

head(WD_total)


GBK36_total <- GBK36_total[complete.cases(GBK36_total[,]), ]
GBK26_total <- GBK26_total[complete.cases(GBK26_total[,]), ]
GCK_total <- GCK_total[complete.cases(GCK_total[,]), ]
HAWS1_total <- HAWS1_total[complete.cases(HAWS1_total[,]), ]
HC_total <- HC_total[complete.cases(HC_total[,]), ]
PYC_total <- PYC_total[complete.cases(PYC_total[,]), ]
WD_total <- WD_total[complete.cases(WD_total[,]), ]


##### 파일 저장하기 #####
writexl::write_xlsx(GBK36_total,"path to write total data here")
writexl::write_xlsx(GBK26_total,"path to write total data here")
writexl::write_xlsx(GCK_total,"path to write total data here")
writexl::write_xlsx(HAWS1_total,"path to write total data here")
writexl::write_xlsx(HC_total,"path to write total data here")
writexl::write_xlsx(PYC_total,"path to write total data here")
writexl::write_xlsx(WD_total,"path to write total data here")