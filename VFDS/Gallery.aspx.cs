using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VFDS
{
    public partial class Gallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //HttpClient client = new HttpClient();

            //// Request headers.
            //client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", subscriptionKey);

            //// Request parameters. A third optional parameter is "details".
            //string requestParameters = "returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise";

            //// Assemble the URI for the REST API Call.
            //string uri = "https://eastasia.api.cognitive.microsoft.com/face/v1.0" + "?" + requestParameters;

            //HttpResponseMessage response;

            //// Request body. Posts a locally stored JPEG image.
            //byte[] byteData = GetImageAsByteArray(imageFilePath);

            //using (ByteArrayContent content = new ByteArrayContent(byteData))
            //{
            //    // This example uses content type "application/octet-stream".
            //    // The other content types you can use are "application/json" and "multipart/form-data".
            //    content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

            //    // Execute the REST API call.
            //    response = await client.PostAsync(uri, content);

            //    // Get the JSON response.
            //    string contentString = await response.Content.ReadAsStringAsync();

            //    // Display the JSON response.
            //    JsonPrettyPrint(contentString);
            //}
        }


    }
}