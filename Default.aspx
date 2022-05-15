<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ajax._Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container my-5">
        <h1>Select AJAX Activity to Perform:</h1>
        <div class="my-5">
            <a href="InsertData.aspx">Insert New Data</a>
            <span class="h5 m-0">|</span>
            <a href="ShowData.aspx">Display Existing Data</a>
        </div>
    </div>
    
</asp:Content>
