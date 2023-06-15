-- SELECT 복습 문제
SELECT *
FROM TBL_BUY tb ;
SELECT *
FROM TBL_CUSTOM tc2 ;
SELECT *
FROM TBL_PRODUCT tp ;
-- 1) 회원 나이 25세 이상인 아이디와 이름을 조회하세요.
SELECT custom_id,name
FROM TBL_CUSTOM tc 
WHERE AGE >= 25;
-- 2) 회원 이메일 gmail.com 계정 모든 컬럼을 조회하세요.
SELECT *
FROM TBL_CUSTOM tc
WHERE email LIKE '%gmail.com';
-- 3) 회원 가입 날짜가 '2022-03-10' 또는 '2021-12-25' 모든 컬럼을 조회하세요. (함수 사용해야 합니다.)
-- To_char(날짜 컬럼 또는 날짜, 형식)
SELECT *
FROM TBL_CUSTOM tc 
WHERE TO_CHAR(reg_date, 'YYYY-MM-DD')   
	  IN ('2022-03-10','2021-12-25');
SELECT *
FROM TBL_CUSTOM tc 
WHERE TO_CHAR(reg_date, 'YYYY-MM-DD') = '2022-03-10' 
	  OR TO_CHAR(reg_date, 'YYYY-MM-DD') = '2021-12-25';
	 
-- 문자열을 날짜 date 형식으로 변환하는 것은 to_date 함수
-- date 형식을 지정된 패턴의 문자열로 변환하는 것은 to_char 함수	 
	 
-- 4) 상품 가격이 10000원 미만 상품명, 가격 컬럼을 조회하세요.
SELECT PCODE , PRICE 
FROM TBL_PRODUCT tp  
WHERE price < 10000;
-- 5) 상품 카테고리 'B1' 을 조회하세요.
SELECT *
FROM TBL_PRODUCT tp 
WHERE CATEGORY = 'B1';
-- 6) 상품명에 '사과' 가 들어가는 상품을 조회하세요.
SELECT *
FROM TBL_PRODUCT tp 
WHERE PNAME LIKE '%사과%';
-- 7) 진라면 상품 코드 'JINRMn5' 를 구입한 회원 id를 조회하세요.
SELECT customId
FROM TBL_BUY tb 
WHERE PCODE = 'JINRMn5';
-- 8) 회원 twice 가 구입한 상품코드를 조회하세요.
SELECT PCODE 
FROM TBL_BUY tb 
WHERE CUSTOMID = 'twice';
-- 9) 진라면 상품 코드 'JINRMn5' 이 판매된 날짜를 조회하세요.
SELECT buy_date
FROM TBL_BUY tb 
WHERE PCODE = 'JINRMn5';
-- 10) 우리 매장에서 상품을 구매한 회원ID를 조회하세요.
SELECT 
DISTINCT  -- 조회된 컬럼의 중복된 값은 제거.
CUSTOMID 
FROM TBL_BUY tb ;
-- 참고 : join이 필요한 예시는
-- 7) 진라면 상품 코드 'JINRMn5' 를 구입한 회원이름과 이메일을 조회하세요.

-- 8) 회원 twice 가 구입한 상품명과 가격을 조회하세요.

-- 10) 우리 매장에서 상품을 구매하지 않은 회원ID,회원이름,이메일을 조회하세요.
