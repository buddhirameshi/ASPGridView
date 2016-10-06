using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
   public static class CommonExtensions
    {

        public static T Getval <T>(this IDataReader reader,string key,T defaultValue)
        {
            T t =  default(T);
            if(reader[key]==DBNull.Value)
            {
                t = defaultValue;
            }
            t = (T)reader[key];

            return t;
        }

      


    }
}
