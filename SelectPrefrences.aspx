<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectPrefrences.aspx.cs" Inherits="SelectPrefrences" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Slippyshop</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/StyleSheet.css" />
    <%--<link rel="stylesheet" href="css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="css/owl.theme.default.min.css"/>--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
   <%-- <script src="js/jquery.min.js"></script>
    <script src="js/owl.carousel.js"></script>--%>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <style>

       .item {
    height: 10rem;
    background-color: #d8dedca8;
    padding: 1rem;
    }

    </style>

    <script type="text/javascript">

        function selc(s) {
            var catg = s.value;
            
            var btntext = s.textContent;          

            var html = "";

            $.ajax({
                type: "POST",
                url: 'SelectPrefrences.aspx/GetSubCatg',
                data: '{catg: "' + catg + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    $('#<%=btn_Proceed.ClientID %>').hide();

                    //$("#div_subcatg").empty();

                    if (btntext == "Select") {

                     var j = 0;

                    if (msg.d == "") {

                        alert("No Sub Categories to display");
                        $("#Subcatg_maindiv").hide();              

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


                        $("[id='btn_selcatg"+catg+"']").addClass("btn-danger");
                        $("[id='h5_"+catg+"']").css("color", "maroon");

                        $("[id='btn_selcatg" + catg + "']").text("Remove");
                        $("[id='itemdiv_"+catg+"']").css("background-color", "antiquewhite");

                        var data_arr = new Array(msg.d);

                        var count_arr = data_arr[0].length;                       

                        html += "<div id='carouselExampleControls_" + catg + "' class='carousel slide my-4' data-ride='carousel'><h5 class='mt-2'>Preferred Sub-Categories of " + catg + "</h5><div class='carousel-inner'><div style='margin-left: 10%;margin-right: 7%;'>";

                        for (var i = 0; i < count_arr; i++) {

                            if (j == 0) {
                                html += "<div class='carousel-item active'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
                            }
                            else {
                                if (j % 4 == 0) {
                                    html += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck'  style='width: 100%'>";
                                }
                            }

                            html += "<div id='itemdiv_" + data_arr[0][i] + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + data_arr[0][i] + "'>" + data_arr[0][i] + "</h5><br/><button type='button' id='btnbrands_" + data_arr[0][i] + "' class='btn btn-primary btn_"+ catg +"' value='" + data_arr[0][i] + "' onclick='selc_brands(this)'>Select</button></div></div>";

                            j++;

                        }

                        html += "</div></div></div></div> </div><a class='carousel-control-prev card_lefticon_div' href='#carouselExampleControls_" + catg + "' role='button' data-slide='prev'><span class='fas fa-angle-left card_lefticon' id='id_card_lefticon_" + catg + "' aria-hidden='true' style='color: black; font-size: 30px; display:none;'></span><span class='sr-only'>Previous</span></a><a class='carousel-control-next card_righticon_div' href='#carouselExampleControls_" + catg + "' role='button' data-slide='next'><span class='fas fa-angle-right card_righticon' id='id_card_righticon_" + catg + "' aria-hidden='true' style='color: black; font-size: 30px; display:none;'></span><span class='sr-only'>Next</span></a><hr /></div>";


                        $("#Subcatg_maindiv").append(html);
                        $("#Subcatg_maindiv").show();


                        if (count_arr <= 3) {
                            $("#id_card_lefticon_" + catg + "").hide();
                            $("#id_card_righticon_" + catg + "").hide();
                        }
                        else {
                            $("#id_card_lefticon_" + catg + "").show();
                            $("#id_card_righticon_" + catg + "").show();
                        }

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
                        $("[id='btn_selcatg"+catg+"']").removeClass("btn-danger");
                        $("[id='btn_selcatg" + catg + "']").text("Select");
                        $("[id='itemdiv_" + catg + "']").css("background-color", "#d8dedca8");
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

            var html = "";          

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


            $.ajax({
                type: "POST",
                url: 'SelectPrefrences.aspx/GetBrands',
                data: '{subcatg: "' + subcatg + '" }',
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

                            $("[id='btnbrands_" + subcatg + "']").addClass("btn-danger");
                            $("[id='h5_" + subcatg + "']").css("color", "maroon");

                            $("[id='btnbrands_" + subcatg + "']").text("Remove");
                            $("[id='itemdiv_" + subcatg + "']").css("background-color", "antiquewhite");

                          
                            var data_arr = new Array(data.d);

                            var count_arr = data_arr[0].length;

                            html += "<div id='carouselExampleControls_" + subcatg + "' class='carousel slide my-4 divcarousel_" + btn_catgsplit[1] + "' data-ride='carousel'><h5 class='mt-2'>Preferred Brands of " + subcatg + "</h5><div class='carousel-inner'><div style='margin-left: 10%;margin-right: 7%;'>";

                            for (var i = 0; i < count_arr; i++) {

                                if (j == 0) {
                                    html += "<div class='carousel-item active'><div class='row text-center'><div class='card-deck' style='width: 100%'>";
                                }
                                else {
                                    if (j % 4 == 0) {
                                        html += "</div></div></div><div class='carousel-item'><div class='row text-center'><div class='card-deck'  style='width: 100%'>";
                                    }
                                }

                                html += "<div id='itemdiv_" + data_arr[0][i] + "' class='rounded-circle mb-4 item col-md-3'><div class='card-body'><h5 id='h5_" + data_arr[0][i] + "'>" + data_arr[0][i] + "</h5><br/><button type='button' class='btn btn-primary' id='btnfinal_" + data_arr[0][i] + "' onclick='final(this);' value='" + data_arr[0][i] + "'>Select</button></div></div>";

                                j++;

                            }

                            html += "</div></div></div></div></div><a class='carousel-control-prev card_lefticon_div' href='#carouselExampleControls_" + subcatg + "' role='button' data-slide='prev'><span class='fas fa-angle-left card_lefticon' id='id_card_lefticon_" + subcatg + "' aria-hidden='true' style='color: black; font-size: 30px; display:none;'></span><span class='sr-only'>Previous</span></a><a class='carousel-control-next card_righticon_div' href='#carouselExampleControls_" + subcatg + "' role='button' data-slide='next'><span class='fas fa-angle-right card_righticon' id='id_card_righticon_" + subcatg + "' aria-hidden='true' style='color: black; font-size: 30px; display:none;'></span><span class='sr-only'>Next</span></a></div>";

                            if (count_arr <= 3) {
                                $("#id_card_lefticon_" + subcatg + "").hide();
                                $("#id_card_righticon_" + subcatg + "").hide();
                            }
                            else {
                                $("#id_card_lefticon_" + subcatg + "").show();
                                $("#id_card_righticon_" + subcatg + "").show();
                            }


                            $("#Brands_maindiv").append(html);
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
                $("[id='itemdiv_" + brands_val + "']").css("background-color", "antiquewhite");
              

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
                $("[id='btnfinal_" + brands_val + "']").text("Select");
                $("[id='itemdiv_" + brands_val + "']").css("background-color", "#d8dedca8");
    

                 if (final != "") {
                     $('#<%=btn_Proceed.ClientID %>').show();
                 }
                 else {
                     $('#<%=btn_Proceed.ClientID %>').hide();
                 }               
                
            }
         
        }

    </script>
  

</head>
<body>
    <form id="form1" runat="server">

        <div class="container mt-5 mb-5">
            <h4 class="text-center">Set Your Prefrences: </h4><br />

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
                     <asp:Button ID="btn_Proceed" runat="server" Text="Proceed" CssClass="btn btn-info" style="display:none;" OnClick="btn_Proceed_Click" />
                </div>
            </div>

            
           <asp:HiddenField ID="Hf_categories" runat="server" Value="" />
           <asp:HiddenField ID="Hf_subcategories" runat="server" Value="" />
           <asp:HiddenField ID="Hf_brands" runat="server" Value="" />
           
     </div>

    </form>


     <script>
         //$('.owl-carousel').owlCarousel({
         //    loop: true,
         //    margin: 10,
         //    nav: true,
         //    responsive: {
         //        0: {
         //            items: 1
         //        },
         //        600: {
         //            items: 3
         //        },
         //        1000: {
         //            items: 3
         //        }
         //    }
         //})
    
    </script>



</body>
</html>
