IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'alegi33deproject_alegi33adlsg2_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [alegi33deproject_alegi33adlsg2_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://alegi33deproject@alegi33adlsg2.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.datesv3 (
	[date_key] int,
	[date] nvarchar(50),
	[year] int,
	[month_num] int,
	[month_name] nvarchar(50),
	[week_num] bigint,
	[day_num_of_year] int,
	[day_num_of_month] int,
	[day_num_of_week] int,
	[day_name] nvarchar(50),
	[quarter] int
	)
	WITH (
	LOCATION = 'dimdates_v3.csv',
	DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.datesv3
GO

-- drop external table dbo.datesv3