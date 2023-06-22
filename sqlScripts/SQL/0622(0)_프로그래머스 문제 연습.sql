-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블
-- ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE
-- 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부

-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블
-- ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME
--  동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부

-- 관리자의 실수로 일부 동물의 입양일이 잘못 입력
-- 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문
-- 결과는 보호 시작일이 빠른 순으로 조회

-------------------------------------------------------------------------------------------------------------

-- ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블
-- ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE
-- 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부

-- ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블
-- ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME
--  동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부

-- 아직 입양을 못 간 동물 중,
-- 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회
-- 결과는 보호 시작일 순으로 조회
SELECT NAME,DATETIME
FROM ANIMAL_INS JOIN (
	SELECT NAME
	FROM ANIMAL_OUTS
	GROUP BY NAME
	HAVING MAX(DATETIME)
)

-------------------------------------------------------------------------------------------------------------
-- 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블
    -- CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS
    -- 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트
-- 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블
    -- HISTORY_ID, CAR_ID, START_DATE, END_DATE
    -- 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일

-- 자동차 종류가 '세단'인 자동차들 중 
    -- 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트
        -- 자동차 ID 리스트는 중복이 없어야 하며,
            -- 자동차 ID를 기준으로 내림차순 정렬해주세요

SELECT A.CAR_ID
FROM CAR_RENTAL_COMPANY_CAR A LEFT JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY B
ON A.CAR_ID = B.CAR_ID
WHERE CAR_TYPE = '세단' AND TO_CHAR(DATETIME,'MM')='10'
GROUP BY A.CAR_ID			-- GROUP BY 를 안쓰면 중복값이 다 나옴. GROUP BY 로 중복값을 제거
ORDER BY A.CAR_ID DESC

-------------------------------------------------------------------------------------------------------------
-- 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블
-- HISTORY_ID,        CAR_ID,   START_DATE,    END_DATE
-- 자동차 대여 기록 ID, 자동차 ID, 대여 시작일,    대여 종료일

-- 2022년 10월 16일에 대여 중인 자동차인 경우
    -- '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시
    -- 컬럼명: AVAILABILITY
    -- 자동차 ID와 AVAILABILITY 리스트를 출력
         -- 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시
    -- 결과는 자동차 ID를 기준으로 내림차순 정렬

SELECT CAR_ID, 
MAX( 	-- MAX 1개만 사용했으면 GROUP BY 를 안써도 됬지만 CAR_ID 컬럼도 사용했기때문에 GROUP BY 를 사용
	CASE 
	WHEN '2022-10-16' BETWEEN TO_CHAR(START_DATE,'YYYY-MM-DD') AND TO_CHAR(END_DATE,'YYYY-MM-DD')
	THEN '대여중' ELSE '대여 가능' END 
) AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC

-------------------------------------------------------------------------------------------------------------
-- PLACES 테이블은 공간 임대 서비스에 등록된 공간의 정보를 담은 테이블
-- ID, NAME, HOST_ID
-- 아이디, 이름, 공간을 소유한 유저의 아이디

--  공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부릅니다
-- 헤비 유저를 구하는 SQL 문
-- SELECT HOST_ID,COUNT(*)
-- FROM PLACES
-- GROUP BY HOST_ID
-- HAVING COUNT(*) >= 2

-- 헤비 유저가
-- 등록한 공간의 정보를
-- 아이디 순으로 조회
SELECT *
FROM PLACES
WHERE HOST_ID IN (
	SELECT HOST_ID
	FROM PLACES
	GROUP BY HOST_ID
	HAVING COUNT(*) >= 2
)
ORDER BY ID






















































