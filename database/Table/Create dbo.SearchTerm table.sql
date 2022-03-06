USE [BidnamicDataChallenge]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SearchTerm](
	Id INT IDENTITY(1,1) NOT NULL,
	[Date] DATE NOT NULL,
	AdGroupId BIGINT NOT NULL,
	CampaignId BIGINT NOT NULL,
	Clicks INT NOT NULL,
	Cost DECIMAL(12,2) NOT NULL,
	ConversionValue DECIMAL(12,2) NOT NULL,
	Conversions INT NOT NULL,
	SearchTerm NVARCHAR(100) NOT NULL
)
GO

ALTER TABLE [dbo].[SearchTerm] ADD CONSTRAINT [PK_SearchTerm] PRIMARY KEY CLUSTERED ([Id] ASC)
GO

ALTER TABLE [dbo].[SearchTerm] ADD CONSTRAINT [FK_SearchTerm_AdGroup] FOREIGN KEY ([AdGroupId]) REFERENCES [dbo].[AdGroup] ([Id])
GO

ALTER TABLE [dbo].[SearchTerm] ADD CONSTRAINT [FK_SearchTerm_Campaign] FOREIGN KEY ([CampaignId]) REFERENCES [dbo].[Campaign] ([Id])
GO