CREATE TABLE PAYMENT_1
AS 
SELECT * FROM PAYMENT;

SELECT * FROM P_BUY5 pb ;

SELECT * FROM PAYMENT_1;
SELECT * FROM CAR ;

UPDATE (
  SELECT p.money, c.price, c.insurance
  FROM PAYMENT p
  JOIN CAR c ON c.CAR_NO = p.CAR_NO
  WHERE p.payment_id = 11
) t
SET t.money = t.price + t.insurance;

ALTER TABLE PAYMENT_1 ADD grade varchar2(30);

CREATE SEQUENCE payment_seq START WITH 17;
CREATE SEQUENCE rent_seq START WITH 17;

-- money 가 10만원 이상인 회원은 VIP , 아니면 일반회원 UPDATE 
CREATE OR REPLACE PROCEDURE carRent_Grade(
	vname IN varchar2,
	vpayment_method IN varchar2
)
IS 
	vpayment_id NUMBER;
	vvip varchar2(20);
	vrent_no NUMBER;
	vcar_no varchar2(30);
	vmoney NUMBER; -- 결제 금액을 저장하기 위한 변수
	vtotal NUMBER;
BEGIN
	SELECT c.car_no INTO vcar_no
	FROM CAR c JOIN CAR_RENT cr ON c.car_no = cr.car_no
	WHERE cr.name = vname AND ROWNUM = 1;
	
	INSERT INTO PAYMENT_1(payment_id,name,rent_no,payment_day,payment_method,car_no)
		VALUES(payment_seq.nextval,vname,rent_seq.nextval,sysdate,vpayment_method,vcar_no);
	
	SELECT payment_seq.currval INTO vpayment_id
		FROM dual;
	
	SELECT rent_seq.currval INTO vrent_no
		FROM dual;
	
	UPDATE PAYMENT_1 p
	SET money = (SELECT sum(c.price + c.insurance)
				 FROM PAYMENT_1 p
				 JOIN CAR c ON c.CAR_NO = p.CAR_NO
				 WHERE p.name = vname
				 GROUP BY p.name)
	WHERE payment_id = vpayment_id;
	
	SELECT sum(money) INTO vtotal
	FROM PAYMENT_1
	WHERE name = vname;
	
	IF vtotal >= 500000 THEN 
		UPDATE PAYMENT_1 SET grade = 'VIP' WHERE name = vname;
	ELSIF vtotal >= 300000 THEN 
		UPDATE PAYMENT_1 SET grade = 'GOLD' WHERE name = vname;
	ELSIF vtotal >= 200000 THEN 
		UPDATE PAYMENT_1 SET grade = 'SILVER' WHERE name = vname;
	ELSE
		UPDATE PAYMENT_1 SET grade = 'FAMILY' WHERE name = vname;
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('성공');
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('실패');
		ROLLBACK;
END;




SELECT cr.NAME 
FROM CAR c JOIN CAR_RENT cr ON c.car_no = cr.car_no;

--CREATE OR REPLACE PROCEDURE carRent_Grade(
--	vname IN varchar2,
--	vpayment_method IN varchar2
--)

BEGIN 
	carRent_Grade('정지우','계좌이체');
END;
BEGIN 
	carRent_Grade('임윤주','신용카드');
END;
BEGIN 
	carRent_Grade('이나현','신용카드');
END;
BEGIN 
	carRent_Grade('김예나','계좌이체');
END;
BEGIN 
	carRent_Grade('이용희','신용카드');
END;
BEGIN 
	carRent_Grade('서동우','계좌이체');
END;
BEGIN 
	carRent_Grade('한빈','신용카드');
END;


