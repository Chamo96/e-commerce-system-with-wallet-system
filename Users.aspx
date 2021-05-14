<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Users.aspx.cs" Inherits="Users" %>

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

    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>

     <div class="container-fluid" style="margin-top:7%;">

        <div class="row">
            <div class="col-md-6 col-lg-6">
                <asp:Panel ID="Panel_search" runat="server">
                    <div class="input-group" style="width: 60%;">
                        <asp:TextBox ID="search_name" runat="server" class="form-control" placeholder="Search Username"></asp:TextBox>
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
                         BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" AutoGenerateColumns="false">
                         <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                         <HeaderStyle BackColor="#003399" Font-Size="17px" Font-Bold="True" ForeColor="#CCCCFF" />
                         <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                         <RowStyle BackColor="White" Font-Size="16px" ForeColor="#003399" />
                         <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                         <SortedAscendingCellStyle BackColor="#EDF6F6" />
                         <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                         <SortedDescendingCellStyle BackColor="#D6DFDF" />
                         <SortedDescendingHeaderStyle BackColor="#002876" />
                         <Columns>
                             <asp:BoundField DataField="name" HeaderText="Username"></asp:BoundField>
                             <asp:BoundField DataField="mobileno" HeaderText="Mobile No."></asp:BoundField>
                             <asp:BoundField DataField="emailid" HeaderText="Email ID"></asp:BoundField>
                             <asp:BoundField DataField="address" HeaderText="Address"></asp:BoundField>
                             <asp:BoundField DataField="country" HeaderText="Country"></asp:BoundField>
                             <asp:BoundField DataField="city" HeaderText="City"></asp:BoundField>
                             <asp:BoundField DataField="walletamt" HeaderText="Wallet Amount"></asp:BoundField>

                         </Columns>
                     </asp:GridView>
                 </div>
                     
             </div>
         </div>

    
    
</div>

</asp:Content>


