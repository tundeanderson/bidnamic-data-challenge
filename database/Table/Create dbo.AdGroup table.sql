USE [BidnamicDataChallenge]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AdGroup](
	Id BIGINT NOT NULL,
	CampaignId BIGINT NOT NULL,
	Alias NVARCHAR(255) NOT NULL,
	Country NVARCHAR(5) NOT NULL,
	[Priority] NVARCHAR(6) NOT NULL,
	[Status] NVARCHAR(7) NOT NULL
)
GO

ALTER TABLE [dbo].[AdGroup] ADD CONSTRAINT [PK_AdGroup] PRIMARY KEY CLUSTERED ([Id] ASC)
GO

ALTER TABLE [dbo].[AdGroup] ADD CONSTRAINT [FK_AdGroup_Campaign] FOREIGN KEY ([CampaignId]) REFERENCES [dbo].[Campaign] ([Id])
GO

ALTER TABLE [dbo].[AdGroup] ADD CONSTRAINT [CK_AdGroup_Status] CHECK([Status] IN ('ENABLED', 'REMOVED'))
GO

ALTER TABLE [dbo].[AdGroup] ADD CONSTRAINT [CK_AdGroup_Priority] CHECK([Priority] IN ('LOW', 'MEDIUM', 'HIGH'))
GO
