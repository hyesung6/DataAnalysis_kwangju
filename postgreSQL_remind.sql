select count(*) "전체건수",
	   count(position) "직책건수",
	   count(distinct position) "직책종류",
	   min(salary) "최소",
	   max(salary) "최대",
	   avg(salary) "평균"
from cslee.tb_emp;


select position "직책",
count(*) "인원수",
min(salary) "최소",
max(salary) "최대",
avg(salary) "평균"
from cslee.tb_emp
group by position;

select org_cd "부서",
max(salary) "최대"
from cslee.tb_emp
group by org_cd
having min(salary) <= 40000000;

select org_cd, position, avg(salary)
from cslee.tb_emp
where position in ('과장', '대리', '사원')
group by org_cd, position;

select org_cd "부서",
count(*) "인원수",
avg(salary) "평균"
from cslee.tb_emp
group by org_cd
having count(*) >= 4;

select org_cd,
sum(coalesce((case position when '팀장' then 1 else 0 end), 0)) "팀장",
sum(coalesce((case position when '과장' then 1 else 0 end), 0)) "과장",
sum(coalesce((case position when '대리' then 1 else 0 end), 0)) "대리",
sum(coalesce((case position when '사원' then 1 else 0 end), 0)) "사원"
from cslee.tb_emp
group by org_cd
order by org_cd asc;

-- equi join
select tb_emp.emp_name "사원명", tb_org.org_cd "부서코드", tb_org.org_name "부서명"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd;

-- from절에 2개 이상의 테이블을 불러오고,
-- where절에 불러온 테이블끼리의 조건을 정해주면
-- join을 명시하지 않더라도 join이 됨
select tb_emp.emp_name "사원명", tb_org.org_cd "부서코드", tb_org.org_name "부서명"
from cslee.tb_emp, cslee.tb_org
where tb_emp.org_cd = tb_org.org_cd and tb_org.org_name like '영업%'
order by tb_emp.emp_name;

--from절에 join을 명시적으로 사용하여 합치기
select tb_emp.emp_name "사원명", tb_org.org_cd "부서코드", tb_org.org_name "부서명"
from cslee.tb_emp
join cslee.tb_org 
on tb_emp.org_cd = tb_org.org_cd    -- join ~ on으로 join 조건 명시해주고
where tb_org.org_name like '영업%'   -- where 절에는 조회테이블에 대한 조건 적어줌
order by tb_emp.emp_name desc;      -- 사원명 역순으로 조회

-- 다중 조인
-- where 절 '=' 조인
select ACNT.accno "계좌번호", CUST.cust_name "고객명", PROD.prod_name "상품명",
ACNT.cont_amt "계약금액", EMP.emp_name "담당자명"
from cslee.tb_Accnt ACNT, cslee.tb_cust CUST, cslee.tb_prod PROD,
cslee.tb_emp EMP
where ACNT.prod_cd = PROD.prod_cd
and ACNT.cust_no = CUST.cust_no
and ACNT.manager = EMP.emp_no;

select e.emp_name "사원명", count(o.org_name) 
from cslee.tb_emp E cross join cslee.tb_org O
group by emp_name, org_name
having emp_name like '김%';

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A full outer join cslee.tb_emp B
on A.org_cd = B.org_cd;

select *
from cslee.tb_org A right outer join cslee.tb_org B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A left outer join cslee.tb_emp B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name
from cslee.tb_org A join cslee.tb_emp B
on A.org_cd = B.org_cd;

select B.org_cd, B.emp_name, A.org_name, A.type
from cslee.tb_org A cross join cslee.tb_emp B
order by B asc;

-- 명시적 cross join
select *
from cslee.tb_org A cross join cslee.tb_emp B;

-- 암시적 cross join
select *
from cslee.tb_org A, cslee.tb_emp B
where A.org_cd  = B.org_cd ;

with tmp as (
select *
from cslee.tb_org A, cslee.tb_emp B
where A.org_cd  = B.org_cd)
select *
from tmp;

select * from cslee.tb_emp;
select * from cslee.tb_org;
select * from cslee.tb_accnt;