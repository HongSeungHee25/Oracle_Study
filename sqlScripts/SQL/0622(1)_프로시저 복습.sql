-- 똑같은 테이블이 p_buy 로 복사됨
-- 프로시저 복습하기 위한 테이블. tbl_buy 복사
CREATE TABLE p_buy 
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM p_buy;

-- 웹애플리케이션(인터넷 환경) 개발할 때, JDBC 에서 사용자가 원하는 기능 요청 하나에 sql을 1개씩만 실행을 합니다.
-- 							프로시저를 이용하면 요청 한번에 대한 많은 SQL을 실행을 할 수 있습니다.
-- 데이터베이스관점에는 '무결성'(정확성)을 유지할 수 있는 방법.
-- 프로시저에서 트랜잭션을 관리하는 예시
CREATE OR REPLACE PROCEDURE proc_set_money(
	acustom_id IN varchar2,			-- 회원ID						-- 입력 매개변수 IN 
	apcode IN varchar2,				-- 상품코드
	acnt IN NUMBER ,				-- 수량
	isSuccess OUT varchar2 			-- 트랜잭션 처리 성공여부 저장.		-- 출력 매개변수 OUT 
)
IS 
	vseq NUMBER;					-- 변수선언
	vprice NUMBER;
BEGIN 
	INSERT INTO p_buy(buy_seq,customid,pcode,qty,buy_date)
		VALUES (buy_seq.nextval, acustom_id,apcode,acnt,sysdate);	-- 매개변수값으로 추가
	SELECT buy_seq.currval			-- 현재 시퀀스 값 조회
		INTO vseq
		FROM dual;
	SELECT price INTO vprice
		FROM TBL_PRODUCT tp WHERE pcode = apcode;		-- 상품코드에 대한 가격 조회
	UPDATE p_buy SET money = vprice * qty
		WHERE buy_seq = vseq;							-- 위 INSERT 한 데이터로 가격 * 수량 수식 구해서 money 컬럼값 수정
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	isSuccess :='success';								-- 프로시저에서 일반변수 대입문 기호 := 
	COMMIT;
	EXCEPTION 											-- EXCEPTION 추가하여 처리 -> 메시지 출력, rollback
		WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('실행 실패');
		ROLLBACK;										-- 오류가 발생한 SQL 앞의 INSERT,UPDATE ,DELETE 를 취소.
		isSuccess :='fail';
END;

-- 실행을 위해서 시퀀스 생성, money 컬럼 추가
CREATE SEQUENCE buy_seq
START WITH 1008;

ALTER TABLE p_buy
ADD money NUMBER ;

-- 위에 만든 컬럼 money 지우기
ALTER TABLE p_buy DROP COLUMN money;
-- 롤백 시나리오 만들기
ALTER TABLE p_buy ADD money NUMBER(7) CHECK (money >= 10000);

-- 실행 성공 예시
DECLARE 
	vresult varchar2(20);
BEGIN 
	proc_set_money('twice','CJBAb12g',2,VRESULT);
	DBMS_OUTPUT.PUT_LINE('결과 : '|| vresult);
END;

-- 실행 실패 예시
DECLARE 
	vresult varchar2(20);
BEGIN 
-- 메시지는 'fail' 이고 p_buy 테이블 insert 도 입력값 없어야 합니다.
	proc_set_money('twice','3MCRY',3,VRESULT);
	DBMS_OUTPUT.PUT_LINE('결과 : '|| vresult);
END;
--------------------------------------------------------------------------------
