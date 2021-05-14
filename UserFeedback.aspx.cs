using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserFeedback : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string uid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

        }

        uid = Session["Uid"].ToString();

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string currdate = DateTime.Now.ToString("yyyy-MM-dd");

        try
        {
            string insert = "Insert into feedback(uid,comments,date) values('"+ uid +"','"+ txtfeedback.Text +"','"+ currdate + "')";
            SqlCommand cmd = new SqlCommand(insert, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Feedback Sent Successfully');window.location.href='UserFeedback.aspx'", true);

        }
        catch(Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }       

    }

}