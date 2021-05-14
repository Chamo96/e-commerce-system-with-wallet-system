<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

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
<body style="background-image: url(../images/Login_banner.png); background-repeat: no-repeat; background-size: cover;">
    <form id="form1" runat="server">
    <div class="container-fluid mt-4">
	    <div class="row">
	    <div class="col-md-4 mt-4 mx-auto shadow-lg p-3 mb-5 bg-white rounded">
		    <div class="col-md-12 text-center">
			    <h4 class="text-dark" id="h4_admin" runat="server" visible="false">Admin Login</h4>
                <h4 class="text-dark" id="h4_user" runat="server" visible="false">User Login</h4>               
		    </div>

		    <div class="form-group">
                <asp:Panel ID="Panel_UserEmail" runat="server" Visible="false">
                    <asp:Label ID="Label1" runat="server" Text="Label">Email Address:</asp:Label>
                    <asp:TextBox ID="txtbx_email" CssClass="form-control" runat="server" type="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="red" runat="server" ValidationGroup="btnlogin"  ControlToValidate="txtbx_email" Display="Dynamic" ErrorMessage="Please Enter Email ID"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="btnlogin" Display="Dynamic" ID="RegularExpressionValidator1" ControlToValidate="txtbx_email" runat="server" ErrorMessage="Invalid Email ID"></asp:RegularExpressionValidator>                        
                </asp:Panel>

                 <asp:Panel ID="Panel_AdminId" runat="server" Visible="false">
                    <asp:Label ID="Label3" runat="server" Text="Admin ID:"></asp:Label>
                    <asp:TextBox ID="txtbx_adminid" CssClass="form-control" runat="server" type="text"></asp:TextBox>
                    <asp:RequiredFieldValidator  ID="RequiredFieldValidator2" ForeColor="red" runat="server" ValidationGroup="btnlogin" ControlToValidate="txtbx_adminid" ErrorMessage="Please Enter Admin ID"></asp:RequiredFieldValidator>                                      
                </asp:Panel>

		    </div>

		    <div class="form-group">        
                 <asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
                 <asp:TextBox ID="txtbx_pass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="red" runat="server" ValidationGroup="btnlogin" ControlToValidate="txtbx_pass" ErrorMessage="Please Enter Password"></asp:RequiredFieldValidator>                                      
		    </div> 

            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Login" ValidationGroup="btnlogin" OnClick="Button1_Click" />

            <asp:Panel ID="Panel_UserSignUp" runat="server" Visible ="false">
            <div class="mt-2">
                <a href="ForgotPassword.aspx"><span>Forgot Password ?</span></a><br /><br />
                <span>Not Registered ?</span> <a href="UserRegister.aspx">Sign Up</a>
            </div>
            </asp:Panel>
         
            <center style="color: blue; font-weight: bold;"><a href="Index.aspx"> <i class="fa fa-arrow-left"></i> Back</a></center>
			<br/>

	    </div>
	    </div>
    </div>

    </form>
</body>
</html>
