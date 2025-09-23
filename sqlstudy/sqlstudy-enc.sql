CREATE SCHEMA IF NOT EXISTS sqlstudy;

CREATE TABLE sqlstudy.enc_dept(
dept_no	DECIMAL(4)	NOT NULL	PRIMARY KEY,
dept_name VARCHAR(30)	NOT NULL,
upper_dept_no	DECIMAL(4)
);

CREATE TABLE sqlstudy.enc_emp(
emp_no			DECIMAL(6)		NOT NULL		PRIMARY KEY,
emp_name		VARCHAR(50)		NOT NULL,
dept_no			DECIMAL(4)		NOT NULL REFERENCES sqlstudy.enc_dept,
hire_date		DATE,
sal				INTEGER,
manager_emp_no	DECIMAL(6)		REFERENCES sqlstudy.enc_emp,
age				DECIMAL(3),
area			VARCHAR(10)
);
ALTER TABLE sqlstudy.enc_emp
ALTER COLUMN sal SET NOT NULL;

CREATE TABLE sqlstudy.enc_prod(
prod_id			DECIMAL(4)		NOT NULL		PRIMARY KEY,
prod_name		VARCHAR(30)		NOT NULL,
price			INTEGER			NOT	NULL,
launch_date		DATE,
maker_name		VARCHAR(50)
);

CREATE TABLE sqlstudy.enc_country(
contry_cd		CHAR(2)			NOT NULL		PRIMARY KEY,
country_name	VARCHAR(20)		NOT NULL,
region			VARCHAR(20)
);

CREATE TABLE sqlstudy.enc_job(
job_cd			CHAR(2)			NOT NULL		PRIMARY KEY,
job_name		VARCHAR(20)		NOT NULL,
job_div			VARCHAR(20)
);

CREATE TABLE sqlstudy.enc_customer(
cust_id			CHAR(7)			NOT NULL		PRIMARY KEY,
cust_name		VARCHAR(50)		NOT NULL,
gender			VARCHAR(4)		NOT NULL,
phone_number	VARCHAR(15)		NOT NULL,
email			VARCHAR(100),
city			VARCHAR(20),
country_cd		CHAR(2)			NOT NULL REFERENCES sqlstudy.enc_country,
cust_div_cd		CHAR(3)			NOT NULL,
job_cd			CHAR(2)			NOT NULL REFERENCES sqlstudy.enc_job,
birth_date		DATE			NOT NULL
);

CREATE TABLE sqlstudy.enc_order(
ord_no			INTEGER			NOT NULL PRIMARY KEY,
cust_id			CHAR(7)			NOT NULL REFERENCES sqlstudy.enc_customer,
ord_dept_no		DECIMAL(4)		NOT NULL REFERENCES sqlstudy.enc_dept(dept_no),
ord_emp_no		DECIMAL(6)		NOT NULL REFERENCES sqlstudy.enc_emp(emp_no),
ord_dt			TIMESTAMPTZ		NOT NULL, -- timestamp with time zone
prod_id			DECIMAL(4)		NOT NULL REFERENCES sqlstudy.enc_prod,
quantity		DECIMAL(5)		NOT NULL,
amount			INTEGER,
ord_status		VARCHAR(10),
complete_date	DATE
);

CREATE TABLE sqlstudy.en_ord_status_hist(
ord_no			INTEGER			NOT NULL REFERENCES sqlstudy.enc_order,
ord_status		VARCHAR(10)		NOT NULL,
ord_status_dt	TIMESTAMPTZ		NOT NULL,
PRIMARY KEY(ord_no, ord_status)
);

CREATE TABLE sqlstudy.enc_contract(
cont_id			INTEGER			NOT NULL PRIMARY KEY,
cust_id			CHAR(7)			NOT NULL REFERENCES sqlstudy.enc_customer,
join_dt			TIMESTAMPTZ,
cancel_dt		TIMESTAMPTZ,
cont_type_cd	CHAR(2)			NOT NULL,
cont_dept_no	DECIMAL(4) NOT NULL REFERENCES sqlstudy.enc_dept(dept_no),
remark			VARCHAR(200)
);

