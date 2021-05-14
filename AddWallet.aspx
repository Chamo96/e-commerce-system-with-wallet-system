<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddWallet.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="AddWallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>


    <div class="container" style="margin-top: 7%;">
        <div class="row">
            <div class="col-md-6 mb-5 mx-auto">
                <div class="card">
                    <div class="card-header"><b>Add Wallet</b></div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label1" runat="server" Text="Wallet Amount"></asp:Label>
                                <asp:TextBox ID="txtbx_walletamt" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>                       
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label2" runat="server" Text="Name on Card"></asp:Label>
                                <asp:TextBox ID="name_card" runat="server" placeholder="Enter Name on Card" CssClass="form-control" ValidationGroup="addwallet"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="name_card" ErrorMessage="Please Enter Name on Card" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                       
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label3" runat="server" Text="Card No"></asp:Label>
                                <asp:TextBox ID="cardno" runat="server" type="number" onKeyPress="if(this.value.length==16) return false;" onblur="if(this.value.length<16) alert('Please Enter 16 Digit Card No.')" placeholder="Enter Card No" CssClass="form-control number" ValidationGroup="addwallet"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cardno" ErrorMessage="Please Enter Card No" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator><br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label4" runat="server" Text="CVV"></asp:Label>
                                <asp:TextBox ID="cvv" runat="server" placeholder="Enter CVV" onKeyPress="if(this.value.length==3) return false;" onblur="if(this.value.length<3) alert('Please Enter 3 Digit CVV No.')" type="number" CssClass="form-control number" ValidationGroup="addwallet"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cvv" ErrorMessage="Please Enter CVV" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator><br />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label6" runat="server" Text="Expiry Month & Year"></asp:Label>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <asp:TextBox ID="txtbx_mm" type="number" placeholder="mm" onKeyPress="if(this.value.length==2) return false;" onblur="if(this.value.length<2) alert('Please Enter Valid Month')" runat="server" CssClass="form-control number" ValidationGroup="addwallet"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtbx_mm" ErrorMessage="Please Enter Expiry Month" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-2 col-lg-2" style="padding-right: 0px !important; padding-left: 0px !important; max-width: 1.666667%;">
                                        <span style="font-size: 20px;">/</span>
                                    </div>
                                    <div class="col-md-3 col-lg-3">
                                        <asp:TextBox ID="txtbx_yy" type="number" placeholder="yy" onKeyPress="if(this.value.length==4) return false;" onblur="if(this.value.length<4) alert('Please Enter Valid Year')" runat="server" CssClass="form-control number" ValidationGroup="addwallet"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtbx_yy" ErrorMessage="Please Enter Expiry Year" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <asp:Label ID="Label5" runat="server" Text="Add Total Amount"></asp:Label>
                                <asp:TextBox ID="totalamt" runat="server" CssClass="form-control" placeholder="Enter Total Amount"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="totalamt" ErrorMessage="Please Enter Total Amount" ForeColor="Red" ValidationGroup="addwallet"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                    </div>

                    <div class="card-footer text-center">
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-info" Text="Submit" OnClick="Button1_Click" ValidationGroup="addwallet" />
                    </div>
                </div>

            </div>
        </div>

    </div>

     <script>

        $('.number').keyup(function () {
            this.value = this.value.replace(/[^0-9\.]/g, '');
        });

    </script>

</asp:Content>



