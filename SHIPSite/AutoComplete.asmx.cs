using System.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.IO;
using System.Text.RegularExpressions;
using System.Configuration;

namespace SHIPAutofill
{
    /// <summary>
    /// This service is designed to query the database with the user generated response for the purpose of allowing that user autofilling
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class AutoCompleteService : System.Web.Services.WebService
    {
        private const string sp = " ";

        [WebMethod]
        [ScriptMethod]
        public string[] GetCompletionList(string prefixText, int count, string contextKey)
        {
            System.Diagnostics.Debug.WriteLine(contextKey);
            //Converts the string to lowercase for easier processing
            prefixText = prefixText.ToLower();
            //Checks the string for any punctuation and then removes everything before the last punctuation mark
            if (prefixText.Any(char.IsPunctuation))
            {
                //In case the mark is at the end of the string
                try
                {
                    prefixText = prefixText.Substring(prefixText.LastIndexOf(".") + 2);
                    prefixText = prefixText.Substring(prefixText.LastIndexOf(",") + 2);
                    prefixText = prefixText.Substring(prefixText.LastIndexOf("!") + 2);
                    prefixText = prefixText.Substring(prefixText.LastIndexOf("?") + 2);
                }
                catch (Exception ex) { }
            }


            //Counts total number of words in the string
            var text = prefixText;
            int wordCount = 0, index = 0;
            while (index < text.Length)
            {
                // check if current char is part of a word
                while (index < text.Length && !char.IsWhiteSpace(text[index]))
                    index++;

                wordCount++;

                // skip whitespace until next word
                while (index < text.Length && char.IsWhiteSpace(text[index]))
                    index++;
            }

            //Checks to make sure its not 0 length
            if (wordCount < 1) { return null; }

            //Uses regular expressions to split apart the words into an array
            Regex rgx = new Regex("\\s+");
            String[] words = rgx.Split(prefixText);


            Regex rg = new Regex("[^\\w]");
            for (int i = 0; i < words.Length; i++)
            {
                words[i] = rg.Replace(words[i], "");
            }

            //Changes the array to a list
            List<string> mainText = words.ToList();

            //Opens the list of "stop words" to remove and then converts it to a list
            var logFile = File.ReadAllLines(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"worldlist.txt"));
            var stopList = new List<string>(logFile);

            //Removes the words that we loaded as stop words
            foreach (string set in stopList)
            {
                mainText.Remove(set);
            }


            //Diagnostic block to preview the query
            string finalText = "";
            foreach (string st in mainText) {
               finalText += st + sp;
            }
            finalText = finalText.Trim(' ');
            System.Diagnostics.Debug.WriteLine("Final Word: " + finalText);
            
            //Connects to the database
            List<string> ret = new List<string>();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString =  ConfigurationManager.ConnectionStrings["SHIPServer"].ToString();
            conn.Open();

            //Generates the query for the stored procedure
            SqlCommand cmd = new SqlCommand(contextKey + "_sp_autofill", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //Adds blank spaces until we reach the stored prcedure's requisit number of parameters
            while (mainText.Count() < 10)
            {
                mainText.Add(" ");
            }
            int textLength = mainText.Count();

            //Adds the parameters to the command
            for (int i = 1; i < 11; i++)
            {
                cmd.Parameters.AddWithValue("@param" + i, mainText[textLength - 11 + i]);
            }

            //Carefully tries to read the lines that the database returns 
            try
            {
                SqlDataReader reader = cmd.ExecuteReader();
                int c = 0;
                reader.Read();
                while (reader.Read() && c < count)
                {
                    string b = "";
                    try
                    {
                        b = " " + reader.GetString(2);
                    }
                    catch (Exception ex)
                    {

                    }
                    ret.Add(b);
                    c++;
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }

            //Return the results
            return ret.ToArray();
        }
    }
}
