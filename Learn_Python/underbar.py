# 언더바의 용도
'''
1. 인터프리터에서의 마지막 값
2. 무시하는 값
3. 숫자 자릿수 구분
4. (앞 언더바 1개) 모듈 내에서만 변수/함수를 사용할 때
5. (뒤 언더바 1개) 파이썬 변수/함수명 충돌을 피하기 위해
6. (앞 언더바 2개) 네임 맹글링
7. (앞뒤 언더바 2개씩) 매직 메소드
'''

# Example
# 1. 인터프리터의 마지막 값
3+4
_+3
# _ 는 선언되지 않았지만, 인터프리터의 마지막 출력 값인 7을 가져와서 3을 더한 10이 출력됨

last_output = _
last_output
# 마지막 출력을 변수에 저장하는 것도 가능

del _print_hello


# 2. 모듈 내에서만 작동하는 변수/함수 이름
from Learn_Python.underbar_use_import import *
_print_hello()
# underbar_use_import 모듈에는 _print_hello 라는 함수가 작성되어있으나,
# 언더바가 앞에 1개 있다면, 직접 불러오는 경우가 아니면 호출할 수 없음

from Learn_Python.underbar_use_import import _print_hello
_print_hello()
# 직접 함수명을 import 하는 경우에는 사용 가능
## 여러 모듈을 불러와서 사용하는 경우, 함수명이 중복될 수도 있으므로 언더바를 붙임



# 3. 네임 맹글링
# 외부에서 클래스 속성값에 접근하지 못하도록 할 때
class House1:
    def __init__(self) -> None:
        self.type = "apartment"
        self.price = 100_000
        self.name = "월곡빌라"
house1 = House1()
print(house1.name)
# 클래스에 작성된 속성값을 출력함

class House2:
    def __init__(self) -> None:
        self.type = "apartment"
        self.price = 100_000
        self.__name = "월곡빌라"
house2 = House2()
print(house2.__name)
# 클래스에 작성된 속성값을 호출하면 AttributeError가 발생


# 네임 맹글링을 통해 오버라이딩을 시도할 때 특정 속성에 대해 상속받지 못하게 할 수도 있음
class House3:
    def __init__(self) -> None:
        super(House2).__init__
        self.type = "apartment"
        self.price = 100_000
        self.name = "월곡빌라"
house3 = House3()
print(house3.__name)


