using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Check;

public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string logintype = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        #region System Generated . . .
        Class1 c = new Class1();
        bool c1 = c.checkLoad("S164", con);
        if (!c1)
        {
            Response.Redirect("Login.aspx");
        }
        #endregion

        logintype = Request.QueryString["logintype"];

        if (logintype == "user")
        {
            h4_user.Visible = true;
            h4_admin.Visible = false;
            Panel_AdminId.Visible = false;
            Panel_UserEmail.Visible = true;
            Panel_UserSignUp.Visible = true;
        }
        else if (logintype == "admin")
        {
            h4_user.Visible = false;
            h4_admin.Visible = true;
            Panel_AdminId.Visible = true;
            Panel_UserEmail.Visible = false;
            Panel_UserSignUp.Visible = false;
        }
        else
        {
            Response.Redirect("Index.aspx");
        }

    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        if (logintype == "admin")
        {
            if (txtbx_adminid.Text == "chamod" && txtbx_pass.Text == "chamod")
            {
                Session["Type"] = "Admin";

                Response.Redirect("Users.aspx");
            }
        }
        else if (logintype == "user")
        {
            if (txtbx_email.Text != "")
            {
                string select = "Select uid,name from [User] where emailid='" + txtbx_email.Text + "' and password='" + txtbx_pass.Text + "'";
                SqlDataAdapter da = new SqlDataAdapter(select, con);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["uid"] = ds.Tables[0].Rows[0][0].ToString();
                    Session["username"] = ds.Tables[0].Rows[0][1].ToString();

                    //Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Login successfull')", true);

                    Session["Type"] = "User";

                    string delete = "Delete from cart where uid='" + Session["uid"].ToString()+ "'";
                    SqlCommand cmd1 = new SqlCommand(delete, con);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();

                    string select1 = "Select * from Preferences where uid = '"+ Session["uid"] + "'";
                    SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
                    DataSet ds1 = new DataSet();
                    da1.Fill(ds1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        Response.Redirect("Cart.aspx");
                    }
                    else
                    {
                        string select2 = "Select * from Products";
                        SqlDataAdapter da2 = new SqlDataAdapter(select2, con);
                        DataSet ds2 = new DataSet();
                        da2.Fill(ds2);
                        if (ds2.Tables[0].Rows.Count > 0)
                        {
                            Response.Redirect("SelectPrefrences.aspx");
                        }
                        else
                        {
                            Response.Redirect("Products.aspx");
                        }                      
                    }                   
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Invalid login')", true);
                }

            }

        }


    }

}