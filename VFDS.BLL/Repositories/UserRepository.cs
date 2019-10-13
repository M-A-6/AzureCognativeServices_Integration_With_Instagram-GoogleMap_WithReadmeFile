using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS.DAL;
using VFDS.BLL.Repositories.Base;
using System.Data.SqlClient;

namespace VFDS.BLL.Repositories
{
    public class UserRepository: IUserRepository
    {
        public void createUser(string email, string password, string fname, string lname)
        {
            using (var ctxNew = new VFDSEntities())
            {
                try
                {
                    ctxNew.Users.Add(new User { User_Email = email, User_Password = password, User_First_Name = fname, User_Last_Name = lname });
                    ctxNew.SaveChanges();
                }
                catch (Exception ex)
                {

                }
            }
        }

        public void getUserByEmail(string email)
        {
           

            

        }

        public bool getUserExistByEmail(string email)
        {
            using (var ctx = new VFDSEntities())
            {
                
                var value= ctx.Database.SqlQuery<bool>("exec spUserNameExists " + email);

                return Convert.ToBoolean(value);
            }
        }



        public User getUserByCredential(string email, string password)
        {
            
            using (var ctxNew = new VFDSEntities())
            {
                
                    return ctxNew.Users.SingleOrDefault(user => user.User_Email == email && user.User_Password==password);

                
            }
        }

      
    }
}
