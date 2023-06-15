## <span style="color:pink">SEQUENCE</span>
: 오라클은 'SEQUENCE'라는 객체를 사용하여 자동증가 되는 값을 만듭니다. </BR>행을 식별할 목적으로 일련번호 컬럼을 만들었을 때 값은 시퀀스로 부여합니다.</BR> MYSQL DBMS 에서는 auto increment (자동 증가) 속성을 설정할 수 있습니다.

### dual - 임시(더미)테이블
: 오라클에서 dual 이름의 임시(더미)테이블 1개 행, 1개 컬럼으로 특정 수식, 함수 값 결과 테스트 목적으로 사용합니다. 
+ EX) <span style="color:red"> **SELECT </span> <span style="color:blue"> 199+1 </span><span style="color:red"> FROM </span>dual;**

### 시퀀스 생성하기
+ EX) <span style="color:red"> **CREATE SEQUENCE </span> test_seq;**

### 시퀀스 삭제하기
+ EX) <span style="color:red">**DROP SEQUENCE </span> test_seq;**

### 시퀀스 함수 
: nextval (다음 시퀀스 값)
+ EX) <span style="color:red">**SELECT </span>test_seq.nextval <span style="color:red">FROM </span>dual;**
    + test_seq 이름의 시퀀스가 갖는 다음 값 조회

: currval (현재 시퀀스 값)
+ EX) <span style="color:red">**SELECT </span> test_seq.currval <span style="color:red">FROM </span>dual;**
    + 처음 1번은 먼저 'nextval'을 꼭 실행해야 'currval' 값을 조회할수 있습니다.

### 시퀀스 시작값 지정하기
+ EX) <span style="color:red">**CREATE SEQUENCE </span> tblbuy_seq(직접지정)<span style="color:red"> START WITH </span><span style="color:blue"> 1001</span>;**

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
