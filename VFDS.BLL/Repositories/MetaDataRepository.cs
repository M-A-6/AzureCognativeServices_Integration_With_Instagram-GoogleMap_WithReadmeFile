using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS.BLL.Repositories.Base;
using VFDS.DAL;

namespace VFDS.BLL.Repositories
{
    public class MetaDataRepository : IMetaDataRepository
    {
        public MetaData getMetaDataByID(string ID)
        {
            using (var ctxNew = new VFDSEntities())
            {
                return ctxNew.MetaDatas.SingleOrDefault(metadata => metadata.Post_ID == ID);
            }
        }

        public MetaData getMetaDataByPostID(string PostID)
        {
            using (var ctxNew = new VFDSEntities())
            {
                return ctxNew.MetaDatas.SingleOrDefault(metadata => metadata.Post_ID == PostID);
            }
        }

        public void saveMetaData(MetaData metaData)
        {
            using (var ctxNew = new VFDSEntities())
            {
                ctxNew.MetaDatas.Add(metaData);
                ctxNew.SaveChanges();
            }
        }
    }
}
