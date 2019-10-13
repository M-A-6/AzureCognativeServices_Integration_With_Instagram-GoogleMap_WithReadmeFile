using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS.DAL;

namespace VFDS.BLL.Repositories.Base
{
    interface IPostRepository
    {
        List<Post> getPostsAll();
        Post getPostByID(string ID);
        void savePost(Post post);
    }
}
