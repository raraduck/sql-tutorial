-- DDL (Data Definition Language)
-- \l (DB 조회) -> \dn (schema 조회) -> \dt (테이블 조회) -> \d (컬럼 조회)

-- DB 정보조회
SELECT  datname AS "데이터베이스명",
        datistemplate AS "템플릿?",
        datallowconn AS "접속허용여부"
FROM pg_database
WHERE datistemplate = false
ORDER BY datistemplate, datname;


-- SCHEMA 정보조회
SELECT  catalog_name as "데이터베이스명",
        schema_name as "스키마명",
        schema_owner as "소유자"
FROM    information_schema.schemata
WHERE   schema_name not like 'pg/_%' escape '/'
AND     schema_name <> 'information_schema'
ORDER BY schema_name;


-- TABLE 정보조회
SELECT  table_catalog AS "데이터베이스명",
        table_schema AS "스키마명",
        table_name AS "테이블명"
FROM information_schema.tables -- 각 스키마 소유의 테이블과 뷰를 보여주는 View
WHERE table_schema = 'mart'
ORDER BY table_schema, table_name;


-- DML (Data Manipulation Language)
-- (1) Insert
INSERT INTO mart.car_member VALUES (1, 'man', 35, 'Gwangju', '2025-09-30');
INSERT INTO mart.car_member (mem_no, gender, age, join_date) VALUES (2, 'woman', 38, '2025-09-30');
-- (2) Update
UPDATE mart.car_member SET addr='Seoul' WHERE mem_no=2;
UPDATE  mart.car_member 
SET     addr='Seoul',
        age=38
WHERE mem_no=1;
DELETE FROM mart.car_member WHERE mem_no=1;

-- DATA SELECT

SELECT * FROM mart.car_member WHERE mem_no = 1;
SELECT * FROM mart.car_member WHERE mem_no IN (1, 2, 3);
SELECT * FROM mart.car_member ORDER BY mem_no ASC LIMIT 5;
SELECT * FROM mart.car_member ORDER BY mem_no ASC LIMIT 5 OFFSET 5;
SELECT NOW(), TO_CHAR(NOW(), 'YYYY-MM-DD');
SELECT CURRENT_DATE;

SELECT  mem_no, addr, age 
FROM    mart.car_member 
WHERE   join_date >= '2025-01-01'
AND     addr='Seoul';

SELECT 
    mem_no AS 번호,
    addr AS 주소,
    (age / 10 * 10)::text || '대' AS 나이대
FROM mart.car_member
ORDER BY mem_no ASC LIMIT 5;

-- SELECT with Condition (WHERE)


SELECT 
    mem_no AS 번호,
    addr AS 주소,
    (age / 10 * 10)::text || '대' AS 나이대
FROM mart.car_member
WHERE   age >= 20
AND     age < 50
ORDER BY mem_no ASC LIMIT 20;

-- JOIN

SELECT  A.*,
        B.prod_cd,
        B.quantity,
        D.price,
        B.quantity * D.price AS sales_amt,
--        (B.quantity::numeric) * (D.price::numeric) AS sales_amt,
--        B.quantity::numeric * REPLACE(D.price, ',', '')::numeric AS sales_amt,
        C.store_addr,
        D.brand,
        D.model,
        E.gender,
        E.age,
        E.addr,
        E.join_date
FROM    mart."car_order" A
LEFT JOIN mart."car_orderdetail" B ON A.order_no = B.order_no
LEFT JOIN mart."car_store" C       ON A.store_cd = C.store_cd
LEFT JOIN mart."car_product" D     ON B.prod_cd  = D.prod_cd
LEFT JOIN mart."car_member" E      ON A.mem_no   = E.mem_no;

-- Analysis

CREATE TEMP TABLE profile_base AS
SELECT 
    *,
    CASE 
        WHEN age < 20 THEN '20대 미만'
        WHEN age BETWEEN 20 AND 29 THEN '20대'
        WHEN age BETWEEN 30 AND 39 THEN '30대'
        WHEN age BETWEEN 40 AND 49 THEN '40대'
        WHEN age BETWEEN 50 AND 59 THEN '50대'
        ELSE '60대 이상'
    END AS ageband
FROM mart.car_mart;

SELECT mem_no, order_no, quantity, price, sales_amt, ageband FROM profile_base LIMIT 5;