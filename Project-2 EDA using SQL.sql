/*
SQL for Data Science 
Project 2
-- Rajesh Murari
*/

/*
1. Create new schema as "alumni"
*/

CREATE DATABASE alumni;
USE alumni;

/*
2. Import all .csv files into MySQL 
*/
-- (Imported all files using 'Table Data Import wizard')

/*
3. Run SQL command to see the structure of six tables
*/
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

/*
4. Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, 
   College_B_HS, College_B_SE, College_B_SJ) with Python.
*/
-- Check Screenshots of python jupyter notebook for solution (Q4***.jpeg) 


/*
5. Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, 
   College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
*/

-- Check Screenshots of Microsoft Excel for solution (Q5***.jpeg)

/*
6. Perform data cleaning on table College_A_HS and store cleaned data 
   in view College_A_HS_V, Remove null values. 
*/

CREATE VIEW College_A_HS_V AS
    (SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL);
            
SELECT* FROM College_A_HS_V;

/*
7. Perform data cleaning on table College_A_SE and 
   store cleaned data in view College_A_SE_V, Remove null values.
*/
DESC college_a_se;
CREATE VIEW College_A_SE_V AS
    (SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
			AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND `Organization` IS NOT NULL
            AND Location IS NOT NULL);

SELECT* FROM College_A_SE_V;

/*
8. Perform data cleaning on table College_A_SJ and 
   store cleaned data in view College_A_SJ_V, Remove null values.
*/

DESC college_a_sj;
CREATE VIEW College_A_SJ_V AS
    (SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
			AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND `Organization` IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL);

SELECT* FROM College_A_SJ_V;

/*
9. Perform data cleaning on table College_B_HS and 
   store cleaned data in view College_B_HS_V, Remove null values.
*/

DESC college_b_hs;
SELECT * FROM college_b_hs;
CREATE VIEW College_B_HS_V AS
    (SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
			AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL);

SELECT* FROM College_B_HS_V;

/*
10. Perform data cleaning on table College_B_SE and 
    store cleaned data in view College_B_SE_V, Remove null values.
*/

DESC college_b_se;
SELECT * FROM college_b_se;
CREATE VIEW College_B_SE_V AS
    (SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
			AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND `Organization` IS NOT NULL
            AND Location IS NOT NULL);

SELECT* FROM College_B_SE_V;

/*
11. Perform data cleaning on table College_B_SJ and 
    store cleaned data in view College_B_SJ_V, Remove null values.
*/

DESC college_b_sj;
SELECT * FROM college_b_sj;
CREATE VIEW College_B_SJ_V AS
    (SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
			AND LastUpdate IS NOT NULL
            AND `Name` IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND `Organization` IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL);

SELECT* FROM College_B_SJ_V;


/* 
12. Make procedure to use string function/s for converting
    record of Name, FatherName, MotherName into lower case 
    for views 
    (College_A_HS_V, College_A_SE_V, College_A_SJ_V, 
    College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
*/

USE `alumni`;
DROP procedure IF EXISTS `alumni_lowercase`;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE alumni_lowercase ()
BEGIN
	SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_A_HS_V;
    SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_A_SE_V;
    SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_A_SJ_V;
    SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_B_HS_V;
    SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_B_SE_V;
    SELECT LOWER(`Name`), LOWER(FatherName), LOWER(MotherName) FROM College_B_SJ_V;
END$$

DELIMITER ;

CALL alumni_lowercase();


/*
13.	Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, 
	College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and 
    make pivot chart for location of Alumni. 
*/
-- Check Screenshots of Microsoft Excel for solution (Q13***.jpeg)

/*
14.	Write a query to create procedure get_name_collegeA using the cursor 
to fetch names of all students from college A.
*/

USE `alumni`;
DROP procedure IF EXISTS `get_name_collegeA`;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE get_name_collegeA (INOUT get_nameA TEXT(20000))
BEGIN
	DECLARE NA INT DEFAULT 0;
    DECLARE get_namelistA VARCHAR(500) DEFAULT "";
	DECLARE get_namecursorA 
            CURSOR FOR 
                SELECT `Name` FROM college_a_hs UNION
                SELECT `Name` FROM college_a_se UNION
                SELECT `Name` FROM college_a_sj;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET NA = 1;
    
    OPEN get_namecursorA;
		 get_namecursorA: LOOP
			 FETCH get_namecursorA INTO get_namelistA;
             IF NA = 1 THEN
				LEAVE get_namecursorA;
			 END IF;
			 SET get_nameA = CONCAT(get_namelistA,";",get_nameA);
         END LOOP;
	CLOSE get_namecursorA;
END$$

DELIMITER ;

SET @NameA = "";
CALL get_name_collegeA (@NameA);
SELECT @NameA `Names of College A Students`;

/*
15.	Write a query to create procedure get_name_collegeB using the cursor 
to fetch names of all students from college B.
*/

USE `alumni`;
DROP procedure IF EXISTS `get_name_collegeB`;

DELIMITER $$
USE `alumni`$$
CREATE PROCEDURE get_name_collegeB (INOUT get_nameB TEXT(20000))
BEGIN
	DECLARE NA INT DEFAULT 0;
    DECLARE get_namelistB VARCHAR(500) DEFAULT "";
	DECLARE get_namecursorB 
            CURSOR FOR 
                SELECT `Name` FROM college_b_hs UNION
                SELECT `Name` FROM college_b_se UNION
                SELECT `Name` FROM college_b_sj;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET NA = 1;
    
    OPEN get_namecursorB;
		 get_namecursorB: LOOP
			 FETCH get_namecursorB INTO get_namelistB;
             IF NA = 1 THEN
				LEAVE get_namecursorB;
			 END IF;
			 SET get_nameB = CONCAT(get_namelistB,";",get_nameB);
         END LOOP;
	CLOSE get_namecursorB;
END$$

DELIMITER ;

SET @NameB = "";
CALL get_name_collegeB (@NameB);
SELECT @NameB `Names of College B Students`;


/*
16.	Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
Note: Approximate percentages are considered for career choices.
*/
SELECT COUNT(*) FROM college_a_hs;   -- 1157  (Higher Studies)  19.6635%
SELECT COUNT(*) FROM college_a_se;   --  724  (Self Employed)   12.3046%
SELECT COUNT(*) FROM college_a_sj;   -- 4003  (Service Jobs)    68.0320%

SELECT 1157 + 724 + 4003;			 -- 5884  (Total Students)

SELECT COUNT(*) FROM college_b_hs;   --  119  (Higher Studies)   8.8092%
SELECT COUNT(*) FROM college_b_se;   --  201  (Self Employed)    8.8977%
SELECT COUNT(*) FROM college_b_sj;   -- 1859  (Service Jobs)    82.2931%
                                    
SELECT 119+201+1859;                 -- 2179  (Total Students)


SELECT 'Higher Studies', 
(SELECT COUNT(*) FROM college_a_hs)/(
					  (SELECT COUNT(*) FROM college_a_hs) 
					+ (SELECT COUNT(*) FROM college_a_se) 
                    + (SELECT COUNT(*) FROM college_a_sj))*100 
                    'College A Percentage',
(SELECT COUNT(*) FROM college_b_hs)/(
					  (SELECT COUNT(*) FROM college_b_hs) 
					+ (SELECT COUNT(*) FROM college_b_se) 
                    + (SELECT COUNT(*) FROM college_b_sj))*100 
                    'College B Percentage'
UNION

SELECT 'Self Employed', 
(SELECT COUNT(*) FROM college_a_se)/(
					  (SELECT COUNT(*) FROM college_a_hs) 
					+ (SELECT COUNT(*) FROM college_a_se) 
                    + (SELECT COUNT(*) FROM college_a_sj))*100 
                    'College A Percentage',
(SELECT COUNT(*) FROM college_b_se)/(
					  (SELECT COUNT(*) FROM college_b_hs) 
					+ (SELECT COUNT(*) FROM college_b_se) 
                    + (SELECT COUNT(*) FROM college_b_sj))*100 
                    'College B Percentage'
UNION

SELECT 'Service Job', 
(SELECT COUNT(*) FROM college_a_sj)/(
					  (SELECT COUNT(*) FROM college_a_hs) 
					+ (SELECT COUNT(*) FROM college_a_se) 
                    + (SELECT COUNT(*) FROM college_a_sj))*100 
                    'College A Percentage',
(SELECT COUNT(*) FROM college_b_sj)/(
					  (SELECT COUNT(*) FROM college_b_hs) 
					+ (SELECT COUNT(*) FROM college_b_se) 
                    + (SELECT COUNT(*) FROM college_b_sj))*100 
                    'College B Percentage';