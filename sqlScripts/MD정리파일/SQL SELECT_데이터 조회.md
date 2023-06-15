## <span style="color:pink">SELECT - 데이터 조회</span>
: SELECT는 '모든 행', '특정 조건의 행', '모든 열', '지정된 열' 에 있는 데이터를 조회할 수 있습니다.
+ [SELECT] 조회할 열 [FROM] 테이블 이름 [WHERE] 특정 행을 조회할 조건 [ORDER BY] 정렬할 컬럼</BR>(코드 적을때는 [] 대괄호 제외하고 입력)
+ [SELECT] 조회할 모든 열을 지정하는 기호 * (와일드카드 문자)

#### 1) 모든행과 모든 열 조회
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER**;

#### 2) 지정된 열의 모든 행 조회
+ EX) **<span style="color:red">SELECT </span> name <span style="color:red">FROM</span> TBL_MEMBER***;
+ EX) **<span style="color:red">SELECT </span> name, email <span style="color:red">FROM</span> TBL_MEMBER**;

#### 3) 조건에 맞는 행의 모든 컬럼 조회
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = <span style="color:green">'박사나' </span>**;

#### 4) 조건에 맞는 행의 지정된 컬럼 조회
+ EX) **<span style="color:red">SELECT </span> email <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = <span style="color:green">'박사나' </span>**;

#### 5) order by로 정렬 컬럼 지정(가나다라 순서 또는 abcd 순서 - 오름차순)
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> ORDER BY </span> NAME**;

#### 5-1) order by로 정렬 컬럼 지정(내림차순)
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> ORDER BY </span> NAME <span style="color:red"> DESC </span>**; 

#### 6) 문자열의 부분 일치 검색 : like 유사 조건값 검색
+ EX) **<span style="color:red">SELECT </span>* <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '박%' </span>**;
    + % 문자는 상관없음. 시작은 '박'
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '%나연' </span>**;
    + 성은 상관없음. '나연' 검색
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '%나%' </span>**;
    + '나' 문자가 있는 이름 검색(위치는 상관없음)

#### 7) 여러가지 값으로 조회 : 이름이 김모모 또는 박나연
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = </span><span style="color:green"> '김모모' </span> <span style="color:red"> OR </span>NAME = <span style="color:green"> '박나연' </span>**;
+  EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME </span><span style="color:red"> IN </span> (<span style="color:green"> '김모모','박나연' </span>)**;
    + OR 연산에 해당
+  EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME </span><span style="color:red"> NOT IN </span> (<span style="color:green"> '김모모','박나연' </span>)**; 
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = </span><span style="color:green"> '김모모' </span> <span style="color:red"> AND </span>NAME = <span style="color:green"> '박나연' </span>**;
    + 2가지 값 동시 만족

#### 8) 이메일 EMAIL 컬럼의 NULL값 조회 : NULL 조회할 때만 IS 연산 사용
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> EMAIL <span style="color:red"> IS NULL </span>**;
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> EMAIL <span style="color:red"> IS NOT NULL </span>**;

#### 9) MNO 컬럼은 수치(정수) 형식
##### <MNO값이 5인 것 조회>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO = <span style="color:blue"> 5 </span>**;
##### <MNO값이 4미만 조회>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO < <span style="color:blue"> 4 </span>**;
##### <MNO값이 1,2,5,7 인 것 조회 : IN 연산(OR 연산)>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO <span style="color:red"> IN </span>(<span style="color:blue">1,2,5,7</span>)**;
##### <MNO값이 3~6 인 것 조회 : between (AND 연산)>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO >= <span style="color:blue">3</span><span style="color:red"> AND </span>MNO <= <span style="color:blue">6</span>**;
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO <span style="color:red"> BETWEEN </span><span style="color:blue">3</span><span style="color:red"> AND </span><span style="color:blue">6</span><span style="color:red"> ORDER BY </span>JOIN_DATE<span style="color:red"> DESC </span>**;