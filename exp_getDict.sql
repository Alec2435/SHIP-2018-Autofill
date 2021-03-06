USE [AutoFill]
GO
/****** Object:  StoredProcedure [dbo].[exp_getDict]    Script Date: 8/9/2018 11:58:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexander Velikanov
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[exp_getDict] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select  stuff(list,1,1,'')
	from    (
			select  ' ' + cast(UPPER_TERM as varchar(max)) as [text()]
			from    exp_db_autofill
			for     xml path('')
			) as Sub(list)
END
