/*
 1 .Define the variables
 2. Create a CTE that rounds theaverage views per video
 3. Select the columns that are required for the analysis
 4. Filter the results by the YouTube channels with the highest subscriber bases
 5. Order by net_profit(from highest to lowest)
 */



 --1. 
 DECLARE @conversionRate FLOAT=0.02;
 DECLARE @productcost MONEY=5.0;
 DECLARE @campaignCost MONEY=50000.0;


 --2.
 WITH ChannelData AS(
	SELECT
		Channel_name,
		views,
		videos,
		ROUND((CAST(views as FLOAT)/videos), -4) AS rounded_avg_view_per_video,
		(views/videos)  AS original_avg_views_per_video
		FROM
			Youtube_data.dbo.view_uk_youtube_channels
		)
		
		
--3. 
	SELECT 
		Channel_name,
		rounded_avg_view_per_video,
		(rounded_avg_view_per_video * @conversionRate) AS potential_units_sold_per_video,
		(rounded_avg_view_per_video * @conversionRate * @productcost) As potential_revenue_per_video,
		(rounded_avg_view_per_video * @conversionRate * @productcost) - @campaignCost AS net_profit

	FROM 
		ChannelData

-- 4. 
	WHERE Channel_name IN ('NoCopyrightSounds' , 'DanTDM'  , 'Dan Rhodes ') 

--5.
   ORDER BY
	net_profit DESC
