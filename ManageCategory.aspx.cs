using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Web.UI.WebControls.WebParts;


public partial class ManageCategory : System.Web.UI.Page
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

    protected void btn_search_ServerClick(object sender, EventArgs e)
    {
        gridview();
    }

    protected void Buttonsbmt_Click(object sender, EventArgs e)
    {
            try
            {
                  string insert = "Insert into ProductsCatg(catg,subcatg) values('" + txtbx_catgname.Text.Replace("'", "''") + "','" + txtbx_subcatg.Text.Replace("'", "''") + "')";
                    SqlCommand cmd = new SqlCommand(insert, con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Category Details Added successfully');window.location.href='ManageCategory.aspx'", true);
                

            }
            catch (Exception)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
            }         
        
    }

    public void gridview()
    {     
        if(search_name.Text !="")
        {
            select = "select catgid,catg,subcatg from ProductsCatg where catg like '%" + search_name.Text + "%'";
        }
        else
        {
            select = "select catgid,catg,subcatg from ProductsCatg";
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

    [WebMethod]
    public static List<string> GetCatg()
    {
        List<string> catgResult = new List<string>();

        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strcon))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "Select Distinct Catg from ProductsCatg";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    catgResult.Add(dr["Catg"].ToString());
                }

                con.Close();
                return catgResult;

            }

        }

    }

    [WebMethod]
    public static List<string> GetSubCatg(string txtbx_catgname)
    {
        List<string> subcatgResult = new List<string>();

        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strcon))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "Select subcatg from ProductsCatg where catg='"+ txtbx_catgname + "'";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    subcatgResult.Add(dr["subcatg"].ToString());
                }

                con.Close();
                return subcatgResult;

            }

        }

    }


    protected void Btn_editsub_Click(object sender, EventArgs e)
    {
        try
        {
            string update = "Update ProductsCatg set catg='" + txtbx_updcatg.Text.Replace("'", "''") + "',subcatg='" + txtbx_updsubcatg.Text.Replace("'", "''") + "' where catgid='" + catgid_upd.Value + "'";
            SqlCommand cmd = new SqlCommand(update, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Category Details Updated successfully');window.location.href='ManageCategory.aspx'", true);

        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }

    }

}