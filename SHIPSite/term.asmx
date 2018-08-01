<%@ WebService Language="C#" Class="term" %>
using System.Data.SqlClient;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Configuration;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class term : System.Web.Services.WebService
{
    public term()
    {
        //
        // TODO: Add any constructor code required
        //
    }

    // WEB SERVICE EXAMPLE
    // The HelloWorld() example service returns the string Hello World.

    [WebMethod]
    public string getTerm(string finalTerm, string db)
    {
        string response = "";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SHIPServer"].ToString()))
        {

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(db+"_getTermFrom", con);
                cmd.CommandType = CommandType.StoredProcedure;
                System.Diagnostics.Debug.WriteLine("The finalterm was: " + finalTerm);
                cmd.Parameters.AddWithValue("@finalTerm", finalTerm.Trim());
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                response = reader.GetString(0);
                System.Diagnostics.Debug.WriteLine("The respone was: " + response);
                con.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.ToString());
            }

        }
        return response;
    }
}
