USE [AutoFill]
GO
/****** Object:  StoredProcedure [dbo].[getMasterDB]    Script Date: 8/9/2018 11:55:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexander Velikanov
-- Create date: 7/17/18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[getMasterDB] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM snippetMasterDB;

    -- Insert statements for procedure here
END
