-- 1. "최행운" 회원이 대여한 책의 수를 구하시오.
SELECT b.NAME , br.rent_count
FROM BOOKMEMBER b JOIN (
	SELECT br.MEM_IDX, COUNT(br.RENT_NO) AS rent_count
	FROM BOOKRENT br 
	GROUP BY br.MEM_IDX
)br
ON b.MEM_IDX = br.MEM_IDX
WHERE b.NAME = '최행운'

-- 2. "2018-07-10" 이전에 출판된 책들의 목록을 조회하시오.
SELECT BCODE , TITLE ,WRITER , PUBLISHER , to_char(PDATE,'yyyy-mm-dd') AS PDATE
FROM BOOKS b 
WHERE to_char(PDATE,'yyyy-mm-dd') < '2018-07-10'
ORDER BY PDATE

-- 3. "푸른사자 와니니" 책의 대여 횟수를 구하시오.
SELECT b.TITLE , br.rent_count
FROM BOOKS b JOIN (
	SELECT br.BCODE, COUNT(br.rent_no) AS rent_count  
	FROM BOOKRENT br
	GROUP BY br.BCODE
)br
ON b.BCODE = br.BCODE 
WHERE b.TITLE = '푸른사자 와니니'

-- 4. 반납일(exp_date)이 지나서 아직 반납되지 않은 책들의 목록을 조회하시오. (14일 이후) 
-- 이건 실행 X
SELECT b.title, bm.name, br.rent_date, br.exp_date
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
JOIN bookmember bm ON br.mem_idx = bm.mem_idx
WHERE br.exp_date < TRUNC(SYSDATE) - 14
AND br.return_date IS NULL;

-- 5. 각 회원별로 대여한 책의 수를 구하시오.
SELECT b.NAME , br.rent_count
FROM BOOKMEMBER b JOIN (
	SELECT br.MEM_IDX, count(br.RENT_NO) AS rent_count
	FROM BOOKRENT br
	GROUP BY br.MEM_IDX
)br
ON b.MEM_IDX = br.MEM_IDX; 

SELECT bm.name, COUNT(*) AS "대여한 책의 수"
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
GROUP BY bm.name;

-- 6. "나길동" 회원이 대여한 책 중에 연체된 책의 수와 총 연체 일수를 구하시오.
SELECT COUNT(*) AS "연체된 책의 수", SUM(delay_days) AS "총 연체 일수"
FROM bookrent br
JOIN bookmember bm ON br.mem_idx = bm.mem_idx
WHERE bm.name = '나길동' AND br.delay_days > 0;
----------------------------------------------------------------------------
-- "나길동" 회원의 대여 지연일과 대여 건수 조회 
SELECT b.NAME, (
	-- BOOKRENT 테이블에서 해당 회원과 관련된 대여 정보를 가져옵니다.(연체일수)
    SELECT br.DELAY_DAYS
    FROM BOOKRENT br
    WHERE br.MEM_IDX = b.MEM_IDX
) AS DELAY_DAYS,
(
	-- BOOKRENT 테이블에서 해당 회원의 대여 건수를 카운트합니다.
    SELECT COUNT(br.RENT_NO)
    FROM BOOKRENT br
    WHERE br.MEM_IDX = b.MEM_IDX
) AS rent_count
FROM BOOKMEMBER b
WHERE b.NAME = '나길동';

-- 7. "코스모스" 책을 대여한 회원들의 이메일 주소를 조회하시오.
SELECT bm.email
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
JOIN books b ON br.bcode = b.bcode
WHERE b.title = '코스모스';

-- 8. 연체 일수가 가장 많은 책을 대여한 회원의 이름과 연체 일수를 조회하시오.


-- 9. "해커스토익" 책이 대여된 횟수를 구하시오.
SELECT b.TITLE , br.rent_no
FROM BOOKS b JOIN (
	SELECT br.bcode, count(br.rent_no) AS rent_no
	FROM BOOKRENT br 
	GROUP BY br.bcode
)br
ON b.BCODE = br.BCODE 
WHERE b.TITLE = '해커스토익'

-- 10. 책을 대여한 회원 중에서 "010-"로 시작하는 전화번호를 가진 회원의 수를 구하시오.


-- 11. "나길동" 회원이 대여한 책들 중에서 아직 반납되지 않은 책의 수를 구하시오.


-- 12. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오.


-- 13. 연체 일수가 0일인 회원들의 이름과 이메일 주소를 조회하시오.


-- 14. "해커스토익" 책을 대여한 회원들과 "푸른사자 와니니" 책을 대여한 회원들의 합집합을 구하시오.


-- 15. "코스모스" 책을 대여한 회원들의 이름과 대여일자를 조회하되, 최대 3명까지만 조회하시오.


-- 16. "푸른사자 와니니" 책을 대여한 회원들 중에서 2명을 제외한 나머지 회원들의 이메일 주소를 조회하시오.


-- 17. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오. 단, 날짜는 월(day)부분을 제외하고 출력하시오.


-- 18. "푸른사자 와니니" 책을 대여한 회원들 중에서 "해커스토익" 책을 대여한 회원들을 제외한 회원들의 이메일 주소를 조회하시오.


-- 19. "해커스토익" 책을 대여한 회원들 중에서 가장 늦게 반납한 회원의 이름과 대여일자, 반납일자를 조회하시오.


-- 20. "코스모스" 책을 대여한 회원들 중에서 연체 일수가 가장 많은 회원의 이름과 연체 일수를 조회하시오.


-- 21. "푸른사자 와니니" 책을 대여한 회원들 중에서 2023년 6월에 대여한 회원들의 이름과 대여일자를 조회하시오.


-- 22. "해커스토익" 책을 대여한 회원들 중에서 연락처(tel) 정보를 가지고 있지 않은 회원들의 이름과 이메일 주소를 조회하시오.


-- 23. "코스모스" 책을 대여한 회원들 중에서 반납되지 않은 대여 건의 수를 구하시오.


-- 24. "해커스토익" 책을 대여한 회원들과 "코스모스" 책을 대여한 회원들의 합집합을 구하시오.


-- 25. 대여 일자(rent_date)가 가장 오래된 책의 정보를 조회하시오.


-- 26. 각 회원별로 대여한 책의 수를 조회하고, 대여한 책의 수가 가장 많은 회원을 찾으시오.


-- 27. 대여한 책 중에서 중복된 책을 제외한 유일한 책의 목록을 조회하시오.


-- 28. 대여된 모든 책의 목록과 대여하지 않은 모든 책의 목록을 합쳐서 조회하시오.


-- 29. 아직 반납되지 않은 책 중에서 반납일이 가장 이른 책의 정보를 조회하시오.


-- 30. 회원별로 대여한 책의 평균 대여 기간을 조회하시오.

