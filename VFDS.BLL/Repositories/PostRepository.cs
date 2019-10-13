using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS.BLL.Repositories.Base;
using VFDS.Common.Services;
using VFDS.DAL;
using System.Data.Entity.Migrations;
using System.Data;

namespace VFDS.BLL.Repositories
{
    public class PostRepository : IPostRepository
    {
        public Post getPostByID(string ID)
        {
            using (var ctxNew = new VFDSEntities())
            {
                return ctxNew.Posts.SingleOrDefault(post=>post.Post_ID==ID);
            }
        }

        public List<Post> getPostsAll()
        {
            using (var ctxNew = new VFDSEntities())
            {

                return ctxNew.Database.SqlQuery<Post>("exec spGetPosts").ToList<Post>();
            }
        }

        public void savePost(Post post)
        {            
            using (var ctxNew = new VFDSEntities())
            {
                ctxNew.Posts.Add(post);
                ctxNew.SaveChanges();  
            }
            
        }

    }
}
