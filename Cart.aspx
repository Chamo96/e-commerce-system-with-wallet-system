<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Cart.aspx.cs" Inherits="Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>

          tbody {
                display: block;
                height: 450px;
                overflow: auto;
            }

           thead, tbody tr {
             display: table;
             width: 100%;
             table-layout: fixed;
          }

          tbody td {
               word-break: break-word;
          }

        .hidden-field
         {
             display:none;
         }

    </style>

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
             <div class="col-md-6 col-lg-6">
                 <h4 style="color: maroon;">My Cart (<span runat="server" id="noOfItems" style="color:black; font-size:20px;"></span>)</h4>
             </div>
              <div class="col-md-6 col-lg-6 text-right">
                  Wallet Balance Amt. : <i class="fa fa-dollar" style="font-size:24px"></i> <asp:Label ID="lblwallet" Font-Bold="true" Font-Size="19px" runat="server" Text=""></asp:Label>
             </div>
         </div>
        

         <div class="row text-center">
             <div class="col-md-12">
                 <asp:Label ID="lblno" Style="font-weight: bold; font-size: 22px;" runat="server" Text="" Visible="false"></asp:Label>
             </div>
         </div>

        <div class="row mt-3">
            <div class="col-md-12 col-lg-12">
                <div class="table-responsive" id="UsersTableArea">
                    <asp:GridView ID="GridView1" CssClass="UsersTable table table-striped table-bordered table-hover text-center" Width="100%" runat="server" CellPadding="4"
                         Style="font-size: large; font-family: 'Century Gothic'" BackColor="White" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                         BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" AutoGenerateColumns="false">
                         <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                         <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                         <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                         <RowStyle BackColor="White" ForeColor="#003399" />
                         <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                         <SortedAscendingCellStyle BackColor="#EDF6F6" />
                         <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                         <SortedDescendingCellStyle BackColor="#D6DFDF" />
                         <SortedDescendingHeaderStyle BackColor="#002876" />
                        <Columns>
                            <asp:ImageField DataImageUrlField="image" HeaderText="Image" ControlStyle-Width="100px"></asp:ImageField>
                            <asp:BoundField DataField="pname" HeaderText="Product Name" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="brands" HeaderText="Brand" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="descr" HeaderText="Description" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="price" HeaderText="Total Price" HeaderStyle-CssClass="GridHeader" />                       
                            <asp:BoundField DataField="pid" HeaderText="PId" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"></asp:BoundField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" CommandArgument='<%# Eval("pid")%>' CommandName="Del"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </div>
            </div>
        </div>
        <br />

         <div class="text-left">
             <asp:Panel ID="Panel_TotalPrice" runat="server">
                 <h5>Total Price:
                     <i class="fa fa-dollar" style="font-size:24px"></i> <asp:Label ID="lbl_totalPrice" runat="server" Text=""></asp:Label></h5>
                 
                 <asp:Button ID="btn_payt" CssClass="btn_buynow" runat="server" Text="Place Order" Width="15%" OnClick="btn_payt_Click" />
             </asp:Panel>
         </div>

        <asp:HiddenField ID="HiddenField_pid" runat="server" Value="" />

         <div class="row mt-4">
            <div class="col-md-12 col-lg-12">
                <asp:Label ID="lbl_related" runat="server" Font-Bold="true" Font-Size="19px" Text="Related Products on the basis of your Preferences:" Visible="false"></asp:Label><br/>
                <div class="row" runat="server" id="div_ProdsCart">
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

          <div class="row mt-2">
            <div class="col-md-12 col-lg-12">
                <asp:Label ID="lblRecomm" runat="server" Font-Bold="true" Font-Size="19px" Text="Recommended Products :" Visible="false"></asp:Label><br/>
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

         <div class="row mt-5">
            <div class="col-md-12 col-lg-12">
                <div class="table-responsive" id="RecommendTableArea">
                    <asp:Label ID="lblRecommendMsg" runat="server" Font-Bold="true" Font-Size="19px" Text="Recommand Products :" Visible="false"></asp:Label><br/>
                    <asp:GridView ID="GridView2" CssClass="UsersTable table table-striped table-bordered table-hover text-center" Width="100%" runat="server" CellPadding="4"
                         Style="font-size: large; font-family: 'Century Gothic'" BackColor="White" 
                         BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" AutoGenerateColumns="false">
                         <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                         <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                         <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                         <RowStyle BackColor="White" ForeColor="#003399" />
                         <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                         <SortedAscendingCellStyle BackColor="#EDF6F6" />
                         <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                         <SortedDescendingCellStyle BackColor="#D6DFDF" />
                         <SortedDescendingHeaderStyle BackColor="#002876" />
                        <Columns>
                            <asp:ImageField DataImageUrlField="image" HeaderText="Image" ControlStyle-Width="100px"></asp:ImageField>
                            <asp:BoundField DataField="pname" HeaderText="Product Name" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="brands" HeaderText="Brand" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="descr" HeaderText="Description" HeaderStyle-CssClass="GridHeader" />
                            <asp:BoundField DataField="price" HeaderText="Total Price" HeaderStyle-CssClass="GridHeader" />                       
                            <asp:BoundField DataField="pid" HeaderText="PId" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"></asp:BoundField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <%--<asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" CommandArgument='<%# Eval("pid")%>' CommandName="Del"></asp:LinkButton>--%>
                                    <button id="btnaddtocart" type="button" class='btn_cart pt-2 mt-2' onclick="prods(<%# Eval("pid") %>)">Add to Cart</button>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </div>
            </div>
        </div>

         <asp:Button ID="Btn_Cart" runat="server" Text="Cart" OnClick="Btn_Cart_Click" style="display: none;" />
         <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
     
   </div>

</asp:Content>
