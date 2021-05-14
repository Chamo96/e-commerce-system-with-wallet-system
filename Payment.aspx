<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Payment.aspx.cs" Inherits="Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
    <style>

    .number::-webkit-inner-spin-button, 
    .number::-webkit-outer-spin-button { 
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0; 
    }

    </style>

   <script>

    $(document).ready(function() {
	
    $('input:radio').change(function() 
    {		
	    var radioValue = $("input[name='paymt_name']:checked").val();
		
	    if(radioValue == "" || radioValue == undefined)
	    {
		    alert("Please Select Payment Options");
	    }
	    else
	    {
		    if(radioValue == "Wallet")
		    {
		        $("#maindiv").slideDown();
		        $("#wallet_div").slideDown();
		        $("#card_div").hide();
		    }
		
		    if(radioValue == "Card")
		    {
		        $("#maindiv").slideDown();
		        $("#card_div").slideDown();
		        $("#wallet_div").hide();
                
		    }
		    
		    document.getElementById('<%=Paytmode.ClientID %>').value = radioValue;
		   
	    }
	
	
    });

      
    });

  </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container mt-3 mb-3">

	<h3 style="text-align:center; font-size: 30px;">Make Payment</h3>
	<br/>
	
	
	<div class="form-group" style="text-align: center;">
        <asp:Label ID="Label1" runat="server" Text="Payment Options:" style="font-size: 1.3rem; font-weight: 500;"></asp:Label><br/>
        	 
		<label class="radio-inline">
			<input type="radio" name="paymt_name" id="paymt_wallet" value="Wallet"> Wallet
		</label>
		<label class="radio-inline" style="margin-left:5%;">
			<input type="radio" name="paymt_name" id="paymt_crcard" value="Card"> Card
		</label><br/>
						
	</div>
	<br/>
			

    <div class="row" id="maindiv" style="display: none;">
        <div class="col-md-8 col-lg-8 mx-auto p-3 bg-white rounded shadow-lg">
            <div class="row">
                <div class="col-md-6 col-lg-6" id="wallet_div" style="display: none;">
                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <asp:Label ID="Label10" runat="server" Text="Wallet Amount (Balance):"></asp:Label>
                            <asp:TextBox ID="txtbx_balance" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-12 col-lg-12">
                            <asp:Label ID="Label11" runat="server" Text="Shipping Address:"></asp:Label>
                            <asp:TextBox ID="txtbx_shpaddr" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Enter Shipping Address" Rows="5" ValidationGroup="makpaymnt1"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtbx_shpaddr" ErrorMessage="Please Enter Shipping Address" ForeColor="Red" ValidationGroup="makpaymnt1"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6" id="card_div" style="display: none;">
                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <asp:Label ID="Label13" runat="server" Text="Shipping Address:"></asp:Label>
                            <asp:TextBox ID="txtbx_shpcard" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Enter Shipping Address" Rows="5" ValidationGroup="makpaymnt1"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtbx_shpcard" ErrorMessage="Please Enter Shipping Address" ForeColor="Red" ValidationGroup="makpaymnt1"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <asp:Label ID="Label5" runat="server" Text="Name on Card"></asp:Label>
                    <asp:TextBox ID="name_card" runat="server" placeholder="Enter Name on Card" CssClass="form-control" ValidationGroup="makpaymnt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="name_card" ErrorMessage="Please Enter Name on Card" ForeColor="Red" ValidationGroup="makpaymnt"></asp:RequiredFieldValidator><br />
                    <br />

                    <asp:Label ID="Label7" runat="server" Text="Card No"></asp:Label>
                    <asp:TextBox ID="cardno" runat="server" type="number" onKeyPress="if(this.value.length==16) return false;" onblur="if(this.value.length<16) alert('Please Enter 16 Digit Card No.')" placeholder="Enter Card No" CssClass="form-control number" ValidationGroup="makpaymnt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="cardno" ErrorMessage="Please Enter Card No" ForeColor="Red" ValidationGroup="makpaymnt"></asp:RequiredFieldValidator><br />
                    <br />

                    <asp:Label ID="Label8" runat="server" Text="CVV"></asp:Label>
                    <asp:TextBox ID="cvv" runat="server" placeholder="Enter CVV" onKeyPress="if(this.value.length==3) return false;" onblur="if(this.value.length<3) alert('Please Enter 3 Digit CVV No.')" type="number" CssClass="form-control number" ValidationGroup="makpaymnt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="cvv" ErrorMessage="Please Enter CVV" ForeColor="Red" ValidationGroup="makpaymnt"></asp:RequiredFieldValidator><br />
                    <br />

                    <asp:Label ID="Label9" runat="server" Text="Expiry Month & Year"></asp:Label>
                    <div class="row">
                        <div class="col-md-3 col-lg-3">
                            <asp:TextBox ID="txtbx_mm" type="number" placeholder="mm" onKeyPress="if(this.value.length==2) return false;" onblur="if(this.value.length<2) alert('Please Enter Valid Month')" runat="server" CssClass="form-control number" ValidationGroup="makpaymnt"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtbx_mm" ErrorMessage="Please Enter Expiry Month" ForeColor="Red" ValidationGroup="makpaymnt"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2 col-lg-2" style="padding-right: 0px !important; padding-left: 0px !important; max-width: 1.666667%;">
                            <span style="font-size: 20px;">/</span>
                        </div>
                        <div class="col-md-3 col-lg-3">
                            <asp:TextBox ID="txtbx_yy" type="number" placeholder="yy" onKeyPress="if(this.value.length==4) return false;" onblur="if(this.value.length<4) alert('Please Enter Valid Year')" runat="server" CssClass="form-control number" ValidationGroup="makpaymnt"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtbx_yy" ErrorMessage="Please Enter Expiry Year" ForeColor="Red" ValidationGroup="makpaymnt"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <asp:Label ID="Label2" runat="server" Text="Total:" Font-Size="20px" Font-Bold="true"></asp:Label>
                    <asp:TextBox ID="txtbx_totalamt" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>

                    <%--<asp:Label ID="lbl_paymntval" Visible="false" runat="server" ForeColor="Red" Font-Size="20px" Text="Insuffecient cash in wallet"></asp:Label>--%>

                </div>

            </div>

            <div class="row text-center mt-5">
                <div class="col-md-12 col-lg-12">
                    <asp:Button ID="btn_mkpaymnt" runat="server" CssClass="btn btn-primary" Text="Make Payment" ValidationGroup="makpaymnt" OnClick="btn_mkpaymnt_Click" />
                </div>
            </div>

        </div>
    </div>
    
	     
    <asp:HiddenField ID="Paytmode" runat="server" Value="" />  	
													
        		   				   
</div>

    <script>

        $('.number').keyup(function () {
            this.value = this.value.replace(/[^0-9\.]/g, '');
        });

    </script>


</asp:Content>