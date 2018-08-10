<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Dictionary_Maker._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">Get the txt file for the necessary database dictionary.</p>
    <asp:DropDownList ID="ddldb" runat="server" OnChange="set_contextKeyset_contextKey(this.value);" CssClass="mydropdownlist" AppendDataBoundItems="true"></asp:DropDownList>
<asp:Button runat="server" ID="Button1" class="btn btn-primary btn-lg" Text="Download"  OnClick="UploadButton_Click" />
    </div>
 

</asp:Content>
