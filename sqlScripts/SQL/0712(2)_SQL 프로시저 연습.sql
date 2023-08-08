-- 프로시저 복습하기 위한 테이블. tbl_buy 복사
CREATE TABLE per_buy
AS 
SELECT * FROM tbl_buy ;

SELECT * FROM per_buy;

CREATE OR REPLACE PROCEDURE proce_set_money2(
	bcustom_id IN varchar2,
	bpcode IN varchar2,
	bcnt IN NUMBER ,
	isSuccess2 OUT varchar2
)
IS 
	xseq NUMBER ;
	xprice NUMBER ;
BEGIN 
	INSERT INTO per_buy(buy_seq,customid,pcode,qty,buy_date)
		VALUES (buy_seq.nextval, bcustom_id,bpcode,bcnt,sysdate);
	SELECT buy_seq.currval
		INTO xseq
		FROM dual;
	SELECT price INTO xprice
		FROM tbl_product WHERE pcode = bpcode;
	UPDATE per_buy SET money = xprice * qty
		WHERE buy_seq = xseq;
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	isSuccess2 :='success';
	COMMIT;
	EXCEPTION;
		WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('실행 실패');
		ROLLBACK;
		isSuccess2 :='fail';
END;

-- 실행을 위해서 시퀀스 생성, money 컬럼 추가
CREATE SEQUENCE buy_seq
START WITH 1008;

ALTER TABLE per_buy
ADD money NUMBER ;

-- 위에 만든 컬럼 money 지우기
ALTER TABLE per_buy DROP COLUMN money;

-- 롤백 시나리오 만들기
ALTER TABLE per_buy ADD money NUMBER(7) CHECK (money >= 10000);

DECLARE 
	xresult varchar2(20);
BEGIN 
	proce_set_money2('twice','CJBAb12g',2,xresult);
	DBMS_OUTPUT.PUT_LINE('결과 : '|| xresult);
END;

SELECT * FROM member_tbl_02;


