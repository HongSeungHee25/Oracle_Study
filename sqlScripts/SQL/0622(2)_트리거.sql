-- 트리거는(trigger)는 데이터베이스 시스템에서 
--      데이터의 `입력, 갱신, 삭제() 등의 이벤트`가 발생할 때마다 '자동적으로 수행되는 사용자 정의 프로시저'이다.
--      특정 테이블에 속해있는 객체
/*
 * 
CREATE OR REPLACE TRIGGER 트리거이름
BEFORE | AFTER                  		 -- 동작 시점
INSERT | UPDATE | DELETE ON 테이블명        -- 테이블과 해당 C,R,D 지정
[FOR EACH ROW]      					 -- 행 트리거. 테이블 행 단위 변화에 대해 동작하기.
[WHEN(조건)]       						 -- 특정컬럼에 대한 값 조건
DECLARE    								 -- 변수선언
...
BEGIN
...
[EXCEPTION] 							 -- 예외사항
END;  
 */
-- 원하는 작업을 자동으로. 데이터베이스 테이블 관리를 위한 목적.
CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON p_buy					-- p_buy 테이블 대상으로 DELETE 실행한 후에 동작한다.
FOR EACH ROW 							-- 적용하는 행이 여러개 일때 각 행에 대해 실행함.
										-- :OLD UPDATE 또는 DELETE 하기전 값, :NEW 는 INSERT 한 값
BEGIN 
		-- 구매 취소(p_buy 테이블에서 삭제)한 데이터 tri_temp 임시테이블에 insert : 여러행에 대한 작업(행 트리거)
		INSERT INTO tri_temp
		VALUES 
		(:OLD.buy_seq, :OLD.customid, :OLD.pcode, :OLD.qty, :OLD.buy_date, :OLD.money);
END;

-- 데이터는 복사하지 않고 테이블 구조만 동일하게 만들기
CREATE TABLE tri_temp
AS 
SELECT * FROM p_buy WHERE buy_seq=0;

-- 확인
SELECT * FROM tri_temp;

-- 트리거 동작시키기
DELETE FROM p_buy WHERE pcode = '3MCRY';
DELETE FROM p_buy WHERE customid = 'hongGD';
SELECT * FROM P_BUY pb ;

-- 테이블 관리 목적의 트리거 : 예시로 update 와 delete 명령을 할 수 없는 시간 정함.
CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom		-- 트리거 동작하는 테이블, SQL 과 시점
BEGIN 
	IF to_char(sysdate, 'HH24:MI') BETWEEN '12:00' AND '16:00' THEN 
		raise_application_error(-20000,'지금 오후 12~16시는 작업할수 없습니다.');
	-- raise_application_error : 오라클의 애플리케이션 오류 발생 함수. 임의 오류값 지정, 메시지 필요.
	END IF;
END;

-- 트리거 동작 테스트
DELETE FROM tbl_custom WHERE custom_id = 'momo';

-- 트리거 비활성화 : disable , 활성화 : enable
ALTER TRIGGER secure_custom disable;






