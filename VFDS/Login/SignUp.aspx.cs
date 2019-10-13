using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VFDS.BLL;
using VFDS.BLL.Repositories;
using VFDS.Common.Services;
using VFDS.DAL;
using VFDS.App_Start;
using System.Web.Security;

namespace VFDS
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    


                    UserRepository repositoryUser = new UserRepository();

                        repositoryUser.createUser(txfEmail.Text.Trim(), FormsAuthentication.HashPasswordForStoringInConfigFile(txfPassword.Text.Trim(), "SHA1"), txfNameFirst.Text.Trim(), txfNameLast.Text.Trim());

                    SecurityLogin.getFormAuthicationToken(txfEmail.Text.Trim());

                   
                    Response.Redirect("~/Dashboard.aspx");
                }
                else
                {

                }
            }
            catch (Exception ex)
            {
                
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