using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class MasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Type"] == "User")
        {
            Panel_User.Visible = true;
            Panel_Admin.Visible = false;

            string uid = Session["uid"].ToString();
            uname.Text = Session["username"].ToString();

            string select1 = "select count(*) from Cart where uid='" + uid + "'";
            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                lblcount.Text = ds1.Tables[0].Rows[0][0].ToString();
            }

        }
        else if(Session["Type"] == "Admin")
        {
            Panel_Admin.Visible = true;
            Panel_User.Visible = false;
        }

   }

}
