<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductDesc.aspx.cs" Inherits="Productdesc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container" style="margin-top:7%;">
        <div class="row">
            <div class="col-md-8 col-lg-8 mx-auto p-3 bg-white rounded shadow-lg">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <asp:Image ID="Image_prod" CssClass="img-thumbnail" runat="server" Width="200px" />
                    </div>
                    <div class="col-md-8">
                        <asp:Label ID="lblprodname" Font-Size="28px" ForeColor="Maroon" runat="server" Text=""></asp:Label>
                        <div class="marg">
                            <i class="fa fa-dollar" style="font-size: 24px"></i>
                            <asp:Label ID="lblprice" runat="server" Text="" Style="font-size: 22px;"></asp:Label>
                        </div>
                        <div class="marg">
                            <asp:Label ID="lblcatg" Font-Bold="true" runat="server" Text="" Style="font-size: 20px;">
                            </asp:Label>
                        </div>
                        <div class="marg">
                            <asp:Label ID="lblbrands" runat="server" Text="" Style="font-size: 19px;">
                            </asp:Label><br />
                        </div>
                        <div class="marg">
                            <asp:Label ID="lbldescr" runat="server" Text="" Style="font-size: 18px;"></asp:Label>
                        </div>
                        
                        <br /><br />
                        <div class="marg">
                            <asp:Button ID="btn_addtocart" CssClass="btn_cart1" runat="server" Text="Add to Cart" OnClick="btn_addtocart_Click" />
                            <asp:Button ID="btn_buynow" CssClass="btn_buynow" runat="server" Text="Buy Now" Style="margin-left: 5%;" OnClick="btn_buynow_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        
    </div>

</asp:Content>

