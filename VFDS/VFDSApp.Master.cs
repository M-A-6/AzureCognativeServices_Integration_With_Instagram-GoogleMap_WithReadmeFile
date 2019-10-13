using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VFDS
{
    public partial class VFDSApp : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string UserName = Page.User.Identity.Name;
            spanUsername.InnerText = "Logged in : " + UserName;

        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Cookies.Remove(FormsAuthentication.FormsCookieName);


            //Response.Cookies[Global.userCookie].Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies[FormsAuthentication.FormsCookieName].Expires = DateTime.Now.AddDays(-1);

            FormsAuthentication.SignOut();


            Response.Redirect(ResolveUrl("~/Login.aspx"));
        }
    }
}