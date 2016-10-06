<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="StockController.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="itemGridView" runat="server" AutoGenerateEditButton="false"  EmptyDataRowStyle-BorderColor="White" ShowFooter="true" ShowHeaderWhenEmpty="true"  AutoGenerateColumns="false" OnRowEditing="OnRowEditing" OnRowUpdating="OnRowUpdating" OnRowCancelingEdit="OnRowEditCancelling" OnRowDeleting="OnRowDeleting" onrowcommand ="onrowcommand" OnPageIndexChanging="OnPaging" PageSize="1" AllowPaging="true" OnRowDataBound="OnRowDataBound" >
            <Columns>
        <asp:TemplateField InsertVisible="False"   SortExpression="ItemId" HeaderText="Item ID">
            <ItemTemplate>
                <asp:Label ID="IdLabel" runat="server"  Text='<%# Bind("ItemId") %>'></asp:Label>
            </ItemTemplate>

               <FooterTemplate>
                            <asp:TextBox ID="addItemId" runat="server" ReadOnly="true"></asp:TextBox>
                </FooterTemplate>
        </asp:TemplateField>

        <asp:TemplateField  InsertVisible="False" SortExpression="Description" HeaderText="Description">

            <ItemTemplate>
                <asp:TextBox ID="DescriptionLabel" runat="server"  Text='<%# Bind("Description") %>' ReadOnly="true"></asp:TextBox>
            </ItemTemplate>
                      <FooterTemplate>
                            <asp:TextBox ID="addDescription" runat="server" ></asp:TextBox>
                </FooterTemplate>

        </asp:TemplateField>


           <asp:TemplateField  InsertVisible="False"  SortExpression="Price" HeaderText="Price ($)">

            <ItemTemplate>
                <asp:TextBox ID="priceLabel" runat="server"  Text='<%# Bind("Price") %>' ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPrice"  runat="server" ControlToValidate="priceLabel" Display="Dynamic"  ForeColor="Red" ErrorMessage="Value is required."> * </asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="priceLabel" ErrorMessage="Enter a valid value" ForeColor="Red" ValidationExpression="^\$?(\d+\.\d\d?\d?\d?|\d+)$">Enter a valid value for price.</asp:RegularExpressionValidator>
            </ItemTemplate>
                     <FooterTemplate>
                            <asp:TextBox ID="addPrice" runat="server"  Text="0.00"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidatorPrice"  runat="server" ControlToValidate="addPrice" Display="Dynamic"  ForeColor="Red">Please enter a valid value. </asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="addPrice" ForeColor="Red" ValidationExpression="^\$?(\d+\.\d\d?\d?\d?|\d+)$">Enter a valid currency value.</asp:RegularExpressionValidator>
                </FooterTemplate>
        </asp:TemplateField>
           
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
                     <FooterTemplate>
                             <asp:LinkButton Text="Add" runat="server" CommandName="Add"></asp:LinkButton>
                     </FooterTemplate>
                  </asp:TemplateField> 
                          
                   
            </Columns>
         
        </asp:GridView>
    </div>
    </form>
</body>
</html>
