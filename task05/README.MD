# Task 5: Databases. Remember everything.
> Базы данных. Кто владеет информацией, тот владеет миром
---

1. [DONE] Основные понятия баз данных. Познакомиться с существующими базами данных. Различия SQL/NoSQL баз данных (Примеры)
```
почитано
```
---
2. [DONE] Развернуть в контейнере базу данных SQL (MySQL or PostgreSQL)
Заполнить базу данных. Сделать две таблицы:
 - Students (ID; Student; StudentId);
 - Result (ID; StudentId; Task1; Task2; Task3; Task4);
 >   Данные брать из https://docs.google.com/spreadsheets/d/1Idg3vRAl83I3SqWqEyqAgKkj6TG9jrPhbIYWMFOJOaY/edit#gid=255060736
```
пробуем stack вместо compose, гугл сказал что это модно/стильно/молодежно))
git: docker-compose.yml
```
---
3. [DONE] [EXTRA] Написать SQL скрипт, который будет заполнять базу данных и проверять на наличие уже существующих таблиц/записей.
```
git 5-3_import.sql
```
<details>
<summary>Workflow</summary>
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

\COPY students_import(ID, Student, StudentID) FROM '..\.help\tabl1.csv' DELIMITER ',' CSV HEADER;
\COPY result_import(ID, StudentID, Task1, Task2, Task3, Task4) FROM '..\.help\tabl2.csv' DELIMITER ';' CSV HEADER;

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
</details>

---
4. [DONE] Написать запрос который по вашей фамилии будет находить информацию по выполненным заданиям и выводить результат на экран
```
git 5-4_search.sql
```
<details>
<summary>Workflow</summary>
SELECT * FROM result
WHERE StudentID = (SELECT StudentID FROM students WHERE Student LIKE '%Pekhockij%');
</details>

---
5. [STUCK] Настроить репликацию SQL базы данных (Master->Slave)
```
stop on set establish replication
```
---
6. Обновить контейнер с базой данных (Взять за основу существующий докер образ и написать докерфайл в котором добавить переменную USERNAME) и запустить новую версию докер контейнера
---
7. Повторить шаг 4 :)
---
8. Повторить шаги 2, 5, 6 для NoSQL (Mongodb)  
---
9. [EXTRA] Написать Ansible роль для создания SQL кластера
---
10. [EXTRA] Написать Ansible роль для создания NoSQL кластера
---
11. [EXTRA] Написать Groovy Pipeline для Jenkins который будет запускать ансибл плейбуки для SQL/NoSQL
