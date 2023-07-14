CREATE TABLE p_buy4
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM p_buy4;
SELECT * FROM TBL_PRODUCT tp ;

-- money 에 10000미만의 값이 들어가면 오류 발생 > 롤백
ALTER TABLE p_buy4 ADD money NUMBER(7) CHECK(money>=10000);
-- 시퀀스 만들기
CREATE SEQUENCE p_buy4_seq START WITH 1008;
-- 프로시저에서 트랜잭션을 관리하는 예시
-- p_buy4 테이블에 CUSTOMID, PCODE, QTY 를 입력하면 자동으로 금액을 입력하는 프로시저
CREATE OR REPLACE PROCEDURE set_money4(
	qcustomid IN varchar2,
	qpcode IN varchar2,
	qQty IN NUMBER
)
IS 
	vprice NUMBER;	-- 지역변수 선언 완료
	vseq NUMBER;
	/*
	 id, code, 수량 입력 > 자동으로 금액 입력
	 				  > 가격 * 수량
	 0. id, code, 수량 insert 
	 1. 가격 가져오기 > vprice
	 2. 기준 시퀀스 값 > vseq 
	 3. 가져온 데이터로 update 
	 */
BEGIN 
	-- 0번 insert 문 실행
	INSERT INTO p_buy4(buy_seq,customid,pcode,qty,buy_date)
		VALUES(p_buy4_seq.nextval,qcustomid,qpcode,qQty,sysdate);
	
	-- 1번 가격가져오기 > vprice
	SELECT price INTO vprice 
		FROM TBL_PRODUCT tp WHERE pcode = qpcode;
	
	-- 2번 기준 시퀀스 값 > vseq
	SELECT p_buy4_seq.currval INTO vseq
		FROM dual;
	
	-- 3번 가져온 데이터로 UPDATE 
	UPDATE p_buy4 SET money = vprice * qQty
		WHERE buy_seq = vseq;
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	COMMIT;
	EXCEPTION --필수사항 아니고 
	WHEN OTHERS THEN -- 모든 예외 처리 하는거 
	DBMS_OUTPUT.PUT_LINE('실행 실패');
	ROLLBACK;
END;

-- 실행
/*
 	CREATE OR REPLACE PROCEDURE set_money4(
	qcustomid IN varchar2,
	qpcode IN varchar2,
	qQty IN NUMBER
)
 */



BEGIN
	set_money4('mina012','CJBAb12g',5);
END;




