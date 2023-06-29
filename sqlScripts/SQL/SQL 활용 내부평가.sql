CREATE TABLE bookmember(
	mem_idx number(5,0)PRIMARY KEY,
	name varchar2(20)NOT NULL ,
	email varchar2(20)NOT NULL UNIQUE,
	tel varchar2(20),
	password varchar2(10)
);

CREATE TABLE books(
	bcode char(5)PRIMARY KEY,
	title varchar2(30)NOT NULL,
	writer varchar2(20)NOT NULL,
	publisher varchar2(20),
	pdate DATE
);

CREATE TABLE bookrent(
	rent_no NUMBER(5,0)PRIMARY KEY,
	mem_idx NUMBER(5,0)NOT NULL,
	bcode char(5)NOT NULL,
	rent_date DATE NOT NULL,
	exp_date DATE NOT NULL,
	return_date DATE,
	delay_days NUMBER(3,0)
);

ALTER TABLE bookrent
ADD CONSTRAINT mem_idx FOREIGN KEY (mem_idx)
	REFERENCES bookmember (mem_idx);

ALTER TABLE bookrent
ADD CONSTRAINT bcode FOREIGN KEY (bcode)
	REFERENCES books (bcode);
-------------------------------------------------------
INSERT INTO BOOKMEMBER b VALUES (10001,'이하니','honey@naver.com','010-9889-0567','1122');
INSERT INTO BOOKMEMBER b VALUES (10002,'이세종','jong@daum.net','010-2354-6773','2345');
INSERT INTO BOOKMEMBER b VALUES (10003,'최행운','lucky@korea.com','010-5467-8792','9876');
INSERT INTO BOOKMEMBER b VALUES (10004,'나길동','nadong@kkk.net','010-3456-8765','3456');
INSERT INTO BOOKMEMBER b VALUES (10005,'강감찬','haha@korea.net','010-3987-9087','1234');

INSERT INTO BOOKS b VALUES ('A1101','코스모스','칼세이건','사이언스북스','2006-12-01');
INSERT INTO BOOKS b VALUES ('B1101','해커스토익','이해커','해커스랩','2018-07-10');
INSERT INTO BOOKS b VALUES ('C1101','푸른사자 와니니','이현','창비','2015-06-20');
INSERT INTO BOOKS b VALUES ('A1102','페스트','알베르트 까뮈','민음사','2011-03-01');

INSERT INTO BOOKRENT b VALUES (1,10001,'B1101',
timestamp'2023-05-01 14:22:00.0','2023-05-15',timestamp'2023-05-14 11:30:00.0',-1);
INSERT INTO BOOKRENT b VALUES (2,10002,'C1101',
timestamp'2023-06-12 17:04:00.0','2023-06-25',NULL,NULL);
INSERT INTO BOOKRENT b VALUES (3,10003,'B1101',
timestamp'2023-06-03 10:15:00.0','2023-06-17',timestamp'2023-06-17 11:33:00.0',0);
INSERT INTO BOOKRENT b VALUES (4,10004,'C1101',
timestamp'2023-04-03 13:34:00.0','2023-04-17',timestamp'2023-04-15 14:20:00.0',-2);
INSERT INTO BOOKRENT b VALUES (5,10001,'A1101',
timestamp'2023-06-16 11:11:00.0','2023-06-30',NULL,NULL);
INSERT INTO BOOKRENT b VALUES (6,10003,'A1102',
timestamp'2023-06-17 11:41:00.0','2023-07-01',NULL,NULL);
INSERT INTO BOOKRENT b VALUES (7,10002,'A1101',
timestamp'2023-05-15 13:42:00.0','2023-05-29',timestamp'2023-05-30 12:42:00.0',1);

SELECT * FROM BOOKMEMBER b ;
SELECT * FROM BOOKS b ;
SELECT * FROM BOOKRENT b ;

SELECT trunc(sysdate) - to_date('20171110','yyyymmdd')
FROM dual;
-----------------------------------------------------------------------------------------------------------------------------
-- 년도, 일수의 차이는 뺄셈연산으로 가능. 개월수 구하는 함수 제공.
-- 2개의 날짜의 간격(일). TRUNC(SYSDATE)는 일(day)까지로 변환
-----------------------------------------------------------------------------------------------------------------------------
-- SELECT 문 7개 시험문제 
-----------------------------------------------------------------------------------------------------------------------------
-- 필기 시험
-- DDL, 제약조건, DML, 트랜잭션 , 인덱스, 뷰 에 대한 기본 사항을 학습해야 합니다.
-----------------------------------------------------------------------------------------------------------------------------
-- bookrent 테이블에 insert 를 합니다.(단, delay_days) 컬럼은 제외.
-- 일수 계산할때는 TRUNC 사용 -> 앞에껄로 사용 
UPDATE bookrent SET delay_days = TRUNC(return_date) - exp_date;
SELECT * FROM bookrent;							-- 연체일수 정수 OR 소수점
SELECT round(return_date - exp_date) FROM bookrent;		-- 연체일수 정수 OR 소수점
-----------------------------------------------------------------------------------------------------------------------------
-- 중요 1. tbl_buy 테이블에서 사용자ID 별로 구매 횟수를 구해서 가장 구매 횟수가 많은 사용자ID, 구매횟수(buy_count)를 조회하여라
-- 단, 구매횟수가 가장 많은 것은 1개이다.
SELECT customid, count(*) buy_count
	FROM TBL_BUY tb 
	GROUP BY CUSTOMID
	ORDER BY buy_count DESC;
-----------------------------------------------------------------------------------------------------------------------------
SELECT rownum,customid,buy_count		-- 아래 서브쿼리() 조회결과에 대한 rownum 을 조건식으로 사용하기.
FROM(
	SELECT customid, count(*) buy_count
	FROM TBL_BUY tb 
	GROUP BY CUSTOMID
	ORDER BY buy_count DESC
)
WHERE rownum <= 1;		-- rownum에 쓸수 있는 연산은 >=, <=,>,<, BETWEEN,rownum = 1(1이외의 다른 값은 동작오류)

-- 오라클은 조회된 행에 순서대로 번호를 부여하여 rownum 컬럼에 저장한다. 항상 사용할 수 있는 컬럼입니다.
SELECT rownum, buy_seq,customid,qty
FROM TBL_BUY tb 		-- rownum은 ORDER BY 하기 전의 rownum
ORDER BY qty DESC ;
-----------------------------------------------------------------------------------------------------------------------------
-- select 연산 중 집합연산이 있습니다. 
-- 이 중 union all 연산은 행을 합칠때 쓰는 연산이라고 수업시간에 했습니다. 
-- 그외에  minus 연산에 대해 알아보고 언제 사용할수 있는지 예시도 만들어보세요.

-- 1. '해커스토익' 책이 대여된 횟수를 구하시오
SELECT b.TITLE , br.rent_no
FROM BOOKS b JOIN (
	SELECT br.bcode, count(br.rent_no) AS rent_no
	FROM BOOKRENT br 
	GROUP BY br.bcode
)br
ON b.BCODE = br.BCODE 
WHERE b.TITLE = '해커스토익';

SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'C1101'
)
MINUS
SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT mem_idx
    FROM bookrent
    WHERE bcode = 'B1101'
);


SELECT email
FROM bookmember
WHERE mem_idx IN (
    SELECT br.mem_idx
    FROM bookrent br
    JOIN books b ON br.bcode = b.bcode
    WHERE b.title = '푸른사자 와니니'
        AND br.return_date IS NULL
        AND br.exp_date < SYSDATE
)
AND mem_idx NOT IN (
    SELECT br.mem_idx
    FROM bookrent br
    JOIN books b ON br.bcode = b.bcode
    WHERE b.title = '해커스토익'
);
-----------------------------------------------------------------------------------------------------------------------------
-- '10002' 회원번호 반납날짜는 오늘로 한다는 코드
UPDATE BOOKRENT SET return_date = sysdate WHERE mem_idex = 10002;

-- 자동으로 연체일 계산하는 코드
UPDATE BOOKRENT SET delay_days = TRUNC(return_date) - exp_date; 
-----------------------------------------------------------------------------------------------------------------------------
-- 전화번호 하이픈 제거하고 최대 2명까지 출력
-- REPLACE(변경하고자 하는 문자열 또는 컬럼명, 찾을 문자열, 대체할 문자열)
SELECT BM.mem_idx, BM.name, BM.email, REPLACE(BM.tel, '-', '') AS tel, BM.password
FROM BOOKMEMBER BM
JOIN (
    SELECT BR.mem_idx
    FROM BOOKRENT BR
    WHERE ROWNUM <= 2
    GROUP BY BR.mem_idx
) R ON BM.mem_idx = R.mem_idx;


SELECT mem_idx, name, email, RPAD(SUBSTR(tel, 1, LENGTH(tel) - 4), LENGTH(tel), '*') AS masked_tel, password
FROM bookmember;
SELECT mem_idx, name, email, tel, RPAD(SUBSTR(password, 1, 2), LENGTH(password), '*') AS masked_password
FROM bookmember;
SELECT mem_idx, name, email, tel, 
       SUBSTR(password, 1, 1) || 
       RPAD('*', LENGTH(password) - 2, '*') || 
       SUBSTR(password, -1, 1) AS masked_password
FROM bookmember;

-----------------------------------------------------------------------------------------------------------------------------
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

-- 9. 날짜 관련 함수인 TRUNC를 사용하여 대여일자의 월별 횟수를 구하는 예시
SELECT TRUNC(rent_date, 'mm') AS "대여", COUNT(*) AS "월별 횟수"
FROM bookrent
GROUP BY TRUNC(rent_date, 'mm')
ORDER BY TRUNC(rent_date, 'mm');

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

-- 13. 반납일(exp_date)이 지나서 아직 반납되지 않은 책들의 목록을 조회하시오. (14일 이후) 
SELECT b.title, bm.name, br.rent_date, br.exp_date
FROM books b
JOIN bookrent br ON b.bcode = br.bcode
JOIN bookmember bm ON br.mem_idx = bm.mem_idx
WHERE br.exp_date < TRUNC(SYSDATE) - 14
AND br.return_date IS NULL;

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

-- 21. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오.
SELECT TO_CHAR(rent_date, 'YYYY-MM-DD') AS "날짜", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'		-- 사이에 있는 값 가져온다는 의미
GROUP BY TO_CHAR(rent_date, 'YYYY-MM-DD')
ORDER BY "날짜"; 

-- 24. "코스모스" 책을 대여한 회원들의 이름과 대여일자를 조회하되, 최대 3명까지만 조회하시오.
SELECT b.NAME , br.RENT_DATE  
FROM BOOKMEMBER b JOIN BOOKRENT br 
ON b.MEM_IDX = br.MEM_IDX 
JOIN BOOKS bs ON bs.BCODE = br.BCODE 
WHERE bs.TITLE = '코스모스' AND rownum <= 3;

-- 26. "2023-06-01"부터 "2023-06-30" 사이에 대여된 책의 수를 날짜별로 구하시오. 단, 날짜는 월(day)부분을 제외하고 출력하시오.
SELECT TRUNC(rent_date, 'MONTH') AS "월", COUNT(*) AS "대여된 책의 수"
FROM bookrent
WHERE rent_date BETWEEN DATE '2023-06-01' AND DATE '2023-06-30'
GROUP BY TRUNC(rent_date, 'MONTH');

-- 40. 회원별로 대여한 책의 평균 대여 기간을 조회하시오.
SELECT b.NAME, AVG(TRUNC(br.return_date) - TRUNC(br.rent_date)) AS "평균 대여 기간"
FROM BOOKMEMBER b
JOIN BOOKRENT br ON b.MEM_IDX = br.MEM_IDX
GROUP BY b.NAME;



