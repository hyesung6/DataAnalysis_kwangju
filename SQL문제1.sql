-- tb_emp 테이블의 org_cd 속성과 tb_org 테이블의 org_cd 속성을 이용하여
-- org_cd, org_name, emp_name 속성을 조회하라
-- 결과 테이블의 컬럼이름은 부서코드, 부서명, 직원명 순으로 출력할 것
-- 단, 암시적 조인을 사용할 것
select tb_org.org_cd "부서코드", org_name "부서명", emp_name "직원명"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd;

-- tb_emp 테이블의 org_cd 속성과 tb_org 테이블의 org_cd 속성을 이용하여
-- org_cd, org_name, emp_name속성을 조회하라
-- 결과 테이블의 컬럼이름은 부서코드, 부서명, 직원명 순으로 출력할 것
-- 단, 명시적 조인을 사용할 것 
select tb_org.org_cd "부서코드", org_name "부서명", emp_name "직원명"
from cslee.tb_emp join cslee.tb_org
on tb_emp.org_cd = tb_org.org_cd;

-- tb_emp 테이블과 tb_org 테이블을 이용하여
-- 두 테이블의 모든 속성을 조회하라
-- 단, 크로스 조인을 사용할 것 
select * from cslee.tb_emp cross join cslee.tb_org;


-- tb_emp 테이블의
-- position 속성을 이용하여 "직책", 
-- salary 속성을 이용하여 "직책별_급여_계"
-- 두 가지 속성으로 이루어진 테이블을 조회하라
-- 단, position 속성 별로 그룹 짓고, 각 position별 salary의 합을 출력할 것
-- 정렬 순서는 "직책별_급여_계"가 높은 순
select position "직책", sum(salary) "직책별_급여_계"
from cslee.tb_emp
group by position
order by "직책별_급여_계" desc;

-- tb_emp 테이블의
-- emp_name에는 3글자로 이루어진 이름만 존재한다.
-- emp_name 속성을 이용하여 이름 가운데 글자가 '지'인 직원만 출력하라
-- emp_name 속성은 "직원명"으로 출력할 것
select emp_name "직원명"
from cslee.tb_emp
where emp_name like '_지%';


-- tb_emp 테이블의
-- position, emp_name, gender 속성을 이용하여
-- "직책", "직원명", "성별" 순으로 조회하라
-- 단, gender 속성의 도메인 값은 case 사용하여 (M, F)를 (남, 여)로 바꾸어 조회할 것 
select position "직책", emp_name "직원명", (case when gender = 'M' then '남' else '여' end) "성별"
from cslee.tb_emp;


-- tb_emp 테이블의
-- emp_name 속성을 "직원명", salary 속성을 "급여등급"으로 바꾸어 조회하되
-- salary가 
-- 200000001 이상은 'A'
-- 100000001 ~ 200000000이면 'B'
-- 50000001 ~ 100000000 이면 'C'
-- 그 외에는 'D'로 바꾸어 조회하라.
select emp_name, (case
                  when salary > 200000001 then 'A'
                  when salary between 100100001 and 200000000 then 'B'
                  when salary between 50000001 and 100000000 then 'C'
                  else 'D' end)
from cslee.tb_emp;


-- tb_org 테이블의
-- org_cd, type, org_name, up_org_cd 속성을 조회하되
-- up_org_cd 속성에
-- null 값이 있으면 '상위 부서가 없음'으로 바꾸어 조회하라
select org_cd "조직코드", type "분류", org_name "조직명", coalesce(up_org_cd, '상위 부서가 없음') "상위부서명"
from cslee.tb_org;


-- tb_org 테이블의 type 속성으로 그룹 지어,
-- type 컬럼과 그 빈도를 센 컬럼으로 이루어진 테이블을 조회하라
-- 단, 빈도가 3과 같거나 커야 하고, 빈도가 낮은 순으로 조회할 것
select type "분류", count(type) "개수" 
from cslee.tb_org
group by type
having count(type) >= 3
order by count(type);


-- with문 사용 subquery
-- 해보고 싶으면 따로 검색해서 찾아서 해보기
-- 공부한 교재에는 해당 내용 없음
-- tb_emp 테이블의 salary 속성이 
-- 200000001 이상이면 'A'
-- 100000001 ~ 200000000 이면 'B'
-- 50000001 ~ 100000000 이면 'C'
-- 그 외에는 'D'를 주고, 컬럼이름을 "급여등급"으로 한다.
-- 조회한 테이블을 with문을 활용하여 임시테이블로 만들고,
-- 임시 테이블에서 "급여등급"을 그룹지어,
-- "급여등급"과 "급여등급"의 빈도를 조회하라.
-- 정렬은 급여등급이 낮은 순으로 (A ~ D 순)
with ranking as (select (case
             when salary > 200000001 then 'A'
             when salary between 100000001 and 200000000 then 'B'
             when salary between 50000001 and 100000000 then 'C'
             else 'D' end) "급여등급"
     from cslee.tb_emp)
select "급여등급", count("급여등급")
from ranking
group by "급여등급"
order by "급여등급";