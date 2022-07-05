# lambda 함수 만들기
add = lambda num1, num2: num1 + num2
add(3, 4)

# map은 여러 개의 데이터를 한 번에 반환할 때 사용하면 편리함
multiple_nums = [7, 8, 9]
multiple_result = list(map(lambda x: x*7, multiple_nums))
multiple_result

# filter는 특종 조건으로 필터한 결과를 반환
list1 = [i+1 for i in range(30)]
list2 = list(filter(lambda i: i%3 == 0, list1))
list2


# reduce는 앞의 결과를 누적한 뒤 반환
from functools import reduce
a = [1,2,3,4]
add = reduce(lambda x,y: x+y, a)
add