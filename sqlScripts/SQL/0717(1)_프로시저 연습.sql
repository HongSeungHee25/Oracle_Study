CREATE TABLE p_buy6
AS 
SELECT * FROM tbl_buy;

SELECT * FROM p_buy6;
SELECT * FROM TBL_PRODUCT tp ;

ALTER TABLE p_buy6 ADD money NUMBER(7) CHECK (money >= 10000);


CREATE TABLE student(
	s_no NUMBER,			-- 학번
	name varchar2(9),		-- 이름
	age NUMBER,				-- 나이
	grade NUMBER			-- 학년
);

CREATE TABLE s_record(
	s_no NUMBER,			-- 학번
	subject varchar2(6),	-- 과목
	score NUMBER,			-- 점수
	grade char(1)			-- 등급
);
-- 직접 입력 X
CREATE TABLE s_management(
	s_no NUMBER,			-- 학번
	name varchar2(9),		-- 이름
	age NUMBER,				-- 나이
	grade NUMBER,			-- 학년
	subject varchar2(6),	-- 과목
	score NUMBER,			-- 점수
	s_grade char(1)			-- 등급
);

-- Casecade 를 사용한 프로시저 

-- 1. 학번, 이름, 나이 입력하면 학년 자동 입력
-- 2. 학번, 과목, 점수 입력하면 등급 자동 입력
-- 3. 1,2번 입력시 자동으로 s_management 에 입력
SELECT * FROM student;


CREATE OR REPLACE PROCEDURE aute_grade(
	vNO student.S_NO %TYPE,
	vName student.NAME %TYPE,
	vage student.AGE %TYPE 
)
IS 
	vgrade student.GRADE %TYPE;
BEGIN 
	SELECT vage-7 INTO vgrade
		FROM dual;
	
	INSERT INTO student VALUES (vNO,vName,vage,vgrade);
	COMMIT ;
exception 
	WHEN OTHERS THEN 
	ROLLBACK ;
END;

BEGIN 
	aute_grade(1001,'김모모',15);
END;











