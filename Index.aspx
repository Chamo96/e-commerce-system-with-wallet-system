<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

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
     

    <style>
        
        .h1_heading{
            /*display: table-cell;*/
            vertical-align: middle;
            text-align: right;
            margin-top:1%;
            font-size: 65px;
            color: #09229b9c;
            font-weight:bold;
            font-family:AlexBrushRegular;
        }

    </style>
   
     
</head>
<body style="background: url(images/Login_banner.png) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;">
    <div class="mainContent">
        <form id="form1" runat="server">

            <nav class="navbar navbar-expand-lg navbar-dark bg-info bg-dark p-2">
                <a class="navbar-brand" href="#"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto" style="margin-right: 5%;">
                        <li class="nav-item">
                            <a class="nav-link" href="Login.aspx?logintype=user"><i class="fa fa-users"></i> USER LOGIN</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Login.aspx?logintype=admin"><i class="fa fa-user-circle"></i> ADMIN LOGIN</a>
                        </li>
                    </ul>
                </div>
            </nav>

            <h1 class="container h1_heading">Slippyshop</h1>

        </form>
    </div>
    
    <div class="footer text-right">
        <h5 class="footerp">Slippyshop | Chamod Dulantha 1941029</h5>
    </div>

</body>


</html>

