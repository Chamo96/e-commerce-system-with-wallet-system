using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ForgotPassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Panel_Verify.Visible = true;
        }      
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string select = "Select * from [User] where emailid='"+txtbx_email.Text+"' and mobileno='"+txtbx_mobno.Text+"'";
        SqlDataAdapter da = new SqlDataAdapter(select,con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if(ds.Tables[0].Rows.Count > 0)
        {
            this.HiddenField_emailid.Value = txtbx_email.Text;

            lbl_val.Visible = false;
            Panel_ChangePass.Visible = true;
            Panel_Verify.Visible = false;
        }
        else
        {
            lbl_val.Visible = true;
            Panel_Verify.Visible = true;
            Panel_ChangePass.Visible = false;
            
        }

    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        if(txtbx_newpass.Text != txtbx_confpass.Text)
        {
            lbl_cnfpass.Visible = true;
        }
        else if(txtbx_newpass.Text!="" && txtbx_confpass.Text!="")
        {
            lbl_cnfpass.Visible = false;

            string update = "Update [User] set password='" + txtbx_newpass.Text + "' where emailid='" + this.HiddenField_emailid.Value + "'";
            SqlCommand cmd = new SqlCommand(update, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Panel_Verify.Visible = false;

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Password Changed Successfully');window.location.href='Login.aspx?logintype=user'", true);

        }
      
    }

}