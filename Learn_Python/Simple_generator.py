import time

def simple_generator(n):
    print(f'==== [총 과자 수: {n}] ====', '\n')
    for i in range(n, 0, -1):
        if i > 0:
            yield f'과자를 하나 먹었고,\n{i-1}개 남았습니다...\n'
            time.sleep(1)
    yield '=== 다 먹었습니다. ==='


for i in simple_generator(5):
    print(i)


## 리스트 내포를 []가 아닌 ()로 사용할 경우 제너레이터를 반환
simple_comprehension = (f'{i}개 남았습니다.' for i in range(5, 0, -1))

for i in simple_comprehension:
    print(i)
    time.sleep(1)

print(type(simple_comprehension))