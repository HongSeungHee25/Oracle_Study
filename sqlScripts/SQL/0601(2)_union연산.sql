/*
	조인 : 2개의 테이블 열(테이블 항목)을 합치는 것
	예시로 '구매 테이블의 구매 수량, 구매날짜' 와 '회원 테이블의 회원 이름, 이메일' 을
	공통 컬럼 동등 조건으로 합치기
	
	union 연산자 : 2개 테이블의 행(데이터 값)을 합치는 것

이 주석 처리 
*/

-- 타입(형식)이 일치하는 2개의 컬럼을 선택해서 행 합치기. 타입 불일치하는 컬럼을 선택하면 오류.
SELECT 
NAME, EMAIL					-- 1) varchar2. 
-- REG_DATE  				-- 두번째 테이블과 타입 불일치로 인해 오류
FROM TBL_CUSTOM tc 
UNION ALL 
SELECT 
PCODE, PNAME				-- 2) 선택되는 컬럼형식과 선택한 컬럼 개수가 1)번과 일치해야함. - varchar2 
FROM TBL_PRODUCT tp ;

-- 컬럼의 개수가 다른 경우
-- 2개 테이블 중 컬럼이 부족한 것을 null 로 채워서 합치기
SELECT 
NAME, EMAIL, REG_DATE
FROM
TBL_CUSTOM tc 
UNION ALL 
SELECT 
PCODE, PNAME, NULL 				
FROM TBL_PRODUCT tp ;


-- 프로그래머스 문제 풀이 : 오프라인/온라인 판매데이터 통합하기(Lv.4)
-- 코드를 입력하세요
-- 1) union 연산으로 행 합치기 -> 결과 확인
-- 2) 조건을 적용하기 위해 새로운 작업이 필요합니다.
-- 의류 쇼핑몰의 온라인 상품 판매 정보를 담은 ONLINE_SALE 테이블
-- 오프라인 상품 판매 정보를 담은 OFFLINE_SALE 테이블 

-- 2022년 3월의 
-- 오프라인/온라인 상품 판매 데이터의 판매 날짜, 상품ID, 유저ID, 판매량을 출력
-- OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 
-- ①결과는 판매일을 기준으로 오름차순 정렬, 
-- ②판매일이 같다면 상품 ID를 기준으로 오름차순, ③상품ID까지 같다면 유저 ID를 기준으로 오름차순 정렬
SELECT
	-- 정렬할 컬럼이므로 별칭을 줍니다.
    TO_CHAR(SALES_DATE,'YYYY-MM-DD'),PRODUCT_ID, USER_ID, SALES_AMOUNT
from 
	-- sql 안에 다른 sql 결과를 사용할 때, 안에 있는 sql을 서브쿼리라고 합니다.
    (
    SELECT SALES_DATE, PRODUCT_ID, USER_ID, SALES_AMOUNT
    from ONLINE_SALE 
    UNION ALL 
    SELECT SALES_DATE, PRODUCT_ID, NULL, SALES_AMOUNT
    from OFFLINE_SALE 
    )
WHERE 
    TO_CHAR(SALES_DATE, 'YYYY-MM') LIKE ('2022-03')
ORDER BY 
-- 첫 번째 정렬기분 컬럼은 패턴이 적용된 날짜로 적용됩니다.
SALES_DATE, PRODUCT_ID, USER_ID;
