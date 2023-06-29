SELECT * FROM BOOKMEMBER b ;
SELECT * FROM BOOKS b ;
SELECT * FROM BOOKRENT b ;

-- 1. 회원별로 대출한 책의 수를 조회
SELECT b.NAME , COUNT(br.RENT_NO) 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 

-- 2. 대출 중인 도서 목록을 조회
SELECT b.*
FROM BOOKS b JOIN BOOKRENT br
ON b.BCODE = br.BCODE 
WHERE br.RETURN_DATE IS NULL 

-- 3. 회원별로 대출한 도서 중 연체된 도서의 수와 총 연체일수를 조회
SELECT b.name, COUNT(br.rent_no) AS overdue_books, SUM(br.delay_days) AS total_delay_days
FROM bookmember b
JOIN bookrent br ON b.mem_idx = br.mem_idx
WHERE br.delay_days > 0
GROUP BY b.name;

-- 4. 대출된 도서와 도서 회원의 정보를 UNION ALL로 결합하여 조회
SELECT '도서' AS TYPE, b.TITLE , b.WRITER ,b.PUBLISHER , br.RENT_DATE 
FROM BOOKS b 
JOIN BOOKRENT br ON b.BCODE = br.BCODE 
UNION ALL 
SELECT '회원' AS TYPE, bm.NAME ,bm.EMAIL ,bm.TEL ,br.RENT_DATE 
FROM BOOKMEMBER bm 
JOIN BOOKRENT br ON bm.MEM_IDX = br.MEM_IDX ;

-- 5. 도서 대출 횟수가 가장 많은 회원을 조회
SELECT b.name, COUNT(br.rent_no) AS rental_count
FROM bookmember b
JOIN bookrent br ON b.MEM_IDX = br.MEM_IDX
GROUP BY b.name
ORDER BY rental_count DESC; 

-- 6. 대출일자(trunc)별로 대출 건수를 조회
SELECT TRUNC(rent_date) AS rent_date, COUNT(rent_date)
FROM BOOKRENT b 
GROUP BY TRUNC(rent_date)
ORDER BY TRUNC(rent_date);

-- 7. 두 테이블을 조인하여 회원 이름과 대여 횟수를 조회
SELECT b.NAME , COUNT(br.RENT_NO) 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME ;

-- 8. 테이블을 조인하고 조건을 추가하여 대여 횟수가 2회 이상인 회원만 조회
SELECT b.NAME , COUNT(br.RENT_NO) AS rent_count
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME
HAVING COUNT(br.RENT_NO) >= 2;

-- 9. UNION ALL을 사용하여 두 테이블의 데이터를 합치는 예시(bookmember,bookrent)
SELECT mem_idx, name, NULL AS bcode
FROM bookmember
UNION ALL
SELECT mem_idx, NULL AS name, bcode
FROM bookrent;

-- 9. 날짜 관련 함수인 TRUNC를 사용하여 대여일자의 월별 횟수를 구하는 예시
SELECT TRUNC(rent_date, 'MONTH') AS "대여", COUNT(*) AS "월별 횟수"
FROM bookrent
GROUP BY TRUNC(rent_date, 'MONTH')
ORDER BY TRUNC(rent_date, 'MONTH');

-- 10. "최행운" 회원이 대여한 책의 수를 구하시오.
SELECT b.NAME , COUNT(br.RENT_NO) AS "대여한 책의 수" 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 
HAVING b.NAME = '최행운';

-- 10번문제 서브쿼리
SELECT b.NAME , br.rent_count
FROM BOOKMEMBER b JOIN (
	SELECT br.MEM_IDX, COUNT(br.RENT_NO) AS rent_count
	FROM BOOKRENT br 
	GROUP BY br.MEM_IDX
)br
ON b.MEM_IDX = br.MEM_IDX
WHERE b.NAME = '최행운';

-- 11. "2018-07-10" 이전에 출판된 책들의 목록을 조회하시오.
SELECT *
FROM BOOKS b 
WHERE TO_CHAR(pdate,'yyyy-mm-dd') < '2018-07-10';

-- 12. "푸른사자 와니니" 책의 대여 횟수를 구하시오.
SELECT b.TITLE , COUNT(*) AS "대여 횟수"
FROM BOOKS b JOIN BOOKRENT br
ON b.BCODE = br.BCODE 
GROUP BY b.TITLE
HAVING b.TITLE = '푸른사자 와니니';

-- 13. 반납일(exp_date)이 지나서 아직 반납되지 않은 책들의 목록을 조회하시오. (14일 이후) 
SELECT b.title, bm.name, br.rent_date, br.exp_date
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
JOIN bookmember bm ON br.mem_idx = bm.mem_idx
WHERE br.exp_date < TRUNC(SYSDATE) - 14
AND br.return_date IS NULL;

-- 14. 각 회원별로 대여한 책의 수를 구하시오.
SELECT b.NAME , COUNT(*) AS "대여한 책의 수" 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME ;

-- 15. "나길동" 회원이 대여한 책 중에 연체된 책의 수와 총 연체 일수를 구하시오.(join)
SELECT b.NAME , br.DELAY_DAYS , COUNT(*) 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME , br.DELAY_DAYS 
HAVING b.NAME = '나길동';

-- 15번문제 서브쿼리
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

-- 16. "코스모스" 책을 대여한 회원들의 이메일 주소를 조회하시오.
SELECT b.EMAIL 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스';

-- 17. 연체 일수가 가장 많은 책을 대여한 회원의 이름과 연체 일수를 조회하시오.
SELECT b.NAME , MAX(br.DELAY_DAYS) AS "연체 일수"
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 
HAVING MAX(br.DELAY_DAYS) > 0;

-- 18. "해커스토익" 책이 대여된 횟수를 구하시오.
SELECT b.TITLE , br.rent_count
FROM BOOKS b JOIN (
	SELECT bcode,COUNT(*) AS rent_count
	FROM BOOKRENT br
	GROUP BY bcode 
)br	
ON b.BCODE = br.BCODE
WHERE b.TITLE = '해커스토익';

-- 19. 책을 대여한 회원 중에서 "010-"로 시작하는 전화번호를 가진 회원의 수를 구하시오.
SELECT COUNT(DISTINCT bm.MEM_IDX) AS "회원 수"
FROM BOOKMEMBER bm
JOIN BOOKRENT br ON bm.MEM_IDX = br.MEM_IDX
WHERE bm.TEL LIKE '010-%';

-- 20. "나길동" 회원이 대여한 책들 중에서 아직 반납되지 않은 책의 수를 구하시오.
SELECT COUNT(*) AS "반납 전 책의 수"
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
WHERE bm.name = '나길동' AND br.return_date IS NULL; 

-- 21. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오.
SELECT TO_CHAR(rent_date, 'YYYY-MM-DD') AS "날짜", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'		-- 사이에 있는 값 가져온다는 의미
GROUP BY TO_CHAR(rent_date, 'YYYY-MM-DD')
ORDER BY "날짜"; 

-- 22. 연체 일수가 0일인 회원들의 이름과 이메일 주소를 조회하시오.
SELECT b.NAME , b.EMAIL 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
WHERE br.DELAY_DAYS = 0;

-- 23. "해커스토익" 책을 대여한 회원들과 "푸른사자 와니니" 책을 대여한 회원들의 합집합을 구하시오.
SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'B1101'
UNION ALL
SELECT mem_idx, bcode
FROM bookrent
WHERE bcode = 'C1101';

-- 23번 문제 join 으로 회원 이름,이메일 조회
SELECT '해커스토익' AS TYPE , b.NAME ,b.EMAIL, br.BCODE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '해커스토익'
UNION ALL 
SELECT '푸른사자 와니니' AS TYPE , b.NAME ,b.EMAIL, br.BCODE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '푸른사자 와니니'
ORDER BY TYPE DESC;

-- 24. "코스모스" 책을 대여한 회원들의 이름과 대여일자를 조회하되, 최대 3명까지만 조회하시오.
SELECT b.NAME , br.RENT_DATE  
FROM BOOKMEMBER b JOIN BOOKRENT br 
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스' AND rownum <= 3;

-- 25. "푸른사자 와니니" 책을 대여한 회원들의 이메일 주소를 조회하시오.
SELECT b.EMAIL  
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '푸른사자 와니니';

-- 26. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오. 단, 날짜는 월(day)부분을 제외하고 출력하시오.
SELECT TRUNC(rent_date, 'MONTH') AS "월", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'
GROUP BY TRUNC(rent_date, 'MONTH');

-- 27. "푸른사자 와니니" 책을 대여한 회원들 중에서 "해커스토익" 책을 대여한 회원들을 제외한 회원들의 이메일 주소를 조회하시오.
SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT br.mem_idx
    FROM bookrent br JOIN BOOKS b 
    ON br.bcode = b.bcode
    WHERE b.TITLE = '푸른사자 와니니'
)
AND mem_idx NOT IN (
    SELECT br.mem_idx
    FROM bookrent br JOIN BOOKS b
    ON br.bcode = b.bcode
    WHERE b.TITLE = '해커스토익'
);

-- 28. "해커스토익" 책을 대여한 회원들 중에서 가장 늦게 반납한 회원의 이름과 대여일자, 반납일자를 조회하시오.
SELECT b.NAME , br.RENT_DATE , br.RETURN_DATE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '해커스토익' 
AND br.RETURN_DATE = (
		SELECT MAX(b2.RETURN_DATE) 
		FROM BOOKRENT b2 JOIN books b3 
		ON b2.bcode = b3.bcode 
		WHERE b3.title = '해커스토익');

-- 29. "코스모스" 책을 대여한 회원들 중에서 연체 일수가 가장 많은 회원의 이름과 연체 일수를 조회하시오.
SELECT b.NAME , br.DELAY_DAYS 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스' AND br.DELAY_DAYS = (SELECT MAX(delay_days) FROM BOOKRENT);

-- 30. "푸른사자 와니니" 책을 대여한 회원들 중에서 2023년 6월에 대여한 회원들의 이름과 대여일자를 조회하시오.
SELECT b.NAME , br.RENT_DATE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '푸른사자 와니니' AND TO_CHAR(br.RENT_DATE,'yyyy-mm') = '2023-06'; 

-- 31. 책을 대여한 회원들 중에서 반납한회원과 반납전인회원의 이름,이메일,전화번호,상태를 조회하시오.
SELECT b.NAME , b.EMAIL , b.TEL ,'반납전' AS TYPE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
WHERE br.RETURN_DATE IS NULL
UNION ALL 
SELECT b.NAME , b.EMAIL , b.TEL ,'반납완료' AS TYPE 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
WHERE br.RETURN_DATE IS NOT NULL;

-- 32. "해커스토익" 책을 대여한 회원들 중에서 연락처(tel) 정보를 가지고 있지 않은 회원들의 이름과 이메일 주소를 조회하시오.
SELECT bm.name, bm.email
FROM bookmember bm
JOIN bookrent br ON bm.mem_idx = br.mem_idx
JOIN books b ON br.bcode = b.bcode
WHERE b.title = '해커스토익'
AND bm.tel IS NULL;

-- 33. "코스모스" 책을 대여한 회원들 중에서 반납되지 않은 대여 건의 수를 구하시오.
SELECT COUNT(*) 
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스' AND br.RETURN_DATE IS NULL ;

-- 34. "해커스토익" 책을 대여한 회원들과 "코스모스" 책을 대여한 회원들의 합집합을 구하시오.
SELECT '해커스토익' AS TYPE ,b.NAME,b.EMAIL ,b.TEL ,b.PASSWORD  
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '해커스토익'
UNION ALL 
SELECT '코스모스' AS TYPE ,b.NAME,b.EMAIL ,b.TEL ,b.PASSWORD  
FROM BOOKMEMBER b JOIN BOOKRENT br
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스'
ORDER BY TYPE ;

-- 35. 대여 일자(rent_date)가 가장 오래된 책의 정보를 조회하시오.
SELECT b.*
FROM BOOKS b JOIN BOOKRENT br
ON b.BCODE = br.BCODE 
WHERE br.RENT_DATE = (SELECT min(RENT_DATE) FROM BOOKRENT);

-- 35번문제 참고 : 출판 일자가 가장 오래된 책의 정보를 조회
SELECT *
FROM books
WHERE pdate = (
    SELECT MIN(pdate)
    FROM books
);

-- 36. 각 회원별로 대여한 책의 수를 조회하고, 대여한 책의 수가 가장 많은 회원을 찾으시오.
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

-- 37. 대여한 책 중에서 중복된 책을 제외한 유일한 책의 목록을 조회하시오.
SELECT b.*
FROM books b
JOIN (
    SELECT bcode
    FROM bookrent
    GROUP BY bcode
    HAVING COUNT(*) = 1
) br ON b.bcode = br.bcode;

-- 38. 대여된 모든 책의 목록과 대여하지 않은 모든 책의 목록을 합쳐서 조회하시오.
SELECT '대여됨'AS TYPE ,b.bcode, b.title, b.writer, b.publisher, b.pdate,br.RENT_DATE 
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
UNION ALL
SELECT '대여안됨'AS TYPE ,b.bcode, b.title, b.writer, b.publisher, b.pdate, NULL 
FROM books b
WHERE b.bcode NOT IN (
    SELECT bcode
    FROM bookrent
);

-- 39. 아직 반납되지 않은 책 중에서 반납일이 가장 이른 책의 정보를 조회하시오.
SELECT b.*
FROM BOOKS b JOIN BOOKRENT br
ON b.BCODE = br.BCODE 
WHERE br.EXP_DATE = (SELECT MIN(EXP_DATE)FROM BOOKRENT WHERE RETURN_DATE IS NULL);

-- 40. 회원별로 대여한 책의 평균 대여 기간을 조회하시오.
SELECT b.NAME, AVG(TRUNC(br.return_date) - TRUNC(br.rent_date)) AS "평균 대여 기간"
FROM BOOKMEMBER b
JOIN BOOKRENT br ON b.MEM_IDX = br.MEM_IDX
GROUP BY b.NAME;





