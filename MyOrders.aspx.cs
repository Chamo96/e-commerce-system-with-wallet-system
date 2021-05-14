using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class MyOrders : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

            gridview();

        }
    }

    protected void gridview()
    {
        string uid = Session["Uid"].ToString();
        string select = "";

        if (search_name.Text != "")
        {
            select = "select p.image,p.pname,p.brands,p.descr,o.totalprice,o.shippingaddress,o.totalprice,o.paymentstatus,o.status,o.date from Orders as o join Products as p on o.pid = p.pid where o.uid = '" + uid + "' and p.pname like '%" + search_name.Text + "%' Order by o.date desc";
        }
        else
        {
            select = "select p.image,p.pname,p.brands,p.descr,o.totalprice,o.shippingaddress,o.totalprice,o.paymentstatus,o.status,o.date from Orders as o join Products as p on o.pid = p.pid where o.uid = '" + uid + "' Order by o.date desc";
        }

        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            Panel_search.Visible = true;
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            lblno.Visible = false;
        }
        else
        {
            Panel_search.Visible = false;
            lblno.Text = "No records to display";
            lblno.Visible = true;
            GridView1.Visible = false;
        }

    }

    protected void btn_search_ServerClick(object sender, EventArgs e)
    {
        gridview();
    }

}