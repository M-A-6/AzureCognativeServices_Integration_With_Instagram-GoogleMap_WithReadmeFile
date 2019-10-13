<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="VFDS.Dashboard" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    
    <script type="text/javascript">

        

       
        
        $(document).ready(function () {


     
            
            $('#btnGetPosts').click(function () {
                
                $.ajax({
                    url: 'https://api.instagram.com/v1/users/self/media/recent/?access_token=7468139260.73ad91d.61a0e44d74314a12a9bfba96bad1bb79',
                    method: 'get',
                    //contentType: "application/json;charset=utf-8",
                    //data: JSON.stringify({ employeeId: empId }),
                    dataType: 'json',
                    success: function (data) {
                        //$('#divPosts').append(data.data[0].caption.text);
                        $('#divPosts').html('');
                        $.each(data.data, function (index, item) {
                            var date = new Date(parseInt(item.created_time) * 1000)
                            $('#divPosts').append(item.caption.text + "  " + date.getDay() + "/" + date.getMonth() + "/" + date.getFullYear() + "</br>");
                            if (item.location != null)

                                 addMarker(map, new google.maps.LatLng(item.location.latitude, item.location.longitude), item.caption.text,
                                     "<b>" + item.caption.text + "</b>" +
                                     "<img src='" + item.images.thumbnail.url + " '> </div>"
                                     +
                                     '<button  type="button" onclick="displayInfo(\'' + item.caption.text + '\',\'' + item.id + '\',\'' + item.images.thumbnail.url + '\'   );" >populate div</button >'
                                    );
                            //< input type='submit' text='Save' />

                        });
                        //$('caption').each(function () {
                         //   $('#divPosts').append(this.text + "</br>");

                        //});
                        //$("location").each(function () {

                        //    addMarker(map, new google.maps.LatLng(this.latitude, this.longitude), this.name, "<b>" + this.name + "</b>" + "<br />");
                        //    //<input type='button' text='Save' />

                        //});
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });





            //$('#btnAddEmployee').click(function () {
            //    var employee = {};
            //    employee.Name = $('#txtName').val();
            //    employee.Gender = $('#txtGender').val();
            //    employee.Salary = $('#txtSalary').val();

            //    $.ajax({
            //        url: 'PostService.asmx/addPost',
            //        method: 'post',
            //        data: '{emp: ' + JSON.stringify(employee) + '}',
            //        contentType: "application/json; charset=utf-8",
            //        success: function () {
            //            getAllEmployees();
            //        },
            //        error: function (err) {
            //            alert(err);
            //        }
            //    });
        });
        
        function displayInfo(valueTe, objval,urlthumb) {
            document.getElementById("divContent").innerHTML = valueTe + " ---- " + objval;

            var postObj = {};
            postObj.Post_ID = objval;
            postObj.Image_Thumbnail_Url = urlthumb;




            $.ajax({
                url: 'PostService.asmx/addPost',
                method: 'post',
                data: '{postObj: ' + JSON.stringify(postObj) + '}',
                contentType: "application/json; charset=utf-8",
                success: function () {
                    alert("saved");
                },
                error: function (err) {
                    alert(err);
                }
            });
            document.getElementById("divContent").innerHTML = "</br> Done------" + valueTe + " ---- " + objval;
        }
    </script>
    <script src="Scripts/bootstrap.min.js"></script>
                                   
<style>
#map {
    width: 100%;
    height: 400px;
   
   
}
</style>
</head>
<body style="padding-top:20px">



    <form runat="server">
    
    
       <div id="divContent">
           saved
       </div> 
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
                        <td>

                            <div class="row text-center">

                                <input type="text" id="txtUsername" placeholder="Enter User name" class="col-md-8 col-md-offset-2" />
                            </div>
                            <div class="row text-center">
                                
                                <button type="button" class="btn btn-info" id="btnGetPosts">
      <span class="glyphicon glyphicon-search"></span> Get Posts</button>
                            </div>
                            <br />
                            <br />
                            <div id="divPosts">

                                

                            </div>
                            <div>
 

<div id="map"></div>

<script>
    
    //<script src="Scripts/googlemap.js">

    
    
  
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMsvQMc1BjJSOlXhdP3PJD4mXCejuWUdw&callback=myMap"></script>

                            </div>
                        </td>
                    </tr>



                </tbody>
            </table>           
        </div>
    </div>

    </form>
   
<%--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD9lI5oi0tZrREY6B4q7w35zoFAfsD8J2I&callback=myMap"></script> --%>

    <script type="text/javascript">

        //btn - primary

      
    </script>
   
    
</body>
</html>

