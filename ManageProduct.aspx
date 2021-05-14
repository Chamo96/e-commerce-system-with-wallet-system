<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProduct.aspx.cs" Inherits="Manageproduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
	
      .hidden-field
         {
             display:none;
         }

    </style>

    <script>

        function add() {
            $("#myModalAdd").modal('show');
            return false;
        }

        <%--function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('<%=fileid.ClientID%>').css('visibility', 'visible');
                    //$('<%=fileid.ClientID%>').attr('src', e.target.result);
                    document.getElementById("<%=fileid.ClientID%>").setAttribute('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }--%>

        function fileupload() {
            document.getElementById('<%=btn_image.ClientID %>').style.display= 'block';
        }



        function GetSelectedRow(lnk) {
            var row = lnk.parentNode.parentNode;    
            var rowIndex = row.rowIndex - 1;
            var pid = row.cells[0].innerText;
            var image = row.cells[1].innerHTML;
            var pname = row.cells[2].innerText;
            var catg = row.cells[3].innerText;
            var subcatg = row.cells[4].innerText;
            var brands = row.cells[5].innerText;
            var descr = row.cells[6].innerText;
            var price = row.cells[7].innerText;

            document.getElementById('<%=HiddenField_pid.ClientID%>').value = pid;

            document.getElementById('img_div').innerHTML = image;         
            
            document.getElementById('<%=txtbx_pname_upd.ClientID%>').value = pname;
            document.getElementById('<%=dd_catg_upd.ClientID%>').value = catg;
            document.getElementById('<%=HiddenField_subcatg.ClientID%>').value = subcatg;
            document.getElementById('<%=txtbx_brands_upd.ClientID%>').value = brands;   
            document.getElementById('<%=txtbx_descr_upd.ClientID%>').value = descr;
            document.getElementById('<%=txtbx_price_upd.ClientID%>').value = price;
          

            $("#myModalEdit").modal('show');

            return false;

        }


          function GetSelectedRow1(lnk) {
            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var pid = row.cells[0].innerText;

            document.getElementById('<%=HiddenFieldpid_del.ClientID%>').value = pid;

            $("#myModal_Del").modal('show');

            return false;

        }

    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>

     <div class="container-fluid" style="margin-top:7%;">

        <div class="row">
            <div class="col-md-6 col-lg-6">
                <asp:Panel ID="Panel_search" runat="server">                 
                        <div class="input-group" style="width: 60%;">                         
                            <asp:TextBox ID="search_name" runat="server" class="form-control" placeholder="Search Product Name"></asp:TextBox>
                            <div class="input-group-btn">
                                <button class="btn btn-primary" id="btn_search" type="submit" runat="server" onserverclick="btn_search_ServerClick">
                                    <i class="fa fa-search" aria-hidden="true" style="font-size: 17px;"></i>
                                </button>                               
                            </div>
                        </div> 
                    </asp:Panel>               
                </div>
           
            <div class="col-md-6 col-lg-6">
                <input id="add_button" type="button" class="btn btn-primary" value="Add" onclick="return add()" style="float: right;" />
            </div>
        </div>

         <div class="row text-center">
             <div class="col-md-12">
                 <asp:Label ID="lblno" Style="font-weight: bold; font-size: 22px;" runat="server" Text="" Visible="false"></asp:Label>
             </div>
         </div>

         <div class="row mt-3">
             <div class="col-md-12">
                 <div class="table-responsive">
                     <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered table-hover text-center" Width="100%" runat="server" CellPadding="4"
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
                             <asp:BoundField DataField="Pid" HeaderText="PId" ItemStyle-CssClass="hidden-field" HeaderStyle-CssClass="hidden-field"></asp:BoundField>
                             <asp:ImageField DataImageUrlField="image" HeaderText="Image" ControlStyle-Width="200px"></asp:ImageField>
                             <asp:BoundField DataField="pname" HeaderText="Product Name" ItemStyle-Width="15%"></asp:BoundField>
                             <asp:BoundField DataField="catg" HeaderText="Category"></asp:BoundField>
                             <asp:BoundField DataField="subcatg" HeaderText="Sub Category"></asp:BoundField>
                             <asp:BoundField DataField="brands" HeaderText="Brands"></asp:BoundField>
                             <asp:BoundField DataField="descr" HeaderText="Description" ItemStyle-Width="15%"></asp:BoundField>
                             <asp:BoundField DataField="price" HeaderText="Price"></asp:BoundField>

                             <asp:TemplateField HeaderText="Action">
                                 <ItemTemplate>
                                     <asp:LinkButton ID="btnEdit" CssClass="btn btn-success" runat="server" Text="Edit" OnClientClick="return GetSelectedRow(this)"></asp:LinkButton>
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Action">
                                 <ItemTemplate>
                                     <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClientClick="return GetSelectedRow1(this)"></asp:LinkButton>
                                 </ItemTemplate>
                             </asp:TemplateField>

                         </Columns>
                     </asp:GridView>
                 </div>
             </div>

         </div>
     
</div>

    <!-- Modal Add -->
    
    <div id="myModalAdd" class="modal fade" role="dialog">
        <div class="modal-dialog" style="max-width:600px;">
           
            <!-- Modal content-->

            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add Product</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>                   
                </div>

                <div class="modal-body">
                    
                    <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="lblnme" runat="server" Text="Product Name:"></asp:Label>
                            <asp:TextBox ID="txtbx_pname" runat="server" class="form-control" placeholder="Enter Product Name" ValidationGroup="add_submit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="red" runat="server" ControlToValidate="txtbx_pname" ValidationGroup="add_submit" ErrorMessage="Please Enter Product Name"></asp:RequiredFieldValidator> 
                        </div>
                     </div>
                    
                    <div class="clearfix"></div> 

                    <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="Category:"></asp:Label>
                            <asp:DropDownList ID="DropDownList_catg" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DropDownList_catg_SelectedIndexChanged">
                                <asp:ListItem Value="--Select Category--">--Select Category--</asp:ListItem>                      
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" InitialValue="--Select Category--" ForeColor="red" runat="server" ControlToValidate="DropDownList_catg" ValidationGroup="add_submit" ErrorMessage="Please Select Category"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                    <asp:Panel ID="Panel_SubCatg" runat="server" Visible="false">
                        <div class="col-md-12 col-lg-12">
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Sub Category:"></asp:Label>
                                <asp:DropDownList ID="dd_subcatg" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="--Select Sub Category--">--Select Sub Category--</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="--Select Sub Category--" ForeColor="red" runat="server" ControlToValidate="dd_subcatg" ValidationGroup="add_submit" ErrorMessage="Please Select Sub Category"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </asp:Panel>

                    <div class="clearfix"></div> 
                    
                    <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Brands:"></asp:Label>
                            <asp:TextBox ID="txtbx_brands" runat="server" class="form-control" placeholder="Enter Brand Name" ValidationGroup="add_submit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="red" runat="server" ControlToValidate="txtbx_brands" ValidationGroup="add_submit" ErrorMessage="Please Enter Brand Name"></asp:RequiredFieldValidator> 
                        </div>
                     </div>  
                    
                     <div class="clearfix"></div>                                                 

                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                          <asp:Label ID="Label7" runat="server" Text="Price:"></asp:Label>
                          <asp:TextBox ID="txtbx_price" runat="server" class="form-control number" type="number" placeholder="Enter Price" ValidationGroup="add_submit"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ForeColor="red" runat="server" ControlToValidate="txtbx_price" ValidationGroup="add_submit" ErrorMessage="Please Enter Price"></asp:RequiredFieldValidator>                       
                        </div>
                     </div>

                     <div class="clearfix"></div>

                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                         <asp:Label ID="Label1" runat="server" Text="Description:"></asp:Label>
			               <asp:TextBox ID="txtbx_descr" runat="server" class="form-control" TextMode="MultiLine" placeholder="Enter Description" ValidationGroup="add_submit"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ForeColor="red" ControlToValidate="txtbx_descr" ValidationGroup="add_submit" runat="server" ErrorMessage="Please Enter Description"></asp:RequiredFieldValidator>
                        </div>
                     </div>

                    <div class="clearfix"></div>

                    <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="Labelage" runat="server" Text="Label">Choose Image :</asp:Label>

                            <asp:FileUpload ID="FileUpload" runat="server" accept=".png,.jpg,.jpeg" onchange="fileupload();" /><br />
                            <br />
                            <asp:Image ID="fileid" runat="server" Visible="false" Width="200px" /><br />
                            <br />
                            <asp:Button ID="btn_image" runat="server" Text="Upload Image" OnClick="btn_image_Click" />
                            <br />
                            <br />
                            <asp:Label ID="lbl_image_val" runat="server" Text="Please Upload Image" ForeColor="Red" Visible="false"></asp:Label>

                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
                <div class="modal-footer"> 
                                
                       <asp:Button ID="Buttonsbmt" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="add_submit" OnClick="Buttonsbmt_Click" />
                       <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> 
                                          
                </div>
        </div>

        </div>
    </div> 

       <!-- Modal Edit -->
    
    <div id="myModalEdit" class="modal fade" role="dialog">
        <div class="modal-dialog" style="max-width:600px;">
           
            <!-- Modal content-->

            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Edit Products</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>                   
                </div>

                <div class="modal-body">

                     <div class="col-md-12 col-lg-12 text-center" id="img_div">
                         <%--<asp:Image ID="Image_product" runat="server" Width="200px" Height="200px" />--%>
                     </div>
                    
                    <div class="clearfix"></div> 
                    
                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="Label5" runat="server" Text="Product Name:"></asp:Label>
                            <asp:TextBox ID="txtbx_pname_upd" runat="server" class="form-control" placeholder="Enter Product Name" ValidationGroup="edit_submit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ForeColor="red" runat="server" ControlToValidate="txtbx_pname_upd" ValidationGroup="edit_submit" ErrorMessage="Please Enter Product Name"></asp:RequiredFieldValidator> 
                        </div>
                     </div>
     
                    <div class="clearfix"></div>  
                    
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>

                            <div class="col-md-12 col-lg-12">
                                <div class="form-group">
                                    <asp:Label ID="Label8" runat="server" Text="Select Category:"></asp:Label>
                                    <asp:DropDownList ID="dd_catg_upd" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dd_catg_upd_SelectedIndexChanged">
                                        <asp:ListItem Value="--Select Category--">--Select Category--</asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ForeColor="red" ControlToValidate="dd_catg_upd" ValidationGroup="edit_submit" InitialValue="--Select Category--" runat="server" ErrorMessage="Please Select Category"></asp:RequiredFieldValidator>

                                    <asp:HiddenField ID="HiddenField_subcatg" runat="server" Value="" />

                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <asp:Panel ID="Panel_subcategory_upd" runat="server" Visible="false">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group">

                                        <asp:Label ID="Label9" runat="server" Text="Select Sub-Category:"></asp:Label>
                                        <asp:DropDownList ID="dd_subcatg_upd" class="form-control number" runat="server" OnSelectedIndexChanged="dd_subcatg_upd_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ForeColor="red" ControlToValidate="dd_subcatg_upd" ValidationGroup="edit_submit" InitialValue="--Select Sub-Category--" runat="server" ErrorMessage="Please Select Sub-Category"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel> 

                    <div class="clearfix"></div>                              

                    <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                            <asp:Label ID="Label6" runat="server" Text="Brands:"></asp:Label>
                            <asp:TextBox ID="txtbx_brands_upd" runat="server" class="form-control" placeholder="Enter Brand Name" ValidationGroup="edit_submit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="red" runat="server" ControlToValidate="txtbx_brands_upd" ValidationGroup="edit_submit" ErrorMessage="Please Enter Brand Name"></asp:RequiredFieldValidator>
                        </div>
                    </div>  
                    
                     <div class="clearfix"></div>                                                 

                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                          <asp:Label ID="Label12" runat="server" Text="Price:"></asp:Label>
                          <asp:TextBox ID="txtbx_price_upd" runat="server" class="form-control" type="number" placeholder="Enter Price" ValidationGroup="edit_submit"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ForeColor="red" runat="server" ControlToValidate="txtbx_price_upd" ValidationGroup="edit_submit" ErrorMessage="Please Enter Price"></asp:RequiredFieldValidator>                       
                        </div>
                     </div>

                     <div class="clearfix"></div>

                     <div class="col-md-12 col-lg-12">
                        <div class="form-group">
                           <asp:Label ID="Label13" runat="server" Text="Description:"></asp:Label>
			               <asp:TextBox ID="txtbx_descr_upd" runat="server" class="form-control" TextMode="MultiLine" placeholder="Enter Description" ValidationGroup="edit_submit"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ForeColor="red" ControlToValidate="txtbx_descr_upd" ValidationGroup="edit_submit" runat="server" ErrorMessage="Please Enter Description"></asp:RequiredFieldValidator>
                        </div>
                     </div>

                    <div class="clearfix"></div>

                    <asp:HiddenField ID="HiddenField_pid" runat="server" Value="" />

                </div>
                <div class="modal-footer"> 
                                
                       <asp:Button ID="ButtonEdit" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="edit_submit" OnClick="ButtonEdit_Click" />
                       <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> 
                                          
                </div>
        </div>

        </div>
    </div>
         
         
       <div class="modal small fade" id="myModal_Del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-header">

                         <h3 id="myModalLabel">Delete Confirmation</h3>
                         <asp:HiddenField ID="HiddenFieldpid_del" runat="server" />

                     </div>
                     <div class="modal-body">
                         <p class="error-text" style="font-size: 17px;">
                             <i class="fa fa-warning modal-icon"></i>Are you sure you want to delete?
                         </p>
                     </div>
                     <div class="modal-footer">
                         <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">No</button>
                         <asp:Button ID="btn_Yes" runat="server" CssClass="btn btn-danger" Text="Yes" OnClick="btn_Yes_Click" />

                     </div>
                 </div>
             </div>
         </div>    

</asp:Content>

