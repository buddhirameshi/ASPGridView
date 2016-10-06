<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="StockController.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="itemGridView" runat="server" AutoGenerateEditButton="false"  AutoGenerateColumns="false" OnRowEditing="OnRowEditing" OnRowUpdating="OnRowUpdating" OnRowCancelingEdit="OnRowEditCancelling" OnRowDeleting="OnRowDeleting" OnRowCreated ="OnRowCreated">
            <Columns>
             <asp:boundfield  HeaderText="Item ID" ReadOnly="true" DataField="ItemId"/>
              <asp:boundfield  HeaderText="Description"  DataField="Description"/>
                  <asp:boundfield  HeaderText="Price"  DataField="Price"/>
                  <%--<asp:TemplateField  HeaderText="Description" >
                         <asp:boundfield  HeaderText="Description"  DataField="Description"/>
                   <ItemTemplate>
                     <asp:boundfield  HeaderText="Description"  DataField="Description"/>
                   </ItemTemplate>--%>
                  <%--    <FooterTemplate>
                        <asp:LinkButton ID="lbtnAdd" runat="server" CommandName="Add"  Text="Add" />
                    </FooterTemplate>  
                   </asp:TemplateField>--%>
              
          <%--  <asp:TemplateField>
                <FooterTemplate>
                <asp:TextBox ID="newDescription" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorDesc"  runat="server" ControlToValidate="newDescription" Display="Dynamic"  ForeColor="Red" ErrorMessage="Value is required."> * </asp:RequiredFieldValidator>
                </FooterTemplate>
               </asp:TemplateField>
                  <asp:boundfield  HeaderText="Price"  DataField="Price"/>
                <asp:TemplateField>
                <FooterTemplate>
                <asp:TextBox ID="newPrice" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPrice"  runat="server" ControlToValidate="newPrice" Display="Dynamic"  ForeColor="Red" ErrorMessage="Value is required."> * </asp:RequiredFieldValidator>
               <asp:RegularExpressionValidator runat="server" ControlToValidate="newPrice" ErrorMessage="Enter a valid value" ForeColor="Red" ValidationExpression="^\$?(\d{1,3},?(\d{3},?)*\d{3}(.\d{0,3})?|\d{1,3}(.\d{2})?)$">*</asp:RegularExpressionValidator>
                     </FooterTemplate>
               </asp:TemplateField>--%>

                <asp:TemplateField>                   
                    <ItemTemplate>
                        <asp:LinkButton Text="Edit" runat="server" CommandName="Edit"></asp:LinkButton>
                     </ItemTemplate>
             
                    <EditItemTemplate>
                        <asp:LinkButton ID="updateId" Text="Update" runat="server" CommandName="Update"></asp:LinkButton>
                        <asp:LinkButton Text="Cancel" runat="server" CommandName="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
               </asp:TemplateField>    
                 <asp:TemplateField>                   
                    <ItemTemplate>
                        <asp:LinkButton Text="Delete" runat="server" CommandName="Delete"></asp:LinkButton>
                     </ItemTemplate>  
                  </asp:TemplateField> 
                          
                   
            </Columns>

         
        </asp:GridView>
    </div>
    </form>
</body>
</html>
