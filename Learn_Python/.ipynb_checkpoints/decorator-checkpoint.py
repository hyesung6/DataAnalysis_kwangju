# 함수로 데코레이터 구현
def decoratorExampleFunc(func):
    def wrapFunc(*args, **kargs):
        print("Start", func.__name__)
        func(*args, **kargs)
        print("End", func.__name__)
    return wrapFunc

@decoratorExampleFunc
def test(a, b, c):
    print("Variables : ", a, b, c)

test("1", 2, c="345")


# 클래스로 데코레이터 구현
class decoratorExampleClass:
    def __init__(self, func):
        self.func = func
    
    def __call__(self, *args, **kargs):
        print("Start", self.func.__name__)
        self.func(*args, **kargs)
        print("End", self.func.__name__)

@decoratorExampleClass
def test(a, b, c):
    print("Varibles : ", a, b, c)

test('String', 369, 3*3)


# 클래스 내 함수로 데코레이터 구현
class TestExample:
    def _decorator(func):
        def wrap(self, *args, **kargs):
            print("Start", func.__name__)
            func(self, *args, **kargs)
            print("End", func.__name__)
        return wrap
    
    @_decorator
    def test(self, a, b, c):
        print("Variables : ", a, b, c)

t = TestExample()

t.test('String', 369, 3*3)



# =========================================
from datetime import datetime
import time

def printLog(func):
    def logging(*args, **kargs):
        print(f'Start time is {datetime.now().strftime("%H:%M:%S")}...')
        func(*args, **kargs)
        print(f'End time is {datetime.now().strftime("%H:%M:%S")}...')
    return logging

@printLog
def waitDinner(second):
    print(f'Init... You may wait for {second} minute')
    time.sleep(second / 3)
    print('Start cook...')
    time.sleep(second / 3)
    print('Cook finished')
    time.sleep(second / 3)
    print('Bon appetit')

waitDinner(10)
