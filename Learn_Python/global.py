# 함수 바깥에서 선언된 변수를 함수 내에서 사용하고 싶은 경우 global 사용
# 함수 내에서 선언된 변수(nonlocal)를 내포된 함수에서 가져다가 쓰려면 nonlocal 키워드로 호출하여 사용


# Example
# 1. global
if 'num' in globals():
    del num
num = 100

def global_nums():
    global num 
    num = int(num * 1.5)
    return num

global_nums()

# Example
# 2. nonlocal
def print_nums():
    num = 100
    
    def change_nums():
        nonlocal num
        num = int(num * 1.5)

    print('before:', num)
    change_nums()
    print('after:', num)


print_nums()


# 전역변수와 지역변수 리스트 확인하기
# globals()
# locals()
# 각 함수 뒤에 [변수명]으로 작성해서 선언하는 것도 가능한데,
# for문과 변수리스트 함수를 활용해서 규칙성 있는 변수 선언 가능

for i in range(1, 11):
    globals()[f'new_{str(i)}'] = i