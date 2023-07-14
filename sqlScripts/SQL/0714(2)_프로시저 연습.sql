CREATE TABLE p_buy5
AS 
SELECT * FROM P_BUY4 pb ;

SELECT * FROM P_BUY5;
SELECT * FROM TBL_PRODUCT tp ;

-- p_buy3 테이블에 CUSTOMID, PCODE, QTY 를 입력하면 자동으로 금액을 입력하고 
	-- 총 구매 금액이 100,000원 이상이면 VIP, 아니면 일반으로 입력하는 프로시저

ALTER TABLE P_BUY5 ADD grade varchar2(10);
CREATE SEQUENCE p_buy5_seq START WITH 1009;

CREATE OR REPLACE PROCEDURE set_grade2(
	gcustomid IN varchar2,
	gpcode IN varchar2,
	gqty IN NUMBER
)
IS 
	/*
	 1. p_buy3 테이블에 CUSTOMID, PCODE, QTY 를 입력 
	 2. 자동으로 금액을 입력 > 가격 * 수량
	 	2-1. 시퀀스 값 가져오기 > vseq NUMBER;
	 	2-2. 가격 가져오기 > vprice NUMBER;
	 3. p_buy3 테이블에 money 값 update > 가격 * 수량
	 4. 같은 customid 의 money 총 합이 100,000 이상이면 VIP, 아니면 일반 등급 표기
	 	4-1. sum(money) group by customid > 해당 customid 가져오기 > vvip varchar2;
	 	4-2. 가져온 customid를 VIP 로 update 
	 */	
	vseq NUMBER;
	vprice NUMBER;
	vvip varchar2(20);
	total NUMBER;
BEGIN 
	INSERT INTO p_buy5(buy_seq,customid,pcode,qty,buy_date)
		VALUES(p_buy5_seq.nextval,gcustomid,gpcode,gqty,sysdate);
	
	SELECT p_buy5_seq.currval INTO vseq
		FROM dual;
	
	SELECT price INTO vprice 
		FROM TBL_PRODUCT tp WHERE pcode = gpcode;
	
	UPDATE P_BUY5 SET money = gqty * vprice WHERE buy_seq = vseq;

	SELECT customid,sum(money) INTO vvip,total FROM P_BUY5 pb 
		WHERE customid = gcustomid GROUP BY customid;
	
	IF total >= 100000 THEN 
		UPDATE p_buy5 SET grade = 'VIP' WHERE customid = vvip;
	 END IF;
	IF total < 100000 THEN 
		UPDATE p_buy5 SET grade = '일반' WHERE customid = vvip;
 	END IF;
	DBMS_OUTPUT.PUT_LINE('성공');
	COMMIT;
	EXCEPTION
	WHEN OTHERS THEN 
	DBMS_OUTPUT.PUT_LINE('실패');
	ROLLBACK;
END;

BEGIN 
	SET_GRADE2('twice','DOWON123a',1);
END;

SELECT * FROM P_BUY5 pb ;





