/*
Data Quality tests
	1.The data needs to be 100 records of Youtube channels(row count test)
	2.The data needs 4 fields (column count test)
	3.The channel name column must be string format,and the other columns must be numerical data types(data type check)
	4.The record must be  unique in the dataset (duplicate count check)
	
Row_count-100
column_count=4
 

Data_Types
	channel_name=VARCHAR
	subscribers=INTEGER
	views=INTEGER
	videos-INTEGER

Duplicate_counts=0
*/

--1. Row _count_test
SELECT 
	count(*) AS Total_rows
FROM 
	view_uk_youtube_channels



--2. Column count check
SELECT 
	COUNT(*) AS column_count
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME='view_uk_youtube_channels'


--3. Data Types
SELECT 
	COLUMN_NAME,
	DATA_TYPE
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME='view_uk_youtube_channels'



--4.DUPLICATE RECORDS CHECK
SELECT 
	Channel_name,
	COUNT(*) AS Duplicate_count
FROM 
	view_uk_youtube_channels
GROUP BY 
	Channel_name
Having COUNT(*)>1
