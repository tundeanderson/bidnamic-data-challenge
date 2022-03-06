USE [master]
GO
CREATE LOGIN [bidnamic_service] WITH PASSWORD=N'UYSxNnu87caL579X', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BidnamicDataChallenge]
GO
CREATE USER [bidnamic_service] FOR LOGIN [bidnamic_service]
GO
USE [BidnamicDataChallenge]
GO
ALTER ROLE [db_datareader] ADD MEMBER [bidnamic_service]
GO
USE [BidnamicDataChallenge]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [bidnamic_service]
GO
GRANT EXECUTE ON [dbo].[UpsertAdGroups] TO [bidnamic_service]
GO
GRANT EXECUTE ON [dbo].[UpsertCampaigns] TO [bidnamic_service]
GO
GRANT EXECUTE ON [dbo].[UpsertSearchTerms] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT EXECUTE ON [dbo].[UpsertAdGroups] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT EXECUTE ON [dbo].[UpsertCampaigns] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT EXECUTE ON [dbo].[UpsertSearchTerms] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT CONTROL ON TYPE::[dbo].[SearchTerm_TVP] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT CONTROL ON TYPE::[dbo].[Campaign_TVP] TO [bidnamic_service]
GO
use [BidnamicDataChallenge]
GO
GRANT CONTROL ON TYPE::[dbo].[AdGroup_TVP] TO [bidnamic_service]
GO