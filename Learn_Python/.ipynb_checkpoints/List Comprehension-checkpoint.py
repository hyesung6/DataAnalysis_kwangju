# 배열의 사이즈를 지정하는 변수 생성
arr_num = 10
# 변수 arr_num의 갯수만큼 배열을 생성하는 리스트 생성
arr = [0]*arr_num
# 생성된 arr 확인
print(arr)

# list comprehension 사용하여 리스트 생성
arr = [i+1 for i in range(arr_num)]
arr

# 조건문 사용하여 arr 만들기
# 1~30중에 홀수로 arr 만들기
arr = [i for i in range(1, 30) if i % 2 == 1]
arr

# and, or 조건 추가하여 만들기
# 리스트 내포의 and는 그냥 if문 뒤에 if 쓰면 and로 연산함
arr = [i for i in range(1,30) if i % 2
        == 1 if i % 3 == 0]
arr

# or은 or키워드 넣어줘야함
arr = [i for i in range(1, 30) if i%3 ==0
        or i//2 == 3]
arr

# 리스트 내포로 매트릭스 만들기
# [[(변수에 적용할 수식) for (컬럼변수) in (for문이 돌아가는 범위)] for (행 변수) in (for문의 범위))]
# (3, 3)행렬 만들기
matrix = [[i+1 for i in range(3)]for n in range(3)]
matrix

# 2차원 행렬을 1차원 리스트로 변환하기
row = [r for i in matrix for r in i]  # 첫번째 for문은 행, 두번째 for문은 열
row