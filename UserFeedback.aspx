<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserFeedback.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="UserFeedback" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .contact-form{
    background: #d3d3d370;
    margin-top: 10%;
    margin-bottom: 5%;
    width: 70%;
}
.contact-form .form-control{
    border-radius:1rem;
}
.contact-image{
    text-align: center;
}
.contact-image img{
    border-radius: 6rem;
    width: 11%;
    margin-top: -6%;
    /*transform: rotate(29deg);*/
}
.contact-form .form{
    padding: 14%;
}
.contact-form .form .row{
    margin-bottom: -7%;
}
.contact-form h3{
    margin-bottom: 8%;
    margin-top: -10%;
    text-align: center;
    color: #0062cc;
}
.contact-form .btnContact {
    width: 50%;
    border: none;
    border-radius: 1rem;
    padding: 1.5%;
    background: #dc3545;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
}
.btnContactSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #fff;
    background-color: #0062cc;
    border: none;
    cursor: pointer;
}
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container contact-form">
            <div class="contact-image">
                <img src="images/comments.jpg" alt="comment images"/>
            </div>
     
        <div class="form">
            <h3>Give Your Feedback</h3>
            <div class="row">
                <div class="col-md-8 mx-auto">
                    <div class="form-group">
                        <asp:TextBox ID="txtfeedback" runat="server" class="form-control" placeholder="Your Comments *" Style="width: 100%; height: 150px;" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtfeedback" ForeColor="Red" ErrorMessage="Please Enter Comments"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="btnSubmit" runat="server" class="btnContact" Text="Send" OnClick="btnSubmit_Click" />
                    </div>

                </div>
            </div>

        </div>

    </div>



















</asp:Content>