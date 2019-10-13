using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using VFDS.BLL.Repositories;
using VFDS.Common.Cognative;
using VFDS.Common.Services;
using VFDS.DAL;

namespace VFDS
{
    /// <summary>
    /// Summary description for CongnativeService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class CongnativeService : System.Web.Services.WebService
    {

        [WebMethod]
        public async void CognativeFace(string postID)
        {
            const string subscriptionKey = "54c11b3999a149e9b1a721961478aa81";
            string Message = "This Post is Already Saved by Cognative Modiator/Vision/Face Api" ;
            
            
            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();

            PostRepository repositoryPost = new PostRepository();
            Post post = repositoryPost.getPostByID(postID);
            if (post != null)
            {
                MetaDataRepository repositoryMetaData = new MetaDataRepository();
                MetaData metaData = repositoryMetaData.getMetaDataByPostID(post.Post_ID);
                if (metaData == null)
                {

                    HttpClient client = new HttpClient();

                    // Request headers.
                    client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", subscriptionKey);

                    // Request parameters. A third optional parameter is "details".
                    string requestParameters = "returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise";

                    // Assemble the URI for the REST API Call.
                    string uri = "https://eastasia.api.cognitive.microsoft.com/face/v1.0/detect" + "?" + requestParameters;

                    HttpResponseMessage response;

                    byte[] byteData = CognativeService.GetImageAsByteArray(Server.MapPath("~/InstagramFiles/" + post.Post_FileName));
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

                        //divShowApiData.InnerHtml = CognativeService.JsonPrettyPrint(contentString);

                        //JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                        List<RootObject> faceApiValue = (List<RootObject>)javaScriptSerializer.Deserialize(CognativeService.JsonPrettyPrint(contentString), typeof(List<RootObject>));
                        if (faceApiValue != null)
                        {
                            metaData.Post_ID = post.Post_ID;
                            metaData.Face_Gender = faceApiValue[0].faceAttributes.gender;
                            metaData.Face_Age = faceApiValue[0].faceAttributes.age;
                            if (faceApiValue[0].faceRectangle.width > 0)
                                metaData.Face_Rectangle = faceApiValue[0].faceRectangle.width + "," + faceApiValue[0].faceRectangle.height + " " + faceApiValue[0].faceRectangle + " " + faceApiValue[0].faceRectangle.left.ToString();
                            Message = "This Post is Saved now by Cognative Modiator/Vision/Face Api";
                        }
                        
                    }

                }
                



                Context.Response.Clear();
                Context.Response.ContentType = "application/json";
                Context.Response.AddHeader("content-length", javaScriptSerializer.Serialize(Message).Length.ToString());
                Context.Response.Flush();
                Context.Response.Write(javaScriptSerializer.Serialize(Message));
                HttpContext.Current.ApplicationInstance.CompleteRequest();

            }
        }
    }
}

