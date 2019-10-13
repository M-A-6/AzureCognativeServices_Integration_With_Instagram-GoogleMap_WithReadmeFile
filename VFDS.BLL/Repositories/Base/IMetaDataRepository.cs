using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS.DAL;

namespace VFDS.BLL.Repositories.Base
{
    public interface IMetaDataRepository
    {
        MetaData getMetaDataByID(string ID);
        MetaData getMetaDataByPostID(string PostID);
        void saveMetaData(MetaData metaData);
    }
}
