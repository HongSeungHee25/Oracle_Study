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
SELECT bm.name, br.delay_days
FROM bookrent br
JOIN bookmember bm ON br.mem_idx = bm.mem_idx
WHERE br.delay_days = (SELECT MAX(delay_days) FROM bookrent);

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
SELECT COUNT(DISTINCT bm.MEM_IDX) AS "회원 수"
FROM BOOKMEMBER bm
JOIN BOOKRENT br ON bm.MEM_IDX = br.MEM_IDX
WHERE bm.TEL LIKE '010-%';

-- 11. "나길동" 회원이 대여한 책들 중에서 아직 반납되지 않은 책의 수를 구하시오.
SELECT COUNT(*) AS "반납 전 책의 수"
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
WHERE bm.name = '나길동' AND br.return_date IS NULL;

-- 12. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오.
SELECT TO_CHAR(rent_date, 'YYYY-MM-DD') AS "날짜", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'		-- 사이에 있는 값 가져온다는 의미
GROUP BY TO_CHAR(rent_date, 'YYYY-MM-DD')
ORDER BY "날짜";

-- 13. 연체 일수가 0일인 회원들의 이름과 이메일 주소를 조회하시오.
SELECT b.NAME , b.EMAIL 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
WHERE br.DELAY_DAYS = 0;

SELECT name, email
FROM bookmember
WHERE mem_idx IN (
    SELECT mem_idx
    FROM bookrent
    WHERE delay_days = 0
);

-- 14. "해커스토익" 책을 대여한 회원들과 "푸른사자 와니니" 책을 대여한 회원들의 합집합을 구하시오.
SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'B1101'
UNION ALL
SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'C1101';
-- 위에 코드결과
--10001	B1101
--10003	B1101
--10002	C1101
--10004	C1101
-- 15. "코스모스" 책을 대여한 회원들의 이름과 대여일자를 조회하되, 최대 3명까지만 조회하시오.
SELECT b.NAME , br.RENT_DATE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS b2 ON b2.BCODE = br.BCODE 
WHERE b2.TITLE = '코스모스' AND rownum <= 3;

-- 16. "푸른사자 와니니" 책을 대여한 회원들 중에서 2명을 제외한 나머지 회원들의 이메일 주소를 조회하시오.
SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'C1101'
    MINUS
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'C1101'
)
AND ROWNUM <= 2;

-- 17. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오. 단, 날짜는 월(day)부분을 제외하고 출력하시오.
SELECT TRUNC(rent_date, 'MONTH') AS "월", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'
GROUP BY TRUNC(rent_date, 'MONTH');

-- 18. "푸른사자 와니니" 책을 대여한 회원들 중에서 "해커스토익" 책을 대여한 회원들을 제외한 회원들의 이메일 주소를 조회하시오.
SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'C1101'
)
AND mem_idx NOT IN (
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'B1101'
);
-- 19. "해커스토익" 책을 대여한 회원들 중에서 가장 늦게 반납한 회원의 이름과 대여일자, 반납일자를 조회하시오.
SELECT bm.name, br.rent_date, br.return_date
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
JOIN books b ON br.bcode = b.bcode
WHERE b.title = '해커스토익'
AND br.return_date = (
    SELECT MAX(return_date)
    FROM bookrent
    WHERE bcode = 'B1101'
);
-- 20. "코스모스" 책을 대여한 회원들 중에서 연체 일수가 가장 많은 회원의 이름과 연체 일수를 조회하시오.
SELECT b.NAME , br.DELAY_DAYS 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스'
AND br.DELAY_DAYS = (
	SELECT MAX(DELAY_DAYS) 
	FROM BOOKRENT 
	WHERE BCODE = 'A1101'
);

SELECT b.NAME , br.DELAY_DAYS 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스'
AND br.DELAY_DAYS > 0;

-- 21. "푸른사자 와니니" 책을 대여한 회원들 중에서 2023년 6월에 대여한 회원들의 이름과 대여일자를 조회하시오.
SELECT b.NAME , br.RENT_DATE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '푸른사자 와니니' AND to_char(br.RENT_DATE,'yyyy-mm') = '2023-06'
ORDER BY br.RENT_DATE;

SELECT bm.name, br.rent_date
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
JOIN books b ON br.bcode = b.bcode
WHERE b.title = '푸른사자 와니니'
AND br.rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30';

-- 22. "해커스토익" 책을 대여한 회원들 중에서 연락처(tel) 정보를 가지고 있지 않은 회원들의 이름과 이메일 주소를 조회하시오.
SELECT bm.name, bm.email
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
JOIN books b ON br.bcode = b.bcode
WHERE b.title = '해커스토익'
AND bm.tel IS NULL;

-- 22. 책을 대여한 회원들 중에서 책을 반납하지 않은 회원들의 이름과 이메일 주소를 조회하시오.
SELECT b.NAME , b.EMAIL 
FROM BOOKMEMBER b JOIN BOOKRENT br 
ON b.MEM_IDX = br.MEM_IDX 
WHERE br.RETURN_DATE IS NULL ;

-- 23. "코스모스" 책을 대여한 회원들 중에서 반납되지 않은 대여 건의 수를 구하시오.
SELECT count(*) AS "반납 전"
FROM BOOKRENT br JOIN BOOKS bs
ON br.BCODE = bs.BCODE 
WHERE bs.TITLE = '코스모스' AND br.RETURN_DATE IS NULL;

SELECT COUNT(*) AS "대여 건의 수"
FROM bookrent
WHERE bcode = 'A1101' AND return_date IS NULL;
-- 24. "해커스토익" 책을 대여한 회원들과 "코스모스" 책을 대여한 회원들의 합집합을 구하시오.
SELECT b.*
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '해커스토익' AND bs.TITLE = '코스모스';

SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'B1101'
UNION ALL
SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'A1101';

-- 25. 대여 일자(rent_date)가 가장 오래된 책의 정보를 조회하시오.
SELECT bs.*
FROM books bs JOIN BOOKRENT b 
ON bs.BCODE = b.BCODE 
WHERE b.RENT_DATE = (
    SELECT MIN(b.RENT_DATE)
    FROM BOOKRENT b
);
-- 참고 : 출판 일자가 가장 오래된 책의 정보를 조회
SELECT *
FROM books
WHERE pdate = (
    SELECT MIN(pdate)
    FROM books
);

-- 26. 각 회원별로 대여한 책의 수를 조회하고, 대여한 책의 수가 가장 많은 회원을 찾으시오.
SELECT b.NAME , COUNT(br.RENT_NO) AS rent_count
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 
HAVING COUNT(br.rent_no) = (
    SELECT MAX(count_rentals)
    FROM (
        SELECT COUNT(rent_no) AS count_rentals
        FROM bookrent
        GROUP BY mem_idx
    )
);

-- 27. 대여한 책 중에서 중복된 책을 제외한 유일한 책의 목록을 조회하시오.
SELECT b.bcode, b.title, b.writer, b.publisher, b.pdate
FROM books b
JOIN (
    SELECT bcode
    FROM bookrent
    GROUP BY bcode
    HAVING COUNT(*) = 1
) br ON b.bcode = br.bcode;

-- 28. 대여된 모든 책의 목록과 대여하지 않은 모든 책의 목록을 합쳐서 조회하시오.
SELECT b.bcode, b.title, b.writer, b.publisher, b.pdate,br.RENT_DATE 
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
UNION ALL
SELECT b.bcode, b.title, b.writer, b.publisher, b.pdate, NULL 
FROM books b
WHERE b.bcode NOT IN (
    SELECT bcode
    FROM bookrent
);
-- 29. 아직 반납되지 않은 책 중에서 반납일이 가장 이른 책의 정보를 조회하시오.
SELECT bs.*
FROM BOOKS bs JOIN BOOKRENT br
ON bs.BCODE = br.BCODE 
WHERE br.EXP_DATE = (
	SELECT MIN(EXP_DATE) AS EXP_DATE 
	FROM BOOKRENT 
	WHERE RETURN_DATE IS NULL 
);

-- 30. 회원별로 대여한 책의 평균 대여 기간을 조회하시오.
SELECT b.NAME, AVG(TRUNC(br.return_date) - TRUNC(br.rent_date)) AS "평균 대여 기간"
FROM BOOKMEMBER b
JOIN BOOKRENT br ON b.MEM_IDX = br.MEM_IDX
GROUP BY b.NAME;


