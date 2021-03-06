USE [AutoFill]
GO
/****** Object:  StoredProcedure [dbo].[exp_tx_sp_autofill]    Script Date: 8/9/2018 11:57:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\Daria\AppData\Local\Temp\~vs958D.sql
-- =============================================
-- Author:		Matthew Morse, Daria Mozolina
-- Create date: 6/15/2016
-- Description:	This stored procedure prov*es top 50 autofill results for the search textbox
-- =============================================
CREATE PROCEDURE [dbo].[exp_tx_sp_autofill]
@param2 varchar(60), @param3 varchar(60), @param4 varchar(60), @param5 varchar(60), @param1 varchar(60), @param6 varchar(50), @param7 varchar(60), @param8 varchar(60), @param9 varchar(60), @param10 varchar(60), @param12 varchar(60), @param13 varchar(60), @param14 varchar(60), @param15 varchar(60), @param11 varchar(60), @param16 varchar(50), @param17 varchar(60), @param18 varchar(60), @param19 varchar(60), @param20 varchar(60), @number_of_levels int
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
	DECLARE @search11 varchar(60) = ltrim(rtrim(@param11))
	DECLARE @search12 varchar(60) = ltrim(rtrim(@param12))
	DECLARE @search13 varchar(60) = ltrim(rtrim(@param13))
	DECLARE @search14 varchar(60) = ltrim(rtrim(@param14))
	DECLARE @search15 varchar(60) = ltrim(rtrim(@param15))
	DECLARE @search16 varchar(60) = ltrim(rtrim(@param16))
	DECLARE @search17 varchar(60) = ltrim(rtrim(@param17))
	DECLARE @search18 varchar(60) = ltrim(rtrim(@param18))
	DECLARE @search19 varchar(60) = ltrim(rtrim(@param19))
	DECLARE @search20 varchar(60) = ltrim(rtrim(@param20))

DECLARE @search varchar(60) =ltrim(rtrim(@param1))
  DECLARE @all_terms varchar(500) =null
 declare @input varchar(500) =ltrim(rtrim(@search1+' '+@search2+' '+@search3+' '+@search4+' '+@search5
 +' '+@search6+' '+@search7+' '+@search8+' '+@search9+' '+@search10+' '+@search11+' '+@search12+' '+@search13+' '+@search14+' '+@search15+' '+@search16+' '+@search17+' '+@search18+' '+@search19+' '+@search20))
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
	SET @search11 = CASE
  WHEN len(@search11) <= 3 THEN N' %'+@search11+N' %'
		ELSE N'%'+@search11+N'%'
	--	WHEN len(@search11) <= 2 THEN ' '+@search11+' '
		--ELSE @search11
		END
	SET @search12 = CASE
  WHEN len(@search12) <= 3 THEN N' %'+@search12+N' %'
		ELSE N'%'+@search12+N'%'
	--	WHEN len(@search12) <= 2 THEN ' '+@search12+' '
		--ELSE @search12
		END
	SET @search13 = CASE
  WHEN len(@search13) <= 3 THEN N' %'+@search13+N' %'
		ELSE N'%'+@search13+N'%'
	--	WHEN len(@search13) <= 2 THEN ' '+@search13+' '
		--ELSE @search13
		END
	SET @search14 = CASE
  WHEN len(@search14) <= 3 THEN N' %'+@search14+N' %'
		ELSE N'%'+@search14+N'%'
	--	WHEN len(@search14) <= 2 THEN ' '+@search14+' '
	--	ELSE @search14
		END
	SET @search15 = CASE
  WHEN len(@search15) <= 3 THEN N' %'+@search15+N' %'
		ELSE N'%'+@search15+N'%'
		--WHEN len(@search15) <= 2 THEN ' '+@search15+' '
	--	ELSE @search15
		END
    SET @search16 = CASE
  WHEN len(@search16) <= 3 THEN N' %'+@search16+N' %'
		ELSE N'%'+@search16+N'%'
	--	WHEN len(@search11) <= 2 THEN ' '+@search11+' '
		--ELSE @search11
		END
	SET @search17 = CASE
  WHEN len(@search17) <= 3 THEN N' %'+@search17+N' %'
		ELSE N'%'+@search17+N'%'
	--	WHEN len(@search12) <= 2 THEN ' '+@search12+' '
		--ELSE @search12
		END
	SET @search18 = CASE
  WHEN len(@search18) <= 3 THEN N' %'+@search18+N' %'
		ELSE N'%'+@search18+N'%'
	--	WHEN len(@search13) <= 2 THEN ' '+@search13+' '
		--ELSE @search13
		END
	SET @search19 = CASE
  WHEN len(@search19) <= 3 THEN N' %'+@search19+N' %'
		ELSE N'%'+@search19+N'%'
	--	WHEN len(@search14) <= 2 THEN ' '+@search14+' '
	--	ELSE @search14
		END
	SET @search20 = CASE
  WHEN len(@search20) <= 3 THEN N' %'+@search20+N' %'
		ELSE N'%'+@search20+N'%'
	--	WHEN len(@search14) <= 2 THEN ' '+@search14+' '
	--	ELSE @search14
		END
    

	If (@number_of_levels =0) begin
		Select distinct FINAL_TERM, length_FINAL_TERM, term_from from exp_db_autofill where  UPPER_TERM LIKE  @search16  AND UPPER_TERM LIKE  @search17 AND UPPER_TERM LIKE  @search18  AND UPPER_TERM LIKE  @search19 AND UPPER_TERM LIKE  @search20  
	End
	else
	If (@number_of_levels =1) begin

		select a.FINAL_TERM, a.length_FINAL_TERM, a.term_from from 
				(select PK from exp_db_autofill where UPPER_TERM LIKE  @search1  AND UPPER_TERM LIKE @search2  AND UPPER_TERM LIKE @search3 AND UPPER_TERM LIKE  @search4  AND UPPER_TERM LIKE  @search5 
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search16  AND UPPER_TERM LIKE  @search17 AND UPPER_TERM LIKE  @search18  AND UPPER_TERM LIKE  @search19 AND UPPER_TERM LIKE  @search20) v
			join exp_db_autofill a on v.PK = a.PK 
	End
	else
	If (@number_of_levels =2) begin

				select a.FINAL_TERM, a.length_FINAL_TERM, a.term_from from 
				(select PK from exp_db_autofill where UPPER_TERM LIKE  @search1  AND UPPER_TERM LIKE @search2  AND UPPER_TERM LIKE @search3 AND UPPER_TERM LIKE  @search4  AND UPPER_TERM LIKE  @search5 
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search6  AND UPPER_TERM LIKE  @search7  AND UPPER_TERM LIKE  @search8  AND UPPER_TERM LIKE  @search9 AND UPPER_TERM LIKE  @search10
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search16  AND UPPER_TERM LIKE  @search17 AND UPPER_TERM LIKE  @search18  AND UPPER_TERM LIKE  @search19 AND UPPER_TERM LIKE  @search20) v
			join exp_db_autofill a on v.PK = a.PK 
	End
	else
	If (@number_of_levels =3) begin

		select a.FINAL_TERM, a.length_FINAL_TERM, a.term_from from 
				(select PK from exp_db_autofill where UPPER_TERM LIKE  @search1  AND UPPER_TERM LIKE @search2  AND UPPER_TERM LIKE @search3 AND UPPER_TERM LIKE  @search4  AND UPPER_TERM LIKE  @search5 
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search6  AND UPPER_TERM LIKE  @search7  AND UPPER_TERM LIKE  @search8  AND UPPER_TERM LIKE  @search9 AND UPPER_TERM LIKE  @search10
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search11  AND UPPER_TERM LIKE  @search12 AND UPPER_TERM LIKE  @search13  AND UPPER_TERM LIKE  @search14 AND UPPER_TERM LIKE  @search15
				intersect
				select PK from exp_db_autofill where  UPPER_TERM LIKE  @search16  AND UPPER_TERM LIKE  @search17 AND UPPER_TERM LIKE  @search18  AND UPPER_TERM LIKE  @search19 AND UPPER_TERM LIKE  @search20) v
			join exp_db_autofill a on v.PK = a.PK 

	End

 end
