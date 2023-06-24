SELECT * FROM BOOKMEMBER b ;
SELECT * FROM BOOKS b ;
SELECT * FROM BOOKRENT b ;

-- 1. 회원별로 대출한 책의 수를 조회
SELECT b.NAME , COUNT(*)  
FROM BOOKMEMBER b JOIN BOOKRENT br 
ON b.MEM_IDX = br.MEM_IDX 
GROUP BY b.NAME 
ORDER BY b.NAME  

-- 2. 대출 중인 도서 목록을 조회
SELECT b2.TITLE ,b.RETURN_DATE 
FROM BOOKS b2 JOIN BOOKRENT b 
ON b2.BCODE = b.BCODE 
WHERE b.RETURN_DATE IS NULL 

SELECT br.rent_no, b.title, b.writer, br.rent_date, br.exp_date
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
WHERE br.return_date IS NULL;

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


SELECT rownum, b.name, br.rental_count
FROM BOOKMEMBER b
JOIN (
    SELECT mem_idx, count(*) AS rental_count
    FROM BOOKRENT
    GROUP BY mem_idx
) br ON b.mem_idx = br.mem_idx
WHERE rownum <= 1
ORDER BY br.rental_count DESC;

-- 6. 대출일자(trunc)별로 대출 건수를 조회
SELECT TRUNC(b.RENT_DATE) AS rental_date, count(b.RENT_NO) 
FROM BOOKRENT b 
GROUP BY TRUNC(b.RENT_DATE);

