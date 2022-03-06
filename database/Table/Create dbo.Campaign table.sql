USE [BidnamicDataChallenge]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Campaign](
	[Id] BIGINT NOT NULL,
	[StructureValue] NVARCHAR(20) NOT NULL,
	[Status] NVARCHAR(7) NOT NULL
)
GO

ALTER TABLE [dbo].[Campaign] ADD CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED ([Id] ASC)
GO

ALTER TABLE [dbo].[Campaign] ADD CONSTRAINT [CK_Campaign_Status] CHECK([Status] IN ('ENABLED', 'REMOVED'))
GO
