using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VFDS;
using VFDS.DAL;

namespace VFDS.BLL.Repositories.Base
{
    public interface IUserRepository
    {
        void getUserByEmail(string email);
        bool getUserExistByEmail(string email);
        void createUser(string email,string password, string fname, string lname);
        User getUserByCredential(string email,string password);


    }
}
