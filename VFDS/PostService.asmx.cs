using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using VFDS.DAL;
using VFDS.BLL.Repositories;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Script.Services;

namespace VFDS
{
    /// <summary>
    /// Summary description for PostService
    /// </summary>
    [WebService(Namespace = "http://vfdsTask.ae/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class PostService : System.Web.Services.WebService
    {

        [WebMethod]
        public string addPost(Post postObj)
        {
            PostRepository repositoryPost = new PostRepository();

            using (WebClient client = new WebClient())
            {
                string filepath =  Server.MapPath("~/InstagramFiles/");
                string filename = Path.GetFileName(postObj.Image_Thumbnail_Url);
                string extension = Path.GetExtension(postObj.Image_Thumbnail_Url);
                client.DownloadFile(postObj.Image_Thumbnail_Url, filepath + filename );
                postObj.Post_Extenion = extension;
                postObj.Post_FileName = filename;
            }            
            JavaScriptSerializer js = new JavaScriptSerializer();

            var resultAlreadySaved = new { Message = "This Post is Already Saved!" };
            var resulSaveNow = new { Message = "This Post is Saved now!" };

            if (repositoryPost.getPostByID(postObj.Post_ID) != null)
            {
                return js.Serialize("This Post is Already Saved!");             
            }
            else
            {
                repositoryPost.savePost(postObj);                
                return js.Serialize("This Post is Saved now!");
            }
        }



        [WebMethod]
        [ScriptMethod(UseHttpGet =  false)]
        public void GetPostsByParams(int iDisplayLength, int iDisplayStart, int iSortCol_0,string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["VFDS"].ConnectionString;
            List<Post> listPosts = new List<Post>();
            int filteredCount = 0;
            //using (SqlConnection con = new SqlConnection(cs))
            //{
            //    SqlCommand cmd = new SqlCommand("spGetPosts", con);
            //    cmd.CommandType = CommandType.StoredProcedure;

            //    SqlParameter paramDisplayLength = new SqlParameter()
            //    {
            //        ParameterName = "@DisplayLength",
            //        Value = displayLength
            //    };
            //    cmd.Parameters.Add(paramDisplayLength);

            //    SqlParameter paramDisplayStart = new SqlParameter()
            //    {
            //        ParameterName = "@DisplayStart",
            //        Value = displayStart
            //    };
            //    cmd.Parameters.Add(paramDisplayStart);

            //    SqlParameter paramSortCol = new SqlParameter()
            //    {
            //        ParameterName = "@SortCol",
            //        Value = sortCol
            //    };
            //    cmd.Parameters.Add(paramSortCol);

            //    SqlParameter paramSortDir = new SqlParameter()
            //    {
            //        ParameterName = "@SortDir",
            //        Value = sortDir
            //    };
            //    cmd.Parameters.Add(paramSortDir);

            //    SqlParameter paramSearchString = new SqlParameter()
            //    {
            //        ParameterName = "@Search",
            //        Value = string.IsNullOrEmpty(search) ? null : search
            //    };
            //    cmd.Parameters.Add(paramSearchString);
            //    //Testing by query....


            //    con.Open();
            //    SqlDataReader rdr = cmd.ExecuteReader();
            //    if (rdr.HasRows)
            //    {
            //        while (rdr.Read())
            //        {
            //            Post post = new Post();
            //            post.Post_ID = Convert.ToString(rdr["Post_ID"]);
            //            filteredCount = Convert.ToInt32(rdr["TotalCount"]);
            //            post.Post_Caption = rdr["Post_Caption"].ToString();
            //            post.Image_Thumbnail_Url = rdr["Image_Thumbnail_Url"].ToString();
            //            post.Post_Date = Convert.ToDateTime(rdr["Post_Date"]);

            //            listPosts.Add(post);
            //        }
            //    }
            //}

            PostRepository repositoryPost = new PostRepository();
            listPosts = repositoryPost.getPostsAll();



            var result = new
            {
                iTotalRecords = GetPostTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listPosts
            };



            JavaScriptSerializer js = new JavaScriptSerializer();


            Context.Response.Clear();
Context.Response.ContentType = "application/json";
            Context.Response.AddHeader("content-length", js.Serialize(result).Length.ToString());
            Context.Response.Flush();
            Context.Response.Write(js.Serialize(result));
           // HttpContext.Current.ApplicationInstance.CompleteRequest();

            
        }

        private int GetPostTotalCount()
        {
            int totalPostCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["VFDS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select count(*) from Posts", con);
                con.Open();
                totalPostCount = (int)cmd.ExecuteScalar();
            }
            return totalPostCount;
        }

        
    }
}
