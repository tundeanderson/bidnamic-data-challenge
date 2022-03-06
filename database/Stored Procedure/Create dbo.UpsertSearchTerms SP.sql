USE BidnamicDataChallenge
GO

CREATE TYPE dbo.SearchTerm_TVP AS TABLE 
(
	[Date] DATETIME NOT NULL,
    AdGroupId BIGINT NOT NULL, 
    CampaignId BIGINT NOT NULL,
	Clicks INT NOT NULL,
	Cost DECIMAL(12,2) NOT NULL,
	ConversionValue DECIMAL(12,2) NOT NULL,
	Conversions INT NOT NULL,
	SearchTerm NVARCHAR(100) NOT NULL
)
GO

CREATE PROCEDURE dbo.UpsertSearchTerms
    @SearchTerms dbo.SearchTerm_TVP READONLY
AS
BEGIN
    SET NOCOUNT ON;

	MERGE dbo.SearchTerm AS t 
	USING (	SELECT	s.[Date],
					s.AdGroupId,
					s.CampaignId,
					s.Clicks,
					s.Cost,
					s.ConversionValue,
					s.Conversions,
					s.SearchTerm
			FROM @SearchTerms s
			INNER JOIN dbo.AdGroup a ON a.Id = s.AdGroupId
			INNER JOIN dbo.Campaign c ON c.Id = s.CampaignId) AS s
	ON (t.SearchTerm = s.SearchTerm AND t.[Date] = s.[Date] AND t.AdGroupId = s.AdGroupId AND t.CampaignId = s.CampaignId AND t.Cost = s.Cost)  
	WHEN MATCHED AND (t.Clicks != s.Clicks OR t.ConversionValue != s.ConversionValue OR t.Conversions != s.Conversions) THEN 
		UPDATE SET t.Clicks = s.Clicks, t.ConversionValue = s.ConversionValue, t.Conversions = s.Conversions
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Date], AdGroupId, CampaignId, Clicks, Cost, ConversionValue, Conversions, SearchTerm) 
		VALUES (s.[Date], s.AdGroupId, s.CampaignId, s.Clicks, s.Cost, s.ConversionValue, s.Conversions, s.SearchTerm);
END
