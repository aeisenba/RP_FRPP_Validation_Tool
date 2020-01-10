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

DROP TABLE IF EXISTS #tmp2
SELECT [OBJECTID]
      ,[Source]
      ,[Unnamed__0]
	  ,ReportingAgency__c
	  ,ReportingBureau__c
	  ,RealPropertyUniqueId__c
	  ,StateName__c
	  ,CityName__c
	  ,StreetAddress__c
	  ,ZipCode__c
	  ,CountyName__c
	  ,Latitude__c
	  ,Longitude__c
      ,[Match_addr]
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
	  into #tmp2
  FROM #tmp1 a
  LEFT JOIN OGPD2D.[dbo].[RP_FRPP_Salesforce_daily] b
  on a.OBJECTID = concat([ReportingAgency__c], '_' ,[ReportingBureau__c], '_' ,[RealPropertyUniqueId__c]) 
 
--SELECT COUNT(*) FROM #tmp2
--SELECT * FROM #tmp2 where StreetAddress__c is null
drop table if exists #tmp3
SELECT ReportingAgency__c,ReportingBureau__c,RealPropertyUniqueId__c, Loc_name, StateName__c, CityName__c,StreetAddress__c,ZipCode__c,CountyName__c,Latitude__c,Longitude__c, Match_addr 
into #tmp3
FROM #tmp2 where Loc_name like 'StreetName' and PATINDEX('%[0-9]%', StreetAddress__c) = 0
union all
SELECT 	ReportingAgency__c,ReportingBureau__c,RealPropertyUniqueId__c, Loc_name, StateName__c, CityName__c,StreetAddress__c,ZipCode__c,CountyName__c,Latitude__c,Longitude__c, Match_addr  FROM #tmp2 where Loc_name like 'Postal' and PATINDEX('%[0-9]%', StreetAddress__c) = 0
union all  
SELECT ReportingAgency__c,ReportingBureau__c,RealPropertyUniqueId__c, Loc_name, StateName__c, CityName__c,StreetAddress__c,ZipCode__c,CountyName__c,Latitude__c,Longitude__c, Match_addr  FROM #tmp2 where Loc_name is NULL 
union all
SELECT ReportingAgency__c,ReportingBureau__c,RealPropertyUniqueId__c, Loc_name, StateName__c, CityName__c,StreetAddress__c,ZipCode__c,CountyName__c,Latitude__c,Longitude__c, Match_addr  FROM #tmp2 where Loc_name like 'AdminPlaces'


/* Create two tabs in Excel file */
--tab 1
SELECT case when reportingAgency__C = 'INDEPENDENT GOVERNMENT OFFICES' then ReportingBureau__c else reportingAgency__C end as reportingAgency__C, count(*) as counter from #tmp3 
group by case when reportingAgency__C = 'INDEPENDENT GOVERNMENT OFFICES' then ReportingBureau__c else reportingAgency__C end
order by count(*) desc

--tab 2
SELECT case when reportingAgency__C = 'INDEPENDENT GOVERNMENT OFFICES' then ReportingBureau__c else ReportingAgency__C end as ReportingAgency__C
,ReportingBureau__c,RealPropertyUniqueId__c, StateName__c, CityName__c,StreetAddress__c,ZipCode__c,CountyName__c,Latitude__c,Longitude__c, Loc_name, Match_addr  
from #tmp3 order by ReportingAgency__C, Loc_name, StateName__c, CityName__c,StreetAddress__c

