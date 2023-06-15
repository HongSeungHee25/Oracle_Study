## <span style="color:pink">데이터 수정, 삭제 </span>
: DML - 데이터 수정, 삭제는 조건식으로 실행하도록 하는 것이 기본입니다.</BR> 전체 행에 대해 수정 또는 삭제하는 것은 위험한 작업으로 실행하기 전 </BR>위험하다는 신호를 줍니다. 조건식은 'WHERE'조건식으로 합니다.

### UPDATE - 수정
: 데이터를 수정하기 위해 사용되는 명령어입니다.</BR> UPDATE 문은 특정 테이블에서 조건을 만족하는 행의 데이터를 변경합니다.
+ **<span style="color:RED">UPDATE</SPAN> 테이블명 <span style="color:RED">SET</SPAN> 열1 = 값1, 열2 = 값2, .... <span style="color:RED">WHERE</SPAN> 조건;**
---
+ EX) **<span style="color:RED">UPDATE</SPAN> TBL_MEMBER <span style="color:RED">SET</SPAN> JOIN_DATE = <span style="color:BLUE">SYSDATE </SPAN><span style="color:RED"> WHERE</SPAN> MNO = 9;**
    + *MNO 9번 JOIN_DATE 값에 현재 날짜와 시간으로 수정히는 명령.*
+ EX) **<span style="color:RED">UPDATE</SPAN> TBL_MEMBER <span style="color:RED">SET</SPAN> EMAIL = <span style="color:GREEN">'guest@koreait.kr' </SPAN><span style="color:RED"> WHERE</SPAN> EMAIL <span style="color:RED">IS NULL</SPAN>;**
    + *EMAIL 이 NULL 값인 곳에 'guest@koreait.kr' 해당 메일 넣어서 수정하는 명령.*
+ EX) **<span style="color:RED">UPDATE</SPAN> TBL_MEMBER <span style="color:RED">SET</SPAN> EMAIL = <span style="color:GREEN">'guest2@koreait.kr' </SPAN>, MNO = 9<span style="color:RED"> WHERE</SPAN> MNO = 10;**
    + *MNO 10번째 값을 9번으로 수정하고 EMAIL도 'guest2@koreait.kr' 메일로 수정하는 명령.* 
---

### DELETE - 삭제
: 데이터를 삭제하기 위해 사용되는 명령어입니다.</BR> DELETE 문은 특정 테이블에서 조건을 만족하는 행을 삭제합니다.
+ **<span style="color:RED">DELETE FROM</SPAN> 테이블명 <span style="color:RED">WHERE</SPAN> 조건;**
----
+ EX) **<span style="color:RED">DELETE FROM</SPAN> TBL_MEMBER <span style="color:RED">WHERE</SPAN> MNO = 1;**
    + *MNO 값중 1번 값을 삭제하는 명령.*