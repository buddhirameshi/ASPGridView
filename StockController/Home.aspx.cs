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
            if(!IsPostBack)
            {

                LoadData();
            }
        }

        protected void OnPaging(object sender,GridViewPageEventArgs e)
        {

        }

        protected void LoadData()
        {
         DataTable itemsTable=   dao.GetItemsTable();
            if(itemsTable==null||itemsTable.Rows.Count==0)
            {
                DataRow dr = itemsTable.NewRow();
                itemsTable.Rows.Add(dr);
            }

            itemGridView.DataSource = itemsTable;
            itemGridView.DataBind();
        }

       protected void OnRowEditing(object sender,GridViewEditEventArgs e)
        {
            itemGridView.EditIndex = e.NewEditIndex;
            LoadData();
            (itemGridView.Rows[e.NewEditIndex].Cells[2].FindControl("priceLabel") as TextBox).ReadOnly = false;
            (itemGridView.Rows[e.NewEditIndex].Cells[2].FindControl("DescriptionLabel") as TextBox).ReadOnly = false;

        }

        protected void OnRowDataBound(object sender,GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                var item = (e.Row.Cells[2].FindControl("priceLabel") as TextBox);
                if (item == null || string.IsNullOrEmpty(item.Text))
                {
                    e.Row.Visible = false;
                }
            }
        }



        protected void OnRowDeleting(object sender,GridViewDeleteEventArgs e)
        {
            int id= Convert.ToInt32(((Label)itemGridView.Rows[e.RowIndex].Cells[0].FindControl("IdLabel")).Text);
            dao.DeleteData(id);
            LoadData();

        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            TextBox dynamicTextBox = itemGridView.Rows[e.RowIndex].Cells[2].FindControl("priceLabel") as TextBox;
            dynamicTextBox.ID = ((Label)(itemGridView.Rows[e.RowIndex].Cells[0].FindControl("idLabel"))).Text;

            RegularExpressionValidator regexValidator = new RegularExpressionValidator
            {
                ControlToValidate = dynamicTextBox.ID,
                ForeColor = Color.Red,
                ErrorMessage = "Invalid Input type",
                ValidationGroup = "Update",
                ValidationExpression = @"^\$?(\d+\.\d\d?\d?\d?|\d+)$"
            };

            RequiredFieldValidator requiredValidator = new RequiredFieldValidator
            {
                ControlToValidate = dynamicTextBox.ID,
                ForeColor = Color.Red,
                ErrorMessage = "Data Required",
                ValidationGroup = "Update"
            };
            itemGridView.Rows[e.RowIndex].Cells[2].Controls.Add(requiredValidator);
            itemGridView.Rows[e.RowIndex].Cells[2].Controls.Add(regexValidator);
            regexValidator.Validate();
            requiredValidator.Validate();
            //if (regexValidator.IsValid&&requiredValidator.IsValid)
            //{
            Item oneitem = new Item();
                oneitem.ItemID = Convert.ToInt32(((Label)(itemGridView.Rows[e.RowIndex].Cells[0].FindControl("idLabel"))).Text);
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

        protected void OnRowEditCancelling(object sender,GridViewCancelEditEventArgs e)
        {
            itemGridView.EditIndex = -1;
            LoadData();
        }
    }
}