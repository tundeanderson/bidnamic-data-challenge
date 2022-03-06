USE BidnamicDataChallenge
GO

CREATE TYPE dbo.Campaign_TVP AS TABLE 
(
    Id BIGINT NOT NULL, 
	StructureValue NVARCHAR(20) NOT NULL,
	[Status] NVARCHAR(7) NOT NULL
)
GO

CREATE PROCEDURE dbo.UpsertCampaigns
    @Campaigns dbo.Campaign_TVP READONLY
AS
BEGIN
    SET NOCOUNT ON;

	MERGE dbo.Campaign AS t 
	USING (	SELECT  Id, 
					StructureValue, 
					[Status]
			FROM @Campaigns) AS s
	ON (t.Id = s.Id)  
	WHEN MATCHED AND (t.StructureValue != s.StructureValue OR t.[Status] != s.[Status]) THEN 
		UPDATE SET t.StructureValue = s.StructureValue, t.[Status] = s.[Status]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, StructureValue, [Status]) 
		VALUES (s.Id, s.StructureValue, s.[Status]);

END