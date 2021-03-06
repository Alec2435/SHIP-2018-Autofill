USE [AutoFill]
GO
/****** Object:  StoredProcedure [dbo].[exp_sp_autofill]    Script Date: 8/9/2018 11:58:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\Daria\AppData\Local\Temp\~vs958D.sql
-- =============================================
-- Author:		Matthew Morse, Daria Mozolina
-- Create date: 6/15/2016
-- Description:	This stored procedure provides top 50 autofill results for the search textbox
-- =============================================
CREATE PROCEDURE [dbo].[exp_sp_autofill]
@param2 varchar(60), @param3 varchar(60), @param4 varchar(60), @param5 varchar(60), @param1 varchar(60), @param6 varchar(50), @param7 varchar(60), @param8 varchar(60), @param9 varchar(60), @param10 varchar(60)
WITH EXEC AS CALLER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

	DECLARE @search1 varchar(60) = ltrim(rtrim(@param1))
	DECLARE @search2 varchar(60) = ltrim(rtrim(@param2))
	DECLARE @search3 varchar(60) = ltrim(rtrim(@param3))
	DECLARE @search4 varchar(60) = ltrim(rtrim(@param4))
	DECLARE @search5 varchar(60) = ltrim(rtrim(@param5))
  DECLARE @search6 varchar(60) = ltrim(rtrim(@param6))
  DECLARE @search7 varchar(60) = ltrim(rtrim(@param7))
  DECLARE @search8 varchar(60) = ltrim(rtrim(@param8))
  DECLARE @search9 varchar(60) = ltrim(rtrim(@param9))
  DECLARE @search10 varchar(60) = ltrim(rtrim(@param10))

DECLARE @search varchar(60) =ltrim(rtrim(@param1))
  DECLARE @all_terms varchar(500) =null
 declare @input varchar(500) =ltrim(rtrim(@search1+' '+@search2+' '+@search3+' '+@search4+' '+@search5
 +' '+@search6+' '+@search7+' '+@search8+' '+@search9+' '+@search10))
 declare @reversed varchar(600) =reverse(@input)

set @search =reverse(left(@reversed,charindex(' ',@reversed)))

set @all_terms =substring(@input,1,len(@input)-len(@search))


SET @search1 = CASE
  WHEN len(@search1) <= 3 THEN N' %'+@search1+N' %'
		ELSE N'%'+@search1+N'%'
	--	WHEN len(@search1) <= 2 THEN ' '+@search1+' '
		--ELSE @search1
		END
	SET @search2 = CASE
  WHEN len(@search2) <= 3 THEN N' %'+@search2+N' %'
		ELSE N'%'+@search2+N'%'
	--	WHEN len(@search2) <= 2 THEN ' '+@search2+' '
		--ELSE @search2
		END
	SET @search3 = CASE
  WHEN len(@search3) <= 3 THEN N' %'+@search3+N' %'
		ELSE N'%'+@search3+N'%'
	--	WHEN len(@search3) <= 2 THEN ' '+@search3+' '
		--ELSE @search3
		END
	SET @search4 = CASE
  WHEN len(@search4) <= 3 THEN N' %'+@search4+N' %'
		ELSE N'%'+@search4+N'%'
	--	WHEN len(@search4) <= 2 THEN ' '+@search4+' '
	--	ELSE @search4
		END
	SET @search5 = CASE
  WHEN len(@search5) <= 3 THEN N' %'+@search5+N' %'
		ELSE N'%'+@search5+N'%'
		--WHEN len(@search5) <= 2 THEN ' '+@search5+' '
	--	ELSE @search5
		END
    SET @search6 = CASE
  WHEN len(@search6) <= 3 THEN N' %'+@search6+N' %'
		ELSE N'%'+@search6+N'%'
	--	WHEN len(@search1) <= 2 THEN ' '+@search1+' '
		--ELSE @search1
		END
	SET @search7 = CASE
  WHEN len(@search7) <= 3 THEN N' %'+@search7+N' %'
		ELSE N'%'+@search7+N'%'
	--	WHEN len(@search2) <= 2 THEN ' '+@search2+' '
		--ELSE @search2
		END
	SET @search8 = CASE
  WHEN len(@search8) <= 3 THEN N' %'+@search8+N' %'
		ELSE N'%'+@search8+N'%'
	--	WHEN len(@search3) <= 2 THEN ' '+@search3+' '
		--ELSE @search3
		END
	SET @search9 = CASE
  WHEN len(@search9) <= 3 THEN N' %'+@search9+N' %'
		ELSE N'%'+@search9+N'%'
	--	WHEN len(@search4) <= 2 THEN ' '+@search4+' '
	--	ELSE @search4
		END
	SET @search10 = CASE
  WHEN len(@search10) <= 3 THEN N' %'+@search10+N' %'
		ELSE N'%'+@search10+N'%'
		--WHEN len(@search5) <= 2 THEN ' '+@search5+' '
	--	ELSE @search5
		END
    
	if exists (

	SELECT DISTINCT TOP 1 FINAL_TERM, length_FINAL_TERM, term_from
		FROM exp_db_autofill
		WHERE UPPER_TERM LIKE  @search1  AND UPPER_TERM LIKE @search2  AND UPPER_TERM LIKE @search3  
			  AND UPPER_TERM LIKE  @search4  AND UPPER_TERM LIKE  @search5 
        AND UPPER_TERM LIKE  @search6  AND UPPER_TERM LIKE  @search7 
        AND UPPER_TERM LIKE  @search8  AND UPPER_TERM LIKE  @search9 
        AND UPPER_TERM LIKE  @search10 
		ORDER BY length_FINAL_TERM asc
   
    )
    begin
    
    SELECT DISTINCT TOP 50 FINAL_TERM, length_FINAL_TERM, term_from
		FROM exp_db_autofill 
		WHERE UPPER_TERM LIKE  @search1  AND UPPER_TERM LIKE @search2  AND UPPER_TERM LIKE @search3  
			  AND UPPER_TERM LIKE  @search4  AND UPPER_TERM LIKE  @search5 
        AND UPPER_TERM LIKE  @search6  AND UPPER_TERM LIKE  @search7 
        AND UPPER_TERM LIKE  @search8  AND UPPER_TERM LIKE  @search9 
        AND UPPER_TERM LIKE  @search10 
		ORDER BY length_FINAL_TERM asc
    end

 end
