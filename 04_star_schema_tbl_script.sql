-- SELECT TOP 3 * FROM dbo.payment
-- SELECT TOP 3 * FROM dbo.rider
-- SELECT TOP 3 * FROM dbo.station
-- SELECT TOP 3 * FROM dbo.trip


CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION     = 'fact_payment_1',
    DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT payment_id
        ,cast(replace(substring(date,1,10),'-','') as int) as date_key
		,cast(substring(date,1,10) as date) as date
		,amount
		,account_number
FROM dbo.payment
GO

-- select count(*) from dbo.fact_payment
-- drop external table dbo.fact_payment

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION     = 'dim_station',
    DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT station_id
        ,station_name
        ,latitude
        ,longitude
FROM dbo.station
GO

-- select count(*) from dbo.dim_station
-- drop external table dbo.dim_station


CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION     = 'dim_rider_2',
    DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT rider_id
		,first_name
		,last_name
		,address
		,birthday
		,member
FROM dbo.rider
GO

-- select count(*) from dbo.dim_rider
-- drop external table dbo.dim_rider


CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION     = 'fact_trip_3',
    DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT a.trip_id
		,a.rideable_type
		,a.member_id
		,a.started_at
		,a.ended_at
		,a.start_station_id
		,a.end_station_id
		,cast(replace(substring(cast(a.started_at as varchar),1,10),'-','') as int) as date_key
        ,cast(substring(cast(a.started_at as varchar),12,2) as int) as hour
        ,datediff(minute,a.started_at,ended_at) as trip_length_min
        ,datediff(year,r.birthday,t.started_at) - (case when dateadd(year,datediff(year,r.birthday,t.started_at),r.birthday) > a.started_at then 1 else 0 end) as age_at_trip 
FROM dbo.trip t
LEFT JOIN dbo.rider r ON t.member_id = r.rider_id
GO

-- select count(*) from dbo.fact_trip
-- drop external table dbo.fact_trip

CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION     = 'dim_date_3',
    DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT date_key
		,cast(date as date) as date
        ,year
		,month_num
		,month_name
		,week_num
		,day_num_of_year
		,day_num_of_month
        ,day_num_of_week
		,day_name
        ,quarter
        ,case when day_name in ('Saturday','Sunday') then 1 else 0 end as is_weekend
FROM dbo.datesv3
GO

-- select count(*) from dbo.dim_date
-- drop external table dbo.dim_date

-- select top 3 * From dbo.fact_payment
-- select top 3 * from dbo.dim_station
-- select top 3 * from dbo.dim_rider
-- select top 3 * from dbo.fact_trip
-- select top 3 * from dim_date




