## ALTER TABLE
: 오라클에서 'ALTER TABLE' 문을 사용하여 테이블을 변경할 수 있습니다. 'ALTER TABLE' 문은 기존 테이블의 구조를 수정하거나 제약 조건을 추가 또는 제거하는 데 사용됩니다.

## <ALTER TABLE 테이블 이름 변경>
ALTER TABLE 테이블명 RENAME TO 새로운_테이블명;

## <ALTER TABLE 테이블 열 추가>
ALTER TABLE 테이블명 ADD (컬럼1 데이터_유형, 컬럼2 데이터_유형,...);

## <ALTER TABLE 테이블 열 삭제>
ALTER TABLE 테이블명 DROP COLUMN 컬럼명;

## <ALTER TABLE 테이블 열 수정>
ALTER TABLE 테이블명 MODIFY (컬럼명 새로운_데이터_유형)

## <ALTER TABLE 테이블 제약 조건 추가>
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건_이름 제약조건_유형(컬럼1,컬럼2,...)

## <ALTER TABLE 테이블 제약 조건 제거>
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건_이름;

## <ALTER TABLE 테이블 컬럼에 대한 기본값 설정>
ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 기본값;

## <ALTER TABLE 테이블 컬럼에 대한 NULL 또는 NOT NULL 제약 조건 설정>
ALTER TABLE 테이블명 MODIFY 컬럼명 NULL;
ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;

## <ALTER TABLE 테이블 컬럼 이름 변경>
ALTER TABLE 테이블명 RENAME COLUMN 기존_컬럼명 TO 새로운_컬럼명;

## <ALTER TABLE 테이블 인덱스 생성>
ALTER TABLE 테이블명 ADD INDEX 인덱스명 (컬럼명);

## <ALTER TABLE 테이블 인덱스 제거>
ALTER TABLE 테이블명 DROP INDEX 인덱스명;