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

public partial class Cart : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    int sum = 0;
    string uid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

            uid = Session["Uid"].ToString();

            string select1 = "select count(*) from Cart where uid='" + uid + "'";
            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                noOfItems.InnerText = ds1.Tables[0].Rows[0][0].ToString();
            }

            string select = "select walletamt from [User] where uid='" + uid + "'";
            SqlDataAdapter da = new SqlDataAdapter(select, con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblwallet.Text = ds.Tables[0].Rows[0][0].ToString();
            }

            //Preference_Items();
            gridview();
          //  Preference_Items();
            gridviewRecommendation();
        }

        uid = Session["Uid"].ToString();

    }

    protected void gridview()
    {
        string select = "select p.Image,p.pname,p.brands,p.descr,p.price,c.pid " +
                        "from products as p join Cart as c on c.pid = p.pid where c.UId = '" + uid + "'";
        
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {           
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            Panel_TotalPrice.Visible = true;
        }
        else
        {
            lblno.Text = "No items in cart to display";
            lblno.Visible = true;
            GridView1.Visible = false;
            Panel_TotalPrice.Visible = false;

        }

    }

    protected void gridviewRecommendation()
    {
        //string select = "select p.Image,p.pname,p.brands,p.descr,p.price,c.pid " +
        //                "from products as p join Cart as c on c.pid = p.pid where c.UId = '" + uid + "'";

        string select = "select p.pid,p.image,p.pname,P.Price from Recomded R " +
"left join Products P " +
"on R.Pid = p.Pid " +
"where uid='" + uid + "'" +
" and row_count_new_final in (1, 2, 3, 4, 5) and p.pname!=''";

        //if (search_name.Text != "")
        //{
        //    select = "select pid,image,pname,price from Products and pname like '%" + search_name.Text + "%'";
        //}
        //else
        //{
        //    select = "select pid,image,pname,price from Products";
        //}


        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string html = "";

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                html += "<div class='card col-md-2 col-lg-2 ml-4 mt-2'><div class='card-body'><a href='ProductDesc.aspx?Pid=" + ds.Tables[0].Rows[i][0].ToString() + "'><img class='img-responsive' style='width: 100%; height: 100px;' src='" + ds.Tables[0].Rows[i][1].ToString() + "' /><h4 class='head pt-2 text-center'>" + ds.Tables[0].Rows[i][2].ToString() + "</h4></a><div class='pt-2 text-center'><i class='fa fa-dollar' style='font-size: 24px'></i> <asp:Label ID = 'Label2' Style='font-size: 20px; font-weight: 700;' runat='server' Text=''>" + ds.Tables[0].Rows[i][3].ToString() + "</asp:Label><button id='" + ds.Tables[0].Rows[i][0].ToString() + "' type='button' class='btn_cart pt-2 mt-2' onclick='prods(" + ds.Tables[0].Rows[i][0].ToString() + ")'>Add to Cart</button></div></div></div>";

            }

            div_Products.InnerHtml = html;
            //Panel_search.Visible = true;
            lblRecomm.Visible = true;

        }
        else
        {
            lblno.Visible = true;
            lblno.Text = "No products to display";
            div_Products.InnerHtml = "";
            //Panel_search.Visible = false;

        }
        //SqlDataAdapter da = new SqlDataAdapter(select, con);
        //DataSet ds = new DataSet();
        //da.Fill(ds);
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    GridView2.DataSource = ds;
        //    GridView2.DataBind();
        //    GridView2.Visible = true;
        //    //Panel_TotalPrice.Visible = true;
        //    lblRecommendMsg.Visible = true;
        //}
        //else
        //{
        //    lblRecommendMsg.Text = "No items in recommend to display";
        //    lblRecommendMsg.Visible = true;
        //    GridView2.Visible = false;
        //    Panel_TotalPrice.Visible = false;

        //}

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {
            int pid = Convert.ToInt32(e.CommandArgument.ToString());
           
            string delete = "Delete from cart where uid='"+ uid + "'";
            SqlCommand cmd = new SqlCommand(delete,con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Products.aspx");

        }

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            sum += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Price"));
            lbl_totalPrice.Text = sum.ToString();

            HiddenField_pid.Value += "," + e.Row.Cells[5].Text;

        }

        this.HiddenField_pid.Value = this.HiddenField_pid.Value.TrimStart(',');

    }


    protected void btn_payt_Click(object sender, EventArgs e)
    {
        Hashtable prods_descr = new Hashtable();
        prods_descr.Add("pid",this.HiddenField_pid.Value);
        Session["prods_descr"] = prods_descr;
        Response.Redirect("Payment.aspx");

    }

    public void Preference_Items()
    {
        string select1 = "Select catg,subcatg,brands from Preferences where uid='"+uid+"'";
        SqlDataAdapter da1 = new SqlDataAdapter(select1,con);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);
        if (ds1.Tables[0].Rows.Count > 0)
        {
            string catg = ds1.Tables[0].Rows[0][0].ToString();
            string subcatg = ds1.Tables[0].Rows[0][1].ToString();
            string brands = ds1.Tables[0].Rows[0][2].ToString();

            string[] catg_arr = catg.Split(',');
            string[] subcatg_arr = subcatg.Split(',');
            string[] brands_arr = brands.Split(',');

            for (int i = 0; i < catg_arr.Length; i++)
            {
                catg_arr[i] = catg_arr[i].Trim();

                string select2 = "Select subcatg from ProductsCatg where catg='" + catg_arr[i] + "'";
                SqlDataAdapter da2 = new SqlDataAdapter(select2, con);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2);
                string[] subcatg_fetch;
                subcatg_fetch = new string[ds2.Tables[0].Rows.Count];

                for (int l = 0; l < ds2.Tables[0].Rows.Count; l++)
                {
                    subcatg_fetch[l] = ds2.Tables[0].Rows[l][0].ToString();
                }

                var subcatgcommon = subcatg_arr.Intersect(subcatg_fetch);
                foreach (string subcatg_chk in subcatgcommon)
                {
                    string select = "select max(p.pname) from Products as p join orders as o on o.pid = p.pid where p.subcatg='" + subcatg_chk + "'";
                    SqlDataAdapter da = new SqlDataAdapter(select, con);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string chk = ds.Tables[0].Rows[0][0].ToString();

                        if (chk != "")
                        {
                            string select3 = "select pid,image,pname,price from Products where subcatg='" + subcatg_chk + "'";
                            SqlDataAdapter da3 = new SqlDataAdapter(select3, con);
                            DataSet ds3 = new DataSet();
                            da3.Fill(ds3);

                            string html = "";

                            lbl_related.Visible = true;

                            html += "<div class='card col-md-2 col-lg-2 ml-4 mt-1'><div class='card-body'>" +
                                "<a href='ProductDesc.aspx?Pid=" + ds3.Tables[0].Rows[0][0].ToString() + "'>" +
                                "<img class='img-responsive' style='width: 100%; height: 100px;' src='" + ds3.Tables[0].Rows[0][1].ToString() + "' />" +
                                "<h4 class='head pt-2 text-center'>" + ds3.Tables[0].Rows[0][2].ToString() + "</h4></a>" +
                                "<div class='pt-2 text-center'><i class='fa fa-dollar' style='font-size: 24px'>" +
                                "</i> <asp:Label ID = 'Label2' Style='font-size: 20px; font-weight: 700;' runat='server' Text=''>" + ds3.Tables[0].Rows[0][3].ToString() + "</asp:Label><button id='" + ds.Tables[0].Rows[0][0].ToString() + "' type='button' class='btn_cart pt-2 mt-2' onclick='prods(" + ds3.Tables[0].Rows[0][0].ToString() + ")'>Add to Cart</button></div></div></div>";

                            div_ProdsCart.InnerHtml = html;

                        }

                    }

                }


             }

        }


    }
   

    protected void Btn_Cart_Click(object sender, EventArgs e)
    {
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

            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Items Added to Cart Successfully');window.location.href='Cart.aspx'", true);

        }

    }
}