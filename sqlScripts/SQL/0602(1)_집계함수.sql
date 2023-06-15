/* 참고  : 집계(통계) 함수 - 개수, 합계, 평균, 최대, 최소
	SELECT COUNT(*) FROM TBL_BUY tb ;			-- 행의 개수. 컬럼을 지정안하고 *
	SELECT SUM(QTY) FROM TBL_BUY tb ;			-- 합계
	SELECT AVG(QTY) FROM TBL_BUY tb ;			-- 평균
	SELECT MAX(QTY) FROM TBL_BUY tb ;			-- 최대
	SELECT MIN(QTY) FROM TBL_BUY tb ;			-- 최소
	SELECT MAX(BUY_SEQ) FROM TBL_BUY tb ;	
	주의(중요) : 집계(통계)함수로 select 할 때에는 다른 컬럼은 조회 불가.
*/

SELECT * FROM TBL_SCORE ts ;

-- 1. 테이블 행의 전체 개수
SELECT count(*) AS "행 전체개수"
FROM TBL_SCORE ts ;
-- 2. '국어' 과목의 전체 개수
SELECT count(*) AS "국어 과목 행 개수"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 오류 : 집계(통계)함수로 select 할 때에는 다른 컬럼은 조회 불가. -> 그룹 함수로 사용하면 가능합니다.
SELECT SUBJECT ,count(*) AS "국어 과목 행 개수"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 3. '국어' 과목의 점수 합계
SELECT SUM(JUMSU) AS "국어 과목 점수 합계"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 4. '국어' 과목의 점수 평균. 소수점 이하 반올림
-- 반올림 전
SELECT AVG(JUMSU) AS "국어 과목 점수 평균"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 반올림 후 
SELECT ROUND(AVG(JUMSU),0)  AS "국어 과목 점수 평균"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 자리수 0일때는 생략 가능
SELECT ROUND(AVG(JUMSU))  AS "국어 과목 점수 평균"
FROM TBL_SCORE ts 
WHERE SUBJECT = '국어';
-- 5. 전체 수강 점수 개수, 합계, 평균
SELECT COUNT(*) AS "과목 전체 개수",
	   SUM(JUMSU) AS "전체 총점",
	   ROUND(AVG(JUMSU),2) AS "전체 평균"
FROM TBL_SCORE ts ;
-- 6. '학번' 2019019 의 수강 점수 개수,합계 평균
SELECT COUNT(*) AS "과목 전체 개수",
	   SUM(JUMSU) AS "전체 총점",
	   ROUND(AVG(JUMSU),2) AS "전체 평균"
FROM TBL_SCORE ts 
WHERE STUNO = '2019019';

SELECT COUNT(*) AS "과목 전체 개수",
	   SUM(JUMSU) AS "전체 총점",
	   ROUND(AVG(JUMSU),2) AS "전체 평균"
FROM TBL_SCORE ts 
WHERE STUNO = '2019019'
GROUP BY STUNO,JUMSU 						-- 같은 기준으로 묶어서 집계함수 값을 SELECT 하는것.
ORDER BY STUNO;						-- 정렬(기본 오름차순)

SELECT COUNT(*) AS "과목 전체 개수",
	   SUM(JUMSU) AS "전체 총점",
	   ROUND(AVG(JUMSU),2) AS "전체 평균"
FROM TBL_SCORE ts 
WHERE STUNO = '2019019'
GROUP BY STUNO						-- 같은 기준으로 묶어서 집계함수 값을 SELECT 하는것.
ORDER BY STUNO;		

/*
 집계함수는 그룹 함수라고도 합니다.
 그룹화 - 행을 지정된 컬럼값 동일한 것으로 합니다.
 		집계함수는 그룹화하여 더 많이 사용합니다.
 
 SELECT 
 	그룹화컬럼, 집계함수
 FROM 테이블이름
 [WHERE] 그룹화하기 이전의 조건식
 GROUP BY 그룹화에 사용할 컬럼		
 [HAVING] 그룹화 후에 사용하는 조건식		
 [ORDER BY] 정렬 컬럼		
*/

SELECT * FROM TBL_SCORE ts ;

SELECT COUNT(*)
FROM TBL_SCORE ts 
GROUP BY STUNO ;

SELECT STUNO,COUNT(*)
FROM TBL_SCORE ts 
GROUP BY STUNO ;

SELECT STUNO,
	   SUBJECT ,		-- 오류 : 그룹화에 사용한 컬럼이 아닙니다.
	   COUNT(*)
FROM TBL_SCORE ts 
GROUP BY STUNO ;

SELECT STUNO,SUBJECT ,COUNT(*)
FROM TBL_SCORE ts 
GROUP BY STUNO,SUBJECT ;	-- STUNO 로 1차 그룹화 하고, SUBJECT 가 같은 값들로 2차 그룹화

-- '학번' 별로 수강 점수의 개수가 많은 순서부터 조회되도록 정렬해보세요.
SELECT STUNO AS "학번",
	   COUNT(*) AS "점수의 개수"
FROM TBL_SCORE ts 
GROUP BY STUNO 
ORDER BY "점수의 개수" DESC ;

-- '과목' 별로 수강 점수의 개수가 많은 순서부터 조회되도록 정렬해보세요. 2차 정렬 조건은 점수의 개수가 같다면 과목을 오름차순으로 정렬하세요.
SELECT SUBJECT AS "과목", -- 조회한 컬럼만 2차 정렬 조건으로 할수 있음.
	   COUNT(*) AS "점수의 개수"
FROM TBL_SCORE ts 
GROUP BY SUBJECT 
ORDER BY "점수의 개수" DESC, SUBJECT ;

-- '학번' 별로 수강 점수의 개수가 2 이상인 것을 조회되도록 정렬해보세요.
-- 학번별 개수를 먼저 구해야 합니다. -> 조건 WHERE 으로는 못하고 HAVING 
SELECT STUNO AS "학번",
	   COUNT(*) AS STUCNT
FROM TBL_SCORE ts 
GROUP BY STUNO 
HAVING COUNT(*) >= 2 AND STUNO != '2021001'
-- STUCNT >= 2			-- HAVING 은 별칭으로 조건을 만들 수 없습니다.
ORDER BY STUCNT DESC ;

-- GROUP BY 하기 전에 사용할 수 있는 조건식
SELECT STUNO AS "학번",
	   COUNT(*) AS STUCNT
FROM TBL_SCORE ts 
WHERE STUNO != '2021001'		
GROUP BY STUNO;



-- 문제 1)학생별로 그룹화 하여 학번, 개수, 평균 을 조회합니다. 단, 평균이 85점 이상인 학생만 조회합니다.
SELECT STUNO , COUNT(*), AVG(JUMSU)  
FROM TBL_SCORE ts 
GROUP BY STUNO 
HAVING AVG(JUMSU) >= 80;

-- 문제 2) 1)번의 결과를 '학생'테이블과 JOIN 하여 이름과 나이도 추가로 조회합니다.
SELECT 
	TSS.STUNO , 
	GROUPSCORE.STUCNT,		-- STUSNT 로 해도 가능
	GROUPSCORE.STUAVG, 		-- STUAVG 로 해도 가능
	NAME,					-- TSS.NAME 에서 TSS 생략.
	AGE  					
FROM TBL_STUDENT tss JOIN 
	(-- 서브 쿼리
	SELECT STUNO , COUNT(*) AS STUCNT , AVG(JUMSU) AS STUAVG  
	FROM TBL_SCORE ts 
	GROUP BY STUNO 
	HAVING AVG(JUMSU) >= 80
	)GROUPSCORE 
	ON TSS.STUNO = GROUPSCORE.STUNO; 

-- 오라클은 서브쿼리로 사용될 조회 결과를 미리 저장 가능.
-- WITH 별칭 AS (서브쿼리)
WITH GRPSCORE
AS (
SELECT STUNO , COUNT(*) AS STUCNT , AVG(JUMSU) AS STUAVG  
	FROM TBL_SCORE ts 
	GROUP BY STUNO 
	HAVING AVG(JUMSU) >= 80
)
SELECT 
	TSS.STUNO , 
	GRPSCORE.STUCNT,		-- STUSNT 로 해도 가능
	GRPSCORE.STUAVG, 		-- STUAVG 로 해도 가능
	NAME,					-- TSS.NAME 에서 TSS 생략.
	AGE  					
FROM TBL_STUDENT tss JOIN GRPSCORE 
ON TSS.STUNO = GRPSCORE.STUNO;


