<%@ Page Title="" Language="C#" MasterPageFile="~/VFDSApp.Master" AutoEventWireup="true" CodeBehind="CognativeServices.aspx.cs" Inherits="VFDS.CognativeServices" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <asp:FileUpload ID="fupImage" runat="server" />
    <br />
    <br />
    <br />
    <br />
    <button id="btnFaceApi" class="btn btn-info" >Get FaceApi Data</button>
    <asp:Button CssClass="btn btn-info" ID="btnVisionApi" runat="server" Text="Get VisionApi Data" OnClick="btnVisionApi_Click" />
     
    <div id="divShowApiData" runat="server">

    </div>

    <br />
    <br />
    <div id="divShowSpecificData" runat="server">

    </div>


</asp:Content>
