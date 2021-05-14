<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewOrders.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="ViewOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid" style="margin-top: 7%;">

        <div class="row">
            <div class="col-md-6 col-lg-6">
                <asp:Panel ID="Panel_search" runat="server">
                    <div class="input-group" style="width: 60%;">
                        <asp:TextBox ID="search_name" runat="server" class="form-control" placeholder="Search Order ID"></asp:TextBox>
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

        <div class="row mt-3">
            <div class="col-md-12">
                <div class="table-responsive" id="UsersTableArea">
                    <asp:GridView ID="GridView1" CssClass="UsersTable table table-striped table-bordered table-hover text-center" Width="100%" runat="server" CellPadding="4"
                        Style="font-size: large; font-family: 'Century Gothic'" BackColor="White"
                        BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Size="17px" Font-Bold="True" ForeColor="#CCCCFF" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" ForeColor="#003399" Font-Size="16px" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SortedAscendingCellStyle BackColor="#EDF6F6" />
                        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                        <SortedDescendingCellStyle BackColor="#D6DFDF" />
                        <SortedDescendingHeaderStyle BackColor="#002876" />
                        <Columns>
                            <asp:BoundField DataField="oid" HeaderText="Oid"></asp:BoundField>
                            <asp:ImageField DataImageUrlField="image" HeaderText="Image" ControlStyle-Width="100px"></asp:ImageField>
                            <asp:BoundField DataField="name" HeaderText="Username"></asp:BoundField>
                            <asp:BoundField DataField="pname" HeaderText="Product Name"></asp:BoundField>
                            <asp:BoundField DataField="brands" HeaderText="Brand"></asp:BoundField>
                            <asp:BoundField DataField="descr" HeaderText="Description"></asp:BoundField>
                            <asp:BoundField DataField="totalprice" HeaderText="Total Price"></asp:BoundField>
                            <asp:BoundField DataField="shippingaddress" HeaderText="Shipping Address"></asp:BoundField>
                            <asp:BoundField DataField="paymentstatus" HeaderText="Payment Type"></asp:BoundField>
                            <asp:BoundField DataField="status" HeaderText="Order Status"></asp:BoundField>
                            <asp:BoundField DataField="date" HeaderText="Ordered Date"></asp:BoundField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                     <asp:LinkButton ID="btnstatus" CssClass="btn btn-success" CommandArgument='<%# Eval("oid") %>' CommandName="Status" runat="server" Text="Dispatch"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </div>


    </div>


</asp:Content>