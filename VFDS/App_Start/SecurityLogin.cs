using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace VFDS.App_Start
{
    public static class SecurityLogin
    {

        public static void getFormAuthicationToken( string username)
        {
            FormsAuthentication.SetAuthCookie(
                               username, false);

            FormsAuthenticationTicket ticket1 =
               new FormsAuthenticationTicket(
                    1,                                   // version
                    username,   // get username  from the form
                    DateTime.Now,                        // issue time is now
                    DateTime.Now.AddHours(1),         // expires in 1 hour
                    false,      // cookie is not persistent
                    "Admin"                              // role assignment is stored
                                                         // in userData
                    );
            HttpCookie cookieAuth = new HttpCookie(
              FormsAuthentication.FormsCookieName,
              FormsAuthentication.Encrypt(ticket1));

            HttpContext.Current.Response.Cookies.Add(cookieAuth);

        }
    }
}