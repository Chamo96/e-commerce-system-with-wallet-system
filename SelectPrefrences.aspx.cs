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

public partial class SelectPrefrences : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string uid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Type"] != "User")
        {
            Response.Redirect("Login.aspx?logintype=user");
        }

        uid = Session["uid"].ToString();

        string select = "Select Distinct catg from ProductsCatg";
        SqlDataAdapter da = new SqlDataAdapter(select,con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string html = "";
            int j = 0;

            for (int i=0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (ds.Tables[0].Rows.Count <= 4)
                {
                    id_card_lefticon.Visible = false;
                    id_card_righticon.Visible = false;
                }
                else
                {
                    id_card_lefticon.Visible = true;
                    id_card_righticon.Visible = true;
                }

                if (j == 0)
				{
					html += "<div class='carousel-item active'><div class='row text-center'><div class='card-deck col-md-12'>";
				}
				else					
				{
					if(j%4 == 0)
					{
                        html += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
					}
				}
                
                html += "<div id='itemdiv_"+ ds.Tables[0].Rows[i][0].ToString() + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + ds.Tables[0].Rows[i][0].ToString() + "'>" + ds.Tables[0].Rows[i][0].ToString() + "</h5><br/><button type='button' class='btn btn-primary' id='btn_selcatg" + ds.Tables[0].Rows[i][0].ToString() + "' value='" + ds.Tables[0].Rows[i][0].ToString() + "' onclick='selc(this);'>Select</button></div></div>";

				j++;
            }

            html+= "</div></div></div>";
            div_catg.InnerHtml = html;

        }

    }

    [WebMethod]
    public static List<string> GetSubCatg(string catg)
    {
        List<string> subcatgResult = new List<string>();

        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strcon))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "Select Distinct subcatg from ProductsCatg where catg = '" + catg + "'";
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

    [WebMethod]
    public static List<string> GetBrands(string subcatg)
    {
        List<string> brandsResult = new List<string>();

        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        using (SqlConnection con = new SqlConnection(strcon))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "Select Distinct brands from Products where subcatg = '" + subcatg + "'";
                cmd.Connection = con;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    brandsResult.Add(dr["brands"].ToString());
                }

                con.Close();
                return brandsResult;

            }

        }
    }



    protected void btn_Proceed_Click(object sender, EventArgs e)
    {
        try
        {
            string insert = "Insert into Preferences(uid,catg,subcatg,brands) values('"+uid+"','"+this.Hf_categories.Value+"','"+this.Hf_subcategories.Value+"','"+this.Hf_brands.Value+"')";
            SqlCommand cmd = new SqlCommand(insert,con);            
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("AddWallet.aspx");

        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }

    }
}