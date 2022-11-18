# 파이썬 함수는 기본적으로 동기 방식으로 동작
def do_sync():
    pass


# async 키워드를 사용하여 비동기 함수를 만들 수 있음 ( = 코루틴 )
async def do_async():
    print('this function is do_async')


do_async()

# 그냥 호출하면 coroutine 객체가 반환되므로
# 일반적으로 async 선언된 다른 비동기 함수 내에서 await 키워드를 붙여서 호출하여야 함
async def main_async():
    await do_async()

main_async()

# async로 선언되지 않은 일반 동기 함수 내에서 비동기 함수를 호출하려면 asyncio 라이브러리의 이벤트 루프를 이용
import asyncio
asyncio.run(main_async())





print('=============================================================')
# Example
# 애플리케이션을 사용자 데이터를 직접 보관하지 않고 외부 API를 호출해서 가져옵니다.
# 외부 API는 1명의 사용자 데이터를 조회하는데 1초가 걸리고, 한 번에 여러 사용자의 데이터를 조회할 수 없습니다.
# 각각 3명, 2명 1명의 사용자를 조회하는 요청 3개가 동시에 애플리케이션에 들어옵니다.
# 제너레이터를 활용해서 작성합니다.

# 1. 동기 조회 방식
import time

def find_users_generator(n):
    yield from [f'{n}명 중 {i}번 째 사용자 조회 중...' for i in range(1, n+1)]
    
def find_users_sync(n):
    for gn in find_users_generator(n):
        print(gn)
        time.sleep(1)
    print(f'> 총 {n}명 사용자 동기 조회 완료!')

def process_sync(n):
    start = time.time()
    for i in range(n, 0, -1):
        find_users_sync(i)
    end = time.time()
    print(f'>>> 동기 조회 총 소요 시간: {end - start}')

process_sync(3)

# 2. 비동기 조회 방식
# async/await 키워드를 사용하여 한 번에 처리될 수 있도록 변경
# time.sleep 대신 asyncio.sleep 을 사용 -- 기다리는 동안 CPU가 다른 처리를 할 수 있게 함
# asyncio의 함수들도 비동기 함수이므로 호출할 때 반드시 await을 붙여야 함

async def find_users_async(n):
    for gn in find_users_generator(n):
        print(gn)
        await asyncio.sleep(1)
    print(f'> 총 {n} 명 사용자 비동기 조회 완료!')

async def process_async(n):
    start = time.time()
    await asyncio.wait([find_users_async(i) for i in range(n, 0, -1)])
    end = time.time()
    print(f'>>> 비동기 처리 총 소요 시간: {end - start}')

asyncio.run()

asyncio.run(process_async(4))


"""
Python 3.11.0 버전에서
asyncio.wait() 메서드는 삭제될 예정
"""