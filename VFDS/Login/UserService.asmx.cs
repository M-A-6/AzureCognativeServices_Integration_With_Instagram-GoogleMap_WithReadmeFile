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

namespace VFDS
{
    /// <summary>
    /// Summary description for UserService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class UserService : System.Web.Services.WebService
    {

        [WebMethod]
        public void UserNameExists(string userName)
        {
            bool userNameInUse = false;




            string cs = ConfigurationManager.ConnectionStrings["VFDS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spUserNameExists", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@UserName",
                    Value = userName
                });

                con.Open();
                userNameInUse = Convert.ToBoolean(cmd.ExecuteScalar());
            }


            Registration user = new Registration();
            user.userName = userName;
            user.UserNameInUse = userNameInUse;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(user));
        }


       

    }

    public  class Registration 
    {
        
        public bool UserNameInUse { get; set; }
        public string userName { get; set; }

    }
}
