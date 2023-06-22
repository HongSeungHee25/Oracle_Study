# 프로시저 (Procedure)
: 프로시저는 이름이 있는 일련의 SQL 문들을 하나의 논리적인 단위로 묶음 데이터베이스 객체입니다. 프로시저는 데이터베이스에서 실행될 때 입력 매개변수를 받아들일 수 있으며, 결과를 반환하거나 결과를 직접 데이터베이스에 저장할 수도 있습니다. 프로시저는 주로 데이터베이스 내의 공통 작업이나 복잡한 작업을 수행하는 데 사용됩니다. 

+ 프로시저는 데이터베이스 내에서 이름을 가지고 있는 일련의 SQL 문을 그룹화한 것입니다.
+ 프로시저는 특정 작업 또는 기능을 수행하기 위해 사용됩니다.
+ 프로시저는 일련의 SQL 문을 단일 논리적 단위로 만들어서 재사용성과 모듈화를 증가시킵니다.
+ 프로시저는 일련의 매개변수를 받아들일 수 있으며, 필요한 데이터를 처리하고 결과를 반환할 수 있습니다.

## 프로시저 (Procedure) 기본 문법
**CREATE PROCEDURE procedure_name [(parameter1 datatype, parameter2 datatype, ...)]** </br>
**[RETURNS return_datatype]** </br>
**[LANGUAGE { SQL | language_name }]** </br>
**[DETERMINISTIC | NOT DETERMINISTIC]** </br>
**[SQL DATA ACCESS { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }]** </br>
**[COMMENT 'string']** </br>
**BEGIN** </br>
    -- 프로시저 내부의 SQL 문장들</br>
**END;** </br>
## 프로시저 (Procedure) 기본 문법 해석
+ **CREATE PROCEDURE** : 프로시저를 생성하는 명령어
+ **procedure_name** : 프로시저의 이름
+ **parameter1 datatype, parameter2 datatype, ...** : 프로시저의 매개변수 (선택 사항)
+ **RETURNS return_datatype** : 프로시저의 반환값 (선택 사항)
+ **LANGUAGE { SQL | language_name }** : 프로시저의 언어 (SQL이나 특정 언어)
+ **DETERMINISTIC | NOT DETERMINISTIC** : 프로시저의 결정론적 여부 (선택 사항)
+ **SQL DATA ACCESS { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }** : 프로시저의 SQL 데이터 접근 방식 (선택 사항)
+ **COMMENT 'string'** : 프로시저에 대한 주석 (선택 사항)
+ **BEGIN ... END** : 프로시저 내부의 SQL 문장들

## 프로시저 (Procedure) 예시
**DELIMITER //** </br>
**CREATE PROCEDURE get_customer(IN customer_id INT)** </br>
**BEGIN** </br>
    **SELECT * FROM customers WHERE id = customer_id;** </br>
**END//** </br>
**DELIMITER ;** </br>

--------
*해석 : 위의 예시에서 **'get_customer'** 라는 이름의 프로시저를 생성하였습니다. **'IN'** 키워드를 사용하여 **'customer_id'** 라는 입력 매개변수를 받습니다. **'BEGIN'** 과 **'END'** 사이에는 프로시저 내에서 수행될 SQL 문장들을 작성합니다. 이 프로시저는 **'customers'** 테이블에서 주어진 **'customer_id'** 에 해당하는 고객 정보를 조회하는 기능을 수행합니다.*


--------
# 트리거 (Trigger)
: 트리거는 데이터베이스에서 특정 이벤트가 발생할 때 자동으로 실행되는 저장 프로그램입니다. 트리거는 데이터의 삽입, 수정, 삭제 등과 같은 이벤트가 발생할 때 원하는 작업을 수행할 수 있습니다. 트리거는 데이터의 무결성 유지, 로그 기록, 복제 등 다양한 용도로 사용됩니다.

+ 트리거는 데이터베이스에서 특정 이벤트가 발생할 때 자동으로 실행되는 일련의 작업들로 구성됩니다.
+ 트리거는 데이터베이스의 특정 테이블에 삽입, 업데이트, 삭제 등의 데이터 변경 작업이 발생할 때 동작합니다.
+ 트리거는 이벤트가 발생한 후에 자동으로 실행되므로 데이터의 일관성 유지, 제약 조건 확인, 로깅 등의 용도로 사용됩니다.
+ 트리거는 특정 테이블에 연결되어 동작하며, 테이블에 대한 변경 작업이 발생할 때마다 실행됩니다.

## 트리거 (Trigger) 기본 문법
**CREATE TRIGGER trigger_name** </br>
**{ BEFORE | AFTER } { INSERT | UPDATE | DELETE }** </br>
**ON table_name** </br>
**[ FOR EACH ROW ]** </br>
**[ WHEN condition ]** </br>
**BEGIN** </br>
    -- 트리거 내부의 SQL 문장들
**END;** </br>
## 트리거 (Trigger) 기본 문법 해석
+ **CREATE TRIGGER** : 트리거를 생성하는 명령어
+ **trigger_name** : 트리거의 이름
+ **{ BEFORE | AFTER } { INSERT | UPDATE | DELETE }** : 트리거의 실행 시점과 작동 대상 (삽입, 갱신, 삭제)
+ **ON table_name** : 트리거가 적용될 테이블
+ **FOR EACH ROW** : 각 레코드에 대해 트리거가 작동 (선택 사항)
+ **WHEN condition** : 트리거가 작동하기 위한 조건 (선택 사항)
+ **BEGIN ... END** : 트리거 내부의 SQL 문장들

## 트리거 (Trigger) 예시
**CREATE TRIGGER after_order_insert** </br>
**AFTER INSERT ON orders** </br>
**FOR EACH ROW** </br>
**BEGIN** </br>
    **UPDATE customers SET total_orders = total_orders + 1 WHERE id = NEW.customer_id;** </br>
**END;** </br>

------
*해석 : 위의 예시에서 **'after_order_insert'** 라는 이름의 트리거를 생성하였습니다. 이 트리거는 **'orders'** 테이블에 새로운 레코드가 삽입될 때 실행됩니다. **'FOR EACH ROW'** 를 사용하여 각 레코드에 대해 트리거가 실행되도록 합니다. 트리거 내에서는 **'NEW'** 라는 예약어를 사용하여 새로 삽입된 레코드에 접근할 수 있습니다. 이 예시에서는 **'customers'** 테이블에서 해당 고객의 **'total_orders'** 값을 1증가시키는 작업을 수행합니다.*


