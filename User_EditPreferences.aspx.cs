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

public partial class User_EditPreferences : System.Web.UI.Page
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
        this.HiddenField_uid.Value = uid;

        string select = "Select Distinct catg from ProductsCatg";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string html = "",selected_val="";
            int j = 0;

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
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
                    if (j % 4 == 0)
                    {
                        html += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
                    }
                }

                string select1 = "Select Distinct Catg from Preferences where uid='" + uid + "'";
                SqlDataAdapter da1 = new SqlDataAdapter(select1,con);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);

                if(ds1.Tables[0].Rows.Count > 0)
                {
                    string catg = ds1.Tables[0].Rows[0][0].ToString();
                    string[] catg_arr = catg.Split(',');

                    for (int k = 0; k < catg_arr.Length; k++)
                    {
                        if (ds.Tables[0].Rows[i][0].ToString() == catg_arr[k])
                        {
                            selected_val = catg_arr[k];
                        }
                    }

                }

                if (ds.Tables[0].Rows[i][0].ToString() == selected_val)
                {
                    html += "<div id='itemdiv_" + ds.Tables[0].Rows[i][0].ToString() + "' class='rounded-circle mb-4 item_selected col-md-3'><div class='card-body'><h5 id='h5_" + ds.Tables[0].Rows[i][0].ToString() + "'>" + ds.Tables[0].Rows[i][0].ToString() + "</h5><br/><button type='button' class='btn btn-success' id='btn_selcatg" + ds.Tables[0].Rows[i][0].ToString() + "' value='" + ds.Tables[0].Rows[i][0].ToString() + "' onclick='selc(this);'>Select</button></div></div>";
                }
                else
                {
                    html += "<div id='itemdiv_" + ds.Tables[0].Rows[i][0].ToString() + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + ds.Tables[0].Rows[i][0].ToString() + "'>" + ds.Tables[0].Rows[i][0].ToString() + "</h5><br/><button type='button' class='btn btn-primary' id='btn_selcatg" + ds.Tables[0].Rows[i][0].ToString() + "' value='" + ds.Tables[0].Rows[i][0].ToString() + "' onclick='selc(this);'>Select</button></div></div>";
                }

                j++;
            }

            html += "</div></div></div>";
            div_catg.InnerHtml = html;

        }

    }

    [WebMethod]
    public static string GetSubCatg(string catg, string HiddenField_uid)
    {       
        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        string subcommon="";
        int j = 0;

        string sql1 = "Select subcatg from ProductsCatg where catg = '" + catg + "'";
        SqlDataAdapter da1 = new SqlDataAdapter(sql1, strcon);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);

        if (ds1.Tables[0].Rows.Count > 0)
        {
            subcommon += "<div id='carouselExampleControls_" + catg + "' class='carousel slide my-4' data-ride='carousel'><h5 class='mt-2'>Preferred Sub-Categories of " + catg + "</h5><div class='carousel-inner'><div style='margin-left: 10%;margin-right: 7%;'>";


            for (var i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                string sub = ds1.Tables[0].Rows[i][0].ToString();

                if (j == 0)
                {
                    subcommon += "<div class='carousel-item active'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
                }
                else
                {
                    if (j % 4 == 0)
                    {
                        subcommon += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck'  style='width: 100%'>";

                    }

                }

                string sql = "Select Distinct subcatg from Preferences where uid = '" + HiddenField_uid + "' and SubCatg like '%" + sub + "%'";
                SqlDataAdapter da = new SqlDataAdapter(sql, strcon);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int count = ds.Tables[0].Rows.Count;

                if (count > 0)
                {
                    subcommon += "<div id='itemdiv_" + sub + "' class='rounded-circle mb-4 item_selected col-md-3'><div class='card-body'><h5 id='h5_" + sub + "'> " + sub + " </h5><br/><button type='button' id='btnbrands_" + sub + "' class='btn btn-success btn_" + catg + "' value='" + sub + "' onclick='selc_brands(this)'>Select</button></div></div>";

                }
                else
                {
                    subcommon += "<div id='itemdiv_" + sub + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + sub + "'> " + sub + " </h5><br/><button type='button' id='btnbrands_" + sub + "' class='btn btn-primary btn_" + catg + "' value='" + sub + "' onclick='selc_brands(this)'>Select</button></div></div>";

                }

                j++;

            }

            if (ds1.Tables[0].Rows.Count <= 3)
            {
                subcommon += "</div></div></div> </div></div><hr />";
            }
            else
            {
                subcommon += "</div></div></div></div> </div><a class='carousel-control-prev card_lefticon_div' href='#carouselExampleControls_" + catg + "' role='button' data-slide='prev'><span class='fas fa-angle-left card_lefticon' id='id_card_lefticon_" + catg + "' aria-hidden='true' style='color: black; font-size: 30px;'></span><span class='sr-only'>Previous</span></a><a class='carousel-control-next card_righticon_div' href='#carouselExampleControls_" + catg + "' role='button' data-slide='next'><span class='fas fa-angle-right card_righticon' id='id_card_righticon_" + catg + "' aria-hidden='true' style='color: black; font-size: 30px;'></span><span class='sr-only'>Next</span></a><hr /></div>";
            }

        }
        else
        {
            subcommon = "";
        }
           
        return subcommon;

    }

    [WebMethod]
    public static string GetBrands(string subcatg, string HiddenField_uid, string maincatg)
    {
        string strcon = ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString;

        string brandscommon = "";
        int j = 0;

        string sql1 = "Select brands from Products where subcatg = '" + subcatg + "'";
        SqlDataAdapter da1 = new SqlDataAdapter(sql1, strcon);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);

        if (ds1.Tables[0].Rows.Count > 0)
        {
            brandscommon += "<div id='carouselExampleControls_" + subcatg + "' class='carousel slide my-4 divcarousel_" + maincatg + "' data-ride='carousel'><h5 class='mt-2'>Preferred Sub-Categories of " + subcatg + "</h5><div class='carousel-inner'><div style='margin-left: 10%;margin-right: 7%;'>";


            for (var i = 0; i < ds1.Tables[0].Rows.Count; i++)
            {
                string brands = ds1.Tables[0].Rows[i][0].ToString();

                if (j == 0)
                {
                    brandscommon += "<div class='carousel-item active'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
                }
                else
                {
                    if (j % 4 == 0)
                    {
                        brandscommon += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck' style='width: 100%'>";

                    }

                }

                string sql = "Select Distinct brands from Preferences where uid = '" + HiddenField_uid + "' and brands like '%" + brands + "%'";
                SqlDataAdapter da = new SqlDataAdapter(sql, strcon);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int count = ds.Tables[0].Rows.Count;

                if (count > 0)
                {
                    brandscommon += "<div id='itemdiv_" + brands + "' class='rounded-circle mb-4 item_selected col-md-3'><div class='card-body'><h5 id='h5_" + brands + "'> " + brands + " </h5><br/><button type='button' id='btnfinal_" + brands + "' class='btn btn-success btnfinal_" + subcatg + "' value='" + brands + "' onclick='final(this);'>Select</button></div></div>";

                }
                else
                {
                    brandscommon += "<div id='itemdiv_" + brands + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + brands + "'> " + brands + " </h5><br/><button type='button' id='btnfinal_" + brands + "' class='btn btn-primary btnfinal_" + subcatg + "' value='" + brands + "' onclick='final(this);'>Select</button></div></div>";

                }

                j++;

            }

            if (ds1.Tables[0].Rows.Count <= 3)
            {
                brandscommon += "</div></div></div> </div></div><hr />";
            }
            else
            {
                brandscommon += "</div></div></div></div> </div><a class='carousel-control-prev card_lefticon_div' href='#carouselExampleControls_" + subcatg + "' role='button' data-slide='prev'><span class='fas fa-angle-left card_lefticon' id='id_card_lefticon_" + subcatg + "' aria-hidden='true' style='color: black; font-size: 30px;'></span><span class='sr-only'>Previous</span></a><a class='carousel-control-next card_righticon_div' href='#carouselExampleControls_" + subcatg + "' role='button' data-slide='next'><span class='fas fa-angle-right card_righticon' id='id_card_righticon_" + subcatg + "' aria-hidden='true' style='color: black; font-size: 30px;'></span><span class='sr-only'>Next</span></a><hr /></div>";
            }

        }
        else
        {
            brandscommon = "";
        }
       
        return brandscommon;

    }


    protected void btn_Proceed_Click(object sender, EventArgs e)
    {
        try
        {         
            string update = "Update Preferences set catg='" + this.Hf_categories.Value + "',subcatg='" + this.Hf_subcategories.Value + "',brands='" + this.Hf_brands.Value + "' where uid='"+uid+"'";
            SqlCommand cmd = new SqlCommand(update, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Preferences Updated Successfully');window.location.href='User_EditPreferences.aspx'", true);

        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
        }

    }

}