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

public partial class Payment : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AI_Wallet"].ConnectionString);

    string uid = "",price_fetch = "",oid="",insert="",totalprice="";
    string[] bkid_arr = new string[0];

    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Session["Type"] != "User")
            {
                Response.Redirect("Login.aspx?logintype=user");
            }

            uid = Session["uid"].ToString();

            if (!IsPostBack)
            {
                string select = "select address from [User] where uid='" + uid + "'";
                SqlDataAdapter da = new SqlDataAdapter(select, con);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtbx_shpaddr.Text = ds.Tables[0].Rows[0][0].ToString();
                    txtbx_shpcard.Text = ds.Tables[0].Rows[0][0].ToString();

                }

                string select1 = "select walletamt from [User] where uid='" + uid + "'";
                SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    txtbx_balance.Text = ds1.Tables[0].Rows[0][0].ToString();
                }

            }

        string Paytstate = Request.QueryString["Paytstate"];

        if (Paytstate == "Cart")
        {
            Hashtable prods_cart = (Hashtable)Session["prods_cart"];          
        }
        else
        {
            Hashtable prods_descr = (Hashtable)Session["prods_descr"];

            string select1 = "select price from products where pid='" + prods_descr["pid"].ToString() + "'";
            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                price_fetch = ds1.Tables[0].Rows[0][0].ToString();
            }

            txtbx_totalamt.Text = price_fetch.ToString();

        }

    }

    //protected void btn_mkpaymnt_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        int oid;
    //        string bookname="",price="",insert="";
    //        string[] bkid_arr = new string[0];

    //        string Paytstate = Request.QueryString["Paytstate"];
    //        string currdate = DateTime.Now.ToString("yyyy-MM-dd");


    //        Hashtable books_descr = (Hashtable)Session["books_descr"];
    //        Hashtable books_cart = (Hashtable)Session["books_cart"];

    //        if (books_cart != null)
    //        {
    //            Session["bkid"] = books_cart["Bookid"];
    //            bkid_arr = Session["bkid"].ToString().Split(',');
    //        }


    //        string select = "select top 1 OrderId from Orders order by OrderId desc";
    //        SqlDataAdapter da = new SqlDataAdapter(select, con);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds);
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            string id = ds.Tables[0].Rows[0][0].ToString();

    //            oid = Convert.ToInt32(id) + 1;
    //        }
    //        else
    //        {
    //            oid = 1001;
    //        }

    //        if (Paytstate == "Cart")
    //        {
    //            insert = "Insert into Orders(orderid,uid,bookid,bookname,shippingaddress,PaymtType,totalprice,date) values('" + oid + "','" + uid + "','" + books_cart["Bookid"].ToString() + "','" + books_cart["BookName"].ToString() + "','" + txtbx_shpaddr1.Text + "','" + this.Paytmode.Value + "','" + books_cart["TPrice"].ToString() + "','" + currdate + "')";
    //        }
    //        else
    //        {
    //            string select1 = "select bookname,price from Books where bookid='" + books_descr["Bookid"].ToString() + "'";
    //            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
    //            DataSet ds1 = new DataSet();
    //            da1.Fill(ds1);

    //            if (ds1.Tables[0].Rows.Count > 0)
    //            {
    //                bookname = ds1.Tables[0].Rows[0][0].ToString();
    //                price = ds1.Tables[0].Rows[0][1].ToString();
    //            }


    //            insert = "Insert into Orders(orderid,uid,bookid,bookname,shippingaddress,PaymtType,totalprice,date) values('" + oid + "','"+uid+"','" + books_descr["Bookid"].ToString() + "','" + bookname + "','"+txtbx_shpaddr1.Text+"','" + this.Paytmode.Value + "','" + price + "','"+currdate+"')";
    //        }


    //        SqlCommand cmd = new SqlCommand(insert, con);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();


    //        string delete = "Delete from cart where uid='" + uid + "'";
    //        SqlCommand cmd1 = new SqlCommand(delete, con);
    //        con.Open();
    //        cmd1.ExecuteNonQuery();
    //        con.Close();

    //        if (books_cart != null)
    //        {
    //            for (int i = 0; i < bkid_arr.Length; i++)
    //            {
    //                string update = "Update Books set status='Sold' where bookid='" + bkid_arr[i] + "'";
    //                SqlCommand cmd2 = new SqlCommand(update, con);
    //                con.Open();
    //                cmd2.ExecuteNonQuery();
    //                con.Close();
    //            }

    //        }
    //        else
    //        {
    //            string update = "Update Books set status='Sold' where bookid='" + books_descr["Bookid"].ToString() + "'";
    //            SqlCommand cmd2 = new SqlCommand(update, con);
    //            con.Open();
    //            cmd2.ExecuteNonQuery();
    //            con.Close();
    //        }



    //        Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Payment Done Successfully');window.location.href='ViewBooks.aspx'", true);

    //    }
    //    catch(Exception ex)
    //    {
    //        Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
    //    }

    //}


    //protected void btn_mkpaymnt1_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        int oid;
    //        string bookname = "", price = "", insert = "";
    //        string[] bkid_arr = new string[0];

    //        string Paytstate = Request.QueryString["Paytstate"];

    //        string currdate = DateTime.Now.ToString("yyyy-MM-dd");

    //        Hashtable books_descr = (Hashtable)Session["books_descr"];
    //        Hashtable books_cart = (Hashtable)Session["books_cart"];

    //        if (books_cart != null)
    //        {
    //            Session["bkid"] = books_cart["Bookid"];
    //            bkid_arr = Session["bkid"].ToString().Split(',');
    //        }


    //        string select = "select top 1 OrderId from Orders order by OrderId desc";
    //        SqlDataAdapter da = new SqlDataAdapter(select, con);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds);
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            string id = ds.Tables[0].Rows[0][0].ToString();

    //            oid = Convert.ToInt32(id) + 1;
    //        }
    //        else
    //        {
    //            oid = 1001;
    //        }


    //        if (Paytstate == "Cart")
    //        {
    //            insert = "Insert into Orders(orderid,uid,bookid,bookname,shippingaddress,PaymtType,totalprice,date) values('" + oid + "','"+uid+"','" + books_cart["Bookid"].ToString() + "','" + books_cart["BookName"].ToString() + "','"+ shpaddr.Text+ "','"+this.Paytmode.Value+"','"+books_cart["TPrice"].ToString() +"','"+currdate+"')";
    //        }
    //        else
    //        {
    //            string select1 = "select bookname,price from Books where bookid='" + books_descr["Bookid"].ToString() + "'";
    //            SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
    //            DataSet ds1 = new DataSet();
    //            da1.Fill(ds1);

    //            if (ds1.Tables[0].Rows.Count > 0)
    //            {
    //                bookname = ds1.Tables[0].Rows[0][0].ToString();
    //                price = ds1.Tables[0].Rows[0][1].ToString();
    //            }


    //            insert = "Insert into Orders(orderid,uid,bookid,bookname,shippingaddress,PaymtType,totalprice,date) values('" + oid + "','" + uid + "','" + books_descr["Bookid"].ToString() + "','" + bookname + "','" + shpaddr.Text + "','" + this.Paytmode.Value + "','" + price + "','" + currdate + "')";

    //        }

    //        SqlCommand cmd = new SqlCommand(insert, con);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();


    //        string delete = "Delete from cart where uid='" + uid + "'";
    //        SqlCommand cmd1 = new SqlCommand(delete, con);
    //        con.Open();
    //        cmd1.ExecuteNonQuery();
    //        con.Close();

    //        if (books_cart != null)
    //        {
    //            for (int i = 0; i < bkid_arr.Length; i++)
    //            {
    //                string update = "Update Books set status='Sold' where bookid='" + bkid_arr[i] + "'";
    //                SqlCommand cmd2 = new SqlCommand(update, con);
    //                con.Open();
    //                cmd2.ExecuteNonQuery();
    //                con.Close();
    //            }

    //        }
    //        else
    //        {
    //            string update = "Update Books set status='Sold' where bookid='" + books_descr["Bookid"].ToString() + "'";
    //            SqlCommand cmd2 = new SqlCommand(update, con);
    //            con.Open();
    //            cmd2.ExecuteNonQuery();
    //            con.Close();
    //        }

    //        Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Payment Done Successfully');window.location.href='ViewBooks.aspx'", true);

    //    }
    //    catch (Exception ex)
    //    {
    //        Page.ClientScript.RegisterStartupScript(GetType(), "msgbox", "alert('Invalid');", true);
    //    }

    //}


    protected void btn_mkpaymnt_Click(object sender, EventArgs e)
    {
        string currdate = DateTime.Now.ToString("yyyy-MM-dd");
        Hashtable prods_descr = (Hashtable)Session["prods_descr"];

        string select = "select top 1 oid from Orders order by oid desc";
        SqlDataAdapter da = new SqlDataAdapter(select, con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string id = ds.Tables[0].Rows[0][0].ToString();
            string[] id_arr = id.Split('-');

            int id_int = Convert.ToInt32(id_arr[1]) + 1;
            oid = "O-" + id_int.ToString();
        }
        else
        {
            oid = "O-1001";
        }

        string select1 = "select price from products where pid='" + prods_descr["pid"].ToString() + "'";
        SqlDataAdapter da1 = new SqlDataAdapter(select1, con);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);

        if (ds1.Tables[0].Rows.Count > 0)
        {
            totalprice = ds1.Tables[0].Rows[0][0].ToString();
        }

        try
        {
            if (this.Paytmode.Value == "Wallet")
            {

                int balance = (Convert.ToInt32(txtbx_balance.Text) - Convert.ToInt32(totalprice));

                if (Convert.ToInt32(totalprice) > Convert.ToInt32(txtbx_balance.Text))
                {
                    //lbl_paymntval.Visible = true;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Insuffecient cash in the wallet')", true);
                }
                else
                {
                    //lbl_paymntval.Visible = false;
               
                    string update = "Update [User] set walletamt='"+balance+"' where uid='"+uid+"'";
                    SqlCommand cmd1 = new SqlCommand(update,con);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();


                    insert = "Insert into Orders(oid,uid,pid,totalprice,shippingaddress,paymentstatus,status,date) values('" + oid + "','" + uid + "','" + prods_descr["pid"].ToString() + "','" + totalprice + "','" + txtbx_shpaddr.Text + "','" + this.Paytmode.Value + "','Order Placed','" + currdate + "')";

                    SqlCommand cmd = new SqlCommand(insert, con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Order Placed Successfully');window.location.href='MyOrders.aspx'", true);


                }

            }
            else if (this.Paytmode.Value == "Card")
            {
                //lbl_paymntval.Visible = false;

                insert = "Insert into Orders(oid,uid,pid,totalprice,shippingaddress,paymentstatus,status,date) values('" + oid + "','" + uid + "','" + prods_descr["pid"].ToString() + "','" + totalprice + "','" + txtbx_shpcard.Text + "','" + this.Paytmode.Value + "','Order Placed','" + currdate + "')";

                SqlCommand cmd = new SqlCommand(insert, con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Order Placed Successfully');window.location.href='MyOrders.aspx'", true);

            }

            string delete = "Delete from cart where uid='" + uid + "'";
            SqlCommand cmd2 = new SqlCommand(delete, con);
            con.Open();
            cmd2.ExecuteNonQuery();
            con.Close();

        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "alert('Invalid')", true);
        }      

    }
}