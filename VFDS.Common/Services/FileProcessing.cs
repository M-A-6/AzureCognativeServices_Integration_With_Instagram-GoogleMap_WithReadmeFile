using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using VFDS.Common.Services.Base;

namespace VFDS.Common.Services
{
    public class FileProcessing : IFileProcessing
    {
        public void FileFromUrl(string fileUrl)
        {
            
            using (WebClient client = new WebClient())
            {
                client.DownloadFile(fileUrl, @"c:\xyz.jpg");

            }
            
        }       
    }
}
