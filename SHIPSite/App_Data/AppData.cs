using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;

namespace SHIPAutofill
{
    public class AppData
    {
        public static DataSet GetData(string selectStatement)
        {
            SqlConnection cn = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cn.ConnectionString = @"Data Source=NEPTUNE\SQLEXPRESS;Integrated Security=False;User ID=aspuser;Password=test;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            try
            {
                cn.Open();
                cmd.CommandText = selectStatement;
                cmd.Connection = cn;
                cmd.CommandType = CommandType.Text;
                da.SelectCommand = cmd;
                da.Fill(ds);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("database connection error");
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            finally
            {
                cn.Dispose();
            }

            return ds;
        }

        /* stored procedure( stored proc"esproc"  with one Param) */
        public static DataSet GetDataSP(string spName, string Param)
        {

            SqlConnection cn = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cn.ConnectionString = @"Data Source=NEPTUNE\SQLEXPRESS;Integrated Security=False;User ID=aspuser;Password=test;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            try
            {
                cn.Open();
                cmd.CommandText = spName;

                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Param1", Param);

                da.SelectCommand = cmd;
                da.Fill(ds);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("database connection error");
                System.Diagnostics.Debug.WriteLine(ex.Message);

            }
            finally
            {
                cn.Dispose();
            }

            return ds;
        }


        public static DataSet GetTableDescription(string spName, string Param)
        {

            SqlConnection cn = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cn.ConnectionString = @"Data Source=NEPTUNE\SQLEXPRESS;Integrated Security=False;User ID=aspuser;Password=test;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            try
            {
                cn.Open();
                cmd.CommandText = spName;

                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Param1", Param);

                da.SelectCommand = cmd;
                da.Fill(ds);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex);
            }
            finally
            {
                cn.Dispose();
            }

            return ds;
        }

        /* Select with one or Multiple params  with use List<SqlParameter> */
        public static DataSet GetDataParamsSP(string spName, List<SqlParameter> Params)
        {
            SqlConnection cn = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            cn.ConnectionString = @"Data Source=NEPTUNE\SQLEXPRESS;Integrated Security=False;User ID=aspuser;Password=test;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

            try
            {
                cn.Open();
                cmd.CommandText = spName;

                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter p in Params)
                {

                    cmd.Parameters.AddWithValue(p.ParameterName, p.Value);

                    System.Diagnostics.Debug.Write("Parameters passed to command: " + p.Value + System.Environment.NewLine);

                }

                da.SelectCommand = cmd;
                da.Fill(ds);
            }
            catch (Exception ex)
            {
                // System.Diagnostics.Debug.Write(ex);

                System.Diagnostics.Debug.Write("The was an sql error: " + ex + System.Environment.NewLine);

            }
            finally
            {
                cn.Dispose();
            }

            return ds;
        }

        /*public static void InsertUpdateData(string SelectStatement)
		{
			SqlConnection cn = new SqlConnection();
			SqlCommand cmd = new SqlCommand();
			SqlDataAdapter da = new SqlDataAdapter();
			DataSet ds = new DataSet();
			cn.ConnectionString = @"Data Source=NEPTUNE\SQLEXPRESS;Integrated Security=False;User ID=aspuser;Password=test;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
			try
			{
				cn.Open();
				cmd.CommandText = SelectStatement;
				cmd.Connection = cn;
				cmd.CommandType = CommandType.Text;
				da.SelectCommand = cmd;
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				//throw ex;
				//LogFile.Write(ex.Message);
			}
			finally
			{
				cn.Dispose();
			}
		}*/

        /**
		 * Calls intersection stored procedure to perform AND of two tables
         * DEPRECATED
		 */
        /*private DataSet GetIntersectionSP(DataTable table1, DataTable table2) {
			/* Create new List parameters for each table
			List<SqlParameter> paramTables = new List<SqlParameter>();
			paramTables.Add(new SqlParameter("@table1", table1));
			paramTables.Add(new SqlParameter("@table2", table2));

			DataSet ds = new DataSet();

			/* Get the intersection of table1 and table2
			ds = AppData.GetDataParamsSP("master_sp_intersection", paramTables);

			return ds;
		}*/

        public static DataSet SearchLogicOld(string searchTerm, string dataSource, string request)
        {
            DataSet searchResults = new DataSet();

            // removes all single quotes from search term.
            searchTerm = searchTerm.Replace("'", "");

            // replaces "and" operators with whitespace.
            searchTerm = searchTerm.Replace(" and ", " ");
            searchTerm = searchTerm.Replace(" & ", " ");
            searchTerm = searchTerm.Replace(" & ", " ");

            int startIndex = -1;
            int endIndex = -1;
            int stringLength = searchTerm.Length;

            /* Search for all quoted strings */
            for (int i = 0; i < stringLength; i++)
            {
                if (searchTerm[i].Equals('\"'))
                {
                    if (startIndex == -1)
                    {
                        startIndex = i;
                    }
                    else if (endIndex == -1)
                    {
                        endIndex = i;
                    }
                    if (startIndex != -1 && endIndex != -1)
                    {
                        string newString = searchTerm.Substring(startIndex, (endIndex + 1 - startIndex));
                        newString = newString.Replace("\"", string.Empty);
                        newString = newString.Replace(" ", "_");
                        searchTerm = searchTerm.Remove(startIndex, (endIndex + 1 - startIndex));
                        searchTerm = searchTerm.Insert(startIndex, newString);
                        i = startIndex;
                        startIndex = -1;
                        endIndex = -1;
                        stringLength = searchTerm.Length;
                    }
                }
            }
            // in case string read has no end quotes, remove remaining quotes
            // then split into tokens on whitespace
            searchTerm = searchTerm.Replace("\"", "");
            searchTerm = searchTerm.Trim();

            List<string> tokensRaw = new List<string>();

            if (!searchTerm.Contains(">>"))
            {
                tokensRaw = searchTerm.Split(' ').ToList();
            }
            else
            {
                searchTerm.Replace(" >> ", " > ");
                tokensRaw = searchTerm.Split('>').ToList();
            }

            // remove all tokens after "#(X Hits)"
            for (int i = 0; i < tokensRaw.Count(); i++)
            {
                if (tokensRaw[i].Contains("#("))
                {
                    while (tokensRaw.Count() > i)
                        tokensRaw.RemoveAt(tokensRaw.Count() - 1);
                    break;
                }
            }

            string[] tokens = new HashSet<string>(tokensRaw).ToArray(); // removes duplicate tokens


            if (tokens.Length > 5) //
            {
                if (request == "search")
                {
                    // iterates through token list performing search stored procedure and adding results
                    // table from each search to searchResults
                    foreach (string t in tokens)
                    {
                        DataSet tResults = GetDataSP(dataSource + "_sp_search", t);
                        if (tResults.Tables[0].Rows.Count > 0)
                        {
                            DataTable tbl = tResults.Tables[0].Copy();
                            tbl.TableName = t;
                            searchResults.Tables.Add(tbl);
                        }
                    }

                    return AddLogic(searchResults, request);
                }
                else
                {
                    return searchResults;
                }
            }
            else
            {
                if (tokens.Length > 1)
                {
                    List<SqlParameter> sp = new List<SqlParameter>();

                    for (int count = 1; count < 6; count++)
                    {
                        if (count <= tokens.Length)
                        {
                            sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        }
                        else
                        {
                            sp.Add(new SqlParameter("@param" + count, ""));
                        }
                    }

                    searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);
                }
                else
                {
                    searchResults = GetDataSP("exp_sp_autofill_andtestten", tokens[0]);
                }
                return searchResults;
            }
        }

        public static DataSet SearchLogic(string searchTerm, string dataSource, string request)
        {
            DataSet searchResults = new DataSet();


            string[] tokens = getSearchTokens(searchTerm.Trim()); // get search tokens

            System.Diagnostics.Debug.Write("Number of tokens received from getSearchTokens: " + tokens.Length + System.Environment.NewLine);



            for (int count = 0; count < tokens.Length; count++)
            {

                System.Diagnostics.Debug.Write("Token " + count + ": a" + tokens[count] + "b" + System.Environment.NewLine);

            }

            // System.Diagnostics.Debug.Write("Tokens length is: " + tokens.Length + System.Environment.NewLine);

            if (tokens.Length < 6) //use current procedure
            {


                if (tokens.Length > 1)
                {
                    List<SqlParameter> sp = new List<SqlParameter>();

                    for (int count = 1; count < 6; count++)
                    {
                        if (count <= tokens.Length)
                        {
                            sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        }
                        else
                        {
                            sp.Add(new SqlParameter("@param" + count, ""));
                        }
                    }

                    searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);

                    System.Diagnostics.Debug.Write("We are searching between 2 and 5 terms using procedure " + dataSource + "_sp_" + request + "_andtest. Count is: " + tokens.Length + System.Environment.NewLine);
                }
                else
                {
                    searchResults = GetDataSP("exp_sp_autofill_andtestten", tokens[0]);

                    System.Diagnostics.Debug.Write("We are searching for one term using procedure " + dataSource + "_sp_" + request + System.Environment.NewLine);
                }

                //System.Diagnostics.Debug.Write("We are searching less than 6" + System.Environment.NewLine);

                return searchResults;


            }
            else if (tokens.Length <= 10) // if less or equal to 10 search terms

            {

                List<SqlParameter> sp = new List<SqlParameter>();

                for (int count = 1; count <= 10; count++)
                {
                    if (count <= tokens.Length)
                    {
                        sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        System.Diagnostics.Debug.Write(tokens[count - 1].ToString() + System.Environment.NewLine);
                    }
                    else
                    {
                        sp.Add(new SqlParameter("@param" + count, ""));
                    }



                }

                searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);

                System.Diagnostics.Debug.Write("We are searching less or equal to 10 using procedure " + "exp_sp_autofill_andtestten. Count is: " + tokens.Length + System.Environment.NewLine);

                return searchResults;


            }
            else  // if more than 10 search terms
            {

                List<SqlParameter> sp = new List<SqlParameter>();

                for (int count = 1; count <= 10; count++)  //only search up to 10 search terms
                {
                    if (count <= tokens.Length)
                    {
                        sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        System.Diagnostics.Debug.Write(tokens[count - 1].ToString() + System.Environment.NewLine);
                    }
                    else
                    {
                        sp.Add(new SqlParameter("@param" + count, ""));
                    }



                }

                searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);

                System.Diagnostics.Debug.Write("We are searching less or equal to 10 using procedure " + "exp_sp_autofill_andtestten. Count is: " + tokens.Length + System.Environment.NewLine);

                return searchResults;
            }


        }



        public static string[] getSearchTokens(string searchTerm)
        {

            string splitStr = String.Empty;
            // removes all single quotes from search term.
            searchTerm = searchTerm.Replace("'", "");

            // replaces "and" operators with whitespace.
            searchTerm = searchTerm.Replace(" and ", " ");
            searchTerm = searchTerm.Replace(" & ", " ");

            int startIndex = -1;
            int endIndex = -1;
            int stringLength = searchTerm.Length;

            /* Search for all quoted strings */
            for (int i = 0; i < stringLength; i++)
            {
                if (searchTerm[i].Equals('\"'))
                {
                    if (startIndex == -1)
                    {
                        startIndex = i;
                    }
                    else if (endIndex == -1)
                    {
                        endIndex = i;
                    }
                    if (startIndex != -1 && endIndex != -1)
                    {
                        string newString = searchTerm.Substring(startIndex, (endIndex + 1 - startIndex));
                        newString = newString.Replace("\"", string.Empty);
                        newString = newString.Replace(" ", "_");
                        searchTerm = searchTerm.Remove(startIndex, (endIndex + 1 - startIndex));
                        searchTerm = searchTerm.Insert(startIndex, newString);
                        i = startIndex;
                        startIndex = -1;
                        endIndex = -1;
                        stringLength = searchTerm.Length;
                    }
                }
            }
            // in case string read has no end quotes, remove remaining quotes
            // then split into tokens on whitespace
            searchTerm = searchTerm.Replace("\"", "");
            searchTerm = searchTerm.Replace(",", "");
            searchTerm = searchTerm.Trim();
            //List<string> tokensRaw = searchTerm.Split(' ').ToList();

            List<string> tokensRaw = new List<string>();

            if (!(searchTerm.Contains(">>") || searchTerm.Contains("&gt;")))
            {
                tokensRaw = searchTerm.Split(' ').ToList();

                splitStr = " ";
            }
            else if (searchTerm.Contains(">>"))
            {

                System.Diagnostics.Debug.Write("We are in the case where >> is present" + System.Environment.NewLine);
                searchTerm = searchTerm.Replace(" >> ", ">");
                System.Diagnostics.Debug.Write("Search Term is now: " + searchTerm + System.Environment.NewLine);
                tokensRaw = searchTerm.Split('>').ToList();
                splitStr = ">";
            }
            else if (searchTerm.Contains("&gt;"))
            {

                System.Diagnostics.Debug.Write("We are in the case where &gt; is present" + System.Environment.NewLine);


                searchTerm = searchTerm.Replace("&gt;", ">");
                searchTerm = searchTerm.Replace(" >> ", ">");
                System.Diagnostics.Debug.Write("Search Term is now: " + searchTerm + System.Environment.NewLine);
                System.Diagnostics.Debug.Write("Number of terms found is: " + searchTerm.Split('>').ToList().Count + System.Environment.NewLine);
                tokensRaw = searchTerm.Split('>').ToList();
                splitStr = "&gt;";

            }

            // remove all tokens after "#(X Hits)"

            if (splitStr.Equals(" ")) //case where split was done with empty space
            {
                for (int i = 0; i < tokensRaw.Count(); i++)
                {
                    if (tokensRaw[i].Contains("#("))
                    {
                        while (tokensRaw.Count() > i)
                            tokensRaw.RemoveAt(tokensRaw.Count() - 1);
                        break;
                    }

                    tokensRaw[i] = tokensRaw[i].Trim();
                }

            }
            else
            { //cases where split was done using either &gt; or >

                for (int i = 0; i < tokensRaw.Count(); i++)
                {
                    if (tokensRaw[i].Contains("#("))
                    {
                        tokensRaw[i] = tokensRaw[i].Substring(0, tokensRaw[i].IndexOf("#"));
                    }

                    tokensRaw[i] = tokensRaw[i].Trim();
                }

            }

            string[] tokens = new HashSet<string>(tokensRaw).ToArray();



            return tokens;


        }

        public static DataSet SearchLogicNew(string searchTerm, string dataSource, string request)
        {
            DataSet searchResults = new DataSet();

            // removes all single quotes from search term.
            searchTerm = searchTerm.Replace("'", "");

            // replaces "and" operators with whitespace.
            searchTerm = searchTerm.Replace(" and ", " ");
            searchTerm = searchTerm.Replace(" & ", " ");

            int startIndex = -1;
            int endIndex = -1;
            int stringLength = searchTerm.Length;

            /* Search for all quoted strings */
            for (int i = 0; i < stringLength; i++)
            {
                if (searchTerm[i].Equals('\"'))
                {
                    if (startIndex == -1)
                    {
                        startIndex = i;
                    }
                    else if (endIndex == -1)
                    {
                        endIndex = i;
                    }
                    if (startIndex != -1 && endIndex != -1)
                    {
                        string newString = searchTerm.Substring(startIndex, (endIndex + 1 - startIndex));
                        newString = newString.Replace("\"", string.Empty);
                        newString = newString.Replace(" ", "_");
                        searchTerm = searchTerm.Remove(startIndex, (endIndex + 1 - startIndex));
                        searchTerm = searchTerm.Insert(startIndex, newString);
                        i = startIndex;
                        startIndex = -1;
                        endIndex = -1;
                        stringLength = searchTerm.Length;
                    }
                }
            }
            // in case string read has no end quotes, remove remaining quotes
            // then split into tokens on whitespace
            searchTerm = searchTerm.Replace("\"", "");
            searchTerm = searchTerm.Trim();
            List<string> tokensRaw = searchTerm.Split(' ').ToList();

            // remove all tokens after "#(X Hits)"
            for (int i = 0; i < tokensRaw.Count(); i++)
            {
                if (tokensRaw[i].Contains("#("))
                {
                    while (tokensRaw.Count() > i)
                        tokensRaw.RemoveAt(tokensRaw.Count() - 1);
                    break;
                }
            }

            string[] tokens = new HashSet<string>(tokensRaw).ToArray(); // removes duplicate tokens


            System.Diagnostics.Debug.Write("Tokens length is: " + tokens.Length + System.Environment.NewLine);

            if (tokens.Length < 6) //use current procedure
            {


                if (tokens.Length > 1)
                {
                    List<SqlParameter> sp = new List<SqlParameter>();

                    for (int count = 1; count < 6; count++)
                    {
                        if (count <= tokens.Length)
                        {
                            sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        }
                        else
                        {
                            sp.Add(new SqlParameter("@param" + count, ""));
                        }
                    }

                    searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);

                    System.Diagnostics.Debug.Write("We are searching between 2 and 5 terms using procedure ..sp_andtest. Count is: " + tokens.Length + System.Environment.NewLine);
                }
                else
                {
                    searchResults = GetDataSP("exp_sp_autofill_andtestten", tokens[0]);

                    System.Diagnostics.Debug.Write("We are searching for one term using procedure ..sp_search" + System.Environment.NewLine);
                }

                //System.Diagnostics.Debug.Write("We are searching less than 6" + System.Environment.NewLine);

                return searchResults;


            }



            if ((tokens.Length >= 6) && (tokens.Length <= 10)) // if less or equal to 10 search terms

            {

                List<SqlParameter> sp = new List<SqlParameter>();

                for (int count = 1; count <= 10; count++)
                {
                    if (count <= tokens.Length)
                    {
                        sp.Add(new SqlParameter("@param" + count, tokens[count - 1]));
                        System.Diagnostics.Debug.Write(tokens[count - 1].ToString() + System.Environment.NewLine);
                    }
                    else
                    {
                        sp.Add(new SqlParameter("@param" + count, ""));
                    }
                }

                searchResults = GetDataParamsSP("exp_sp_autofill_andtestten", sp);

                System.Diagnostics.Debug.Write("We are searching less or equal to 10. Count is: " + tokens.Length + System.Environment.NewLine);

                return searchResults;


            }
            // if more than 10 search terms


            if (tokens.Length > 10)
            {

                foreach (string t in tokens)
                {
                    DataSet tResults = GetDataSP(dataSource + "_sp_search", t);
                    if (tResults.Tables[0].Rows.Count > 0)
                    {
                        DataTable tbl = tResults.Tables[0].Copy();
                        tbl.TableName = t;
                        searchResults.Tables.Add(tbl);
                    }
                }

                System.Diagnostics.Debug.Write("We are searching more than 10");

                return searchResults;
            }

            return searchResults;
        }



        /**
		 * Requires a DataSet of Tables for each token in the search phrase. Perform AND
		 * operation by calling GetIntersectionSP to repeatedly obtain the intersection
		 * of a pair of tables.
		 */
        private static DataSet AddLogic(DataSet tokenTables, string type)
        {
            int numTokens = tokenTables.Tables.Count;
            DataSet intersectionOfTokens = new DataSet();
            /* At least 2 Tables are needed */
            if (numTokens > 1)
            {
                /* Add the first token table to the intersection DataSet (which contains only one table) */
                intersectionOfTokens.Tables.Add(tokenTables.Tables[0].Copy());

                for (int currentTable = 1; currentTable < numTokens; currentTable++)
                {
                    List<SqlParameter> paramTables = new List<SqlParameter>();
                    paramTables.Add(new SqlParameter("@table1", intersectionOfTokens.Tables[0]));
                    paramTables.Add(new SqlParameter("@table2", tokenTables.Tables[currentTable]));

                    /* replace old intersection DataSet (of one data table) with the AND of the old intersection table and the current token Table */
                    if (type == "search")
                        intersectionOfTokens = GetDataParamsSP("master_sp_intersection", paramTables);
                    else if (type == "autofill")
                        intersectionOfTokens = GetDataParamsSP("master_sp_intersectAutofill", paramTables);
                    else
                        intersectionOfTokens = tokenTables;
                }
            }
            else
            {
                /* otherwise set returned DataSet to passed parameter */
                intersectionOfTokens = tokenTables;
            }
            return intersectionOfTokens;
        }


        public static string hightSearchTerms(string nodeStr, string searchStr)
        {
            // string searchTerm = txtSrchAutoFill.Text.Trim();
            string highlighTedText = string.Empty;
            string[] tokens = AppData.getSearchTokens(searchStr);
            highlighTedText = nodeStr;
            for (int i = 0; i < tokens.Length; i++)
            {
                highlighTedText = highLightSearchTerm(highlighTedText, tokens[i]);
            }

            return highlighTedText;
        }


        public static string highLightSearchTerm(string nodeStr, string searchTerm)
        {

            System.Diagnostics.Debug.Write("nodeStr is: " + nodeStr + System.Environment.NewLine);
            System.Diagnostics.Debug.Write("searchTerm is: " + searchTerm + System.Environment.NewLine);

            if (nodeStr.ToLower().Contains(searchTerm.ToLower()) || nodeStr.Equals(searchTerm))
            {
                string fstr, pstr, estr = "";
                string sValue = nodeStr.ToLower();
                int fstrlen = 0, pstrlen = 0, estrlen = 0;

                int index = sValue.IndexOf(searchTerm);
                int addedT = 0;
                int[] indexes = getIndexes(searchTerm, nodeStr, false).ToArray();
                System.Diagnostics.Debug.Write("For " + nodeStr + System.Environment.NewLine);

                try
                {
                    if (indexes.Length > 0)
                    {
                        for (int z = 0; z < indexes.Length; z++)
                        {

                            fstr = nodeStr.Substring(0, indexes[z] + addedT);
                            fstrlen = fstr.Length;
                            pstr = nodeStr.Substring(fstr.Length, searchTerm.Length);
                            pstrlen = pstr.Length;

                            if (searchTerm.Length < nodeStr.Length)
                            {
                                estr = nodeStr.Substring(fstr.Length + searchTerm.Length);
                            }
                            else
                            {

                                estr = "";

                            }
                            estrlen = estr.Length;

                            if ((searchTerm != "b") || ((!nodeStr.Contains("<b>")) && (searchTerm == "b")))
                            {
                                nodeStr = fstr + "<b>" + pstr + "</b>" + estr;
                            }

                            if (addedT + 7 <= nodeStr.Length)
                            {
                                addedT = addedT + 7;
                            }

                            System.Diagnostics.Debug.Write("Indexes found: " + indexes[z] + System.Environment.NewLine);
                            System.Diagnostics.Debug.Write("fstr.Length: " + fstr.Length + System.Environment.NewLine);
                            System.Diagnostics.Debug.Write("searchTerm.Length: " + searchTerm.Length + System.Environment.NewLine);
                            System.Diagnostics.Debug.Write("nodeStr.Length: " + nodeStr.Length + System.Environment.NewLine);

                        }

                    }
                }
                catch (Exception e)
                {

                    System.Diagnostics.Debug.Write("Error : " + e + System.Environment.NewLine);
                    System.Diagnostics.Debug.Write("fstrlen " + fstrlen + System.Environment.NewLine);
                    System.Diagnostics.Debug.Write("pstrlen: " + pstrlen + System.Environment.NewLine);
                    System.Diagnostics.Debug.Write("estrlen: " + estrlen + System.Environment.NewLine);
                }

                System.Diagnostics.Debug.Write("----------------" + System.Environment.NewLine);
            }


            return nodeStr;
        }

        public static Boolean preventCrossScriptInjection(String requestStr)
        {

            requestStr = requestStr.ToLower();

            Boolean check = false;

            if (requestStr.Contains("script"))
            {

                check = true;

            }
            else if ((requestStr.Contains("style")))
            {

                check = true;
            }
            else if ((requestStr.Contains("alert")))
            {

                check = true;
            }

            return check;
        }


        public static List<int> getIndexes(string searchStr, string str, Boolean caseSensitive)
        {

            int searchStrLen = searchStr.Length;
            List<int> indices = new List<int>();
            int count = 0;
            if (searchStrLen == 0)
            {
                return indices;
            }
            int startIndex = 0, index;
            if (!caseSensitive)
            {
                str = str.ToLower();
                searchStr = searchStr.ToLower();
            }
            while ((index = str.IndexOf(searchStr, startIndex)) > -1)
            {
                indices.Add(index);
                System.Diagnostics.Debug.Write("Found: " + searchStr + " at index " + index + System.Environment.NewLine);
                startIndex = index + searchStrLen;
                count++;
            }
            System.Diagnostics.Debug.Write("Index(es) found: " + count + " for " + searchStr + " in " + str + System.Environment.NewLine);
            return indices;
        }


    }
}