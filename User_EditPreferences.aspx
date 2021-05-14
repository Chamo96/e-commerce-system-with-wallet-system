<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="User_EditPreferences.aspx.cs" Inherits="User_EditPreferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
          .carousel-control-next, .carousel-control-prev{
        width: 10%!important;
      }
    </style>
    
    <script type="text/javascript">

     function selc(s) {
            var catg = s.value;

            var btntext = s.textContent;

            var HiddenField_uid = $('#<%=HiddenField_uid.ClientID %>').val();

            var html = "";

            $.ajax({
                type: "POST",
                url: 'User_EditPreferences.aspx/GetSubCatg',
                data: '{catg: "' + catg + '",HiddenField_uid: "' + HiddenField_uid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
 
                    $('#<%=btn_Proceed.ClientID %>').hide();

                    //$("#div_subcatg").empty();

                    if (btntext == "Select") {

                     var j = 0;

                    if (msg.d == "") {

                        alert("No Sub Categories to display");
                        //$("#Subcatg_maindiv").hide();              

                    }
                    else {                     
                        
                   if($('#<%=Hf_categories.ClientID %>').val() == ""){
                        var catgnames = catg;
                    }
                    else if($('#<%=Hf_categories.ClientID %>').val() == catg){
                        var catgnames = $('#<%=Hf_categories.ClientID %>').val();
                    }
                    else {
                        var catgnames = $('#<%=Hf_categories.ClientID %>').val() + "," + catg;
                    }

                    $('#<%=Hf_categories.ClientID %>').val(catgnames);

                   
                        $("[id='btn_selcatg" + catg + "']").addClass("btn-danger");
                        $("[id='h5_" + catg + "']").css("color", "maroon");

                        $("[id='btn_selcatg" + catg + "']").text("Remove");

                        if ($("[id='itemdiv_" + catg + "']").hasClass("item_selected")) {

                        }
                        else {
                            $("[id='itemdiv_" + catg + "']").css("background-color", "antiquewhite");
                        }                  

                        $("#Subcatg_maindiv").append(msg.d);
                        $("#Subcatg_maindiv").show();

                       }

                    }
                    else if (btntext == "Remove") {

                        var final = "";
                        var id = s.value;
                        var hidden = $('#<%=Hf_categories.ClientID %>').val();
                        var arr2 = hidden.split(",");
                        var count = arr2.length;
                        for (var i = 0; i < count; i++)
                        {
                            if($.trim(arr2[i]) != id)
                            {
                                final += $.trim(arr2[i]) + ",";
                            }
                        }

                        final = final.replace(/,\s*$/, "");
                        $("#<%=Hf_categories.ClientID %>").val(final);

                        $("[id='carouselExampleControls_" + catg + "']").hide();
                        $("[id='h5_" + catg + "']").css("color", "#000");
                        $("[id='btn_selcatg" + catg + "']").removeClass("btn-danger");
                        
                        $("[id='btn_selcatg" + catg + "']").text("Select");

                        if ($("[id='itemdiv_" + catg + "']").hasClass("item_selected")) {
                            $("[id='btn_selcatg" + catg + "']").addClass("btn-success");
                        }
                        else {
                            $("[id='btn_selcatg" + catg + "']").addClass("btn-primary");
                            $("[id='itemdiv_" + catg + "']").css("background-color", "#d8dedca8");
                        }
                    
                        $('.divcarousel_' + catg).hide();
                          
                        $('#<%=btn_Proceed.ClientID %>').hide();

                    }
                
                },
                error: function (e) {
                    
                }
            });
     }



    function selc_brands(btn) {

            var subcatg = btn.value;

            var btn_catg = btn.className;

            var btn_catgsplit = btn_catg.split("_");

            var btntext = btn.textContent;

            var HiddenField_uid = $('#<%=HiddenField_uid.ClientID %>').val();

            var html = "";          

           
            $.ajax({
                type: "POST",
                url: 'User_EditPreferences.aspx/GetBrands',
                data: '{subcatg: "' + subcatg + '",HiddenField_uid: "' + HiddenField_uid + '",maincatg: "' + btn_catgsplit[1] + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $('#<%=btn_Proceed.ClientID %>').hide();

                    //$("#div_brands").empty();

                    if (btntext == "Select") {


                        var j = 0;

                        if (data.d == "") {
                            alert("No Brands to display");
                            //$("#Brands_maindiv").hide();

                        }
                        else {

                             if($('#<%=Hf_subcategories.ClientID %>').val() == ""){
                                var subcatgnames = subcatg;
                            }
                            else if ($('#<%=Hf_subcategories.ClientID %>').val() == subcatg) {
                                var subcatgnames = $('#<%=Hf_subcategories.ClientID %>').val();
                            }
                            else{
                                var subcatgnames = $('#<%=Hf_subcategories.ClientID %>').val() + "," + subcatg;
                            }

                            $('#<%=Hf_subcategories.ClientID %>').val(subcatgnames);


                            $("[id='btnbrands_" + subcatg + "']").addClass("btn-danger");
                            $("[id='h5_" + subcatg + "']").css("color", "maroon");

                            $("[id='btnbrands_" + subcatg + "']").text("Remove");

                            if ($("[id='itemdiv_" + subcatg + "']").hasClass("item_selected")) {

                            }
                            else {
                                $("[id='itemdiv_" + subcatg + "']").css("background-color", "antiquewhite");
                            }


                            $("#Brands_maindiv").append(data.d);
                            $("#Brands_maindiv").show();

                        }
                    }
                    else if (btntext == "Remove") {

                        var final = "";
                        var id = btn.value;
                        var hidden = $('#<%=Hf_subcategories.ClientID %>').val();
                        var arr2 = hidden.split(",");
                        var count = arr2.length;
                        for (var i = 0; i < count; i++)
                        {
                            if($.trim(arr2[i]) != id)
                            {
                                final += $.trim(arr2[i]) + ",";
                            }
                        }

                        final = final.replace(/,\s*$/, "");
                        $("#<%=Hf_subcategories.ClientID %>").val(final);


                        $("[id='carouselExampleControls_" + subcatg + "']").hide();
                        $("[id='h5_" + subcatg + "']").css("color", "#000");
                        $("[id='btnbrands_" + subcatg + "']").removeClass("btn-danger");
                        $("[id='btnbrands_" + subcatg + "']").addClass("btn-primary");
                        $("[id='btnbrands_" + subcatg + "']").removeClass("btn-success");
                        $("[id='btnbrands_" + subcatg + "']").text("Select");
                        $("[id='itemdiv_" + subcatg + "']").css("background-color", "#d8dedca8");


                        $('#<%=btn_Proceed.ClientID %>').hide();

                    }

                },
                error: function (e) {

                }
            });

    }


         function final(brands) {
            var brands_val = brands.value;

            var btntext = brands.textContent;

            if (btntext == "Select") {

                $("[id='btnfinal_" + brands_val + "']").addClass("btn-danger");
                $("[id='h5_" + brands_val + "']").css("color", "maroon");

                $("[id='btnfinal_" + brands_val + "']").text("Remove");

                if ($("[id='itemdiv_" + brands_val + "']").hasClass("item_selected")) {

                }
                else {
                    $("[id='itemdiv_" + brands_val + "']").css("background-color", "antiquewhite");
                }


                if($('#<%=Hf_brands.ClientID %>').val() == ""){
                    var brandnames = brands_val;
                }
                else if ($('#<%=Hf_brands.ClientID %>').val() == brands_val) {
                    var brandnames = $('#<%=Hf_brands.ClientID %>').val();
                }
                else{
                    var brandnames = $('#<%=Hf_brands.ClientID %>').val() + "," + brands_val;
                }

                $('#<%=Hf_brands.ClientID %>').val(brandnames);

                $('#<%=btn_Proceed.ClientID %>').show();

            }
            else if (btntext == "Remove") {

                 var final = "";
                 var id = brands.value;
                 var hidden = $('#<%=Hf_brands.ClientID %>').val();
                 var arr2 = hidden.split(",");
                 var count = arr2.length;
                 for (var i = 0; i < count; i++)
                 {
                     if($.trim(arr2[i]) != id)
                     {
                         final += $.trim(arr2[i]) + ",";
                     }
                 }

                 final = final.replace(/,\s*$/, "");
                 $("#<%=Hf_brands.ClientID %>").val(final);

                $("[id='carouselExampleControls_" + brands_val + "']").hide();
                $("[id='h5_" + brands_val + "']").css("color", "#000");
                $("[id='btnfinal_" + brands_val + "']").removeClass("btn-danger");

                if ($("[id='itemdiv_" + brands_val + "']").hasClass("item_selected")) {
                    $("[id='btnfinal_" + brands_val + "']").addClass("btn-success");
                }
                else {
                    $("[id='btnfinal_" + brands_val + "']").addClass("btn-primary");
                    $("[id='itemdiv_" + brands_val + "']").css("background-color", "#d8dedca8");
                }

                $("[id='btnfinal_" + brands_val + "']").text("Select");
                
                 if (final != "") {
                     $('#<%=btn_Proceed.ClientID %>').show();
                 }
                 else {
                     $('#<%=btn_Proceed.ClientID %>').hide();
                 }               
                
            }
         
        }


    </script>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container mb-5" style="margin-top:6%;">
            <h4 class="text-center">Edit Your Prefrences: </h4><br />

            <h5 class="text-left">Select Preferred Category :</h5>

                <div id="carouselExampleControls" class="carousel slide my-4" data-ride="carousel">
				  <div class="carousel-inner">
                        <div id="div_catg" runat="server" style="margin-left: 5%;"></div>
                    </div>
					<a class="carousel-control-prev card_lefticon_div" href="#carouselExampleControls" role="button" data-slide="prev">
						<span class="fas fa-angle-left card_lefticon" id="id_card_lefticon" runat="server" aria-hidden="true" style="color: black;font-size: 30px;"></span>
						<span class="sr-only">Previous</span>
					</a>
					  <a class="carousel-control-next card_righticon_div" href="#carouselExampleControls" role="button" data-slide="next">
						<span class="fas fa-angle-right card_righticon" id="id_card_righticon" runat="server" aria-hidden="true" style="color: black;font-size: 30px;"></span>
						<span class="sr-only">Next</span>
					</a>

				</div>
                <hr />


             <%-- <h5 class="text-left">Select Sub Category :</h5>--%>

                <div id="Subcatg_maindiv" style="display:none;"></div>

               <%-- <div id="carouselExampleControls1" class="carousel slide my-4" data-ride="carousel">
                    <div class="carousel-inner">
                        <div id="div_subcatg"></div>
                    </div>
                    <a class="carousel-control-prev card_lefticon_div" href="#carouselExampleControls1" role="button" data-slide="prev">
                        <span class="fas fa-angle-left card_lefticon" id="id_card_lefticon1" aria-hidden="true" style="color: black; font-size: 30px;"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next card_righticon_div" href="#carouselExampleControls1" role="button" data-slide="next">
                        <span class="fas fa-angle-right card_righticon" id="id_card_righticon1" aria-hidden="true" style="color: black; font-size: 30px;"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>--%>


           
               <%-- <h5 class="text-left">Select Brands :</h5>--%>

                <div id="Brands_maindiv" style="display:none;"></div>

                <%--<div id="carouselExampleControls2" class="carousel slide my-4" data-ride="carousel">
                    <div class="carousel-inner">
                        <div id="div_brands"></div>
                    </div>
                    <a class="carousel-control-prev card_lefticon_div" href="#carouselExampleControls2" role="button" data-slide="prev">
                        <span class="fas fa-angle-left card_lefticon" id="id_card_lefticon2"  aria-hidden="true" style="color: black; font-size: 30px;"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next card_righticon_div" href="#carouselExampleControls2" role="button" data-slide="next">
                        <span class="fas fa-angle-right card_righticon" id="id_card_righticon2" aria-hidden="true" style="color: black; font-size: 30px;"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>--%>

            <div class="row text-center">
                <div class="col-md-12 col-lg-12">
                     <asp:Button ID="btn_Proceed" runat="server" Text="Submit" OnClick="btn_Proceed_Click" CssClass="btn btn-info" style="display:none;" />
                </div>
            </div>

           <asp:HiddenField ID="HiddenField_uid" runat="server" Value="" /> 
           <asp:HiddenField ID="Hf_categories" runat="server" Value="" />
           <asp:HiddenField ID="Hf_subcategories" runat="server" Value="" />
           <asp:HiddenField ID="Hf_brands" runat="server" Value="" />
           
     </div>

</asp:Content>