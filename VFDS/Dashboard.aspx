<%@ Page Title="" Language="C#" MasterPageFile="~/VFDSApp.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="VFDS.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">



        var map;
        function myMap() {
            var mapCanvas = document.getElementById("map");
            var mapOptions = {
                center: new google.maps.LatLng(23.4241, 53.8478), zoom: 6
            };
            map = new google.maps.Map(mapCanvas, mapOptions);

            //var googleLatLng = ;
            //var googleLatLng2 = new google.maps.LatLng(25.1184678, 55.2002478);


            //addMarker(map, new google.maps.LatLng(25.1184678, 55.2002478), "title 2", "test 2 <br /><b>About VFDS:</b>http://vfds.com/about/");


        }

        function addMarker(map, googleLatLng, title, content) {
            var markerOptn = {
                position: googleLatLng,
                map: map,
                title: title,
                animation: google.maps.Animation.DROP
            };

            var marker = new google.maps.Marker(markerOptn);

            var infoWindow = new google.maps.InfoWindow({
                content: content,
                position: googleLatLng


            });
            google.maps.event.addListener(marker, "click", function () {
                infoWindow.open(map);

            });

        }

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
                                    "<b>" + item.caption.text + "</b> </br>" +
                                    "<img src='" + item.images.thumbnail.url + " '> </div> </br>"
                                    +
                                    " Date : " + date.getDay() + "/" + date.getMonth() + "/" + date.getFullYear() + "</br>" +
                                    
                                    '<button  type="button" onclick="displayInfo(\'' + item.caption.text + '\',\'' + item.id + '\',\'' + item.images.thumbnail.url +  '\'  ,\'' + item.created_time + '\',\'' + item.images.standard_resolution.url + '\' );" >Save Post</button >'
                                );
                        });
                      
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            });




            
        });

        function displayInfo(postCaption, postID, urlthumb, postdate, urlstandard) {

            var myDate = new Date(postdate * 1000);
            document.getElementById("divContent").innerHTML = "Testing..." + postCaption + " ---- " + postID + "  " + myDate.toUTCString();
            
            var postObj = {};
            postObj.Post_ID = postID;
            postObj.Post_Caption = postCaption;
            postObj.Image_Thumbnail_Url = urlthumb;
            postObj.Post_Date = myDate.toUTCString();
            postObj.Image_Standard_Url = urlstandard;

            $.ajax({
                url: 'PostService.asmx/addPost',
                method: 'post',
                data: '{postObj: ' + JSON.stringify(postObj) + '}',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    alert(data.d.substr(1, data.d.length - 2));
                },
                error: function (err) {
                    alert(err);
                }
            });
            
            document.getElementById("divContent").innerHTML = "</br>Testing..." + postCaption + " ---- " + postID;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div id="divContent">
           
       </div> 
    <div class="row text-center">

        <input type="text" id="txtUsername" placeholder="anis.qau6   Username.....Instagram api depricated..." class="col-md-8 col-md-offset-2" />
    </div>
    <div class="row text-center">

        <button type="button" class="btn btn-info" id="btnGetPosts">
            <span class="glyphicon glyphicon-search"></span>Get Posts</button>
    </div>
    <br />
    <br />
    <div id="divPosts">
    </div>
    <div>


        <div id="map" style="width:800px; height:600px"></div>

       

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMsvQMc1BjJSOlXhdP3PJD4mXCejuWUdw&callback=myMap"></script>
         

    </div>
</asp:Content>

