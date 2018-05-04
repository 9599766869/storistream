<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/4.1.1/imagesloaded.pkgd.min.js'></script>

    <script src="js/index.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,700" rel="stylesheet">


    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css'>

    <link rel="stylesheet" href="css/style.css">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <style>
        img {
            max-width: 100%;
        }

        .masonry-column {
            padding: 0 1px;
        }

        .masonry-grid > div .thumbnail {
            margin: 5px 1px;
        }
    </style>

<%---------------Start Scroll Based Binding---------------%>
    
    <script type="text/javascript">      
        $(window).scroll(function () {
            if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                GetRecords();
            }
        });

        function GetRecords() {
            var dd = $("#hdn_pg").val();
            var nextval = parseInt(dd) + 1;
            $("#hdn_pg").val(nextval);
            // $("#loader").show();
            
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetCustomer2",
                data: "{'PageIndex':" + nextval + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
        function OnSuccess(response) {
            var customers = response.d;
            var iCounter = 1;
            $.getScript('js/index.js');
            $(customers).each(function (index) {
                if ((index + 1) % 3 == 1) {
                    $("#dvCustomers").append("<div id=" + iCounter + " class='grid'>");
                }
                var html = '<div class="item photo"> <div class="content"><b>Id: </b><span>' + this.BrandId + '</span><br /><b>Name: </b><span>' + this.BrandName + '</span><br /><b>logo: </b><span>' + this.logo + '</span><br /><img class="img" src=\'' + this.logo + '\'/></div></div>'
                $("#" + iCounter).append(html);

            });

        }
    </script>

 <%--   --------------End Scroll Based Binding---------------%>

      <%--   --------------Load More Based Binding---------------%>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#topscroll").click(function () {
                $(window).scrollTop(0);
            });
        });

        $(function () {
            $('#loader').click(function () {
                var dd = $("#hdn_pg").val();
                var nextval = parseInt(dd) + 1;
                $("#hdn_pg").val(nextval);
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetCustomer2",
                    data: "{'PageIndex':" + nextval + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            });
        });
        function OnSuccess(response) {
            var customers = response.d;
            var iCounter = 1;
            $(customers).each(function (index) {
                if ((index + 1) % 3 == 1) {
                    $("#dvCustomers").append("<div id=" + iCounter + " class='grid'>");
                }
                var html = '<div class="item photo"> <div class="content"><b>Id: </b><span>' + this.BrandId + '</span><br /><b>Name: </b><span>' + this.BrandName + '</span><br /><b>logo: </b><span>' + this.logo + '</span><br /><img class="img" src=\'' + this.logo + '\'/></div></div>'
                $("#" + iCounter).append(html);

            });

        }
    </script>

     <%--   --------------first Based Binding---------------%>
    <script type="text/javascript">
        $(function () {
            var dd = 1
            var nextval = parseInt(dd);
            $("#hdn_pg").val(nextval);
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetCustomers",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        });

        function OnSuccess(response) {
            var customers = response.d;
            var iCounter = 1;
            $.getScript('js/index.js');
            $(customers).each(function (index) {
                if ((index + 1) == 1) {
                    $("#dvCustomers").append("<div id=" + iCounter + " class='grid'>");
                }
                var html = '<div class="item blog"> <div class="content"><b>Id: </b><span>' + this.BrandId + '</span><br /><b>Name: </b><span>' + this.BrandName + '</span><br /><b>logo: </b><span>' + this.logo + '</span><br /><img class="photothumb" src=\'' + this.logo + '\'/></div></div>'
                $("#" + iCounter).append(html);

            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdn_pg" runat="server" Value="0" />
        <div id="dvCustomers" class="">
        </div>

        <center>
             <input id="loader" type="button" value="Load More" style="background-color:darkcyan;color:white"  />
             <input id="norec" type="text" value="No record" style="display:none;border:none" readonly="true" />
        </center>




    </form>
</body>
</html>
