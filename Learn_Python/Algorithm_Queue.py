'''
1. 큐(Queue)
- 양 쪽 끝에서만 데이터를 넣거나 뺄 수 있는 선형구조
- 가장 먼저 넣은 데이터를 가장 먼저 꺼낼 수 있는 구조
- FIFO ( First In , First Out)
- LILO ( Last In, Last Out)
- back이 입구, front가 출구

2. 큐의 활용 예시
* 큐는 주로 데이터가 입력된 시간 순서대로 처리해야 할 필요가 있는 상황에 이용
- 우선 순위가 같은 작업 예약 ( 프린터의 인쇄 대기열 )
- 프로세스 관리
- 너비 우선 탐색 ( BFS ) 구현

3. 큐의 주요 기능
- enqueue(x) : 큐에 데이터를 집어넣는 기능 (=back에 요소 x를 추가)
- dequeue() : 큐에서 데이터를 꺼내는 기능 (=front의 요소를 반환하면서 꺼냄)
- first() : front의 요소를 제거하지 않고 반환
- is_empty() : 큐가 비어있으면, True를 반환

4. 큐의 종류
- 선형 큐 (Linear Queue )
    - 기본적인 큐
    - 크기가 제한되어 있고, 빈 공간을 사용하려면 
      모든 자료를 꺼내거나 자료를 한 칸 씩 앞으로 옮겨야함
- 원형 큐 ( Circular Queue )
    - 선형 큐의 단점을 보완
    - back이 마지막 인덱스를 가리키고 있지만,
      큐의 공간이 남아있을 때,
      비어있는 공간을 활용하여 효율성을 높임
    - 원형으로 돌면서 데이터가 채워지고, 처음 들어온 데이터가 삭제되면
      front 인덱스가 다음 데이터로 이동
- 우선순위 큐 ( Priority Queue )
    - 들어가는 순서에 관계 없이, 큐에서 dequeue될 때 우선순위에 맞게 나감
    - 아무리 먼저 들어왔어도, 우선순위가 낮으면 나중에 나감
    - 항상 이진 트리의 균형을 맞춰야함 -> 완전 이진 트리 구조를 이용
    - Ex) (3, 'A'), (1, 'B'), (2, 'C')면 우선순위가 1인 B부터 B->C->A 순으로 나옴

* 원형 큐를 구현하려면 back의 인덱스를 증가시킬 때,
  단순히 1을 더하는게 아니라, 1을 더한 값에 전체 크기를 나눈 나머지를 할당

'''

# 1. List 자료 구조 사용
# List 자료 구조의 .append(n) 함수 : back에 데이터 추가
# List 자료 구조의 .pop(0) 함수 : front의 데이터 반환하며 제거
# -> Queue와 같은 효과를 낼 수는 있으나,
# 파이썬의 List 구조는 무작위 접근에 최적화된 자료구조이므로
# pop(0)의 시간복잡도는 O(N)이다. 따라서 N이 커질수록 연산이 매우 느려짐
# 따라서, 큐 자료 구조를 사용할 때 List 자료구조는 추천되지 않음

list_queue = [1,2,3]
list_queue.append(4)
list_queue.append(5)
print(list_queue)

list_queue.pop(0)
list_queue.pop(0)
print(list_queue)


# 2. Collections 모듈의 deque 사용
# deque의 popleft()와 appendleft(x) 메서드는 O(1)의 시간복잡도를 가지기 때문에,
# List 자료구조에 비해 연산이 빠르다.
# 하지만 내부적으로 Linked List를 사용하고 있기 때문에,
# N번째 데이터에 접근할 때 N번의 순회가 필요,
# -> 데이터접근에 대한 시간복잡도가 O(N)이다.

from collections import deque
import queue
collections_queue = deque([1,2,3])
collections_queue.append(4)
print(collections_queue)

collections_queue.popleft()
collections_queue.popleft()
print(collections_queue)

collections_queue.appendleft(2)
collections_queue.appendleft(1)
print(collections_queue)



# 3. queue 모듈의 Queue 클래스 사용
# 데이터 추가 : put(x)
# 데이터 삭제 : get()
# -> deque와 같이, 데이터 추가/삭제는 O(1), 데이터 접근은 O(N)의 시간복잡도
# 따라서, deque를 더 많이 사용
# ** 시간복잡도가 어차피 같으므로, popleft, appendleft가 가능한 deque가 수월함

from queue import Queue
queue_module = Queue()
queue_module.put(1)
queue_module.put(2)
queue_module.put(3)
print(queue_module)

queue_module.get()