<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Slippyshop</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/StyleSheet.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>

<body style="background-color:#a1d7d0c4;">
    <form id="form1" runat="server">
    <div class="container-fluid mt-4">
	    <div class="row">
	    <div class="col-md-4 mt-4 mx-auto shadow-lg p-3 mb-5 bg-white rounded">
		    <div class="col-md-12 text-center">
			    <h4 class="text-dark">Verify</h4>                
		    </div>

            <asp:Panel ID="Panel_Verify" runat="server">
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" Text="Email Address:"></asp:Label>
                    <asp:TextBox ID="txtbx_email" CssClass="form-control" runat="server" type="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="red" runat="server" ValidationGroup="btnverify" ControlToValidate="txtbx_email" Display="Dynamic" ErrorMessage="Please Enter Email ID"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="btnverify" Display="Dynamic" ID="RegularExpressionValidator1" ControlToValidate="txtbx_email" runat="server" ErrorMessage="Invalid Email ID"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" Text="Mobile No.:"></asp:Label>
                    <asp:TextBox ID="txtbx_mobno" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="red" runat="server" Display="Dynamic" ControlToValidate="txtbx_mobno" ValidationGroup="btnverify" ErrorMessage="Please Enter Mobile No."></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMobNo" runat="server" ErrorMessage="Invalid Mobile No."
                        ValidationExpression="^([0-9]{10})$" ControlToValidate="txtbx_mobno" Display="Dynamic" ValidationGroup="btnverify"
                        ForeColor="Red"></asp:RegularExpressionValidator>
                </div>

                <asp:Label ID="lbl_val" ForeColor="Red" Visible="false" Text="User details does not match" runat="server"></asp:Label><br />

                <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Verify" ValidationGroup="btnverify" OnClick="Button1_Click" />
               
                 <center style="color: blue; font-weight: bold;"><a href="Login.aspx?logintype=user"> <i class="fa fa-arrow-left"></i> Back</a></center>
			     <br/>

            </asp:Panel>

            <asp:Panel ID="Panel_ChangePass" runat="server" Visible="false">
                <div class="form-group">
                    <asp:Label ID="Label3" runat="server" Text="New Password:"></asp:Label>
                    <asp:TextBox ID="txtbx_newpass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="red" runat="server" Display="Dynamic" ValidationGroup="btnchangepass" ControlToValidate="txtbx_newpass" ErrorMessage="Please Enter New Password"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegExp1" runat="server"
                        ErrorMessage="Password must contain: Minimum 8 characters atleast 1 UpperCase Alphabet, 1 LowerCase Alphabet and 1 Number"
                        ControlToValidate="txtbx_newpass"
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" Display="Dynamic" ForeColor="red" />                        
                </div>

                <div class="form-group">
                    <asp:Label ID="Label4" runat="server" Text="Confirm Password:"></asp:Label>
                    <asp:TextBox ID="txtbx_confpass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="red" runat="server" ControlToValidate="txtbx_confpass" ValidationGroup="btnchangepass" ErrorMessage="Please Enter Confirm Password" Display="Dynamic"></asp:RequiredFieldValidator><br />
                    <asp:Label ID="lbl_cnfpass" ForeColor="Red" Visible="false" Text="Confirm Password must be same as Old Password" runat="server"></asp:Label>
                </div>

                <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="btnchangepass" OnClick="Button2_Click" />

            </asp:Panel>

            <asp:HiddenField ID="HiddenField_emailid" runat="server" value="" />

	    </div>
	    </div>
    </div>
    </form>
</body>
</html>
