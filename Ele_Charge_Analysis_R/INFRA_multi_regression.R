# csv 불러오기
dat <- read.csv(file = "C:/Users/user/Desktop/data/INFRA_real.csv", header = T)

data <- dat
data

# 통계지표 
str(data)
summary(data)



set.seed(1234)
idx = sample(nrow(data), nrow(data))
idx

train = data[idx, ]
test = data[idx, ]


dim(train)
dim(test)

colnames(train)

# VIF 확인
result = lm(formula = CHARGE ~ TRAD + CONCERT + OLD + MART + LIB + ART + MUS + MED
            + COMM + SPORT, data = data)

result

summary(result)

par(mfrow=c(2,2))
plot(result)
par(mfrow=c(1,1))

