<%@ Page Title="" Language="C#" MasterPageFile="~/VFDSApp.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="VFDS.Gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    


<%--
       <script>
           $(document).ready(function () {
               $("#btnLoadGallery").click(function () {
                   $.ajax({
                       url: 'PostService.asmx/GetPostsByParams',
                       method: 'post',
                       data: JSON.stringify({
                           iDisplayLength: 10,
                           iDisplayStart: 0,
                           iSortCol_0: 1,
                           sSortDir_0: 'asc',
                           sSearch: '' //document.getElementById("txfSearch").value
                       }),
                       dataType: 'json',
                       contentType: "application/json; charset=utf-8",
                       success: function (data) {

                           $("#galleryrow").append(
                               "<div class='col-lg-3 col-md-4 col-sm-6'>

                               < a href= 'data'  class='thumbnail' >
                               <p></p>
                               <img src="InstagramFiles/30592353_444949459258912_7946452640274055168_n.jpg" />
                                </a >
                            </div > ");
                    },
                       error: function (err) {
                           alert(err);
                       }
                   });
               });

           });
         </script>--%>

    <script>
        $(document).ready(function () {
            ajaxGallery();
            $("#btnLoadGallery").click(function () {
                ajaxGallery();         
            });           
        });
        function ajaxGallery()
        {

            $.ajax({
                url: "PostService.asmx/GetPostsByParams",
                method: 'post',
                data: JSON.stringify({

                    iDisplayLength: 10,
                    iDisplayStart: 0,
                    iSortCol_0: 1,
                    sSortDir_0: 'asc',
                    sSearch: document.getElementById("txfSearch").value,
                }),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $.each(data.aaData, function (index, item) {
                        $("#galleryrow").append(
                            "<div class='col-lg-3 col-md-4 col-sm-6'>" +
                            "<a href='" + item.Image_Standard_Url + "' class='thumbnail'>" +
                            "<p> " + item.Post_Caption + "</p>" +
                            "<img src='" + item.Image_Thumbnail_Url + "' />" +
                            '</a><p><input type="button" onclick="Cognativemediator(\'' + item.Post_ID + '\');"    type="button" class="btn btn-primary" value="Run Cognative/Moderator Service"> </p></div >')

                    });
                },
                error: function (err) {
                    alert(err);
                }
            });
        }

        function Cognativemediator(postid)
        {
            $.ajax({
                url: "CongnativeService.asmx/CognativeFace",
                method: 'post',
                data: JSON.stringify({
                    postID: postid
                }),
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    alert(data); 
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
         </script>
       <%--<div class="col-lg-3 col-md-4 col-sm-6">
                        
                        <a href="InstagramFiles/30592353_444949459258912_7946452640274055168_n.jpg" class="thumbnail">
                            <p>InstagramFiles</p>
                            <img src="InstagramFiles/30592353_444949459258912_7946452640274055168_n.jpg" />
                        </a>
                    </div>--%>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <input type="text" id="txfSearch" placeholder ="Seach by post..."/>
        <input type="button" value="Refresh Gallery" class="btn btn-primary"  id="btnLoadGallery"/>

        <div class="row" id="galleryrow">            
        </div>
    </div>

    
</asp:Content>
