/*
	오라클 프로시저는 오라클 데이터베이스에서 저장된 프로그램 유형 중 하나입니다. 
	프로시저는 SQL 문과 제어 구문을 조합하여 데이터베이스 작업을 수행하는 데 사용됩니다. 
	이러한 프로시저는 오라클 데이터베이스 내에서 실행되며, 복잡한 비즈니스 로직이나 데이터 처리를 수행하는 데 유용합니다.

	프로시저는 일련의 작업을 수행하기 위해 하나 이상의 SQL 문을 포함하는 블록으로 구성됩니다. 
	이 블록은 이름을 가지며, 필요한 매개변수를 가질 수 있습니다. 프로시저를 실행할 때는 매개변수 값을 전달하여 실행됩니다.

	1. 데이터 조작: 프로시저는 데이터를 삽입, 갱신 또는 삭제하는 등의 데이터 조작 작업을 수행할 수 있습니다.
	이를 통해 데이터베이스의 무결성을 유지하고 데이터 일관성을 보장할 수 있습니다.
	
	2. 비즈니스 로직 처리: 복잡한 비즈니스 규칙을 구현하기 위해 프로시저를 사용할 수 있습니다. 
	예를 들어, 주문 처리, 결제 처리, 인증 등의 비즈니스 로직을 프로시저로 구현할 수 있습니다.
	
	3. 성능 향상: 프로시저는 데이터베이스 서버에서 실행되므로 네트워크 오버헤드를 줄일 수 있습니다. 
	또한, 반복적인 작업을 수행할 때 프로시저를 사용하면 네트워크 부하를 줄이고 실행 시간을 단축시킬 수 있습니다.
	
	4. 보안: 프로시저를 사용하여 데이터베이스 객체에 대한 접근 권한을 효과적으로 관리할 수 있습니다. 
	프로시저를 호출하는 클라이언트는 해당 프로시저에 대한 실행 권한만 갖고 있으면 되며, 프로시저 내에서의 
	데이터 액세스는 권한 부여 및 제어에 따라 이루어집니다.

	프로시저는 데이터베이스 개발자 및 관리자에게 강력한 도구로서 데이터베이스 작업의 효율성과 일관성을 향상시키는데 도움을 줍니다.


*/

CREATE TABLE pex_buy
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM pex_buy;




CREATE OR REPLACE PROCEDURE proc_insert_pex_buy(
-- 'proc_insert_pex_buy' 라는 이름의 프로시저를 생성하거나 수정합니다. 프로시저는 매개변수를 받습니다.
    p_customid IN pex_buy.customid%TYPE,
    -- 'p_customid' 라는 이름의 매개변수를 선언하고, 데이터 타입은 'pex_buy' 테이블의 'customid' 라는 컬럼과 동일한 타입으로 지정합니다.
    p_pcode IN pex_buy.pcode%TYPE,
    -- 'p_pcode' 라는 이름의 매개변수를 선언하고, 데이터 타입은 'pex_buy' 테이블의 'pcode' 라는 컬럼과 동일한 타입으로 지정합니다.
    p_qty IN pex_buy.qty%TYPE
    -- 'p_qty' 라는 이름의 매개변수를 선언하고, 데이터 타입은 'pex_buy' 테이블의 'qty' 라는 컬럼과 동일한 타입으로 지정합니다.
) IS 	-- 프로시저 본문의 시작을 나타내는 키워드입니다.
BEGIN	-- 프로시저 본체의 시작을 나타냅니다.
    INSERT INTO pex_buy (buy_seq, customid, pcode, qty, buy_date)
    VALUES (buy_seq.NEXTVAL, p_customid, p_pcode, p_qty, SYSDATE);
    -- 'pex_buy' 테이블에 데이터를 삽입하는 INSERT 문입니다. 컬럼과 값의 대응관계를 명시합니다.
    COMMIT;
   -- 실행 성공할 경우 데이터베이스 트랙잭션을 커밋하여 변경사항을 영구적으로 저장합니다.
    DBMS_OUTPUT.PUT_LINE('데이터가 성공적으로 삽입되었습니다.');
   -- 성공적으로 실행되면 '데이터가 성공적으로 삽입되었습니다.' 라는 메시지를 출력합니다.
EXCEPTION
-- 예외 처리 섹션의 시작을 나타내는 키워드입니다.
    WHEN OTHERS THEN
    -- 예외가 발생한 경우를 처리하기 위한 예외 핸들러의 시작을 나타냅니다.
        ROLLBACK;
       -- 실행 실패할 경우 데이터베이스 트랙잭션을 롤백하여 이전 상태로 되돌립니다.
        DBMS_OUTPUT.PUT_LINE('오류: 데이터 삽입 실패.');
       -- 실패할경우 '오류: 데이터 삽입 실패.' 라는 메시지를 출력합니다.
END;	--프로시저 본체의 끝을 나타냅니다.



-- 실행
SET SERVEROUTPUT ON
-- 'DBMS_OUTPUT' 으로 출력되는 결과를 활성화합니다.

DECLARE	-- 익명 블록(Anonymous Block)의 시작을 나타내는 키워드입니다.
    v_customid pex_buy.customid%TYPE := 'mina012';
   -- 'v_customid' 라는 이름의 변수를 선언하고 초기값을 'mina012' 로 설정합니다. 
   -- 데이터타입은 'pex_buy' 테이블의 'customid' 컬럼과 동일한 타입으로 지정됩니다.
    v_pcode pex_buy.pcode%TYPE := 'JINRMn5';
   -- 'v_pcode' 라는 이름의 변수를 선언하고 초기값을 'JINRMn5' 로 설정합니다. 
   -- 데이터타입은 'pex_buy' 테이블의 'pcode' 컬럼과 동일한 타입으로 지정됩니다.
    v_qty pex_buy.qty%TYPE := 2;
   -- 'v_qty' 라는 이름의 변수를 선언하고 초기값을 '2' 로 설정합니다. 
   -- 데이터타입은 'pex_buy' 테이블의 'qty' 컬럼과 동일한 타입으로 지정됩니다.
BEGIN	-- 익명 블록의 본문을 시작을 나타내는 키워드입니다.
    proc_insert_pex_buy(v_customid, v_pcode, v_qty);
   -- 'proc_insert_pex_buy' 프로시저를 호출하면서 선언한 변수들을 인수로 전달합니다.
    DBMS_OUTPUT.PUT_LINE('프로시저가 성공적으로 실행됨.');
   -- 성공적으로 실행될시 '프로시저가 성공적으로 실행됨.' 라는 메시지를 출력합니다.
END;	-- 익명 블록의 끝을 나타내는 키워드입니다.



-------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_set_money(
-- 'proc_set_money' 라는 이름의 프로시저를 생성하거나 수정합니다. 프로시저는 매개변수를 받습니다.
	acustom_id IN varchar2,
	-- 'acustom_id' 라는 이름의 'varchar2' 타입의 입력 매개변수를 정의합니다.
	apcode IN varchar2,	
	-- 'apcode' 라는 이름의 'varchar2' 타입의 입력 매개변수를 정의합니다.
	acnt IN NUMBER ,	
	-- 'acnt' 라는 이름의 'NUMBER' 타입의 입력 매개변수를 정의합니다.
	isSuccess OUT varchar2 	
	-- 'isSuccess' 라는 이름의 'varchar2' 타입의 출력 매개변수를 정의합니다.
	-- 매개변수 
)
IS	-- 프로시저의 본문을 시작하는 키워드 입니다.
	vseq NUMBER;			
	-- 'vseq' 라는 이름의 'NUMBER' 타입의 변수를 선언합니다.
	vprice NUMBER;
	-- 'vprice' 라는 이름의 'NUMBER' 타입의 변수를 선언합니다.
	-- 프로시저에 지역 변수
BEGIN 	-- 프로시저 시작하는 키워드 입니다.
	INSERT INTO p_buy(buy_seq,customid,pcode,qty,buy_date)
		VALUES (buy_seq.nextval, acustom_id,apcode,acnt,sysdate);	
	-- 'p_buy' 테이블에 데이터를 삽입합니다. 'buy_seq.nextval' 은 시퀀스에서 다음 값을 가져옵니다.
	SELECT buy_seq.currval			
		INTO vseq
		FROM dual;
	-- 'buy_seq.currval' 을 'vseq' 변수에 저장합니다. 'dual' 테이블은 단일 행을 가지며, 여기서는 시퀀스의 현재 값을 가져옵니다.
	SELECT price INTO vprice
		FROM TBL_PRODUCT tp WHERE pcode = apcode;
	-- 'TBL_PRODUCT' 테이블에서 'pcode' 와 일치하는 레코드의 'price' 값을 'vprice' 변수에 저장합니다.
	UPDATE p_buy SET money = vprice * qty
		WHERE buy_seq = vseq;		
	-- 'p_buy' 테이블에서 'buy_seq' 값이 'vseq' 와 일치하는 레코드의 'money' 값을 'vprice * qty' 로 업데이트 합니다.
	DBMS_OUTPUT.PUT_LINE('실행 성공');
	-- 실행성공하면 "실행 성공" 이라는 메시지를 출력합니다.
	isSuccess :='success';	
	-- 실행 성공하면 'isSuccess' 변수에 'success' 라는 값을 할당합니다.
	COMMIT;
	-- 실행 성공할 경우 트랙잭션을 커밋하여 변경 사항을 영구적으로 저장합니다.
	EXCEPTION 	
	-- 예외 처리 부분을 시작하는 키워드 입니다.
		WHEN OTHERS THEN 
		-- 다른 모든 예외를 처리합니다.
		DBMS_OUTPUT.PUT_LINE('실행 실패');
		-- 실행실패하면 "실행 실패" 라는 메시지를 출력합니다.
		ROLLBACK;
		-- 실행 실패할 경우 트랙잭션을 롤백하여 변경 사항을 취소합니다.
		isSuccess :='fail';
		-- 실행 실패하면 'isSuccess' 변수에 'fail' 라는 값을 할당합니다.
END;	--프로시저 본체의 끝을 나타냅니다.

SELECT * FROM P_BUY pb ;

-- 롤백 시나리오 만들기
ALTER TABLE p_buy ADD money NUMBER(7) CHECK (money >= 10000);
-- 'p_buy' 테이블에 'money' 라는 이름의 'NUMBER(7)' 타입의 컬럼을 추가합니다. 
-- 'CHECK' 제약 조건은 'money' 값이 10,000원 이상이어야 함을 나타냅니다.

-- 실행 성공 예시
DECLARE 
-- 익명 블록을 시작을 나타내는 키워드입니다.
	vresult varchar2(20);
	-- 'vresult' 라는 이름의 'varchar2(20)' 타입의 변수를 선언합니다.
BEGIN 
-- 익명 블록의 시작을 나타내는 키워드입니다.
	proc_set_money('twice','CJBAb12g',2,VRESULT);
	-- 'proc_set_money' 프로시저를 호출하고 매개변수로는 'twice','CJBAb12g','2','VRESULT' 값을 전달합니다.
	-- 'VRESULT' 는 위에서 선언한 변수를 참조합니다.
	DBMS_OUTPUT.PUT_LINE('결과 : '|| vresult);
	-- "결과" 와 'VRESULT' 변수의 값을 합쳐서 출력합니다.
END;	-- 익명 블록의 끝을 나타내는 키워드입니다.
SELECT 
c.CAR_NO,
c.CAR_TYPE,
TO_CHAR(cr.RENT_START, 'yyyy-mm-dd') AS RENT_START,
TO_CHAR(cr.RENT_END, 'yyyy-mm-dd') AS RENT_END,
p.PAYMENT_METHOD, 
c.PRICE + c.INSURANCE AS money 
FROM 
CAR c 
JOIN CAR_RENT cr ON c.CAR_NO = cr.CAR_NO 
JOIN PAYMENT p ON c.CAR_NO = p.CAR_NO 
WHERE
cr.NAME = '홍승희'
ORDER BY RENT_START;

SELECT c.car_no , c.car_type, to_char(cr.rent_start,'yyyy-mm-dd'), TO_CHAR(cr.rent_end, 'yyyy-mm-dd'),p.payment_method,
(c.PRICE + c.INSURANCE) AS MONEY 
FROM CAR c JOIN CAR_RENT cr 
ON c.CAR_NO = cr.CAR_NO 
JOIN PAYMENT p ON c.CAR_NO = p.CAR_NO 
WHERE cr.NAME = '홍승희'
ORDER BY rent_start;



SELECT
    b.car_no,
    a.car_type,
    TO_CHAR(b.rent_start, 'yyyy-mm-dd') AS rent_start,
    TO_CHAR(b.rent_end, 'yyyy-mm-dd') AS rent_end,
    (a.PRICE + a.INSURANCE) * (b.rent_end - b.rent_start) AS MONEY
FROM
    CAR a
JOIN
    CAR_RENT b ON a.car_no = b.car_no
WHERE
    b.NAME = '심준서'
ORDER BY
    b.rent_start;


payment_method,
JOIN PAYMENT


SELECT b.car_no ,b.car_type, b.rent_start,b.rent_end,a.payment_method,b.money
FROM PAYMENT a JOIN (SELECT car_no , car_type, to_char(rent_start,'yyyy-mm-dd') AS rent_start, TO_CHAR(rent_end, 'yyyy-mm-dd') AS rent_end,
(PRICE + INSURANCE) AS MONEY 
FROM CAR JOIN CAR_RENT 
using(car_no)
WHERE NAME = '홍승희'
ORDER BY rent_start) b
ON a.car_no = b.car_no;


SELECT b.car_no, b.car_type, b.rent_start, b.rent_end, a.payment_method, b.money
FROM PAYMENT a
JOIN (
    SELECT car_no, car_type, TO_CHAR(rent_start, 'yyyy-mm-dd') AS rent_start, TO_CHAR(rent_end, 'yyyy-mm-dd') AS rent_end,
        (PRICE + INSURANCE) AS MONEY 
    FROM CAR
    JOIN CAR_RENT USING (car_no)
    WHERE NAME = '홍승희'
    GROUP BY car_no, car_type, TO_CHAR(rent_start, 'yyyy-mm-dd'), TO_CHAR(rent_end, 'yyyy-mm-dd'), (PRICE + INSURANCE)
    ORDER BY rent_start
) b
ON a.car_no = b.car_no;

SELECT car_no, car_type, rent_start, rent_end, payment_method, money
FROM (
    SELECT b.car_no, b.car_type, b.rent_start, b.rent_end, a.payment_method, b.money,
        ROW_NUMBER() OVER (PARTITION BY b.car_no ORDER BY b.rent_start) AS rn
    FROM PAYMENT a
    JOIN (
        SELECT car_no, car_type, TO_CHAR(rent_start, 'yyyy-mm-dd') AS rent_start, TO_CHAR(rent_end, 'yyyy-mm-dd') AS rent_end,
            (PRICE + INSURANCE) AS MONEY 
        FROM CAR
        JOIN CAR_RENT USING (car_no)
        WHERE NAME = '홍승희'
        ORDER BY rent_start
    ) b
    ON a.car_no = b.car_no
) c
WHERE rn = 1;

SELECT * FROM CUSTOMER c ;
SELECT * FROM CUSTOMERSERVICECENTER c ;

SELECT name, total_money, 
CASE
WHEN total_money >= 500000 THEN 'VIP'
WHEN total_money >= 300000 THEN 'GOLD'
WHEN total_money >= 200000 THEN 'SILVER'
ELSE 'FAMILY'
END AS grade
FROM (
SELECT p.name, SUM(money) AS total_money
FROM PAYMENT p
JOIN CAR c ON p.car_no = c.car_no
GROUP BY p.name
) subquery
ORDER BY name;

SELECT 
to_char(payment_day,'yyyy-mm') AS months, payment_method, money AS total
FROM ( SELECT p.payment_id, p.name, p.payment_day, p.money, p.payment_method, p.car_no
FROM PAYMENT p 
JOIN CAR c
ON p.car_no = c.car_no)
GROUP BY to_char(payment_day,'yyyy-mm') , payment_method, money
ORDER BY months DESC;

SELECT
    TO_CHAR(payment_day, 'yyyy-mm') AS months,
    payment_method,
    SUM(money) AS total
FROM
    (
        SELECT
            p.payment_id,
            p.name,
            p.payment_day,
            p.money,
            p.payment_method,
            p.car_no
        FROM
            PAYMENT p
        JOIN
            CAR c ON p.car_no = c.car_no
    )
GROUP BY
    TO_CHAR(payment_day, 'yyyy-mm'),
    payment_method
ORDER BY
    months DESC;
   
-- 자주 사용될 join 결과는 view 로 만들기. view 는 create or replace 로 생성후 에 수정까지 가능.
create or replace view mypage_buy
as
select buy_date , customid, p.pcode ,pname, qty, price, qty*price total from j_buy  b
join j_product p
on p.pcode=b.pcode
order by buy_date desc
;

select * from mypage_buy where customid='twice';


select sum(total) from mypage_buy where customid='twice';


