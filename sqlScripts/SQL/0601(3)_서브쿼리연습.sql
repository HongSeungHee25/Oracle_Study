-- 서브쿼리 연습

SELECT * FROM TBL_PRODUCT tp ;
SELECT * FROM TBL_BUY tb ;

SELECT PNAME
FROM TBL_PRODUCT tp 
WHERE 
--	pcode = 'APLE5kg';			-- 아래와 같이 서브쿼리로 실행해보기
--	PCODE =(					-- 등호 '=' 연산은 서브쿼리 SELECT 결과가 1행 
	PCODE IN(					-- IN 연산은 OR와 동일하게 여러개 값 중 해당되는지 비교
		SELECT PCODE 			-- 서브쿼리 SELECT 조회 컬럼도 1개
		FROM TBL_BUY tb 
		WHERE CUSTOMID = 'twice'
	);
	
SELECT PNAME
FROM TBL_PRODUCT tp 
WHERE 
--	pcode = 'APLE5kg';			-- 아래와 같이 서브쿼리로 실행해보기
	PCODE = (					-- 등호 '=' 연산은 서브쿼리 SELECT 결과가 1행 
		SELECT PCODE FROM TBL_BUY tb 
		WHERE BUY_SEQ = 1001	-- 기본키 컬럼의 조건식이므로 0 또는 1개 행
	);
	
-- 서브쿼리 문제점 : 외부쿼리가 조건식을 모든행에 대해 검사할때마다 내부쿼리가 실행되므로
-- 테이블의 행 개수가 많으면 처리 속도에 문제가 생깁니다. --> 테이블의 조인 연산으로 대체할 수 있으면 서브쿼리는 지양.

-- CREATE TABLE 에 SELECT 결과를 넣기
CREATE TABLE buy_temp			-- TBL_BUY 의 SELECT 조회 테이블 구조를 그대로 새로운 테이블 생성
	AS 
	SELECT * FROM TBL_BUY tb 	-- 만들어진 테이블의 SELECT 조회 결과 추가
	WHERE customid = 'twice';
	
SELECT * FROM buy_temp;

INSERT INTO BUY_TEMP bt 
SELECT * FROM TBL_BUY tb WHERE QTY >= 3;
-- VALUES ()

INSERT INTO TBL_BUY tb 
VALUES (tblbuy_seq.nextval,'hongGD','CJBAb12g',3,sysdate);

SELECT max(buy_seq) FROM TBL_BUY tb; 	-- 테스트로 해보기

-- 시퀀스 대신에 사용할 max 함수의 서브쿼리 예시를 확인 후 해봅시다.

-- 참고 : 집계 함수
SELECT COUNT(*) FROM TBL_BUY tb ;		
SELECT SUM(QTY) FROM TBL_BUY tb ;
SELECT AVG(QTY) FROM TBL_BUY tb ;
SELECT MAX(QTY) FROM TBL_BUY tb ;
SELECT MIN(QTY) FROM TBL_BUY tb ;
SELECT MAX(BUY_SEQ) FROM TBL_BUY tb ;

INSERT INTO TBL_BUY tb 
VALUES(
	  (SELECT MAX(BUY_SEQ)+1 FROM TBL_BUY), 	-- 괄호 필수
	  'mina012','APLE5kg',11,sysdate);







