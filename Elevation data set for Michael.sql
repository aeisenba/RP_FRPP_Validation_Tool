/****** Script for SelectTopNRows command from SSMS  ******/

DROP TABLE IF EXISTS #tmp1
SELECT [OBJECTID]
      ,[Source]
      ,[Unnamed__0]
      ,[address]
      ,[AddNum]
      ,[AddNumFrom]
      ,[AddNumTo]
      ,[Addr_type]
      ,[City]
      ,[Country]
      ,[DisplayX]
      ,[DisplayY]
      ,[Distance]
      ,[LangCode]
      ,[Loc_name]
      ,[Match_addr]
      ,[Postal]
      ,[Rank]
      ,[Region]
      ,[RegionAbbr]
      ,[ResultID]
      ,[Score]
      ,[Side]
      ,[StAddr]
      ,[StDir]
      ,[_StName__]
      ,[StPreDir]
      ,[StPreType]
      ,[StType]
      ,[Status]
      ,[X]
      ,[Xmax]
      ,[Xmin]
      ,[Y]
      ,[Ymax]
      ,[Ymin]
      ,[location_x]
      ,[location_y]
      ,[score2]
	  into #tmp1
  FROM [OGPD2D].[dbo].[RP_FRPP_geocoded_SF_API_01102020]
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608163'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608163'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608160'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608160'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608162'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608162'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0100500011'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_100500011'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608165'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608165'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608159'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608159'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608164'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608164'
update #tmp1 set OBJECTID = 'INTERIOR_NATIONAL PARK SERVICE_2696'		where [OBJECTID] = 'INTERIOR_NATIONAL PARK SERVICE_00002696'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0120300015'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_120300015'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_60608167'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_0060608167'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0100500010'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_100500010'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0100500013'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_100500013'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0120300014'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_120300014'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0100500012'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_100500012'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0100500009'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_100500009'
update #tmp1 set OBJECTID = 'LABOR_DEPARTMENT OF LABOR_0120300014'		where [OBJECTID] = 'LABOR_DEPARTMENT OF LABOR_120300014'

--SELECT count(*) FROM [OGPD2D].[dbo].[RP_FRPP_Salesforce_daily] 
--  where LegalInterest__c = 'owned' 
--  and CountryName__c in ('American Samoa','Guam','Northern Mariana Is','Puerto Rico','U.S. Minor Outlying Isl','United States','Virgin Islands')
--  and [Asset_Type__c] in ('building','structure')
----703680

--SELECT  124175 as [good:]
--	, 3775 as [badCorps:]
--	,478053
--	,97677

--SELECT 124175 + 3775 + 478053 + 97677= 703680


drop table if exists #tmp2
SELECT --124175
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,NULL as Generated_X
,NULL as Generated_Y
,Latitude__c	as Final_Latitude__c	
,Longitude__c	as Final_Longitude__c
,[Condition] = 'Good, keep'
into #tmp2
FROM [OGPD2D].[dbo].[RP_FRPP_Salesforce_daily]
where DATEADD(SECOND, CAST(LastModifiedDate as BIGINT)/1000 ,'1970/1/1') > '2020/1/4'
and Latitude__c is not null and Latitude__c !=  '0.0' 
  and LegalInterest__c = 'owned' 
  and CountryName__c in ('American Samoa','Guam','Northern Mariana Is','Puerto Rico','U.S. Minor Outlying Isl','United States','Virgin Islands')
  and [Asset_Type__c] in ('building','structure')

UNION ALL 

SELECT --3775
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,NULL as Generated_X
,NULL as Generated_Y
,Latitude__c	as Final_Latitude__c	
,Longitude__c	as Final_Longitude__c
,[Condition] = 'Bad Corps Data, run api geocode'
FROM [OGPD2D].[dbo].[RP_FRPP_Salesforce_daily]
where DATEADD(SECOND, CAST(LastModifiedDate as BIGINT)/1000 ,'1970/1/1') > '2020/1/4'
and Latitude__c =  '0.0'
  and LegalInterest__c = 'owned' 
  and CountryName__c in ('American Samoa','Guam','Northern Mariana Is','Puerto Rico','U.S. Minor Outlying Isl','United States','Virgin Islands')
  and [Asset_Type__c] in ('building','structure')

UNION ALL 

SELECT --478053
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,[X] as Generated_X
,[Y] as Generated_Y
,case when (Latitude__c =  '0.0' and Longitude__c = '0.0') or (Latitude__c =  '0.0' and Longitude__c = '99.999899999999997') or Latitude__c is null  then [Y] else Latitude__c	   END 	as Final_Latitude__c	
,case when (Latitude__c =  '0.0' and Longitude__c = '0.0') or (Latitude__c =  '0.0' and Longitude__c = '99.999899999999997') or Longitude__c is null then [X] else Longitude__c   END 	as Final_Longitude__c
,[Condition] = 'Good data, although Territories did not run on api geocode'
  FROM [OGPD2D].[dbo].[RP_FRPP_Salesforce_daily]
  LEFT JOIN #tmp1 b
on concat([ReportingAgency__c], '_' ,[ReportingBureau__c], '_' ,[RealPropertyUniqueId__c])  = b.OBJECTID 
  where DATEADD(SECOND, CAST(LastModifiedDate as BIGINT)/1000 ,'1970/1/1') <= '2020/1/4'
  and LegalInterest__c = 'owned' 
  and CountryName__c in ('American Samoa','Guam','Northern Mariana Is','Puerto Rico','U.S. Minor Outlying Isl','United States','Virgin Islands')
  and [Asset_Type__c] in ('building','structure')
  and Latitude__c is null
  --and case when (Latitude__c =  '0.0' and Longitude__c = '0.0') or (Latitude__c =  '0.0' and Longitude__c = '99.999899999999997') or Longitude__c is null then [X] else Longitude__c   END is null

union all

SELECT --97677
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,[X] as Generated_X
,[Y] as Generated_Y
,case when (Latitude__c =  '0.0' and Longitude__c = '0.0') or (Latitude__c =  '0.0' and Longitude__c = '99.999899999999997') or Latitude__c is null  then [Y] else Latitude__c	   END 	as Final_Latitude__c	
,case when (Latitude__c =  '0.0' and Longitude__c = '0.0') or (Latitude__c =  '0.0' and Longitude__c = '99.999899999999997') or Longitude__c is null then [X] else Longitude__c   END 	as Final_Longitude__c
,[Condition] = 'Good data with errors like Tennessee power, run api geocode'
  FROM [OGPD2D].[dbo].[RP_FRPP_Salesforce_daily] a
LEFT JOIN #tmp1 b
on concat([ReportingAgency__c], '_' ,[ReportingBureau__c], '_' ,[RealPropertyUniqueId__c])  = b.OBJECTID 
  where DATEADD(SECOND, CAST(LastModifiedDate as BIGINT)/1000 ,'1970/1/1') <= '2020/1/4'
  and LegalInterest__c = 'owned' 
  and CountryName__c in ('American Samoa','Guam','Northern Mariana Is','Puerto Rico','U.S. Minor Outlying Isl','United States','Virgin Islands')
  and [Asset_Type__c] in ('building','structure')
  and Latitude__c is not null

--SELECT distinct COndition, count(*)  from #tmp2 group by condition

  --for kyle to run
SELECT --3775
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,Generated_X
,Generated_Y
,Final_Latitude__c	
,Final_Longitude__c
--,[Condition]
--into RP_Geocode_rerun_02102020
  FROM #tmp2
  where Condition like '%bad%'
-- to be joined with what Kyle returns
  SELECT --97677
 [Asset_ID__c]
,[CountryName__c]
,[StateName__c]
,[CityName__c]
,[ZipCode__c]
,[StreetAddress__c]
,Latitude__c
,Longitude__c
,Generated_X
,Generated_Y
,Final_Latitude__c	
,Final_Longitude__c
,[Condition]
  FROM #tmp2
  where Condition like '%good%' 
  --This is to show where the bad data no matter what is.
  and (Final_Latitude__c = 0 or Final_Latitude__c is null)
  and [CountryName__c] != 'united States'



--For Michael
SELECT --3775
 [Asset_ID__c]
,Final_Latitude__c	
,Final_Longitude__c
--,[Condition]
--into RP_Geocode_rerun_02102020
into #tmp3
  FROM #tmp2
  except 

   SELECT --97677
 [Asset_ID__c]
,Final_Latitude__c	
,Final_Longitude__c
--,[Condition]
  FROM #tmp2
  where Condition like '%good%' 
  --This is to show where the bad data no matter what is.
  and (Final_Latitude__c = 0 or Final_Latitude__c is null)
  and [CountryName__c] != 'united States'

--  SELECT count(*) - 694876 FROM #tmp2
--703680
--For Michael, all US +Territories Owned buildings. Just need FRPP Asset ID and lat/lons 
SELECT --3775 
 [Asset_ID__c]
,Final_Latitude__c	
,Final_Longitude__c
--,[Condition]
--into RP_Geocode_rerun_02102020
FROM #tmp3
union all 
SELECT 
 [Asset_ID__c]
,y	
,x
FROM OGPD2D.[dbo].[RP_FRPP_FY19_Territories_Geocoded]
