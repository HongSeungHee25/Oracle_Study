SELECT * FROM BOOKMEMBER b ;
SELECT * FROM BOOKS b ;
SELECT * FROM BOOKRENT b ;

-- 1. 두 테이블을 조인하여 회원 이름과 대여 횟수를 조회
SELECT b.NAME , count(br.RENT_NO) AS rent_total 
FROM BOOKMEMBER b JOIN BOOKRENT br 
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 


-- 2. 테이블을 조인하고 조건을 추가하여 대여 횟수가 2회 이상인 회원만 조회
SELECT b.NAME , count(br.RENT_NO)
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 
HAVING count(br.RENT_NO) >= 2

--SELECT MEM_IDX,count(RENT_NO)
--FROM BOOKRENT 
--GROUP BY mem_idx
--HAVING count(RENT_NO) >= 2

-- 3. UNION ALL을 사용하여 두 테이블의 데이터를 합치는 예시
SELECT mem_idx, name, NULL AS bcode
FROM bookmember
UNION ALL
SELECT mem_idx, NULL AS name, bcode
FROM bookrent;

-- 4. 날짜 관련 함수인 TRUNC를 사용하여 대여일자의 월별 횟수를 구하는 예시
SELECT trunc(RENT_DATE),count(RENT_DATE)
FROM BOOKRENT b 
GROUP BY trunc(RENT_DATE)

SELECT TRUNC(rent_date, 'MONTH') AS month, COUNT(*) AS rental_count
FROM bookrent
GROUP BY TRUNC(rent_date, 'MONTH');
