-- 오라클 조건식에서 같다는 = , 같지 않다는 !=

-- 문자열 함수 : 자바와 비슷한 내용으로 분석
-- 함수, 수식 결과값 확인할 때 오라클 dual 테이블 사용
SELECT concat('java',' hello') FROM dual; 	-- 문자열 연결
SELECT 'java' || ' hello!' FROM dual;

-- 실제로는 테이블의 컬럼으로 함수 실행합니다.
SELECT INITCAP('hello') 					-- initail capital : 첫번째 대문자
FROM dual;									-- 결과 : Hello
SELECT UPPER('hello') 						-- 대문자로 변환 
FROM dual;									-- 결과 : HELLO
SELECT LOWER('OraCle') 						-- 소문자로 변환 
FROM dual;									-- 결과 : oracle
SELECT LENGTH('oracle') 					-- 문자열 길이
FROM dual;									-- 결과 : 6
SELECT SUBSTR('java program',3,5) 			-- 부분 추출(문자열,위치,길이)
FROM dual; 									-- 결과 : va pr 
-- 오라클에서 문자열 위치 인덱스는 1부터 시작.
SELECT SUBSTR('java program',-5,3) 			-- 부분 추출(문자열,위치,길이)
FROM dual;									-- 결과 : ogr
SELECT REPLACE('java program','pro','프로') 	-- 문자열 바꾸기
FROM dual;									-- 결과 : java 프로gram
SELECT INSTR('java program','og') 			-- 자바의 indexOf
FROM dual;									-- 결과 : 8
SELECT TRIM(' java program   ') 			-- 공백(불필요한 앞뒤 공백)제거
FROM dual;									-- 결과 : 앞뒤 공백 제거됨
SELECT LENGTH(' java program   ')			-- 공백 포함 : 16
FROM dual;
SELECT LENGTH(TRIM(' java program   ')) 	-- 공백 제거 후 : 12
FROM dual;

-- 숫자 함수(정수 또는 실수 number를 대상으로 하는 함수)
-- abs(n) : 절대값
-- trunc(숫자,자리수) : 자리수 맞추기 위해서 버림 3.177567 -> 3.17
SELECT TRUNC(3.177567,2) 
FROM dual; 
-- round(숫자,자리수) : 반올림 3.177567 -> 3.18
SELECT ROUND(3.177567,2) 
FROM dual;
-- ceil(숫자) : 실수를 정수로 올림해서 변환 3.177567 -> 4
SELECT CEIL(3.177567)
FROM dual;
-- floor(숫자) : 실수를 정수로 내림으로 변환 3.177567 -> 3
SELECT FLOOR(3.177567) 
FROM dual;

-- 날짜 함수 : SYSDATE가 인자로 들어간곳은 TO_DATE,... 등등 날짜 형식으로 들어가야함.
SELECT SYSDATE , SYSTIMESTAMP 		-- 서버의 날짜(초단위)와 시간(ms)
FROM dual;
--------------------------------------------------------------------------
SELECT ADD_MONTHS(SYSDATE,3)		-- 오늘날짜 3개월 이후. 첫번째 인자는 날짜 형식, 두번째 인자는 더해지는 값
FROM dual;

SELECT ADD_MONTHS(TO_DATE('2023/06/02') ,3)	-- 오늘날짜 3개월 이후. 첫번째 인자는 날짜 형식, 두번째 인자는 더해지는 값
FROM dual;
--------------------------------------------------------------------------
SELECT TO_CHAR(SYSDATE, 'MONTH')	-- 오늘 날짜에서 '월' 출력. 두번째 인자로 쓰이는 날짜 포맷 더 알아보기
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YEAR')	AS results -- 오늘 날짜에서 '월' 출력. 두번째 인자로 쓰이는 날짜 포맷 더 알아보기
FROM dual;
--------------------------------------------------------------------------
SELECT TO_CHAR(SYSDATE, 'YYYY')		-- 오늘 날짜에서 '년도' 4자리 출력
FROM dual;

SELECT 								-- 문자열패턴 기호 - 또는 / 또는 구분기호 없음 가능
TO_CHAR(ADD_MONTHS(SYSDATE,3),'YYYY/MM/DD')
FROM dual;

SELECT 								-- 지정된 2개의 날짜 사이에 간격(월). 결과는 소수점
MONTHS_BETWEEN(TO_DATE('2022/06/05'),
TO_DATE('2022/09/23')) 
FROM dual;

SELECT 
TRUNC(SYSDATE) - TO_DATE('20171110','YYYYMMDD')	-- 2개의 날짜형식 값 간격(일)
FROM dual;	-- 2개의 날짜의 간격(일). TRUNC(SYSDATE)는 일(day)까지 변환

-- 년도, 일수의 차이는 뺄셈연산으로 가능. 개월수 구하는 함수 제공.



