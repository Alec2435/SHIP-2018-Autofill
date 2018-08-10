using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dictionary_Maker
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDBs();
        }

        private void LoadDBs()
        {

            DataTable dbs = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SHIPServer"].ToString()))
            {

                try
                {
                    SqlDataAdapter adapter = new SqlDataAdapter("getMasterDB", con);
                    adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                    adapter.Fill(dbs);

                    ddldb.DataSource = dbs;
                    ddldb.DataTextField = "propName";
                    ddldb.DataValueField = "dbName";
                    ddldb.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.ToString());
                }

            }



            // Add the initial item - you can add this even if the options from the
            // db were not successfully loaded
            //ddldb.Items.Insert(0, new ListItem("<Select Subject>", "0"));

        }

        public void UploadButton_Click(object sender, EventArgs e)
        {
            string response = "";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SHIPServer"].ToString()))
            {
                
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(ddldb.SelectedItem.Value + "_getDict", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    response = reader.GetString(0);
                    con.Close();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.ToString());
                }

            }
            RegexOptions options = RegexOptions.None;
            Regex regex = new Regex("[ ]{2,}", options);
            response = regex.Replace(response, " ");
            Regex regex1 = new Regex("[,]", options);
            response = regex1.Replace(response, "");
            List<string> s = response.Split(' ').ToList();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment; filename=" + ddldb.SelectedItem.Value + "_dict.txt");
            Response.AddHeader("content-type", "text/plain");

            using (StreamWriter writer = new StreamWriter(Response.OutputStream))
            {
                foreach(string x in s.Distinct())
                {
                    writer.WriteLine(x);
                }
            }
            Response.End();
        }
    }


}