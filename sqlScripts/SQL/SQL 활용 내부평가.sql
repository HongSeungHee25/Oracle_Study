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
WHERE b.TITLE = '해커스토익'





