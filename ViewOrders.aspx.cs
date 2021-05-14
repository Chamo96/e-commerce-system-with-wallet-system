using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;


public partial class ViewOrders : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Type"] != "Admin")
            {
                Response.Redirect("Login.aspx?logintype=admin");
            }

            gridview();

        }
    }

    protected void gridview()
    {
        string select = "";

        if (search_name.Text != "")
        {
            select = "select u.name, p.image,p.pname,p.brands,p.descr,o.totalprice,o.shippingaddress,o.totalprice,o.paymentstatus,o.status,o.date,o.oid from Orders as o join Products as p on o.pid = p.pid join [User] as u on o.uid = u.uid where o.oid like '%" + search_name.Text + "%' Order by o.date desc";
        }
        else
        {
            select = "select u.name,p.image,p.pname,p.brands,p.descr,o.totalprice,o.shippingaddress,o.totalprice,o.paymentstatus,o.status,o.date,o.oid from Orders as o join Products as p on o.pid = p.pid join [User] as u on o.uid = u.uid Order by o.date desc";
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

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string upd_status = "";

        if (e.CommandName == "Status")
        {
            string oid = e.CommandArgument.ToString();

            GridViewRow selectedRow = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
            string status = selectedRow.Cells[9].Text;
          
            if (status == "Order Placed")
            {
                upd_status = "Dispatched";
            }
            else if (status == "Dispatched")
            {
                upd_status = "Delivered";
            }

            string update = "Update orders set status='"+ upd_status + "' where oid='"+oid+"'";
            SqlCommand cmd = new SqlCommand(update,con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('"+ upd_status + " Successfully');window.location.href='ViewOrders.aspx'", true);

        }

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton btnstatus = (LinkButton)e.Row.Cells[11].FindControl("btnstatus");

            if (e.Row.Cells[9].Text == "Order Placed")
            {
                btnstatus.Text = "Dispatch";
            }
            else if (e.Row.Cells[9].Text == "Dispatched")
            {
                btnstatus.Text = "Deliver";
                btnstatus.Style.Add("background-color", "#5bc0de");
                btnstatus.Style.Add("border-color", "#46b8da");
            }
            else if (e.Row.Cells[9].Text == "Delivered")
            {
                btnstatus.Visible = false;
            }

        }
    }

    protected void btn_search_ServerClick(object sender, EventArgs e)
    {
        gridview();
    }

}