using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Products : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string select="",uid="";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

            List_Prods();
        }

    }

    protected void List_Prods()
    {
        if(search_name.Text !="")
        {
            select = "select pid,image,pname,price from Products where pname like '%" + search_name.Text+"%'";
        }
        else
        {
            select = "select pid,image,pname,price from Products";
        }

      
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string html = "";

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                html += "<div class='card col-md-2 col-lg-2 ml-4 mt-2'><div class='card-body'><a href='ProductDesc.aspx?Pid="+ds.Tables[0].Rows[i][0].ToString()+"'><img class='img-responsive' style='width: 100%; height: 100px;' src='" + ds.Tables[0].Rows[i][1].ToString() + "' /><h4 class='head pt-2 text-center'>" + ds.Tables[0].Rows[i][2].ToString() + "</h4></a><div class='pt-2 text-center'><i class='fa fa-dollar' style='font-size: 24px'></i> <asp:Label ID = 'Label2' Style='font-size: 20px; font-weight: 700;' runat='server' Text=''>" + ds.Tables[0].Rows[i][3].ToString() + "</asp:Label><button id='" + ds.Tables[0].Rows[i][0].ToString() + "' type='button' class='btn_cart pt-2 mt-2' onclick='prods(" + ds.Tables[0].Rows[i][0].ToString() + ")'>Add to Cart</button></div></div></div>";

            }

            div_Products.InnerHtml = html;
            Panel_search.Visible = true;
            lblno.Visible = false;

        }
        else
        {
            lblno.Visible = true;
            lblno.Text = "No products to display";
            div_Products.InnerHtml = "";
            Panel_search.Visible = false;

        }
    }


    protected void btn_search_ServerClick(object sender, EventArgs e)
    {
        List_Prods();
    }

    protected void Btn_Cart_Click(object sender, EventArgs e)
    {
        uid = Session["uid"].ToString();

        string select = "select * from Cart where pid='" + this.HiddenField_pid.Value + "'";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('This Item is already added to Cart')", true);
        }
        else
        {
            string insert = "Insert into Cart(uid,pid) values('" + uid + "','" + this.HiddenField_pid.Value + "')";
            SqlCommand cmd = new SqlCommand(insert, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Items Added to Cart Successfully');window.location.href='Products.aspx'", true);

        }

    }
}