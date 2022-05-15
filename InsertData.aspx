<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsertData.aspx.cs" Inherits="Ajax.InsertData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container my-5">
        <h1>Insert Details in DB with AJAX</h1>
        <div class="row my-3">
            <div class="col-md-4 col-6">
                <asp:Label ID="Label1" runat="server" Text="Enter your First Name: "></asp:Label>
            </div>
            <input type="text" id="fname" class="col-md-8 col-6" value="" />
            <asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static" CssClass="d-none"></asp:TextBox>
        </div>
        <div class="row my-3">
            <div class="col-md-4 col-6">
                <asp:Label ID="Label2" runat="server" Text="Enter your Last Name: "></asp:Label>
            </div>
            <input type="text" id="lname" class="col-md-8 col-6" value="" />
        </div>
        <div class="row my-3">
            <div class="col-md-4 col-6">
                <asp:Label ID="Label3" runat="server" Text="Enter your email ID: "></asp:Label>
            </div>
            <input type="text" id="email" class="col-md-8 col-6" value="" />
        </div>
        <input type="button" id="SubmitBtn" class="btn btn-primary" value="Submit" />
        <a href="ShowData.aspx" class="btn btn-primary">Display Data</a>
        <asp:Label ID="Label4" runat="server" CssClass="text-success" ClientIDMode="Static" Text=""></asp:Label>
    </div>

    
    <script type="text/javascript">
        $("#SubmitBtn").on('click', function () {
            let fname = $("#fname").val();
            let lname = $("#lname").val();
            let email = $("#email").val();
            var aspTextBox = $("#TextBox1").val();
            console.log(aspTextBox);



            let jsonStr = "{'Fname':'" + fname + "', 'Lname':'" + lname + "', 'Email':'" + email + "', 'ASP':'" + aspTextBox + "'}";
            console.log(jsonStr)

            $.ajax({
                type: "POST",
                url: "WebService.asmx/InsertUser",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: jsonStr,
                success: function (response) {
                    console.log('response:::::::::>>' + response.d)
                    clearAll();
                },
            })
        })

        function clearAll() {
            $("#Label4").text("Insert data successful !");
            $("#fname").val("");
            $("#lname").val("");
            $("#email").val("");
        }
    </script>

</asp:Content>
