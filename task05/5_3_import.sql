\echo "=================IMPORT CSV students======================"
DROP TABLE IF EXISTS students_import, result_import;

CREATE TEMPORARY TABLE students_import (
  ID VARCHAR(5),
  Student VARCHAR(50),
  StudentID smallint
);

\echo "=================IMPORT CSV result========================"

CREATE TEMPORARY TABLE result_import (
  ID VARCHAR(5),
  StudentID smallint,
  Task1 VARCHAR(10),
  Task2 VARCHAR(10),
  Task3 VARCHAR(10),
  Task4 VARCHAR(10)
);

\COPY students_import(ID, Student, StudentID) FROM 'd:\InternShip\task05\.help\tabl1.csv' DELIMITER ',' CSV HEADER;
\COPY result_import(ID, StudentID, Task1, Task2, Task3, Task4) FROM 'd:\InternShip\task05\.help\tabl2.csv' DELIMITER ';' CSV HEADER;

SELECT * FROM students_import;
SELECT * FROM result_import;
\echo "=================PREPARE PROD TABLE========================"

CREATE TABLE IF NOT EXISTS students (
  ID SERIAL PRIMARY KEY, 
  Student VARCHAR(50) NOT NULL UNIQUE,
  StudentID smallint NOT NULL
  );

CREATE TABLE IF NOT EXISTS result (
  ID SERIAL PRIMARY KEY,
  StudentID smallint NOT NULL UNIQUE,
  Task1 VARCHAR(10),
  Task2 VARCHAR(10),
  Task3 VARCHAR(10),
  Task4 VARCHAR(10)
);

\echo "=================IMPORT DATA======================"

INSERT INTO students (Student, StudentID)
SELECT Student, StudentID FROM students_import
WHERE Student NOT IN (SELECT student FROM students);

INSERT INTO result (StudentID, Task1, Task2, Task3, Task4)
SELECT StudentID, Task1, Task2, Task3, Task4 FROM result_import
WHERE StudentID NOT IN (SELECT StudentID from result);