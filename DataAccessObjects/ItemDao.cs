using BusinessObjects;
using DB;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessObjects
{
    public class ItemDao
    {
        public List<Item> GetItems()
        {
            List<Item> items = new List<Item>();

            return items;
        }

        public DataTable GetItemsTable()
        {
           
            DataTable dataTable = SetItemTable();
           return DataAccessor.GetTable(DataAccessor.GetConnectionString("SourceConn"), CommandType.StoredProcedure, "[dbo].[ItemGetData]", dataTable, null);
        }

        public bool UpdateDate(Item oneItem)
        {
            Dictionary<string, object> inputParams = new Dictionary<string, object>();
            inputParams.Add("@ItemId", oneItem.ItemID);
            inputParams.Add("@Description",oneItem.Description);
            inputParams.Add("@Price", oneItem.Price);
         return    DataAccessor.Update(DataAccessor.GetConnectionString("SourceConn"),CommandType.StoredProcedure, "[dbo].[ItemUpdateData]", inputParams);
        }


        public bool DeleteData(int itemId)
        {
            Dictionary<string, object> inputParams = new Dictionary<string, object>();
            inputParams.Add("@ItemId", itemId);
            return DataAccessor.Update(DataAccessor.GetConnectionString("SourceConn"), CommandType.StoredProcedure, "[dbo].[ItemDeleteData]", inputParams);
        }
        private static DataTable SetItemTable()
        {
            DataTable t = new DataTable();
            t.Columns.Add("ItemId");
            t.Columns.Add("Description");
            t.Columns.Add("Price");
            return t;
        }
    }
}
