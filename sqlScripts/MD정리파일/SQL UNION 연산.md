## UNION 연산자
: 오라클의 UNION 연산자는 두 개 이상의 SELECT 문의 결과를 하나로 결합하는 역할을 합니다. UNION 연산자를 사용하여 여러 SELECT 문의 결과를 합치고 중복된 행을 제거할 수 있습니다.

### UNION 연산자 특징 
+ 1. 열의 수와 데이터 유형이 일치해야 합니다. 
    + UNION 연산자를 사용하여 SELECT 문의 결과를 결합할 때, 각 SELECT 문의 열의 수와 데이터 유형은 일치해야 합니다. 만약 열의 수가 일치하지 않거나 데이터 유형이 호환되지 않으면 오류가 발생합니다.

+ 2. 중복된 행을 제거합니다. 
    + UNION 연산자는 결과로 중복된 행을 제거합니다. 따라서, UNION을 사용하여 두 개의 SELECT 문을 결합하면 결과에는 중복된 행이 없는 유일한 행들이 포함됩니다. 만약 중복된 행을 포함하고자 한다면 UNION ALL 을 사용할 수 있습니다.

+ 3. SELECT 문의 순서에 따라 결과가 정렬됩니다.
    + UNION 연산자로 결합된 결과는 첫 번째 SELECT 문부터 순서대로 결합되며, 이에 따라 결과가 정렬됩니다. 따라서, SELECT 문에 ORDER BY 절을 사용하여 원하는 순서로 결과를 정렬할 수 있습니다.

+ 4. UNION 연산자릐 왼쪽과 오른쪽 SELECT 문의 열 이름은 일치해야 합니다. 
    + UNION 연산자를 사용할 때, 왼쪽과 오른쪽 SELECT 문의 열 이름은 일치해야 합니다. 열의 이름이 일치하지 않으면 오류가 발생합니다. 필요한 결우, AS 키워드를 사용하여 열 별칭을 지정하여 일치시킬 수 있습니다.

### UNION 코드 형식
+ UNION(중복 불가) : SELECT 컬럼명A FROM 테이블명A UNION SELECT 컬럼명B FROM 테이블명B;
    + EX) SELECT NAME, EMAIL FROM TBL_CUSTOM tc UNION SELECT PCODE, PNAME FROM TBL_PRODUCT tp;
+ UNION ALL(중복 가능) : SELECT 컬럼명A FROM 테이블명A UNION ALL SELECT 컬럼명B FROM 테이블명B;
    + EX) SELECT NAME, EMAIL FROM TBL_CUSTOM tc UNION ALL SELECT PCODE, PNAME FROM TBL_PRODUCT tp;