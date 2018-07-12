using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SHIPAutofill
{
    public partial class CompletionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Submit_Click(object sender, EventArgs e)
        {
           string q = String.Join(" ",SearchText.Text.Replace("(", "").Replace(")", "").Split(' ').Take(15));

            Response.Redirect("~/Search.aspx?q=" + q);
        }

        }
    }
}