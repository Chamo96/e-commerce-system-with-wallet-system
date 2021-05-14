<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageCategory.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="ManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
      tbody {
        display: block;
        height: 450px;
        overflow:auto;
    }
    thead, tbody tr {
        display:table;
        width:100%;
        table-layout:fixed;
    }

    tbody td{	
	    word-break: break-word;	
    }	

        .hidden-field
         {
             display:none;
         }

    </style>

<script>

    function btn_add() {
        $('#Panel_AddCatg').show();
        $('#add_button').hide();
    }

    
    function GetSelectedRow(lnk) {
        var row = lnk.parentNode.parentNode;
        var rowIndex = row.rowIndex - 1;
        var catgid = row.cells[0].innerText;
        var catgname = row.cells[1].innerText;
        var subcatg = row.cells[2].innerText;

        document.getElementById('<%=txtbx_updcatg.ClientID%>').value = catgname;
        document.getElementById('<%=txtbx_updsubcatg.ClientID%>').value = subcatg;
        document.getElementById('<%=catgid_upd.ClientID%>').value = catgid;
    
        $('#Panel_EditCatg').show();

        return false;

    }

    function btn_editclose() {
        $('#Panel_EditCatg').hide();
    }

    function btn_addclose() {
        $('#Panel_AddCatg').hide();
        $('#add_button').show();
    }


</script>

</asp:Content>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <div class="container-fluid" style="margin-top:7%;">
        
          <div class="row text-left">
              <div class="col-md-12">
                  <asp:Label ID="lblno" Style="font-weight: bold; font-size: 24px;" runat="server" Text="" Visible="false"></asp:Label>
              </div>
          </div>

          <div class="row">
              <div class="col-md-6 col-lg-6">
                  <div class="row">
                      <div class="col-md-8 col-lg-8">
                          <asp:Panel ID="Panel_search" runat="server">
                              <div class="input-group">
                                  <asp:TextBox ID="search_name" runat="server" class="form-control" placeholder="Search Category"></asp:TextBox>
                                  <div class="input-group-btn">
                                      <button class="btn btn-primary" id="btn_search" type="submit" runat="server" onserverclick="btn_search_ServerClick">
                                          <i class="fa fa-search" aria-hidden="true" style="font-size: 17px;"></i>
                                      </button>
                                  </div>
                              </div>
                          </asp:Panel>
                      </div>

                      <div class="col-md-4 col-lg-4">
                          <input id="add_button" type="button" onclick="btn_add();" class="btn btn-primary" value="Add" style="float: right;" />
                      </div>
                  </div>

                  <div class="row mt-3">
                      <div class="col-md-12">
                          <div class="table-responsive" id="CatgTableArea">
                              <asp:GridView ID="GridView1" CssClass="CatgTable table table-striped table-bordered table-hover text-center" Width="100%" runat="server" CellPadding="4"
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
                                      <asp:BoundField DataField="catgid" HeaderText="CatgID" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"></asp:BoundField>
                                      <asp:BoundField DataField="catg" HeaderText="Category"></asp:BoundField>
                                      <asp:BoundField DataField="subcatg" HeaderText="Sub-Category"></asp:BoundField>
                                      <asp:TemplateField HeaderText="Action">
                                          <ItemTemplate>
                                              <asp:LinkButton ID="btnEdit" CssClass="btn btn-success" runat="server" Text="Edit" OnClientClick="return GetSelectedRow(this)"></asp:LinkButton>
                                          </ItemTemplate>
                                      </asp:TemplateField>
                                  </Columns>
                              </asp:GridView>
                          </div>
                      </div>
                  </div>
              </div>

              <div class="col-md-6 col-lg-6">
                  <div id="Panel_AddCatg" style="display:none;">
                      <div class="row">
                          <div class="col-md-12 col-lg-12 bg-white rounded shadow-lg p-3">

                              <h4>Add Category Products</h4>

                              <div class="col-md-12 col-lg-12">
                                  <div class="form-group">
                                      <asp:Label ID="lblnme" runat="server" Text="Category Name:"></asp:Label>
                                      <asp:TextBox ID="txtbx_catgname" runat="server" class="form-control" placeholder="Enter Category Name"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="AddCatg" ControlToValidate="txtbx_catgname" ForeColor="Red" ErrorMessage="Please Enter Category Name"></asp:RequiredFieldValidator>
                                  </div>
                              </div>

                              <div class="clearfix"></div>

                              <div class="col-md-12 col-lg-12">
                                  <div class="form-group">
                                      <asp:Label ID="Label1" runat="server" Text="Sub-Category Name:"></asp:Label>
                                      <asp:TextBox ID="txtbx_subcatg" runat="server" class="form-control" placeholder="Enter Sub-Category Name"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="AddCatg" runat="server" ControlToValidate="txtbx_subcatg" ForeColor="Red" ErrorMessage="Please Enter Sub-Category Name"></asp:RequiredFieldValidator>
                                  </div>
                              </div>

                              <div class="clearfix"></div>

                              <div class="col-md-12 col-lg-12 text-center">
                                  <asp:Button ID="Buttonsbmt" class="btn btn-primary" ValidationGroup="AddCatg" runat="server" Text="Submit" OnClick="Buttonsbmt_Click" />                                
                                  <button class="btn btn-danger" id="Buttonclose" onclick="btn_addclose();">Close</button>
                              </div>

                             
                          </div>
                      </div>
                     
                  </div>

                  <div id="Panel_EditCatg" style="display:none;">

                      <div class="row">
                          <div class="col-md-12 col-lg-12 bg-white rounded shadow-lg p-3">

                              <h4>Edit Category Products</h4>

                              <div class="col-md-12 col-lg-12">
                                  <div class="form-group">
                                      <asp:Label ID="Label2" runat="server" Text="Category Name:"></asp:Label>
                                      <asp:TextBox ID="txtbx_updcatg" runat="server" class="form-control" placeholder="Enter Category Name"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="EditCatg" runat="server" ControlToValidate="txtbx_updcatg" ForeColor="Red" ErrorMessage="Please Enter Category Name"></asp:RequiredFieldValidator>
                                  </div>
                              </div>

                              <div class="clearfix"></div>

                              <div class="col-md-12 col-lg-12">
                                  <div class="form-group">
                                      <asp:Label ID="Label3" runat="server" Text="Sub-Category Name:"></asp:Label>
                                      <asp:TextBox ID="txtbx_updsubcatg" runat="server" class="form-control" placeholder="Enter Sub-Category Name"></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="EditCatg" runat="server" ControlToValidate="txtbx_updsubcatg" ForeColor="Red" ErrorMessage="Please Enter Sub-Category Name"></asp:RequiredFieldValidator>
                                  </div>
                              </div>

                              <div class="clearfix"></div>
                           
                              <input type="hidden" id="catgid_upd" value="" runat="server" />

                              <div class="col-md-12 col-lg-12 text-center">
                                  <asp:Button ID="Btn_editsub" class="btn btn-primary" runat="server" Text="Submit" ValidationGroup="EditCatg" OnClick="Btn_editsub_Click" />
                                  <button class="btn btn-danger" id="Btn_editclose" onclick="btn_editclose();">Close</button>
                              </div>


                          </div>
                      </div>

                 
                  </div>



              </div>
          </div>

          
 
    </div>

     

    <script>

      $(document).ready(function () {
            Search_Catg();
      });

     <%-- $("#<%=txtbx_catgname.ClientID%>").change(function () {
          Search_SubCatg();
      });--%>

        function Search_Catg() {

        $('#<%=txtbx_catgname.ClientID%>').autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ManageCategory.aspx/GetCatg",
                    data: '{}',
                    dataType: "json",
                    success: function (data) {
                        response(data.d);                       
                    },
                    error: function (result) {
                        alert("No Match");
                    }
                });
            }
        });

        }


       <%-- function Search_SubCatg() {

            var test = $('#<%=txtbx_catgname.ClientID%>').val();

             $('#<%=txtbx_subcatg.ClientID%>').autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "ManageCategory.aspx/GetSubCatg",
                    data: '{txtbx_catgname:"' + test + '"}',
                    dataType: "json",
                    success: function (data) {
                        response(data.d);
                        
                    },
                    error: function (result) {
                        alert("No Match");
                    }
                });
            }
        });
     
        }--%>

    </script>
   
</asp:Content>
