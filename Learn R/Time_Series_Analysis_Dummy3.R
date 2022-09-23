# 지수평활법
# 평활치를 구하는 데 전체 데이터를 사용하며, 시간에 따라 다른 가중치를 주는 기법
# 과거 관측값은 오래될수록 지수적으로 감소하는 가중치를 가짐
# 가장 최근의 관측값에 가장 높은 가중치 부여

# package 설치를 위해 상단의 Tools -> Install Packages 사용


# 단순지수평활법
# 불규칙 성분만 고려하여 수준 추정 ( 추세와 계절의 패턴이 없는 데이터일 때 )
library(fpp2)

oildata <- fpp2::oil
oildata

# autoplot 이용해서 그래프 그리기 : 다양한 데이터 개체에 맞게 그래프 시각화
autoplot(oildata, col='purple', lwd= 2) + ggtitle("Annual oil production in Saudi Arabia")


# ses() : 단순지수평활 함수
oil.ses <- ses(oildata, h = 10)  # 10년간 석유생산량 예측측
oil.ses


# 예측모델 성능 알아보기
accuracy(oil.ses)

# 지표의 의미
# ME : Mean Error : 평균오차
# RMSE : Root Mean Squared Error : 제곱근 평균 제곱 오차
# MAE : Mean Absolute Error : 평균 절대 오차
# MPE : Mean Percentage Error : 평균 백분율 오차
# MAPE : Mean Absolute Percentage Error : 평균 절대 백분율 오차
# MASE : Mean Absolute Scaled Error : 눈금 조정된 평균 절대 오차
# ACFI : Autocorrelation of errors at lags 1 : 잔차간의 자기상관도 ==> 예측모델이 적절하여 개선 X

# 적합값 확인
tail(oil.ses$fitted, 1)

# 관측값 확인
tail(oil.ses$x, 1)

# 잔차 확인
tail(oil.ses$residuals, 1)

# 그래프 그리기
autoplot(oil.ses) + autolayer(oil.ses$x, series = "관측값", lwd = 1.5) +
  autolayer(oil.ses$fitted, series = "적합값", lwd=1.5) + ylab("Oil (millions of tonnes)") +
  xlab("Year") + ggtitle("Annual oil production if Saudi Arabia")


# 이중지수평활법 : 추세 성분도 고려하여 수준과 기울기를 추정 ( 단순지수평활법을 두 번 적용 )
# ==> 추세를 갖는 시계열 예측 모델 생성
# 홀트-윈터 지수평활법 : 계절 성분도 고려하여 수준, 기울기, 계절 요인 추정

# Electricity slaes to residential customers in South Australia
# Annual electricity slaes for South Australia in GWh from 1989 to 2008. 
elecsales <- fpp2::elecsales
elecsales

# 그래프로 시계열 데이터 확인
autoplot(elecsales, col = 'green', lwd= 2)+
  xlab("Year") + ylab("Electricity Sales (Gwh)") +
  ggtitle("Electricity Sales in South Australia")

# 홀트 지수 평활법 이용
# holt() : 선형 추세 또는 감쇠 추세에 대한 holt의 2개 매개변수 지수평활 함수
elecsales.holt <- holt(elecsales, h = 10)
elecsales.holt

# 정확도 확인
accuracy(elecsales.holt)

# 적합값 확인
tail(elecsales.holt$fitted, 1)

# 관측값 확인
tail(elecsales.holt$x, 1)

# 잔차 확인
tail(elecsales.holt$residuals, 1)

# 홀트 지수 평활법 이용 그래프 그리기
autoplot(elecsales.holt) + autolayer(elecsales.holt$x, lwd = 1.5, series = "관측값")+
  autolayer(elecsales.holt$fitted, lwd =1.5 , series = "적합값") + xlab("Year") + ylab("Electricity Sales (Gwh)") + ggtitle("Electricity Sales in South Australia")


## 홀트-윈터 지수평활법
aust <- fpp2::austourists
aust

# 그래프 그리기
autoplot(aust, col='royalblue', lwd=2) + xlab("Year") + ylab("Total Visitor Nights") +
  ggtitle("International Tourists to Australia")

# 홀트윈터지수 평활법의 계절 성분은 덧셈 기법과 곱셈 기법으로 나누어 짐
# 덧셈 : 계절성이 있는 시계열 데이터의 전반적인 진행이 일정할 때
# 곱셈 : 계절성이 있는 시계열 데이터의 진행이 수준에 비례하게 진행할 때