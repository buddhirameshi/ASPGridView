using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DB
{
    public static class DataAccessor
    {
        public static List<T>  Get<T>(string sqlconn,CommandType type,string sqlQuery,Func<IDataReader,T> Map,Dictionary<string,object> inputParams=null)
        {
            List<T> tList = new List<T> ();
            try
            {
                using (SqlConnection conn = new SqlConnection(sqlconn))
                {

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandType = type;
                        cmd.CommandText = sqlQuery;
                        cmd.Connection = conn;
                        foreach (var pair in inputParams)
                        {
                            cmd.Parameters.AddWithValue(pair.Key, pair.Value);
                        }
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader != null)
                        {
                            T t = default(T);
                            t = Map(reader);
                            tList.Add(t);
                        }
                        conn.Close();
                    }
                   
                }
            }
            catch(SqlException ex)
            {
                throw ex;
            }

            return tList;
        }

        public static DataTable GetTable (string sqlconn, CommandType type, string sqlQuery, DataTable t, Dictionary<string, object> inputParams = null)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(sqlconn))
                {

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandType = type;
                        cmd.Connection = conn;
                        cmd.CommandText = sqlQuery;
                        if(inputParams!=null)
                        {
                            foreach (var pair in inputParams)
                            {
                                cmd.Parameters.AddWithValue(pair.Key, pair.Value);
                            }
                        }
                      
                        conn.Open();

                        SqlDataAdapter adapter = new SqlDataAdapter();
                        adapter.SelectCommand = cmd;
                        adapter.Fill(t);
                        conn.Close();
                    }

                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return t;
        }


        public static bool Update(string sqlconn, CommandType type, string sqlQuery, Dictionary<string, object> inputParams = null)
        {
            bool isUpdated = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(sqlconn))
                {

                    using (SqlCommand cmd = new SqlCommand(sqlconn))
                    {
                        cmd.CommandType = type;
                        cmd.Connection = conn;
                        cmd.CommandText = sqlQuery;
                        foreach (var pair in inputParams)
                        {
                            cmd.Parameters.AddWithValue(pair.Key, pair.Value);
                        }
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        isUpdated = true;
                    }
                  
                }
                return isUpdated;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            
        }

        public static string GetConnectionString( string key)
        {
            if (key == null)
            {
                return "Invalid Key value";
            }
            return ConfigurationManager.ConnectionStrings[key].ConnectionString;
        }
    }
}
