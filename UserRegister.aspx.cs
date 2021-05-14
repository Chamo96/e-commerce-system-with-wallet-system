using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class UserRegister : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string uid="";
        string emailid_data = "";

        string select = "select top 1 UId from [User] order by uid desc";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string id = ds.Tables[0].Rows[0][0].ToString();
            string[] id_arr = id.Split('-');

            int id_int = Convert.ToInt32(id_arr[1]) + 1;
            uid = "U-"+id_int.ToString();
        }
        else
        {
            uid = "U-101";
        }


        if (TextBoxemail.Text != "")
        {
            string select1 = "select emailid from [User] where emailid ='" + TextBoxemail.Text + "'";
            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                emailid_data = ds1.Tables[0].Rows[0][0].ToString();
            }
        }

        if (TextBoxemail.Text == emailid_data)
        {
            lbl_email_val.Visible = true;
            lbl_email_val.Text = "This Email ID already exists";
        }
        else
        {
            try
            {
                string insert = "Insert into [User](UId,Name,MobileNo,EmailId,Password,Address,Country,City,WalletAmt) values('" + uid + "','" + TextBoxname.Text + "','" + TextBoxmnum.Text + "','" + TextBoxemail.Text + "','" + TextBoxpsd.Text + "','" + Textareaaddr.Text + "','"+Country.SelectedItem.Text+"','" + TextBoxcity.Text + "','500')";
                SqlCommand cmd = new SqlCommand(insert, con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Registration successfull');window.location.href='Login.aspx?logintype=user'", true);

            }
            catch (Exception ex)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
            }

        }


    }

}