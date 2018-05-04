<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="js/prettify.js"></script>
    <link href="css/style.css" rel="stylesheet" />

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
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

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
                    url: "Home.aspx/GetCustomer2",
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
                    $("#dvCustomers").append("<div id=" + iCounter + " class='masonry'>");
                }
                var html = '<div id="dvd" class="tblCustomer item"><b>Id: </b><span>' + this.BrandId + '</span><br /><b>Name: </b><span>' + this.BrandName + '</span><br /><b>logo: </b><span>' + this.logo + '</span><br /><img class="img" src=\'' + this.logo + '\'/> </div>'
                $("#" + iCounter).append(html);

            });

        }
    </script>


    <script type="text/javascript">
        $(function () {
            var dd = 1
            var nextval = parseInt(dd);
            $("#hdn_pg").val(nextval);
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetCustomers",
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
            $(customers).each(function (index) {

                if ((index + 1) == 1) {
                    $("#dvCustomers").append("<div id=" + iCounter + " class='masonry'>");
                }
                var html = '<div id="dvd" class="tblCustomer item"><b>Id: </b><span>' + this.BrandId + '</span><br /><b>Name: </b><span>' + this.BrandName + '</span><br /><b>logo: </b><span>' + this.logo + '</span><br /><img class="img" src=\'' + this.logo + '\'/> </div>'
                $("#" + iCounter).append(html);

            });
        }
    </script>



</head>
<body>

    <form id="form1" runat="server">
        <asp:HiddenField ID="hdn_pg" runat="server" Value="0" />
        <div class="container">

            <div id="dvCustomers" class="">
            </div>
        </div>
        <span style="float: right; color: cornflowerblue;">
            <input id="topscroll" type="button" value="Top" />
        </span>

        <center>
             <input id="loader" type="button" value="Load More" style="background-color:darkcyan;color:white"  />
             <input id="norec" type="text" value="No record" style="display:none;border:none" readonly="true" />
        </center>
    </form>
    <script type='text/javascript'>
        prettyPrint()
    </script>

</body>
</html>
