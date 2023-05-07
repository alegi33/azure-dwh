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

CREATE EXTERNAL TABLE dbo.trip (
	[trip_id] nvarchar(50),
	[rideable_type] nvarchar(50),
	[started_at] nvarchar(50),
	[ended_at] nvarchar(50),
	[start_station_id] nvarchar(50),
	[end_station_id] nvarchar(50),
	[member_id] int
	)
	WITH (
	LOCATION = 'publictrip.csv',
	DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.trip
GO

-- drop external table dbo.trip