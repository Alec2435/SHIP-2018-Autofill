using System.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SHIPAutofill
{
    public partial class CompletionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDBs();
        }

        private void LoadDBs()
        {

            DataTable dbs = new DataTable();
            System.Diagnostics.Debug.WriteLine("Code is really hard mkayy");
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


        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}