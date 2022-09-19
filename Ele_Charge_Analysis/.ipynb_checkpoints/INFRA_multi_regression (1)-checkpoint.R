install.packages("car")
library("car")

install.packages("corrplot")
library("corrplot")

install.packages("ggcorrplot")
library("ggcorrplot")

# csv file upload
dat <- read.csv(file = "C:/Users/user/Desktop/DataAnalysisStudy/Ele_Charge_Analysis_R/INFRA_real_real.csv", header = T)

infra_data <- dat
infra_data

# missing value 
is.na(infra_data)

sum(is.na(infra_data))

colSums(is.na(infra_data))

# 통계지표 
str(infra_data)

summary(infra_data)


# sampling
set.seed(1234)
idx = sample(nrow(infra_data), nrow(infra_data))
idx

# train, test data 8:2
train = infra_data[idx, ]
test = infra_data[idx, ]

# dimension 
dim(train)
dim(test)


# Pearson correlation
infra_cor = cor(data[,c(2:12)])
round(infra_cor, 2)

# heatmap ver.1
ggcorrplot(infra_cor)

# heatmap ver.2
corrplot(infra_cor)

# heatmap ver.3
corrplot(infra_cor, type = 'lower', order = 'hclust', tl.srt = 45)


# multiple linear regression 
result = lm(formula = CHARGE ~ TRAD + CONCERT + OLD + MART + LIB + ART + MUS + MED
            + COMM + SPORT, data = data)

result

summary(result)

# variance inflation factor(VIF) -> 10 이상일 경우 다중공선성 문제
vif(result)





# par(mfrow=c(2,2))
# plot(result)
# par(mfrow=c(1,1))

