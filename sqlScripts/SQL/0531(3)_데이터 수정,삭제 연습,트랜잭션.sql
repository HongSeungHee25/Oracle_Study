-- DML : 데이터 수정, 삭제는 조건식으로 실행하도록 하는 것이 기본입니다.
-- 		전체 행에 대해 수정 또는 삭제하는 것은 위험한 작업입니다.

-- 트랜잭션의 개념 : 트랜잭션은 ‘일을 처리하는 단위’를 의미한다. 더 나아가 트랜잭션의 다양한 관점은 다음과 같다. 
/*
	• 트랜잭션은 논리적인 연산 단위이다.
	• 하나 이상의 SQL문이 포함된다.
	• 트랜잭션은 거래를 의미한다.
	• 거래의 모든 결과가 모두 반영되거나 모두 취소되어야 한다.
	• 분해되지 않는 최소 단위이다.
 */

-- update 테이블명 set 컬럼명 = 변결될값, 컬럼명 = 변경될값, .... 'WHERE' 조건식

SELECT * FROM TBL_MEMBER tm ;

-- 수정하는 명령어
UPDATE TBL_MEMBER 
SET join_date = SYSDATE 
WHERE mno = 9;					-- 예상 : 1개 행을 반영

UPDATE TBL_MEMBER 
SET email = 'guest@koreait.kr'
WHERE email IS NULL;			-- 예상 : 2개 행을 반영

UPDATE TBL_MEMBER 
SET email = 'guest2@koreait.kr', mno = 9		-- 2개의 컬럼을 값 수정
WHERE mno = 10;

-- 삭제하는 명령어
DELETE FROM TBL_MEMBER tm 
WHERE mno = 1;

SELECT * FROM TBL_MEMBER tm ;

-- 추가 하는 명령어
INSERT INTO TBL_MEMBER tm VALUES (1,'김모모','momo@gamil.com',sysdate);

-- DML 명령 중에 데이터 변경과 관련된 insert, update, delete 는 ROLLBACK 을 할수 있습니다.
-- ROLLBACK 은 실행된 데이터입력, 수정, 삭제를 취소하는 명령. (트랜잭션 모든 autocommit을 OFF 일때만 가능.)
-- COMMIT 은 데이터 입력, 수정, 삭제를 최종 승인(트랜잭션 모든 autocommit을 OFF 일때만 가능.)

-- 트랜잭션의 commit을 테스트하는 순서 (트랜잭션 관리명령)
-- 1. 새로운 데이터 입력
INSERT INTO tbl_member VALUES (1,'김모모','momo@naver.com','2022-11-24');
INSERT INTO tbl_member VALUES (10,'박나연','parkny@gmail.com','2022-10-24');

-- 2. 디비버에서 조회하기
SELECT * FROM TBL_MEMBER tm ;

-- 3. SQL plus 는 다른 사용자입니다. 다른 사용자가 조회하면 새로운 입력이 보이나요?
-- 이유는 데이터 입력한 디비버가 사용자가 commit 을 안했습니다.

-- 4. 3번 상태에서 rollback
ROLLBACK;

-- 5. 디비버에서 조회하기
SELECT * FROM TBL_MEMBER tm ;

-- 6. 입력 -> 디비버 조회 -> SQL plus 조회 -> commit -> SQL plus 조회
INSERT INTO tbl_member VALUES (1,'김모모','momo@naver.com','2022-11-24');
INSERT INTO tbl_member VALUES (10,'박나연','parkny@gmail.com','2022-10-24');

SELECT * FROM TBL_MEMBER tm ;

COMMIT;

-- TRUNCATE table 테이블명 : 모든 데이터 삭제는 rollback을 할 수 없습니다. (DDL)
-- DELETE FROM 테이블명 : 모든 데이터 삭제는 rollback을 할 수 있습니다. (DML)

/*
 * INSERT 		//a
 * DELETE		//b
 * COMMIT;		(1) 라인 a,b 물리저장공간에 반영
 * UPDATE		//c
 * DELETE;		//d
 * ROLLBACK;	(2) 라인 c,d만 취소 합니다. (1) 번의 commit완료 이후부터
 * INSERT;		//e
 * INSERT;		//f
 * ROLLBACK;	(3) 라인 e,f (2) 번의 rollback 이후부터
 * INSERT 		//g
 * UPDATE;		//h
 * COMMIT;		(4) 라인 g,h (3) 번의 rollback 이후부터
 * 
 * 중간에 savepoint 를 실행하면 rollback위치를 설정할 수 있습니다.
 */
