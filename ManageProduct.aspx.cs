using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Manageproduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string select = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if (Session["Type"] != "Admin")
            {
                Response.Redirect("Login.aspx?logintype=admin");
            }

            string select = "Select Distinct catg from ProductsCatg";
            SqlDataAdapter da = new SqlDataAdapter(select,con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {                
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string val = ds.Tables[0].Rows[i][0].ToString();
                    DropDownList_catg.Items.Add(val);
                    dd_catg_upd.Items.Add(val);
                }
            }

            gridview();

        }
    }

    public void gridview()
    {
        if (search_name.Text != "")
        {
            select = "select pid,image,pname,catg,subcatg,brands,descr,price from products where pname like '%" + search_name.Text + "%'";
        }
        else
        {
            select = "select pid,image,pname,catg,subcatg,brands,descr,price from products";
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



    protected void DropDownList_catg_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList_catg.SelectedItem.Text != "" || DropDownList_catg.SelectedItem.Text != "--Select Category--")
        {
            string select = "Select subcatg from ProductsCatg where catg = '"+DropDownList_catg.SelectedItem.Text+"'";
            SqlDataAdapter da = new SqlDataAdapter(select, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dd_subcatg.Items.Clear();

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string val = ds.Tables[0].Rows[i][0].ToString();
                    dd_subcatg.Items.Add(val);
                }
            }

            Panel_SubCatg.Visible = true;
            ClientScript.RegisterStartupScript(this.GetType(), "Pop", "add();", true);

        }
        else
        {
            Panel_SubCatg.Visible = false;
        }
        
    }


    protected void btn_image_Click(object sender, EventArgs e)
    {
        string image, path;

        try
        {
            image = FileUpload.FileName;
            path = Server.MapPath("~\\Images\\");
            FileUpload.SaveAs(path + image);
            fileid.ImageUrl = "Images\\" + image;
            fileid.Visible = true;
            btn_image.Attributes.Add("style", "display:none;");
        }
        catch (Exception ex)
        {
            lbl_image_val.Visible = true;
        }

        ClientScript.RegisterStartupScript(this.GetType(), "Pop", "add();", true);

    }


    protected void Buttonsbmt_Click(object sender, EventArgs e)
    {
        try
        {
            string insert = "Insert into Products(pname,catg,subcatg,brands,descr,price,image) values('"+txtbx_pname.Text+"','"+DropDownList_catg.SelectedItem.Text+"','"+dd_subcatg.SelectedItem.Text+"','"+txtbx_brands.Text+"','"+txtbx_descr.Text+"','"+txtbx_price.Text+"','"+fileid.ImageUrl+"')";
            SqlCommand cmd = new SqlCommand(insert,con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Product Added Successfully');window.location.href='ManageProduct.aspx'", true);

        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }

    }


    protected void btn_search_ServerClick(object sender, EventArgs e)
    {
        gridview();
    }


    protected void dd_catg_upd_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dd_catg_upd.SelectedItem.Text != "" || dd_catg_upd.SelectedItem.Text != "--Select Category--")
        {
            string select = "Select subcatg from ProductsCatg where catg = '" + dd_catg_upd.SelectedItem.Text + "'";
            SqlDataAdapter da = new SqlDataAdapter(select, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dd_subcatg_upd.Items.Clear();

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string val = ds.Tables[0].Rows[i][0].ToString();
                    dd_subcatg_upd.Items.Add(val);
                }
            }

            Panel_subcategory_upd.Visible = true;
            //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "add();", true);
            
        }
        else
        {
            Panel_subcategory_upd.Visible = false;
        }

    }

    protected void ButtonEdit_Click(object sender, EventArgs e)
    {
        try
        {
            string update = "Update Products set pname='" + txtbx_pname_upd.Text + "',catg='" + dd_catg_upd.SelectedItem.Text + "',subcatg='" + this.HiddenField_subcatg.Value + "',brands='" + txtbx_brands_upd.Text + "',descr='" + txtbx_descr_upd.Text + "',price='" + txtbx_price_upd.Text + "' where pid='" + this.HiddenField_pid.Value + "'";
            SqlCommand cmd = new SqlCommand(update, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Product Updated Successfully');window.location.href='ManageProduct.aspx'", true);

        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }
    }

    protected void btn_Yes_Click(object sender, EventArgs e)
    {
        try
        {
            string delete = "Delete from products where pid='" + this.HiddenFieldpid_del.Value + "'";
            SqlCommand cmd = new SqlCommand(delete, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "window.location.href='ManageProduct.aspx'", true);
        }
        catch (Exception)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }
    }

    protected void dd_subcatg_upd_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.HiddenField_subcatg.Value = dd_subcatg_upd.SelectedItem.Text;
    }

}