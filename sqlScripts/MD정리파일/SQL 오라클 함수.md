## 오라클 함수
: 오라클 함수는 데이터베이스에서 데이터를 처리하고 가공하기 위해 사용되는 기능입니다.함수는 특정한 작업을 수행하고 그 결과를 반환합니다.오라클에서는 다양한 종류의 함수를 제공하여 데이터의 조작, 변환, 집계 등을 수행할 수 있습니다.

### 1. 스킬라 함수 (Scalar Functions)
: 스킬라 함수는 하나의 인자를 받아 하나의 결과를 반환합니다. 예를 들어, 문자열 함수, 숫자 함수, 날짜 함수 등이 있습니다. 이러한 함수들은 단일 값에 대해 작업을 수행합니다. 

### 2. 집계 함수 (Aggregate Functions)
: 집계 함수는 여러 행의 데이터를 그룹화하여 그룹별로 계산된 결과를 반환합니다. 주로 GROUP BY 절과 함께 사용되며, COUNT,SUM,AVG,MAX,MIN 등이 일반적인 집계 함수입니다. 이러한 함수들은 그룹 단위로 데이터를 집계하고 요약합니다.

### 3. 윈도우 함수 (Window Functions)
: 윈도우 함수는 OVER 절과 함께 사용되며, 집계 함수를 그룹 단위로 계산하는 동안 개별행에 대한 계산을 수행합니다. PARTITION BY 절로 그룹을 지정하고, ORDER BY 절로 정렬 순서를 지정할 수 있습니다. 예를 들어, ROW_NUMBER, RANK, LAG, LEAD 등이 윈도우 함수의 예시입니다.

### 4. 변환 함수 (Conversion Functions)
: 변환 함수는 데이터의 형식을 변환하거나 다른 형식으로 표현할 때 사용됩니다. TO_CHAR, TO_NUMBER, TO_DATE 등이 일반적인 변환 함수입니다. 이러한 함수들은 문자열에서 숫자로, 숫자에서 문자열로, 날짜 형식의 변환 등을 수행합니다.

### 5. 조건 함수 (Conditional Functions)
: 조건 함수는 특정 조건에 따라 다른 결과를 반환합니다.  주로 CASE 문을 사용하여 조건을 평가하고 결과를 반환하는 방식으로 사용됩니다. DECODE, NVL, NVL2 등이 조건 함수의 예시입니다.

-------------

**참고 : 함수, 수식 결과값 확인할 때 오라클 dual 테이블 사용, 오라클에서 문자열 위치 인덱스는 1부터 시작**

---

#### <문자열 함수>
+ CONCAT('문자열','문자열') : 문자열을 연결해주는 함수입니다.
    + SELECT CONCAT('JAVA','HELLO') FROM dual; -- 결과 : JAVAHELLO
    + SELECT 'JAVA' || 'HELLO' FROM dual; (concat 대신에 || 로 사용할수 있습니다.)
---
+ INITCAP('문자열') : 첫번째 문자를 대문자로 변환하는 함수입니다. => initail capital 줄임말
    + SELECT INITCAP('hello') FROM dual; -- 결과 : Hello
---
+ UPPER('문자열') : 문자열 전체를 대문자로 변환하는 함수입니다. 
    + SELECT UPPER('hello') FROM dual; -- 결과 : HELLO
---
+ LOWER('문자열') : 문자열 전체를 소문자로 변환하는 함수입니다. 
    + SELECT LOWER('OraCle') FROM dual; -- 결과 : oracle
---
+ LENGTH('문자열') : 문자열 길이를 확인하는 함수입니다.
     + SELECT LENGTH('hello') FROM dual; -- 결과 : 5
---
+ SUBSTR('문자열',문자열 위치,확인할 길이) : 문자열을 부분 추출하는 함수입니다.
    + SELECT SUBSTR('java program',3,5) FROM dual; -- 결과 : va pr
    + SELECT SUBSTR('java program',-5,3) FROM dual; -- 결과 : ogr
---
+ REPLACE('문자열','기본문자열에서 바꿀 문자열','변경할 새로운 문자열') : 문자열 바꾸는 함수입니다.
    + SELECT REPLACE('java program','pro','프로') FROM dual; -- 결과 : java 프로gram
---
+ INSTR('문자열','인덱스 위치를 찾을 특정 문자열') : 
문자열에서 특정 문자 또는 문자열의 위치를 찾는 함수입니다.
    + SELECT INSTR('java program','og') FROM dual; -- 결과 : 8
---
+ TRIM : 불필요한 앞뒤 공백을 제거하는 함수입니다.
    + SELECT TRIM(' java program   ') FROM dual; -- 결과 : 앞뒤 공백 제거됨
---

**참고 : 숫자 함수(정수 또는 실수 NUMBER를 대상으로 하는 함수)**

---
#### <숫자 함수>
+ ABS(n) : 숫자의 절대값을 반환하는 함수입니다.
+ TRUNC(숫자, 자리수) : 자리수 맞추기 위해서 소수점 뒤에 자리를 버리는 함수입니다.
    + SELECT TRUNC(3.177567, 2) FROM dual; -- 결과 : 3.17
---
+ ROUND(숫자, 자리수) : 자리수 맞추기 위해서 반올림 하는 함수입니다.
    + SELECT ROUND(3.177567, 2) FROM dual; -- 결과 : 3.18
----
+ CEIL(숫자) : 실수를 정수로 올림하는 함수입니다.
    + SELECT CEIL(3.177567) FROM dual; -- 결과 : 4
---
+ FLOOR(숫자) : 실수를 정수로 내림하는 함수입니다.
    + SELECT FLOOR(3.177567) FROM dual; -- 결과 : 3
---
+ MOD : 숫자의 나머지를 계산하는 함수입니다.
    + SELECT MOD(33,2) FROM dual; -- 결과 : 1
----
+ POWER(숫자, 거듭제곱 숫자) : 숫자의 제곱을 계산하는 함수입니다.
    + SELECT POWER(4,3) FROM dual; -- 결과 : 64
---
+ SORT(숫자) : 숫자의 제곱근을 계산하는 함수입니다.
    + SELECT SORT(25) FROM dual; -- 결과 : 5

---
+ SIGN(숫자) : 숫자 값이 음수인지 양수인지 확인하는 함수입니다.(결과 값은 양수면 0, 음수이면 1,0,-1로 조회 됩니다.)
    + SELECT SIGN(25),SIGN(0),SIGN(-20) FROM dual; -- 결과 : 1 0 -1
---
+ CHR(숫자) : 숫자 값을 ASCII 코드의 문자 값으로 반환하는 함수입니다.
    + SELECT CHR(25), CHR(65) FROM dual; -- 결과 : ㅏ A
---
#### <날짜 함수>
+ SYSTATE : 현재 날짜를 반환하는 함수입니다.
+ SYSTIMESTAMP : 현재 시간을 반환하는 함수입니다.
+ TO_CHAR : 날짜를 문자열로 변환하는 함수입니다.
+ TO_DATE : 문자열을 날짜로 변환하는 함수입니다.
+ EXTRACT : 날짜 또는 시간에서 특정 구성 요소를 추출하는 함수입니다.
+ ADD_MONTHS : 날짜에 월을 더하는 함수입니다.
---
#### <그룹 함수> - 예습
+ COUNT : 행의 개수를 계산하는 함수입니다.
+ SUM : 숫자 열의 합계를 계산하는 함수입니다.
+ AVG : 숫자 열의 평균을 계산하는 함수입니다.
+ MAX : 열의 최댓값을 계산하는 함수입니다.
+ MIN : 열의 최솟값을 계산하는 함수입니다.
---
#### <조건 함수> - 예습
+ CASE : 조건에 따라 다른 값을 반환합니다.
+ NVL, NVL2 : NULL 값을 다른 값으로 대체합니다.
+ DECODE : 조건에 따라 다른 값을 반환합니다.