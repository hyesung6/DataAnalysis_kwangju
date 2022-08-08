# 생활인프라 가중 평균 지수 산출

# ridge, lasso, elastic
install.packages("glmnet")
library(glmnet)

# preprocessing 
install.packages('dplyr')
library('dplyr')

# graph
install.packages('ggplot2')
library(ggplot2)

# transform _ data structure
install.packages('reshape')
library('reshape')

# csv 불러오기
dat <- read.csv(file = "C:/Users/user/Desktop/DataAnalysisStudy/Ele_Charge_Analysis_R/INFRA_real.csv", header = T)

data <- dat
data

######### statistics ###########

# head()
head(data)

# view()
View(data)

# summary()
summary(data)



# train, test data

#set.seed(100) #random_seed 
#trainIndex <- sample(1 : nrow(data), replace = F, size = 5)
#train <- data[trainIndex, ] # 학습용 데이터 80%
#test <- data[-trainIndex, ] # 테스트용 데이터 20%

#train.x <- scale(train[, -4]) # 예측변수 표준화
#train.y <- train[, 5]

#test.x <- scale(test[, -4]) 
#test.y <- test[, 5]

# 독립변수
x = as.matrix(data[,c(2:11)])

# 종속변수
y = data[,12]

x
y


lasso_model <- glmnet(x,y, family = "gaussian", alpha = 1) 
cv2 <- cv.glmnet(x, y, family = "gaussian", alpha = 1)
cv2$lambda.min

# graph
plot(lasso_model, xvar = 'lambda')
plot(cv2)


lasso_fit = glmnet(x, y, family = "gaussian", alpha=1, lambda = cv2$lambda.min)
coef(lasso_fit)
lasso_pred = predict(lasso_fit, s = cv2$lambda.min, type = 'coefficients')
lasso_pred

# 교차검정을 통한 적절한 람다 선정
# 로그(람다)에 따른 평균 교차타당오차를 나타냄
set.seed(100)
cv.lasso <- cv.glmnet(train.x, train.y , alpha = 1)
plot(cv.lasso)
(best_lambda <- cv.lasso$lambda.min)

# 적절한 람다에 따른 회귀계수 확인
(lassso_coef <- coef(lasso_model, s = best_lambda))


