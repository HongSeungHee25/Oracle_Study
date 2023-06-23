/*
남은 시간은 아래와 같은 내용으로 복습하세요.
1. tbl_buy2 의 buy_seq 를 tbl_money 가 참조하도록
외래키를 설정합니다. 
2. 외래키의 on delete 옵션은 cascade로 합니다.
3. tbl_buy2 테이블의 set_delete_trig 트리거를 정의합니다. 
내용은 tbl_money 테이블에서 sum(돈)를 
구하여 tbl_sale 테이블을 update 합니다.
4. delete from tbl_buy2 where buy_seq = 1004;
실행하여 확인합니다.
==> 4번 실행할 때 mutating 오류 생기면 2번 외래키 삭제하고 다시해보세요
 */

-- 트리거 삭제
DROP TRIGGER set_delete_trig;

-- 1. tbl_buy2 의 buy_seq 를 tbl_money 가 참조하도록 외래키를 설정합니다. 
ALTER TABLE tbl_buy2 ADD CONSTRAINT buyseq_pk primary KEY (buy_seq);
-- ALTER TABLE tbl_money ADD CONSTRAINT moneyseq_fk FOREIGN KEY (buy_seq) REFERENCES tbl_buy2;

-- 2. 외래키의 on delete 옵션은 cascade 로 합니다.
ALTER TABLE tbl_money ADD CONSTRAINT moneyseq_fk 
FOREIGN KEY (buy_seq) REFERENCES tbl_buy2(buy_seq) 
ON DELETE CASCADE;	-- 부모가 삭제되면 자식도 같이 삭제 

-- 3. tbl_buy2 테이블의 set_delete_trig 트리거를 정의합니다. 
-- 내용은 tbl_money 테이블에서 sum(money)를 구하여 tbl_sale 테이블을 update 합니다.
CREATE OR REPLACE TRIGGER set_delete_trig
AFTER DELETE ON tbl_buy2
FOR EACH ROW 	-- 행단위
DECLARE 
	vmoney NUMBER(7);
BEGIN 
	DELETE FROM TBL_MONEY
	WHERE buy_seq =:OLD.buy_seq;
	SELECT sum(money)
		INTO vmoney
		FROM tbl_money 
		WHERE customid =:OLD.customid;			-- 삭제된 행의 customid 필드값
	
	UPDATE TBL_SALE 
		SET total = vmoney
		WHERE customid =:OLD.customid; 
	dbms_output.put_line('*' || :OLD.customid || ' ' || vmoney);
	EXCEPTION          -- EXCEPTION 추가하여 처리 -> 메시지 출력, rollback 
       WHEN OTHERS THEN      -- 여러 종류 예외처리하는 예시
          dbms_output.put_line('set_delete_trig 실패!');
         ROLLBACK;
END;
-- 4. delete from tbl_buy2 where buy_seq = 1004; 실행하여 확인합니다.
-- ==> 실행할 때 mutating 오류 생기면 외래키 삭제하고 다시해보세요
-- cascade 때문에 tbl_buy2 테이블 삭제하면 tbl_money 테이블 삭제되면서 충돌.
-- mutating 오류 : 돌연변이 즉 잘못 실행되고 있음.(같은 테이블에 접근하는 충돌)
-- 				┗> 외래키의 자체를 삭제하고 실행
-- DELETE FROM TBL_MONEY WHERE buy_seq =:OLD.buy_seq; 를 트리거에서 직접 실행합니다.
--	┗> cascade 대신에 사용하는 delete 문
delete from tbl_buy2 where buy_seq = 1004;

SELECT * FROM TBL_BUY2;
SELECT * FROM TBL_SALE;
SELECT * FROM TBL_MONEY;

