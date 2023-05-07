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

CREATE EXTERNAL TABLE dbo.rider (
	[rider_id] int,
	[first_name] nvarchar(50),
	[last_name] nvarchar(50),
	[address] nvarchar(100),
	[birthday] nvarchar(50),
	[start_date] nvarchar(50),
	[end_date] nvarchar(50),
	[member] bit
	)
	WITH (
	LOCATION = 'publicrider.csv',
	DATA_SOURCE = [alegi33deproject_alegi33adlsg2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.rider
GO

-- drop external table dbo.rider
