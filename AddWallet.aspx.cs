using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddWallet : System.Web.UI.Page
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

        uid = Session["uid"].ToString();

        string select = "select walletamt from [User] where uid='" + uid + "'";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            txtbx_walletamt.Text = ds.Tables[0].Rows[0][0].ToString();
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            int t_amt = (Convert.ToInt32(txtbx_walletamt.Text) + Convert.ToInt32(totalamt.Text));

            string update = "Update [User] set walletamt ='" + t_amt + "' where uid='"+uid+"'";
            SqlCommand cmd = new SqlCommand(update, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Balance Updated Successfully');window.location.href='AddWallet.aspx'", true);
        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Invalid')", true);
        }
        
    }
}