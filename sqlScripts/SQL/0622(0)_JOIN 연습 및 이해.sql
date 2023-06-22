SELECT * FROM TBL_CUSTOM tc ;	-- CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE
SELECT * FROM TBL_PRODUCT tp ;	-- PDOCE, CATEGORY, PNAME, PRICE
SELECT * FROM TBL_BUY tb ;		-- BUY_SEQ, CUSTOMID, PCODE, QTY, BUY_DATE

SELECT *
FROM TBL_CUSTOM tc 
LEFT JOIN TBL_PRODUCT tp 
ON tc.CUSTOM_ID = tp.PCODE;

SELECT CUSTOM_ID
FROM TBL_CUSTOM tc NATURAL JOIN TBL_BUY tb 		-- 겹칠수있는 모든 컬럼을 다 겹침. (함부로 쓰면 안됨 - 값이 많이 나오고 감을 잡고 써야함)

SELECT PCODE
FROM TBL_PRODUCT tp JOIN TBL_BUY tb 
USING(PCODE)	-- ON tp.PCODE = tb.PCODE

-- 내부조인
-- INNER JOIN 
-- 공통된 컬럼을 묶는 용(기준 테이블 X)
SELECT * 
FROM TBL_CUSTOM tc JOIN TBL_BUY tb 
ON tc.CUSTOM_ID = tb.CUSTOMID 

-- CUSTOM_ID 가 'twice' 인 고객이 구매한 상품 코드 조회
SELECT tc.CUSTOM_ID , tb.PCODE 
FROM TBL_CUSTOM tc JOIN TBL_BUY tb 
ON tc.CUSTOM_ID = tb.CUSTOMID 
WHERE tc.CUSTOM_ID = 'twice'

-- 외부조인
-- left join, right join 로 기준 테이블을 정하고, 그 테이블을 기준으로 묶는 용(기준 테이블 O)
SELECT tb.PCODE , 
FROM TBL_BUY tb LEFT JOIN TBL_PRODUCT tp 
ON tb.PCODE = tp.PCODE 

-- TBL_PRODUCT 테이블에 있는 전체상품코드와 가격 조회
SELECT tp.PCODE , tp.PRICE  
FROM TBL_PRODUCT tp LEFT JOIN TBL_BUY tb
ON tp.PCODE = tb.PCODE 

-- TBL_BUY 테이블에 있는 구매한 전체 상품코드와 코드별 TBL_PRODUCT 테이블에 가격 조회
SELECT tb.PCODE , tp.PRICE 
FROM TBL_PRODUCT tp LEFT JOIN TBL_BUY tb
ON tp.PCODE = tb.PCODE 

-- full join - 전부 다 합침
SELECT *
FROM TBL_BUY tb FULL JOIN TBL_PRODUCT tp 
ON tb.PCODE = tp.PCODE 

-- BUY 에는 수량, PRODUCT 에는 개당 가격이 있습니다.
-- 상품별 총 구매 가격을 구하는 코드 작성
-- 최종 코드 : BUY 와 서브쿼리를 조인할 예정

-- product 에서 pcode 와 개당 가격
SELECT PCODE ,PRICE 
FROM TBL_PRODUCT tp 

-- buy 에서 pcode 와 구매 수량
SELECT pcode, QTY 
FROM TBL_BUY tb 

-- pcode별 총 구매금액
SELECT PCODE ,(price*qty) AS total
FROM(
	SELECT PCODE ,PRICE 
	FROM TBL_PRODUCT tp)
JOIN (
	SELECT pcode, QTY 
	FROM TBL_BUY tb )
USING (pcode)

-- 최종 코드
SELECT *
FROM TBL_BUY tb 
JOIN (
		SELECT PCODE ,(price*qty) AS total
		FROM(
			SELECT PCODE ,PRICE 
				FROM TBL_PRODUCT tp)
		JOIN (
			SELECT pcode, QTY 
				FROM TBL_BUY tb )
		USING (pcode)
)
USING (pcode)
ORDER BY total

-- where 절 서브쿼리
-- where 컬럼명 in(서브쿼리 - 비교할 컬럼 갯수만큼 select에 있어야 함)
-- where (컬럼1,컬럼2,컬럼3) in (서브쿼리 - select 에 컬럼 갯수가 맞아야함 > 3)










