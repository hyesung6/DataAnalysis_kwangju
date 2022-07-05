# 클래스 만들기
class Cookie:
    shape = ' '
    def say(self):
        print(f'저는 {self.shape} 모양의 쿠키입니다 ^o^')

first_cookie = Cookie()
first_cookie.shape = '트리'
first_cookie.say()


# 상속
class OvenCookie(Cookie):
    def cry(self):
        print(f'저는 사실 {self.shape}가 싫어요..T ^ T')
    

second_cookie = OvenCookie()
second_cookie.shape = '먹히기'
second_cookie.cry()