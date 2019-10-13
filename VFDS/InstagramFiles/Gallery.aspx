
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="VFDS.Gallery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
       <%--<link rel="stylesheet" type="text/css" 
         <link href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js">
    </script>--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript">
        //$(document).ready(function () {
        //    $('#datatable').DataTable({
        //        columns: [
        //            { 'data': 'Post_ID' },
        //            { 'data': 'Post_Caption' },
        //            { 'data': 'Image_Thumbnail_Url' },
        //            { 'data': 'Gender' },
        //            { 'data': 'JobTitle' }
        //        ],
        //        bServerSide: true,
        //        sAjaxSource: 'PostService.asmx/GetPosts',
        //        sServerMethod: 'post'
        //    });
        //});
    </script>

       <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div class="container">
                <div class="row">

                    <div class="col-md-10 col-md-offset-1">
        <div class="well">
            <!--This table contains the fields that we want to capture to sign up a new user-->
            <table class="table table-bordered" style="height:400px;">
                <thead>
                    <tr class="success">
                        <th colspan="2">
                           Dashboard
                             <span id="spanUsername" class="text-muted" runat="server"></span>
                             <asp:Button ID="btnLogout" runat="server" Text="LogOut" CssClass="btn btn-success pull-right" OnClick="btnLogout_Click"  />
                        </th>
                    </tr>
                </thead>
                <tbody>
    
                    <tr>
                        <td >
                             <div class="container">
    <div class="row" id="galleryrow">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        
                        <a href="InstagramFiles/30592353_444949459258912_7946452640274055168_n.jpg" class="thumbnail">
                            <p>InstagramFiles</p>
                            <img src="InstagramFiles/30592353_444949459258912_7946452640274055168_n.jpg" />
                        </a>
                    </div>
        </div>
                                 </div>
                            </td>
                        </tr>
                    
                </tbody>
            </table>           
        </div>
    </div>
                </div>
            </div>
            

           <%--<div style="width: 900px; border: 1px solid black; padding: 3px">
            <table id="datatable">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Job Title</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Job Title</th>
                    </tr>
                </tfoot>
            </table>
        </div>--%>
        </div>
    </form>
</body>
</html>
