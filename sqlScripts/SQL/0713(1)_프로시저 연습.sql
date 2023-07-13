CREATE TABLE p_buy2
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM P_BUY2;
SELECT * FROM TBL_PRODUCT tp ;

-- money 에 10000미만의 값이 들어가면 오류 발생 > 롤백
ALTER TABLE p_buy2 ADD money NUMBER(7) CHECK (money >= 10000);

CREATE SEQUENCE p_buy2_seq START WITH 1008;

-- 프로시저에서 트랜잭션을 관리하는 예시
-- p_buy2 테이블에 CUSTOMID, PCODE, QTY 를 입력하면 자동으로 금액을 입력하는 프로시저
CREATE OR REPLACE PROCEDURE set_money2(
	scustomid IN varchar2,
	spcode IN varchar2,
	sqty IN NUMBER
)
IS 
	vseq NUMBER;
	vprice NUMBER;
BEGIN
	/*
	 id, code, 수량 입력 > 자동으로 금액 입력
	 				  > 가격 * 수량
	 0. id, code, 수량 insert 
	 1. 가격 가져오기 > vprice
	 2. 기준 시퀀스 값 > vseq 
	 3. 가져온 데이터로 update 
	 */
	INSERT INTO P_BUY2(buy_seq,customid,pcode,qty,buy_date)
		VALUES(p_buy2_seq.nextval, scutomid, spcode,sqty,sysdate);
	SELECT price INTO vprice
		FROM TBL_PRODUCT tp WHERE pcode = spcode;
	SELECT p_buy2_seq.currval INTO vseq 
		FROM dual; -- 단일 행 dual 가상 테이블 -> 1회성으로 확인할려고 쓰는 테이블 
	UPDATE P_BUY2 SET money = vprice * sqtn
		WHERE buy_seq = vseq;
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	COMMIT;
	EXCEPTION 
	WHEN OTHERS THEN 
	DBMS_OUTPUT.PUT_LINE('실행 실패');
	ROLLBACK;
END;

/*
    CREATE OR REPLACE PROCEDURE set_money2(
	scustomid IN varchar2,
	spcode IN varchar2,
	sqty IN NUMBER
)
 */

BEGIN 
	set_money2('mina012','APLE5kg',5);
END;


	