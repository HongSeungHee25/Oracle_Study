CREATE TABLE P_BUY3
AS 
SELECT * FROM P_BUY2;

SELECT * FROM P_BUY3;
SELECT * FROM TBL_PRODUCT tp ;

-- p_buy3 테이블에 CUSTOMID, PCODE, QTY 를 입력하면 자동으로 금액을 입력하고 
	-- 총 구매 금액이 100,000원 이상이면 VIP, 아니면 일반으로 입력하는 프로시저

ALTER TABLE P_BUY3 ADD grade varchar2(10);
CREATE SEQUENCE p_buy3_seq START WITH 1010;

CREATE OR REPLACE PROCEDURE set_grade(
	wcustomid IN varchar2,
	wpcode IN varchar2,
	wqty IN NUMBER
)
IS 
	/*
	 1. p_buy3 테이블에 CUSTOMID, PCODE, QTY 를 입력 
	 2. 자동으로 금액을 입력 > 가격 * 수량
	 	2-1. 시퀀스 값 가져오기
	 	2-2. 가격 가져오기
	 3. p_buy3 테이블에 money 값 update  
	 4. 같은 customid 의 money 총 합이 100,000 이상이면 VIP, 아니면 일반 등급 표기
	 	4-1. sum(money) group by customid > 해당 customid 가져오기
	 	4-2. 가져온 customid를 VIP 로 update 
	 */
	vseq NUMBER;
	vprice NUMBER;
	vvip varchar2;
BEGIN 
	INSERT INTO p_buy3(buy_seq,customid, pcode,qty,buy_date)
		VALUES(p_buy3_seq.nextval,wcustomid,wpcode,wqty,sysdate);
	
	SELECT p_buy3_seq.currval INTO vseq
		FROM dual;
	
	SELECT price INTO vprice 
		FROM TBL_PRODUCT tp WHERE pcode = wpcode;
	
	UPDATE P_BUY3 SET money = wqty * vprice WHERE buy_seq = vseq;

	SELECT customid INTO vvip FROM P_BUY3 pb 
		GROUP BY customid HAVING sum(money) >= 100000;
	
	UPDATE p_buy3 SET grade = 'VIP' WHERE customid = vvip;
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	COMMIT;
	EXCEPTION
	WHEN OTHERS THEN 
	DBMS_OUTPUT.PUT_LINE('실행 실패');
	ROLLBACK;
END;

BEGIN 
	SET_GRADE('mina012','APLE5kg',5);
END;


