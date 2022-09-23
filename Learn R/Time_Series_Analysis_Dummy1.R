#데이터 저장
url <- "http://jse.amstat.org/datasets/utility.dat.txt"
utility <- read.table(url)
utility


# 주요 변수 설명
#V1 : 관측 월(mmm-yy)형식
#V2 : 보스턴의 월 평균 기온
#V7 : 월 총 에너지 사용량


# 시계열 분석에는 관측값의 시작 시점, 종료 시점, 주기가 필요.
# v7 변수를 시계열 분석에 사용

# ts(data, start, end, frequency)
# data : 데이터
# start : 시작 시점
# end : 종료 시점
# frequency : 단위 시간 당 관측 개수 ( 년도별 : 1, 월별 : 12 등 )

utility.ts <- ts(data = utility$V7, start = c(1990, 9), frequency = 12)
utility.ts


# 데이터 구조 확인
class(utility.ts)


# 시계열 그래프 그리기
plot(utility.ts, col='salmon', lwd = 2, xlab = 'Year', 
     ylab = 'Electricity Usage', main = 'Electricity Usage Trand of Boston Area')

## 시계열 데이터 파악
# 데이터 시작, 종료 시점
start(utility.ts)
end(utility.ts)

# 단위 시간에 관측된 관측값 개수 확인
frequency(utility.ts)

# 관측값 간의 시간 간격 ( frequency 의 역수 )
deltat(utility.ts)

# 관측값 간의 간격을 동일하게 변환
# ( 연간 12개의 값을 0.083의 동일한 간격을 갖는 시계열 벡터로 변환 )
time(utility.ts)


# 각 관측값에 대응되는 주기의 일련번호를 반환
cycle(utility.ts)

# window() 함수 --> start와 end 사이의 객체 추출
window(utility.ts, start =c(1991, 1), end = c(1992, 6))

# 연간 1개의 관측값 ( 각 년의 최초값- 1월 )
window(utility.ts, start = c(1991, 1), frequency = 1)

# 연간 2개의 관측값 ( 상하반기 6개월 간격 )
window(utility.ts, start = c(1991, 1), frequency = 2)

# 연간 4개의 관측값 ( 분기별 )
window(utility.ts, start = c(1991, 1), frequency = 4)
