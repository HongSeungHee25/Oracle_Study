DROP TABLE TBL_BUY ;
DROP TABLE TBL_PRODUCT ;
DROP TABLE TBL_CUSTOM ;

-- 고객 테이블
CREATE TABLE tbl_custom(
	custom_id varchar2(20) PRIMARY KEY,		-- 회원 고유 id - PK(기본)키
	name varchar2(40) NOT NULL ,			-- 이름
	email varchar2(40),						-- 이메일
	age number(3) DEFAULT 0,-- 기본 값			-- 나이
	reg_date DATE DEFAULT sysdate 						-- 가입날짜
);

INSERT INTO
	TBL_CUSTOM
VALUES ('mina012','김미나','kimm@gmail.com',20,to_date('2022-03-10 14:23:25','yyyy-mm-dd hh24:mi:ss')); 
-- 함수로 문자열에서 날짜형식 변환. 문자열의 패턴이 필요.
--'2022-03-10 14:23:25');  -- 타입이 DATE 일때 시:분:초 포함된 문자열은 자동 변환이 안됩니다. 오류
INSERT INTO 
	TBL_CUSTOM 
VALUES ('hongGD', '홍길동', 'gil@korea.com', 32,to_date('2021-10-21 11:12:23','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_CUSTOM 
VALUES ('twice', '박모모', 'momo@daum.net', 29,to_date('2021-12-25 19:23:45','yyyy-mm-dd hh24:mi:ss'));
-- 현재날짜와 시간 입력하는 것은 컬럼의 기본값을 오라클의 sysdate 로 설정합니다.
INSERT INTO 
	TBL_CUSTOM (custom_id, name, email, age)
VALUES ('wonder', '이나나', 'lee@naver.com', 40);

-- 상품 테이블 : 
CREATE TABLE tbl_product(
	pcode varchar2(20) PRIMARY KEY,			-- 상품코드 - PK(기본)키
	category char(2) NOT NULL,				-- 카테고리
	pname varchar2(40) NOT NULL,			-- 상품명
	price number(9) NOT NULL				-- 가격
);
-- 참고로 code 는 상품명, 회사명, 강사명 등 중복될 수 있는 데이터를 식별하기 위해 부여하는 임이의 체계있는 값입니다.
INSERT INTO 
	TBL_PRODUCT
VALUES ('DOWON123a', 'B2', '동원참치선물세트', 54000);
INSERT INTO 
	TBL_PRODUCT
VALUES ('CJBAb12g', 'B1', '햇반 12개입', 14500);
INSERT INTO 
	TBL_PRODUCT
VALUES ('JINRMn5', 'B1', '진라면 5개입', 6350);
INSERT INTO 
	TBL_PRODUCT
VALUES ('APLE5kg', 'A1', '청송사과 5kg', 66000);
INSERT INTO 
	TBL_PRODUCT
VALUES ('MANGOTK4r', 'A2', '애플망고 1kg', 32000);

-- 구매 테이블 : 어느 고객이 무슨 상품을 구입하는가? 고유 ID 또는 상품코드로 기본키를 만들 수 있을까요? -> 없습니다.
CREATE TABLE tbl_buy(
	buy_seq number(8) PRIMARY KEY,			-- 구매번호 - PK(기본)키
	customId varchar2(20) NOT NULL,		-- 고유 id -- 참조테이블 컬럼명과 다르게 할수 있습니다.
	pcode varchar2(20) NOT NULL,			-- 상품코드
	qty number(5) DEFAULT 1,				-- 구매수량
	buy_date DATE, 							-- 구매날짜
	FOREIGN KEY (customId)					-- 이 테이블의 외래키 컬럼
		REFERENCES tbl_custom(custom_id),	-- 참조하는 테이블과 컬럼명
	FOREIGN KEY (pcode)
		REFERENCES tbl_product(pcode)
);

INSERT INTO 
	TBL_BUY 
VALUES (1,'mina012' , 'CJBAb12g' , 5 , to_date('2022-03-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (2,'mina012' , 'APLE5kg' , 2 , to_date('2022-03-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (3,'mina012' , 'JINRMn5' , 2 , to_date('2022-03-16 10:13:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (4,'twice' , 'JINRMn5' , 3 , to_date('2021-12-25 19:32:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (5,'twice' , 'MANGOTK4r' , 2 , to_date('2021-12-25 19:32:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (6,'hongGD' , 'DOWON123a' , 1 , to_date('2021-10-21 11:13:25','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO 
	TBL_BUY 
VALUES (7,'hongGD' , 'APLE5kg' , 1 , to_date('2021-10-21 11:13:25','yyyy-mm-dd hh24:mi:ss'));
