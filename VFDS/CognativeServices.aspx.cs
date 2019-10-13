using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using VFDS.Common.Cognative;
using VFDS.Common.Services;

namespace VFDS
{
    public partial class CognativeServices : System.Web.UI.Page
    {

        const string subscriptionKey = "54c11b3999a149e9b1a721961478aa81";
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void btnVisionApi_Click(object sender, EventArgs e)
        {
            HttpClient client = new HttpClient();

            // Request headers.
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", subscriptionKey);

            // Request parameters. A third optional parameter is "details".
            string requestParameters = "returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise";

            // Assemble the URI for the REST API Call.
            string uri = "https://eastasia.api.cognitive.microsoft.com/face/v1.0/detect" + "?" + requestParameters;

            HttpResponseMessage response;

            // Request body. Posts a locally stored JPEG image.
            string filename = Path.GetFileName(fupImage.FileName);
            string extension = Path.GetExtension(fupImage.FileName);
            fupImage.PostedFile.SaveAs(Server.MapPath("~/InstagramFiles/"+ filename ));

            byte[] byteData = CognativeService.GetImageAsByteArray(Server.MapPath("~/InstagramFiles/" + filename ));

            using (ByteArrayContent content = new ByteArrayContent(byteData))
            {
                // This example uses content type "application/octet-stream".
                // The other content types you can use are "application/json" and "multipart/form-data".
                content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

                // Execute the REST API call.
                response = await client.PostAsync(uri, content);

                // Get the JSON response.
                string contentString = await response.Content.ReadAsStringAsync();

                // Display the JSON response.

                divShowApiData.InnerHtml = CognativeService.JsonPrettyPrint(contentString);


              //  RootObject

                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                List<RootObject> faceApiValue = (List<RootObject>)javaScriptSerializer.Deserialize(divShowApiData.InnerHtml, typeof(List<RootObject>));

                divShowSpecificData.InnerHtml = @"<br/>totalFaces : " + faceApiValue.Count() +
                                                 "<br/>Face ID : " + faceApiValue[0].faceId +
                                                 "<br/>Age : " + faceApiValue[0].faceAttributes.age +
                                                 "<br/>Gender : " + faceApiValue[0].faceAttributes.gender +
                                                 "<br/>Glasses/No Glasses : " + faceApiValue[0].faceAttributes.glasses;


                fupImage.Dispose();
            }
        }
    }
}