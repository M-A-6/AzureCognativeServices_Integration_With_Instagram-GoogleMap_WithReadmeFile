using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using VFDS.Common.Services.Base;
using Newtonsoft.Json.Linq;


namespace VFDS.Common.Services
{
    public class ReCaptchaService : IReCaptchaService
    {

        public bool getReCaptchaStatus(string grecaptchaRespone)
        {
            string secretKey = "6LcQo1IUAAAAAI-je9PbW842F1yfukxLDl0ZYRRJ";
            var result = new WebClient().DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, grecaptchaRespone));
            var obj = JObject.Parse(result);
            return (bool)obj.SelectToken("success");

        }
       
    }
}
