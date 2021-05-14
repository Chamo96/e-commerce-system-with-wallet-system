using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;


public partial class Productdesc : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string uid = "", pid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

            if (Request.QueryString["Pid"] == null || Request.QueryString["Pid"] == "")
            {
                Response.Redirect("Products.aspx");
            }
            else
            {
                pid = Request.QueryString["pid"];
            }
 
            uid = Session["uid"].ToString();


            string select = "select image,pname,catg,descr,price,brands from Products where pid='" + pid + "'";
            SqlDataAdapter da = new SqlDataAdapter(select, con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Image_prod.ImageUrl = ds.Tables[0].Rows[0][0].ToString();
                lblprodname.Text = ds.Tables[0].Rows[0][1].ToString();
                lblcatg.Text = ds.Tables[0].Rows[0][2].ToString();
                lbldescr.Text = ds.Tables[0].Rows[0][3].ToString();
                lblprice.Text = ds.Tables[0].Rows[0][4].ToString();
                lblbrands.Text = ds.Tables[0].Rows[0][5].ToString();

            }

    }

    protected void btn_addtocart_Click(object sender, EventArgs e)
    {
        string select = "select * from Cart where pid='" + pid + "'";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('This Item is already added to Cart')", true);
        }
        else
        {
            string insert = "Insert into Cart(uid,pid) values('" + uid + "','" + pid + "')";
            SqlCommand cmd = new SqlCommand(insert, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Items Added to Cart Successfully');window.location.href='Products.aspx'", true);

        }

    }


    protected void btn_buynow_Click(object sender, EventArgs e)
    {
        Hashtable prods_descr = new Hashtable();
        prods_descr.Add("pid", pid);
        Session["prods_descr"] = prods_descr;

        Response.Redirect("Payment.aspx");

    }
}