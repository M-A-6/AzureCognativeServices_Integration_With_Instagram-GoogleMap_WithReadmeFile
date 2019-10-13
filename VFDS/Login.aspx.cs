using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using VFDS.BLL.Repositories;
using VFDS.Common.Services;
using VFDS.App_Start;

namespace VFDS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    UserRepository repositoryUser = new UserRepository();
                    if (repositoryUser.getUserByCredential(txf_Email.Text.Trim(), 
                        FormsAuthentication.HashPasswordForStoringInConfigFile(txf_Password.Text.Trim(), "SHA1") ) != null)
                    {
                        // Success, create non-persistent authentication cookie.
                        
                        SecurityLogin.getFormAuthicationToken(txf_Email.Text.Trim());

                        // 4. Do the redirect. 
                        

                        Response.Redirect("~/Dashboard.aspx", true);
                    }
                    else
                    {
                        divError.Visible = true;
                        txf_Email.Text = "";
                        txf_Password.Text = "";
                    }
                }
                catch(Exception ex)
                {

                }
            }
        }


        protected void vcustCaptcha_ServerValidate(object source, ServerValidateEventArgs args)
        {
            bool status = false;
            ReCaptchaService recaptchaObj = new ReCaptchaService();
            status = recaptchaObj.getReCaptchaStatus(Request["g-recaptcha-response"]);
            args.IsValid = status;
        }
    }

}
