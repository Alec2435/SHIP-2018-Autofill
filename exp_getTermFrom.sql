USE [AutoFill]
GO
/****** Object:  StoredProcedure [dbo].[exp_getTermFrom]    Script Date: 8/9/2018 11:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[exp_getTermFrom] 
	-- Add the parameters for the stored procedure here
	@finalTerm text 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT term_from FROM exp_db_autofill WHERE FINAL_TERM LIKE @finalTerm

END
