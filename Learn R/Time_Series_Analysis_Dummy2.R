# 평활법
# 평균을 취해서 시계열 데이터의 노이즈를 제거, 감소시켜서
# 데이터의 품질을 높이는 방법

# 평활법의 종류로는 이동평균법, 지수평활법 등이 있다.

# 이동평균법
# 매 시점에서 직전 N개의 데이터 평균을 산출하여, 다음 시점의 예측치로 사용
# 즉 과거로부터 현재까지의 시계열 자료를 대상으로 일정기간별 이동평균을계산
# 이들의 추세를 파악하여 다음 기간을 예측하는 방법

# 이동평균법의 특징
# - 간단하고 쉽게 미래 예측 가능
# - 특정 기간에 속하는 시계열에 대해서는 동일한 가중치 부여
# - 일반적으로 시계열 자료에 뚜렷한 추세가 있거나 불규칙변동이 심하지 않은 경우
# ~ 짧은 기간의 평균을 사용, 반대로 불규칙변동이 심한 경우 긴 기간의 평균을 사용
# - N값이 커질수록 좀 더 수평적인 모습을 보임
# => 이동평균법에서 가장 중요한 것은 적절한 기간의 N의 개수를 지정하는 것.

# R 내장 데이터 사용 ( 뉴해븐 지역의 연 평균 기온 )
nhtemp

# plot 그리기
plot(nhtemp, col = 'purple', lwd = 2,
     ylab = 'Temperature', main = 'Base Time Series')


library(forecast)

# N = 3일 때
ma(nhtemp, 3)

plot(ma(nhtemp, 3), col='red', lwd=2,
     ylab = 'Temperature', main = 'Base Time Series(k=3)')
plot(ma(nhtemp, 7), col='blue', lwd=2,
     ylab= 'Temperature', main = 'Base Time Series(k=7)')
plot(ma(nhtemp, 11), col='green', lwd=2,
     ylab = 'Temperature', main = 'Base Time Series(k=11)')


# ma 함수의 N 값을 크게 줄수록 곡선이 완만해지면서 우상향에 가까워짐