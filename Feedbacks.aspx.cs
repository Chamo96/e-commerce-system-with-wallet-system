using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Feedbacks : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string select = "";

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

    public void gridview()
    {
        if (search_name.Text != "")
        {
            select = "select u.name,f.comments,f.date from feedback as f join [User] as u on f.uid = u.uid where u.name like '%" + search_name.Text + "%' Order by f.date desc";
        }
        else
        {
            select = "select u.name,f.comments,f.date from feedback as f join [User] as u on f.uid = u.uid Order by f.date desc";
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