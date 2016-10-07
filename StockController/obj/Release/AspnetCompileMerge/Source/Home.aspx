<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="StockController.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Styles/StockControllerStyles.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>
            Editable GridView Demo
        </h1>
        <asp:GridView ID="itemGridView" runat="server" AutoGenerateEditButton="false"  EmptyDataRowStyle-BorderColor="White" ShowFooter="true" ShowHeaderWhenEmpty="true"  AutoGenerateColumns="false" OnRowEditing="OnRowEditing" OnRowUpdating="OnRowUpdating" OnRowCancelingEdit="OnRowEditCancelling" OnRowDeleting="OnRowDeleting" onrowcommand ="onrowcommand"   OnRowDataBound="OnRowDataBound" CssClass="grid-view" RowStyle-CssClass="rows" HeaderStyle-CssClass="header" FooterStyle-CssClass="footer" >
            <Columns>
        <asp:TemplateField InsertVisible="False"   SortExpression="ItemId" HeaderText="Item ID">
            <ItemTemplate>
                <asp:Label ID="IdLabel" runat="server"  Text='<%# Bind("ItemId") %>'></asp:Label>
            </ItemTemplate>

               <FooterTemplate>
                            <asp:Label ID="addItemId" runat="server" ReadOnly="true"></asp:Label>
                </FooterTemplate>
        </asp:TemplateField>

        <asp:TemplateField  InsertVisible="False" SortExpression="Description" HeaderText="Description">

            <ItemTemplate>
                <asp:TextBox ID="DescriptionLabel" runat="server"  Text='<%# Bind("Description") %>' CssClass="textBox" ReadOnly="true"></asp:TextBox>
            </ItemTemplate>
                      <FooterTemplate>
                            <asp:TextBox ID="addDescription" runat="server"  CssClass="textBox"></asp:TextBox>
                </FooterTemplate>

        </asp:TemplateField>


           <asp:TemplateField  InsertVisible="False"  SortExpression="Price" HeaderText="Price ($)">

            <ItemTemplate>
                <asp:TextBox ID="priceLabel" CssClass="textBox" runat="server"  Text='<%# Bind("Price") %>' ReadOnly="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPrice"  runat="server" ControlToValidate="priceLabel" Display="Dynamic"  ForeColor="Red" > *Value is required. </asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator runat="server" Display="Dynamic" ControlToValidate="priceLabel" ErrorMessage="Enter a valid value" ForeColor="Red" ValidationExpression="^\$?(\d+\.\d\d?\d?\d?|\d+)$">*Enter a valid value for price.</asp:RegularExpressionValidator>
            </ItemTemplate>
                     <FooterTemplate>
                            <asp:TextBox ID="addPrice" runat="server"  Text="0.00" CssClass="textBox"></asp:TextBox>
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
                        <%--<asp:LinkButton Text="Edit" runat="server" CommandName="Edit"></asp:LinkButton>--%>
                          <asp:ImageButton  runat="server" ImageUrl="Images/edit.ico" CommandName="Edit" Width="30px" Height="30px" ImageAlign="Middle" AlternateText="Edit" ToolTip="Edit"/>
                     </ItemTemplate>
             
                    <EditItemTemplate>
                          <asp:ImageButton ID="updateId" runat="server" ImageUrl="Images/update.ico" CommandName="Update" Width="30px" Height="30px" ImageAlign="Middle" AlternateText="Update" ToolTip="Update"/>
                       <%-- <asp:LinkButton ID="updateId" Text="Update" runat="server" CommandName="Update"></asp:LinkButton>--%>
                         <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="Images/cancel.ico" CommandName="Cancel" Width="30px" Height="30px" ImageAlign="Middle" AlternateText="Cancel" ToolTip="Cancel"/>
                       <%--  <asp:LinkButton Text="Cancel" runat="server" CommandName="Cancel"></asp:LinkButton>--%>
                    </EditItemTemplate>
               </asp:TemplateField>    
                 <asp:TemplateField>                   
                    <ItemTemplate>
                     <asp:ImageButton runat="server" ImageUrl="Images/delete.png" CommandName="Delete" Width="30px" Height="30px" ImageAlign="Middle" AlternateText="Delete" ToolTip="Delete"/>
                     </ItemTemplate>  
                     <FooterTemplate>
                         <asp:ImageButton runat="server" ImageUrl="Images/add.ico" CommandName="Add" Width="30px" Height="30px" ImageAlign="Middle" AlternateText="Add" ToolTip="Add"/>
                           <%--  <asp:LinkButton Text="Add" runat="server" CommandName="Add"></asp:LinkButton>--%>
                     </FooterTemplate>
                  </asp:TemplateField> 
                          
                   
            </Columns>
         
        </asp:GridView>
    </div>
    </form>
</body>
</html>
