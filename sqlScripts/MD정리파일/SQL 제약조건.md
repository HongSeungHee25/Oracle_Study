## <span style="color:pink">제약 조건 'constraints'</span>
: 테이블에 저장되는 데이터가 '부적절한 값'을 갖지 않도록 규칙을 적용
+ 1) NOT NULL(널 허용X)
+ 2) UNIQUE(유일한 값)
+ 3) PRIMARY KEY : 1)과 2)를 모두 만족. 데이터 행을 식별(구별)

### <span style="color:pink">주요한 SQL 제약 조건 - ChatGPT</SPAN>
+ 1) **<span style="color:RED">주기적인 제약 조건 (Periodic Constraint)</SPAN>**: 특정 열의 값이 특정 범위 내에 속해야 하는 경우입니다.</BR> 예를 들어, 날짜 열이 특정 기간에 속하는지 확인하는 제약 조건입니다.
+ 2) **<span style="color:RED">고유한 제약 조건 (Unique Constraint)</SPAN>**: 특정 열에 중복된 값을 허용하지 않는 제약 조건입니다.</BR>  이를 통해 특정 열의 값이 고유하게 유지됩니다.
+ 3) **<span style="color:RED">외래 키 제약 조건 (Foreign Key Constraint)</SPAN>**: 다른 테이블의 기본 키와 관련된 제약 조건입니다.</BR>  외래 키 제약 조건을 통해 두 테이블 간의 관계를 설정하고 참조 무결성을 유지할 수 있습니다.
+ 4) **<span style="color:RED">체크 제약 조건 (Check Constraint)</SPAN>**: 특정 열의 값이 특정 조건을 만족해야 하는 제약 조건입니다.</BR>  예를 들어, 숫자 열의 값이 양수인지 확인하는 제약 조건입니다.
+ 5) **<span style="color:RED">NOT NULL 제약 조건</SPAN>**: 특정 열에 NULL 값을 허용하지 않는 제약 조건입니다.</BR>  이를 통해 특정 열이 항상 값이 존재해야 함을 보장할 수 있습니다.

 *이러한 제약 조건은 데이터베이스 설계 시 데이터의 무결성과 일관성을 보장하기 위해 사용됩니다. </BR> 제약 조건은 CREATE TABLE 문을 사용하여 테이블을 생성하거나 ALTER TABLE 문을 사용하여 기존 테이블에 추가할 수 있습니다.또한, 제약조건을 설정할때에는 뒤에 '()'괄호가 붙어야합니다.*