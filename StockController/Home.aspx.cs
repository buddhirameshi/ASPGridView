using BusinessObjects;
using DataAccessObjects;
using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;

namespace StockController
{
    public partial class Home : System.Web.UI.Page
    {
        ItemDao dao = new ItemDao();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            itemGridView.PageIndex = e.NewPageIndex;
            var sortDir = GetSortDir(); //Helps to protects the viewstate of the sort direction in previous page
            DataTable dt = dao.GetItemsTable();
            DataView sortedView = new DataView(dao.GetItemsTable());
            sortedView.Sort = string.Format("{0} {1}", SortExpression, sortDir);
            itemGridView.DataSource = sortedView;
            itemGridView.DataBind();
        }

        protected void LoadData()
        {
            DataTable itemsTable = dao.GetItemsTable();
            if (itemsTable == null || itemsTable.Rows.Count == 0) //Added an empty row to protect the footer row when the gridview is empty
            {
                DataRow dr = itemsTable.NewRow();
                itemsTable.Rows.Add(dr);
            }

            itemGridView.DataSource = itemsTable;
            itemGridView.DataBind();
        }


        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            itemGridView.EditIndex = e.NewEditIndex;
            LoadData();
            (itemGridView.Rows[e.NewEditIndex].Cells[2].FindControl("priceLabel") as TextBox).ReadOnly = false; //By default these are read only untill user clicks the edit button
            (itemGridView.Rows[e.NewEditIndex].Cells[2].FindControl("DescriptionLabel") as TextBox).ReadOnly = false; //By default these are read only untill user clicks the edit button
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var item = (e.Row.Cells[2].FindControl("priceLabel") as TextBox); //Checks this field to catch null or empty rows 
                if (item == null || string.IsNullOrEmpty(item.Text))
                {
                    e.Row.Visible = false; //make empty rows invisible. Empty rows are useful to keep footer row visible when the gridview is emptpy. This simply hides empty rows while allowing footer row to be visible
                }
            }
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(((TextBox)itemGridView.Rows[e.RowIndex].Cells[0].FindControl("IdLabel")).Text);
            dao.DeleteData(id);
            LoadData();

        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //TextBox dynamicTextBox = itemGridView.Rows[e.RowIndex].Cells[2].FindControl("priceLabel") as TextBox;
            //dynamicTextBox.ID = ((TextBox)(itemGridView.Rows[e.RowIndex].Cells[0].FindControl("idLabel"))).Text;

            //RegularExpressionValidator regexValidator = new RegularExpressionValidator
            //{
            //    ControlToValidate = dynamicTextBox.ID,
            //    ForeColor = Color.Red,
            //    ErrorMessage = "Invalid Input type",
            //    ValidationGroup = "Update",
            //    ValidationExpression = @"^\$?(\d+\.\d\d?\d?\d?|\d+)$"
            //};

            //RequiredFieldValidator requiredValidator = new RequiredFieldValidator
            //{
            //    ControlToValidate = dynamicTextBox.ID,
            //    ForeColor = Color.Red,
            //    ErrorMessage = "Data Required",
            //    ValidationGroup = "Update"
            //};
            //itemGridView.Rows[e.RowIndex].Cells[2].Controls.Add(requiredValidator);
            //itemGridView.Rows[e.RowIndex].Cells[2].Controls.Add(regexValidator);
            //regexValidator.Validate();
            //requiredValidator.Validate();
            //if (regexValidator.IsValid&&requiredValidator.IsValid)
            //{
            Item oneitem = new Item();
            oneitem.ItemID = Convert.ToInt32(((TextBox)(itemGridView.Rows[e.RowIndex].Cells[0].FindControl("idLabel"))).Text);
            oneitem.Description = ((TextBox)(itemGridView.Rows[e.RowIndex].Cells[1].FindControl("DescriptionLabel"))).Text;
            oneitem.Price = Convert.ToDecimal((itemGridView.Rows[e.RowIndex].Cells[2].FindControl("priceLabel") as TextBox).Text);
            dao.UpdateDate(oneitem);
            itemGridView.EditIndex = -1;
            LoadData();
            //}
            //else
            //{
            //    itemGridView.EditIndex = -1;
            //}

        }

        protected void OnSorting(object sender, GridViewSortEventArgs e)
        {
            string sortDir = ToggleSortDir(); //Toggle the exsiting sorting direction
            DataTable dt = dao.GetItemsTable();
            DataView sortedView = new DataView(dao.GetItemsTable());
            SortExpression = e.SortExpression;
            sortedView.Sort = string.Format("{0} {1}", e.SortExpression, sortDir);
            itemGridView.DataSource = sortedView;
            itemGridView.DataBind();
        }


        protected void onrowcommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                Item oneItem = new Item();
                oneItem.Description = ((TextBox)itemGridView.FooterRow.FindControl("addDescription")).Text;
                oneItem.Price = Convert.ToDecimal(((TextBox)itemGridView.FooterRow.FindControl("addPrice")).Text);
                dao.UpdateDate(oneItem);
                LoadData();
            }
        }

        protected void OnRowEditCancelling(object sender, GridViewCancelEditEventArgs e)
        {
            itemGridView.EditIndex = -1; //Bring back the previous state
            LoadData();
        }


        #region private methods
        private string ToggleSortDir()
        {
            string sortDir;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                sortDir = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                sortDir = "Asc";
            }    
            return sortDir;
        }


        private string GetSortDir()
        {
            string sortDir;
            if (dir == SortDirection.Ascending)
            {             
                sortDir = "Asc";
            }
            else
            {
                sortDir = "Desc";
            }
            return sortDir;
        }

        #endregion

        #region properties

        protected SortDirection dir
        {
            get
            {
                if (ViewState["dirState"] == null)
                {
                    ViewState["dirState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dirState"];
            }
            set
            {
                ViewState["dirState"] = value;
            }
        }

        protected string SortExpression
        {
            get
            {
                if (ViewState["sortExpression"] == null)
                {
                    ViewState["sortExpression"] = "ItemId";
                }
                return ViewState["sortExpression"].ToString();
            }
            set
            {
                ViewState["sortExpression"] = value;
            }
        }
        #endregion
    }
}