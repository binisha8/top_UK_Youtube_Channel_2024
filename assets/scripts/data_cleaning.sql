/*
Data Cleaning steps
1. Removing unnecessary columns by only selecting the ones we need
2. Extract the YouTube channel names from the first columns
3. Rename the column names
*/

SELECT
NOMBRE,
subscribers,
views,
videos
FROM top_youtube_channels_2024;


--CHARINDEX
SELECT CHARINDEX('@', NOMBRE),NOMBRE FROM top_youtube_channels_2024


--SUBSTRING
CREATE VIEW view_uk_youtube_channels AS
SELECT 
	CAST(SUBSTRING(NOMBRE,1,CHARINDEX('@', NOMBRE) -1 ) AS VARCHAR(100)) AS Channel_name,
	subscribers,
	views,
	videos
FROM	
	top_youtube_channels_2024
