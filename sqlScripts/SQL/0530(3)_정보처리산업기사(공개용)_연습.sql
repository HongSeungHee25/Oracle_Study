DROP TABLE member_tbl_02;
DROP TABLE money_tbl_02;

-- 데이터 모두 제거하기
TRUNCATE TABLE member_tbl_02;
TRUNCATE TABLE money_tbl_02;

CREATE TABLE member_tbl_02(
	custno number(6) PRIMARY KEY NOT NULL ,
	custname varchar2(20),
	phone varchar2(13),
	address varchar2(60),
	joindate DATE ,
	grade char(1),
	city char(2)
);

-- member_tbl_ 02 시퀀스 생성
CREATE SEQUENCE tbl_member_02
	START WITH 100001;

DROP SEQUENCE tbl_member_02;

INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '김행복', '010-1111-2222','서울 동대문구 휘경1동','2015-12-02','A','01');
INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '이축복', '010-1111-3333','서울 동대문구 휘경2동','2015-12-02','B','01');
INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '장믿음', '010-1111-4444','울릉군 울릉읍 독도1리','2015-12-02','B','30');
INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '최사랑', '010-1111-5555','울릉군 울릉읍 독도2리','2015-12-02','A','30');
INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '진평화', '010-1111-6666','제주도 제주시 외나무골','2015-12-02','B','60');
INSERT INTO member_tbl_02 VALUES (tbl_member_02.nextval, '차공단', '010-1111-7777','제주도 제주시 감나무골','2015-12-02','C','60');

SELECT *
FROM member_tbl_02;

CREATE TABLE money_tbl_02(
	custno number(6) NOT NULL ,
	salenol number(8) NOT NULL ,
	pcost number(8),
	amount number(4),
	price number(8),
	pcode varchar2(4),
	sdate DATE, 
	PRIMARY KEY(custno, salenol)
);

-- money_tbl_02 시퀀스 생성
CREATE SEQUENCE tbl_money_02
	START WITH 20160001;

DROP SEQUENCE tbl_money_02;

INSERT INTO money_tbl_02 VALUES (100001,tbl_money_02.nextval,500,5,2500,'A001','2016-01-01');
INSERT INTO money_tbl_02 VALUES (100001,tbl_money_02.nextval,1000,4,4000,'A002','2016-01-01');
INSERT INTO money_tbl_02 VALUES (100001,tbl_money_02.nextval,500,3,1500,'A008','2016-01-01');
INSERT INTO money_tbl_02 VALUES (100002,tbl_money_02.nextval,2000,1,2000,'A004','2016-01-02');
INSERT INTO money_tbl_02 VALUES (100002,tbl_money_02.nextval,500,1,500,'A001','2016-01-03');
INSERT INTO money_tbl_02 VALUES (100003,tbl_money_02.nextval,1500,2,3000,'A003','2016-01-03');
INSERT INTO money_tbl_02 VALUES (100004,tbl_money_02.nextval,500,2,1000,'A001','2016-01-04');
INSERT INTO money_tbl_02 VALUES (100004,tbl_money_02.nextval,300,1,300,'A005','2016-01-04');
INSERT INTO money_tbl_02 VALUES (100004,tbl_money_02.nextval,600,1,600,'A006','2016-01-04');
INSERT INTO money_tbl_02 VALUES (100004,tbl_money_02.nextval,3000,1,3000,'A007','2016-01-06');

SELECT *
FROM money_tbl_02;
