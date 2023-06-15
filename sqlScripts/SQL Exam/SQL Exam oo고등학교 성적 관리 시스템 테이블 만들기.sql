CREATE TABLE tbl_student (
    student_No NUMBER(4,0) PRIMARY KEY,
    student_Name VARCHAR2(20) NOT NULL,
    student_day NUMBER(8,0) NOT NULL,
    student_address VARCHAR2(30) NOT NULL,
    record_Midterm NUMBER(3),
    record_final NUMBER(3),
    average_score NUMBER(4,2)
);


CREATE TABLE tbl_subject (
	subject_No NUMBER(5,0) PRIMARY KEY,
	subject_Name VARCHAR2(20) NOT NULL,
	subject_teacherID VARCHAR2(20) NOT NULL,
	subject_semester CHAR(1) NOT NULL
);

CREATE TABLE tbl_record (
	record_No NUMBER(10,0) PRIMARY KEY,
	record_Midterm NUMBER(3),
	record_final NUMBER(3),
	student_No NUMBER(4,0),
	subject_No NUMBER(5,0),
	CONSTRAINT fk_student FOREIGN KEY (student_No) REFERENCES tbl_student(student_No),
	CONSTRAINT fk_subject FOREIGN KEY (subject_No) REFERENCES tbl_subject(subject_No)
);
SELECT * FROM TBL_STUDENT ts ;