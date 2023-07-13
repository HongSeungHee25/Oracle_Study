CREATE TABLE x_buy
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM x_buy;

CREATE TABLE X_PRODUCT
AS 
SELECT * FROM TBL_PRODUCT tp ;

SELECT * FROM X_PRODUCT ;


CREATE OR REPLACE PROCEDURE proce_p_buy(
    c_customid IN varchar2,
    c_pcode IN varchar2,
    c_atn IN NUMBER,
    c_isSuccess OUT varchar2
)
IS 
    zseq NUMBER;
    zprice NUMBER;
    zstock NUMBER; -- 추가된 변수: 제품 재고량을 저장하기 위한 변수
BEGIN 
    -- 주문 테이블에 구매 정보 삽입
    INSERT INTO x_buy(buy_seq, customid, pcode, qty, buy_date)
        VALUES(buy_seq.nextval, c_customid, c_pcode, c_atn, sysdate);
    SELECT buy_seq.currval INTO zseq
        FROM dual;
    
    -- 제품 가격 조회
    SELECT price INTO zprice
        FROM tbl_product WHERE pcode = c_pcode;
    
    -- 제품 재고량 조회
    SELECT stock INTO zstock
        FROM tbl_product WHERE pcode = c_pcode;
    
    -- 제품 가격과 수량을 곱하여 주문 금액 계산
    UPDATE x_buy SET money = zprice * c_atn
        WHERE buy_seq = zseq;
    
    -- 재고량에서 구매한 수량 차감
    UPDATE tbl_product SET stock = zstock - c_atn
        WHERE pcode = c_pcode;
    
    DBMS_OUTPUT.PUT_LINE('실행 성공');
    c_isSuccess := 'success';
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('실행 실패');
        c_isSuccess := 'fail';
END;


ALTER TABLE x_buy ADD money NUMBER(7) CHECK (money >= 10000);
ALTER TABLE x_product ADD stock NUMBER;


DECLARE 
vresult varchar2(20);		-- 프로시저에서 선언한 OUT 을 받아올 변수
BEGIN 
	proce_p_buy('mina012','CJBAb12g',3,vresult);
	DBMS_OUTPUT.PUT_LINE('결과 : '||vresult);  -- := 할당 연산자(변수에 값을 할당하는 데 사용) -- SYSOUT 같은 거 = 출력문
END;

-- 제품 재고량 조회
SELECT stock INTO zstock
    FROM x_product WHERE pcode = c_pcode;

-- 재고량에서 구매한 수량 차감
UPDATE x_product SET stock = zstock - c_atn
    WHERE pcode = c_pcode;
-----------------------------------------------------------------------------------------------
CREATE TABLE V_BUY
AS 
SELECT * FROM TBL_BUY tb ;

SELECT * FROM V_BUY ;
   
   
   
   
   
   

