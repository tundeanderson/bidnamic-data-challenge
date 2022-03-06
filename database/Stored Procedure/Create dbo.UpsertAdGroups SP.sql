USE BidnamicDataChallenge
GO

CREATE TYPE dbo.AdGroup_TVP AS TABLE 
(
    Id BIGINT NOT NULL, 
    CampaignId BIGINT NOT NULL,
	Alias NVARCHAR(255) NOT NULL,
	[Status] NVARCHAR(7) NOT NULL,
	Country NVARCHAR(5) NOT NULL,
	[Priority] NVARCHAR(6) NOT NULL
)
GO

CREATE PROCEDURE dbo.UpsertAdGroups 
    @AdGroups dbo.AdGroup_TVP READONLY
AS
BEGIN
    SET NOCOUNT ON;

	MERGE dbo.AdGroup AS t 
	USING (	SELECT	a.Id,
					a.CampaignId,
					a.Alias, 
					a.Country,
					a.[Priority],
					a.[Status]
			FROM @AdGroups a
			INNER JOIN dbo.Campaign c ON c.Id = a.CampaignId) AS s
	ON (t.Id = s.Id)  
	WHEN MATCHED AND (t.CampaignId != s.CampaignId OR t.Alias != s.Alias OR t.Country != s.Country OR t.[Priority] != s.[Priority] OR t.[Status] != s.[Status]) THEN 
		UPDATE SET t.CampaignId = s.CampaignId, t.Alias = s.Alias, t.Country = s.Country, t.[Priority] = s.[Priority], t.[Status] = s.[Status]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Id, CampaignId, Alias, Country, [Priority], [Status]) 
		VALUES (s.Id, s.CampaignId, s.Alias, s.Country, s.[Priority], s.[Status]);
END