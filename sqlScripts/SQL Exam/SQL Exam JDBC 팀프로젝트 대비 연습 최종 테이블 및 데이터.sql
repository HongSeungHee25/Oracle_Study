CREATE TABLE car
(
    car_id varchar2(30) NOT NULL,
    Rating_id number NOT NULL,
    carType varchar2(30) NOT NULL,
    fuel varchar2(30) NOT NULL,
    car_option varchar2(100) NOT NULL,
    Daily_Rental_Rate number NOT NULL,
    Daily_Premium number,
    PRIMARY KEY (car_id),
    FOREIGN KEY (Rating_id) REFERENCES vehicle_class (Rating_id)
);

CREATE TABLE CARD
(
    card_id number NOT NULL,
    card_name varchar2(30) NOT NULL UNIQUE,
    discount_rate number(5,2),
    PRIMARY KEY (card_id)
);

CREATE TABLE car_rent
(
    history_id number NOT NULL,
    customer_id varchar2(30) NOT NULL,
    car_id varchar2(30) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    Remainin_fuel_amount varchar2(30),
    ReservationStatusID varchar2(30),
    PRIMARY KEY (history_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (car_id) REFERENCES car (car_id),
    FOREIGN KEY (ReservationStatusID) REFERENCES Reservation_Status (ReservationStatusID)
);

CREATE TABLE customer
(
    customer_id varchar2(30) NOT NULL,
    password number NOT NULL UNIQUE,
    name varchar2(30) NOT NULL,
    phone varchar2(30) NOT NULL,
    license_id number NOT NULL UNIQUE,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (license_id) REFERENCES Drivers_License (license_id)
);

CREATE TABLE Drivers_License
(
    license_id number NOT NULL,
    license_information varchar2(30) NOT NULL UNIQUE,
    Date_issue date NOT NULL,
    expiration_period date NOT NULL,
    licensed_servant varchar2(30) NOT NULL,
    license_source varchar2(30),
    PRIMARY KEY (license_id)
);

CREATE TABLE Payment
(
    payment_id varchar2(30) NOT NULL,
    customer_id varchar2(30) NOT NULL,
    history_id number NOT NULL,
    payment_date date NOT NULL,
    payment_amount number,
    payment_method varchar2(30) NOT NULL,
    car_id varchar2(30) NOT NULL,
    card_id number NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (history_id) REFERENCES car_rent (history_id),
    FOREIGN KEY (CAR_ID) REFERENCES CAR (CAR_ID),
    FOREIGN KEY (card_id) REFERENCES card (card_id)
);

CREATE TABLE Reservation_Status
(
    ReservationStatusID varchar2(30) NOT NULL,
    ReservationStatusName varchar2(30) NOT NULL,
    PRIMARY KEY (ReservationStatusID)
);

CREATE TABLE vehicle_class
(
    Rating_id number NOT NULL,
    vehicle_Class varchar2(30) NOT NULL,
    domestic_Market varchar2(30) NOT NULL,
    PRIMARY KEY (Rating_id)
);
-----------------------------------------------------------------------------------------------------------------
INSERT INTO DRIVERS_LICENSE dl VALUES (10001,'12-00-019328-61','2020-03-09','2030-03-09','1종보통',null);
INSERT INTO DRIVERS_LICENSE dl VALUES (10002,'21-19-174133-01','2023-08-21','2033-08-21','2종보통',null);
INSERT INTO DRIVERS_LICENSE dl VALUES (10003,'0031-17-000794','2017-05-14','2027-05-14','1종보통',null);
INSERT INTO DRIVERS_LICENSE dl VALUES (10004,'0121-25-015894','2020-09-01','2030-09-01','2종보통',null);
---------------- 위에는 원래 만들어 놓은 데이터들 -----------------------------------------------------------
INSERT INTO DRIVERS_LICENSE dl VALUES (10005,'0045-05-025711','2022-01-21','2032-01-21','1종보통',null);
INSERT INTO DRIVERS_LICENSE dl VALUES (10006,'17-15-034851-23','2015-03-03','2025-03-03','2종보통',null);

SELECT * FROM DRIVERS_LICENSE dl ;


-- 면허증 번호를 확인해서 "한국인면허증", "외국인면허증" UPDATE 하기
UPDATE drivers_license
SET license_source = CASE
    WHEN REGEXP_LIKE(license_information, '\d{2}-\d{2}-\d{6}-\d{2}') AND LENGTH(REPLACE(license_information, '-', '')) = 12 THEN '한국인면허증'
    WHEN REGEXP_LIKE(license_information, '\d{4}-\d{2}-\d{6}') AND LENGTH(REPLACE(license_information, '-', '')) = 12 THEN '외국인면허증'
    ELSE license_source
  END;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO CUSTOMER c VALUES ('momo123',1234,'김모모','010-1245-9584',10001);
INSERT INTO CUSTOMER c VALUES ('gildong487',4568,'홍길동','010-9856-1546',10002);
INSERT INTO CUSTOMER c VALUES ('ann8452',8452,'Ann','010-3246-5916',10003);
INSERT INTO CUSTOMER c VALUES ('jone9785',9785,'Jone','010-6124-9785',10004);

SELECT * FROM CUSTOMER c ;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO VEHICLE_CLASS vc VALUES (1,'소형','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (2,'중형','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (3,'준중형','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (4,'대형','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (5,'SUV','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (6,'미니밴','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (7,'스포츠카','국산차');
INSERT INTO VEHICLE_CLASS vc VALUES (101,'스포츠카','외제차');
INSERT INTO VEHICLE_CLASS vc VALUES (102,'소형','외제차');
INSERT INTO VEHICLE_CLASS vc VALUES (103,'중형','외제차');
INSERT INTO VEHICLE_CLASS vc VALUES (104,'대형','외제차');
INSERT INTO VEHICLE_CLASS vc VALUES (105,'SUV','외제차');

SELECT * FROM VEHICLE_CLASS vc ;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO RESERVATION_STATUS rs VALUES ('A','대여 가능');
INSERT INTO RESERVATION_STATUS rs VALUES ('B','예약 접수');
INSERT INTO RESERVATION_STATUS rs VALUES ('C','대여 중');
INSERT INTO RESERVATION_STATUS rs VALUES ('D','완료');

SELECT * FROM RESERVATION_STATUS rs ;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO CAR c VALUES ('A1001',2,'쏘나타','LPG','풀옵션',65000,15000);
INSERT INTO CAR c VALUES ('A1002',1,'스파크','LPG','풀옵션',45000,10000);
INSERT INTO CAR c VALUES ('A1003',5,'쏘렌토','LPG','풀옵션',100000,45000);
INSERT INTO CAR c VALUES ('A1004',3,'SM3','LPG','풀옵션',75000,20000);
INSERT INTO CAR c VALUES ('A1005',4,'제네시스 G80','LPG','풀옵션',100000,10000);
INSERT INTO CAR c VALUES ('A1006',7,'제네시스 쿠페','LPG','풀옵션',110000,25000);
INSERT INTO CAR c VALUES ('A1007',6,'카니발','LPG','풀옵션',100000,30000);
INSERT INTO CAR c VALUES ('B1008',104,'벤츠 E 클래스','디젤','풀옵션',200000,50000);
INSERT INTO CAR c VALUES ('B1009',102,'벤츠 A 클래스','가솔린','풀옵션',130000,25000);
INSERT INTO CAR c VALUES ('B10010',103,'BMW X3','디젤','풀옵션',165000,35000);
INSERT INTO CAR c VALUES ('B10011',105,'아우디 Q3','LPG','풀옵션',300000,80000);
INSERT INTO CAR c VALUES ('B10012',101,'포르쉐 박스터','가솔린','풀옵션',300000,80000);

SELECT * FROM CAR c ;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO CAR_RENT VALUES (999, 'momo123', 'A1001', '2023-06-30', '2023-07-02', '30L', NULL);
INSERT INTO CAR_RENT VALUES (998, 'ann8452', 'A1006', '2023-07-01', '2023-07-05', '50L', NULL);
INSERT INTO CAR_RENT VALUES (997, 'gildong487', 'A1004', '2023-06-28', '2023-07-01', '25L', NULL);
INSERT INTO CAR_RENT VALUES (996, 'jone9785', 'B10012', '2023-07-03', '2023-07-05', '56L', NULL);

SELECT * FROM CAR_RENT cr ;

MERGE INTO CAR_RENT cr
USING (
    SELECT cr.history_id, rs.ReservationStatusID
    FROM CAR_RENT cr
    LEFT JOIN RESERVATION_STATUS rs ON cr.ReservationStatusID = rs.ReservationStatusID
    WHERE cr.ReservationStatusID IS NULL
) temp ON (cr.history_id = temp.history_id)
WHEN MATCHED THEN
    UPDATE SET cr.ReservationStatusID = 
        CASE
            WHEN cr.start_date > SYSDATE THEN 'B'
            WHEN cr.start_date < SYSDATE AND cr.end_date > SYSDATE THEN 'C'
            WHEN cr.end_date <= TRUNC(SYSDATE) THEN 'D'
            ELSE 'A'
        END;
       
-- 예약접수, 대여 중, 완료 등등 조회
SELECT cr.history_id, cr.customer_id, cr.car_id, cr.start_date, cr.end_date, cr.Remainin_fuel_amount, rs.ReservationStatusName
FROM CAR_RENT cr
LEFT JOIN RESERVATION_STATUS rs ON cr.ReservationStatusID = rs.ReservationStatusID;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO CARD c VALUES (101,'신한카드',0.09);
INSERT INTO CARD c VALUES (102,'KB국민카드',0.08);
INSERT INTO CARD c VALUES (103,'하나카드',0.05);
INSERT INTO CARD c VALUES (104,'NH농협카드',0.07);
INSERT INTO CARD c VALUES (105,'현대카드',0.04);
INSERT INTO CARD c VALUES (106,'삼성카드',0.1);
INSERT INTO CARD c VALUES (107,'롯데카드',0.06);
INSERT INTO CARD c VALUES (108,'우리카드',0.02);
INSERT INTO CARD c VALUES (109,'IBK기업은행',0.01);
INSERT INTO CARD c VALUES (110,'BC카드',0.03);

SELECT * FROM CARD c ;

-----------------------------------------------------------------------------------------------------------------
INSERT INTO PAYMENT p VALUES ('AB100','momo123',999,'2023-06-27',NULL,'신용카드','A1001',101);
INSERT INTO PAYMENT p VALUES ('AB101','ann8452',998,'2023-06-28',NULL,'신용카드','A1006',105);
INSERT INTO PAYMENT p VALUES ('AB102','gildong487',997,'2023-06-25',NULL,'신용카드','A1004',110);
INSERT INTO PAYMENT p VALUES ('AB103','jone9785',996,'2023-06-30',NULL,'신용카드','B10012',107);

SELECT * FROM PAYMENT p ;

SELECT c.CARTYPE ,c.DAILY_RENTAL_RATE + c.DAILY_PREMIUM AS "할인율 적용 전 가격"
FROM CAR c;

DELETE FROM PAYMENT p ;

-----------------------------------------------------------------------------------------------------------------

-- 총 결제 금액 업데이트
UPDATE PAYMENT p
SET p.PAYMENT_AMOUNT = (
    SELECT (c.DAILY_RENTAL_RATE + c.DAILY_PREMIUM) * (1 - d.DISCOUNT_RATE)
    FROM CAR c, CARD d
    WHERE c.CAR_ID = p.CAR_ID
      AND d.CARD_ID = p.CARD_ID
)
WHERE p.PAYMENT_AMOUNT IS NULL;


-----------------------------------------------------------------------------------------------------------------
-- car_id 에 맞는 card_name 조회
SELECT p.PAYMENT_ID, p.CUSTOMER_ID, p.HISTORY_ID, p.PAYMENT_DATE,p.PAYMENT_AMOUNT ,p.PAYMENT_METHOD ,p.CAR_ID , c.CARD_NAME
FROM PAYMENT p 
LEFT JOIN CARD c ON p.CARD_ID = c.CARD_ID;

SELECT p.PAYMENT_ID, p.CUSTOMER_ID, p.HISTORY_ID, p.PAYMENT_DATE,p.PAYMENT_AMOUNT ,p.PAYMENT_METHOD ,c2.CARTYPE , c.CARD_NAME
FROM PAYMENT p 
LEFT JOIN CARD c ON p.CARD_ID = c.CARD_ID
LEFT JOIN CAR c2 ON p.CAR_ID = c2.CAR_ID ;

SELECT p.PAYMENT_ID, p.CUSTOMER_ID, p.HISTORY_ID, p.PAYMENT_DATE,c2.DAILY_RENTAL_RATE + c2.DAILY_PREMIUM AS "할인율 적용 전 가격" ,p.PAYMENT_METHOD ,c2.CARTYPE , c.CARD_NAME
FROM PAYMENT p 
LEFT JOIN CARD c ON p.CARD_ID = c.CARD_ID
LEFT JOIN CAR c2 ON p.CAR_ID = c2.CAR_ID ;

