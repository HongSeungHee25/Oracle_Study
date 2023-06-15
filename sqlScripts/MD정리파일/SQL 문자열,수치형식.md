## <span style="color:pink">SQL 이란?</span>
 : Structured Query Lenguage (구조화된 질의 언어)
+ 1. DML - 데이터 추가, 삭제, 수정, 조회 명령(INSERT, DELETE, SELECT)
+ 2. DDL - 데이터를 저장할 테이블 또는 사용자 등등 오라클의 객체 생성/삭제 명령(CREATE, ALTER, DROP)
+ 3. DCL - 계정 등등 데이터를 다루는데 필요한 기능을 실행 명령(GRANT,REVOKE)

## <span style="color:pink">문자열 형식 테스트</span>
+ **CHAR (길이)** : 고정길이, 단위는 바이트
+ **VARVHAR (길이)** : 오라클에서 존재하지만 사용하지 않는 예비자료형.
+ **VARCHAR2 (길이)** : 가변형 길이 단위 바이트, 길이는 최대 길이고 실제로 메모리는 데이터 크기만큼 사용합니다.</BR> 최대 2000바이트입니다. UTF-8 인코딩에서 한글은 3바이트, 영문/숫자/기호는 1바이트 입니다. 

     + 참고 : 고정길이는 지정된 만큼 기억공간을 차지합니다. 가변길이는 데이터 크기만큼 기억공간 사용하고 최대 크기로 제한됩니다.

### DDL : 1. 테이블 생성
**<span style="color:red">CREATE</span><span style="color:blue"> TABLE</span> 테이블명(테이블을 구성하는 컬럼을 정의)**;

### DDL : 2. 테이블 제거
**<span style="color:red">DROP </span><span style="color:blue"> TABLE</span> 테이블명;</span>**

### DDL : 3. 테이블의 모든 데이터 삭제
**<span style="color:red">TRUNCATE </span><span style="color:blue"> TABLE</span> 테이블이름;</span>**

### DML : 테이블에 데이터 추가
**<span style="color:red">INSERT INTO</span> 테이블명<span style="color:red"> VALUES</span> (컬럼순서에 대응되는 값, 값,....)**;

## <span style="color:pink">정수 또는 실수 수치 형식 테스트</span>

+ 데이터 타입 NUMBER (길이) : JAVA 정수와 실수 타입 형식 지정
+ NUMBER(정밀도 N, 소수점이하 자리수 M)

    + <참고>
    + **NUMBER** - 정밀도 지정 안하면 최대 38자리 (JAVA BIGDECIMAL) - 정수자리와 실수자리
    + **NUMBER(5)** - 정수로 최대 5자리(소수점 이하 없음. -소수점 이하 반올림)(M = 0 인경우)
    + **NUMBER(7,2)** - 전체 자리수 최대 7자리, 소수점 이하 2자리(고정)(N > M 인경우)
    + **NUMBER(2,5)** - 소수점이하 최대 5자리(0이 3개 고정), 0아닌 유효 숫자 최대 2자리(N < M 인경우)

### TO_DATE
: 문자열을 날짜 DATE 형식으로 변환하는 함수입니다.
+ EX) <span style="color:blue">**TO_DATE </span>(<span style="color:green">'2022-03-10 14:23:25'</span>,<span style="color:green">'YYYY-MM-DD HH24:MI:SS</span>);**
    + 현재날짜와 시간 입력하는 것은 컬럼의 기본값을 오라클의 "<span style="color:blue">**SYSDATE**</span>" 로 설정합니다.

### TO_CHAR
: date 형식을 지정된 패턴의 문자열로 변환하는 함수입니다.
+ EX) <span style="color:red">**WHERE </span><span style="color:blue">TO_CHAR</span> (reg_date, <span style="color:green">'YYYY-MM-DD'</span>) <span style="color:red">IN </span>(<span style="color:green">'2022-03-10'</span>,<span style="color:green">'2021-12-25'</span>);**
    + **"<span style="color:red">IN</span>"** 대신에 **"<span style="color:red">OR</span>"** 을 사용해도 무관. 그러나 **"<span style="color:red">IN</span>"** 이 더 코드가 간결함.

### DISTINCT - 조회된 컬럼중 중복값은 제거
+ **<span style="color:red">SELECT DISTINCT</span> 중복값 제거할 컬럼 <span style="color:red">FROM</span> 테이블명**;
