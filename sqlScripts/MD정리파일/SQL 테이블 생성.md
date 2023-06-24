# SQL 테이블 생성
    CREATE TABLE 테이블명(
        컬럼명1 데이터 유형,
        컬럼명2 데이터 유형,
        컬럼명3 데이터 유형,....
    );

# SQL 테이블 생성시 제약조건 설정
    CREATE TABLE 테이블명(
        컬럼명1 데이터 유형 PRIMARY KEY,
        컬럼명2 데이터 유형 NOT NULL,
        컬럼명3 데이터 유형,....
        ....
        CONSTRAINT 제약조건명 PRIMARY KEY (기본키_열1, 기본키_열2, ...),
        CONSTRAINT 제약조건명 FOREIGN KEY (외래키_열1, 외래키_열2, ...)
        REFERENCES 참조_테이블명 (참조_테이블_기본키1, 참조_테이블_기본키2, ...)
    );

# SQL 테이블 생성 이후 제약조건 설정
    ALTER TABLE 테이블명 
    ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키_컬럼)
    REFERENCES 참조_테이블명 (참조_테이블_외래키);