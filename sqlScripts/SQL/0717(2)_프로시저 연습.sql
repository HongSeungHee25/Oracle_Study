-- 강사님이랑 했던 p_buy 프로시저 복습
-- 똑같은 테이블이 p2_buy 로 복사됨
-- 1. 프로시저 복습하기 위한 테이블. tbl_buy 복사
CREATE TABLE p2_buy
AS 
SELECT * FROM TBL_BUY;

-- 2. 실행을 위해서 시퀀스 생성,money 컬럼 추가
CREATE SEQUENCE buy_seq
START WITH 1008;

ALTER TABLE P2_BUY ADD money number(7) CHECK (money >= 10000);
--------------------------------------------------------------------------------------------------
SELECT * FROM P2_BUY;
SELECT * FROM TBL_PRODUCT tp ;
-- 프로시저 생성(회원ID, 상품코드, 수량, 트랜잭션 처리 성공여부 저장) ▶ 입력 or 출력 매개변수 선언
-- 시나리오 : 누가, 무엇을 얼마나 구입했는지 입력 매개변수로 값을 프로시저에 전달하면
--		구매 테이블에 insert 하고 단가 X 수량 = 구매금액 계산해서 money 컬럼에 update 합니다.
-- 		프로시저에서 트랜잭션을 관리하는 예시 : insert와 update 2개의 DML 이 두개 모두 정상 실행될 때만 commit.
--									2개 중에 하나라도 오류이면 rollback(철회)
-- 3. 프로시저 생성
CREATE OR REPLACE PROCEDURE pro_set_money0(
	-- 입력 or 출력 매개변수 입력
	pcustomid IN varchar2,		-- 회원ID 입력매개변수
	pPcode IN varchar2,			-- 상품코드 입력매개변수
	pqty IN NUMBER,				-- 수량 입력매개변수
	isSuccess OUT varchar2,		-- 출력 매개변수
)
IS 
	lseq NUMBER;				
	lprice NUMBER;				-- 단가 변수선언
BEGIN 
	--1. 구매 테이블에 insert 하고
	INSERT INTO p2_buy(buy_seq,customid,pcode,qty,buy_date)
		VALUES(buy_seq.nextval,pcustomid,pPcode,pqty,sysdate);
	
	--2. output 에 현재 시퀀스 값을 출력 해줌
	SELECT buy_seq.currval INTO isSuccess
		FROM dual;
	
	-- 현재 시퀀스 값 조회
	SELECT buy_seq.currval INTO lseq
		FROM dual; 
	
	-- 단가 가져오기
	SELECT price INTO lprice 
		FROM TBL_PRODUCT tp WHERE pcode = pPcode;
	
	-- money 컬럼 업데이트
	UPDATE p2_buy SET money = lprice * pqty
		WHERE buy_seq = lseq;
	
	-- 자바에서 SYSOUT 과 같은 개념인 DBMS 출력문 선언
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	COMMIT;	-- 실행 성공하면 트랙잭션으로 커밋
	EXCEPTION -- 예외처리
	WHEN OTHERS THEN -- 모든 예외처리 하겠다는 뜻
	DBMS_OUTPUT.PUT_LINE('실행 실패');
	ROLLBACK;	-- 실행 실패하면 트랜잭션으로 롤백
END;

-- 실행 성공 예시
/*
 CREATE OR REPLACE PROCEDURE pro_set_money0(
	-- 입력 or 출력 매개변수 입력
	pcustomid IN varchar2,		-- 회원ID 입력매개변수
	pPcode IN varchar2,			-- 상품코드 입력매개변수
	pqty IN NUMBER,				-- 수량 입력매개변수
	isSuccess OUT varchar2		-- 출력 매개변수
)
 */
-------------------------------------------------------------
SELECT * FROM P2_BUY;
SELECT * FROM TBL_PRODUCT tp ;
-------------------------------------------------------------
DECLARE 
	wresult varchar2(20);
BEGIN
	pro_set_money0('mina012','DOWON123a',1,wresult);
	DBMS_OUTPUT.PUT_LINE('결과 : ' || wresult);
END;
--------------------------------------------------------------
DECLARE 
	wresult varchar2(20);
BEGIN
	pro_set_money0('hongGD','JINRMn5',2,wresult);
	DBMS_OUTPUT.PUT_LINE('결과 : ' || wresult);
END;

-- 실행 실패 예시



