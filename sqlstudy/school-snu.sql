CREATE SCHEMA IF NOT EXISTS school;

create table
	school.department (
		dept_name varchar(20),
		building varchar(15),
		budget numeric(12, 2) check (budget > 0),
		primary key (dept_name)
	);

create table
	school.student (
		student_ID varchar(5),
		name varchar(20) not null,
		dept_name varchar(20),
		tot_cred numeric(3, 0) check (tot_cred >= 0),
		primary key (student_ID),
		foreign key (dept_name) references department (dept_name) on delete set null
	);

create table
	school.course (
		course_id varchar(7),
		title varchar(50),
		dept_name varchar(20),
		credits numeric(2, 0) check (credits > 0),
		primary key (course_id),
		foreign key (dept_name) references department (dept_name) on delete set null
	);

create table
	school.instructor (
		instructor_ID varchar(5),
		name varchar(20) not null,
		dept_name varchar(20),
		salary numeric(8, 2) check (salary > 29000),
		primary key (instructor_ID),
		foreign key (dept_name) references department (dept_name) on delete set null
	);

create table
	school.all_list (
		course_id varchar(7),
		seq_id varchar(8),
		semester varchar(6) check (
			semester in ('Fall', 'Winter', 'Spring', 'Summer')
		),
		year numeric(4, 0) check (
			year > 1701
			and year < 2100
		),
		building varchar(15),
		room_number varchar(7),
		class_time varchar(1),
		primary key (course_id, seq_id, semester, year),
		foreign key (course_id) references course (course_id) on delete cascade
	);

create table
	school.take_course (
		student_ID varchar(5),
		course_id varchar(8),
		seq_id varchar(8),
		semester varchar(6),
		year numeric(4, 0),
		grade varchar(2),
		primary key (student_ID, course_id, seq_id, semester, year),
		foreign key (course_id, seq_id, semester, year) references all_list (course_id, seq_id, semester, year) on delete cascade,
		foreign key (student_ID) references student (student_ID) on delete cascade
	);

-- LOAD DATA  INFILE 'department.txt' INTO TABLE department;
COPY school.department
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/department.txt' DELIMITER E '\t' NULL '' CSV;

COPY school.all_list
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/all_list.txt' DELIMITER E '\t' NULL '';

COPY school.course
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/course.txt' DELIMITER E '\t' NULL '';

COPY school.instructor
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/instructor.txt' DELIMITER E '\t' NULL '';

COPY school.student
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/student.txt' DELIMITER E '\t' NULL '';

COPY school.take_course
FROM
	'/Users/dwnm1/workspace/sql-tutorial/ClassDB_0605/take_course.txt' DELIMITER E '\t' NULL '';

DROP TABLE IF EXISTS school.department;

DROP TABLE IF EXISTS school.all_list CASCADE;

DROP TABLE IF EXISTS school.course;

DROP TABLE IF EXISTS school.instructor;

DROP TABLE IF EXISTS school.student CASCADE;

DROP TABLE IF EXISTS school.take_course CASCADE;