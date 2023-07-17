-- 강사님이랑 했던 p_buy 프로시저 복습
-- 똑같은 테이블이 pb_buy 로 복사됨
-- 1. 프로시저 복습하기 위한 테이블. tbl_buy 복사
CREATE TABLE pb_buy
AS 
SELECT * FROM TBL_BUY tb ;

-- 2. 실행을 위해서 시퀀스 생성,money 컬럼 추가
CREATE SEQUENCE pb_buy_seq START WITH 1008;

ALTER TABLE pb_buy ADD money NUMBER(7) CHECK (money >= 10000);

SELECT * FROM pb_buy;
SELECT * FROM TBL_PRODUCT;
--------------------------------------------------------------------------------------------------
-- 프로시저 생성(회원ID, 상품코드, 수량, 트랜잭션 처리 성공여부 저장) ▶ 입력 or 출력 매개변수 선언
-- 시나리오 : 누가, 무엇을 얼마나 구입했는지 입력 매개변수로 값을 프로시저에 전달하면
--		구매 테이블에 insert 하고 단가 X 수량 = 구매금액 계산해서 money 컬럼에 update 합니다.
-- 		프로시저에서 트랜잭션을 관리하는 예시 : insert와 update 2개의 DML 이 두개 모두 정상 실행될 때만 commit.
--									2개 중에 하나라도 오류이면 rollback(철회)
-- 3. 프로시저 생성
CREATE OR REPLACE PROCEDURE pb_pro_set_money(
	pbcustomid IN varchar2,
	pbpcode IN varchar2,
	pbqty IN NUMBER,
	isSuccess OUT varchar2
)
IS 
	bseq NUMBER;
	bprice NUMBER;
BEGIN 
	INSERT INTO pb_buy(buy_seq,customid,pcode,qty,buy_date)
		VALUES(pb_buy_seq.nextval,pbcustomid,pbpcode,pbqty,sysdate);
	
	SELECT pb_buy_seq.currval INTO isSuccess
		FROM dual;
	
	SELECT pb_buy_seq.currval INTO bseq
		FROM dual;
	
	SELECT price INTO bprice
		FROM TBL_PRODUCT WHERE pcode = pbpcode;
	
	UPDATE pb_buy SET money = bprice * pbqty
		WHERE buy_seq = bseq;
	
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	COMMIT;
	EXCEPTION
	WHEN OTHERS THEN 
	DBMS_OUTPUT.PUT_LINE('실행 실패');
	ROLLBACK;
END;

/*
CREATE OR REPLACE PROCEDURE pb_pro_set_money(
	pbcustomid IN varchar2,
	pbpcode IN varchar2,
	pbqty IN NUMBER,
	isSuccess OUT varchar2
)
 */

DECLARE 
	bresult varchar2(20);
BEGIN
	pb_pro_set_money('twice','MANGOTK4r',1,bresult);
	DBMS_OUTPUT.PUT_LINE('결과 : ' || bresult);
END;

SELECT * FROM PB_BUY pb ;







