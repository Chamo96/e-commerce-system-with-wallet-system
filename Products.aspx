<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Products.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">

        function prods(pid)
        {
            $("#<%=HiddenField_pid.ClientID%>").val(pid);
            $("#<%=Btn_Cart.ClientID%>").click();
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container-fluid" style="margin-top:6%; margin-bottom:2%;">

         <div class="row">
             <div class="col-md-8 col-lg-8">
                 <asp:Panel ID="Panel_search" runat="server">
                     <div class="input-group" style="width: 50%;">
                         <asp:TextBox ID="search_name" runat="server" class="form-control" placeholder="Search Product Name"></asp:TextBox>
                         <div class="input-group-btn">
                             <button class="btn btn-primary" id="btn_search" type="submit" runat="server" onserverclick="btn_search_ServerClick">
                                 <i class="fa fa-search" aria-hidden="true" style="font-size: 17px;"></i>
                             </button>
                         </div>
                     </div>
                 </asp:Panel>
             </div>

            
           </div>
        
        <div class="row text-center">
            <div class="col-md-12">
                <asp:Label ID="lblno" Style="font-weight: bold; font-size: 22px;" runat="server" Text="" Visible="false"></asp:Label>
            </div>
        </div>

        <div class="row mt-2">
            <div class="col-md-12 col-lg-12">
                <div class="row" runat="server" id="div_Products">
                  <%--  <div class="card col-md-3 col-lg-3">
                        <div class="card-body">
                            <a href='#'>
                                <img class='img-responsive' style='width: 100%; height: 180px;' src='images/science.jpg' />

                                <h4 class='head pt-2 text-center'>Science</h4>
                            </a>

                            <div class="pt-2 text-center">
                                <i class="fa fa-dollar" style="font-size: 24px"></i>
                                <asp:Label ID='Label2' Style='font-size: 20px; font-weight: 700;' runat='server' Text='350'></asp:Label><br />
                                <br />

                                <asp:Button ID="Btn_addtocart" runat="server" Text="Add to Cart" CssClass="btn_cart pt-2" />

                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>

       </div>

       
         <asp:Button ID="Btn_Cart" runat="server" Text="Cart" OnClick="Btn_Cart_Click" style="display: none;" />
         <asp:HiddenField ID="HiddenField_pid" runat="server" Value="" />

</div>


</asp:Content>