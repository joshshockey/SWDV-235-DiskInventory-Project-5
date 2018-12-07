<%@ Page Title="CheckOut" Language="C#" AutoEventWireup="true "MasterPageFile="~/Site.Master"  CodeBehind="CheckOut.aspx.cs" Inherits="Project5.CheckOut" %>

<%--Check Out Page Added 11/28/2018--%>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="col-xs-6 table-responsive">
        <h1>Borrower Check Out Page</h1>
      <%--  -GridView table for Borrower info---%>
    <asp:GridView ID="grdinventory" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
        CssClass="table table-bordered table-striped table-condensed"
        OnPreRender="grdinventory_PreRender">        
        <Columns>
            <asp:BoundField DataField="inv_ID" HeaderText="Inv ID" SortExpression="inv_ID" >                
                <ItemStyle CssClass="col-xs-1" />
            </asp:BoundField>
            <asp:BoundField DataField="inv_name" HeaderText="Album" SortExpression="inv_name">
                <ItemStyle CssClass="col-xs-3" />
            </asp:BoundField>
            <asp:BoundField DataField="first_name" HeaderText="Borrower First" SortExpression="first_name">
                <ItemStyle CssClass="col-xs-3" />
            </asp:BoundField>
            <asp:BoundField DataField="last_name" HeaderText="Borrower Last" SortExpression="last_name">
                <ItemStyle CssClass="col-xs-3" />
            </asp:BoundField>
            <asp:BoundField DataField="borrow_date" HeaderText="Check Out Date" SortExpression="borrow_date">
                <ItemStyle CssClass="col-xs-2" />
            </asp:BoundField>
            <asp:CommandField />
            <asp:CommandField ButtonType="Link" ShowSelectButton="True">
                <ItemStyle CssClass="col-xs-1" />
            </asp:CommandField>
        </Columns>
        <AlternatingRowStyle CssClass="altRow" />
        <EditRowStyle CssClass="warning" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>" SelectCommand="SELECT inventory.inv_ID, inventory.inv_name, customer.first_name, customer.last_name, loan_status.borrow_date FROM inventory INNER JOIN loan_status ON inventory.inv_ID = loan_status.inv_ID INNER JOIN customer ON loan_status.cust_ID = customer.cust_ID">

    </asp:SqlDataSource>
    <br />
    </div>
    <%---Details View table added---%>
    <div class="col-sm-6">
                <asp:DetailsView ID="dvinventory" runat="server" 
                    DataSourceID="SqlDataSource2" DataKeyNames="inv_ID" 
                    AutoGenerateRows="False"  
                    CssClass="table table-bordered table-condensed" 
                    OnItemDeleted="dvinventory_ItemDeleted" 
                    OnItemDeleting="dvinventory_ItemDeleting" 
                    OnItemInserted="dvinventory_ItemInserted" 
                    OnItemUpdated="dvinventory_ItemUpdated">
                    <Fields>                        
                        <asp:TemplateField HeaderText="Borrower">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:DropDownList runat="server" ID="ddlBorrower" 
                                        DataSourceID="SqlDataSource3" 
                                        DataTextField="first_name" DataValueField="first_name" 
                                        SelectedValue='<%# Bind("first_name") %>'
                                        CssClass="form-control"></asp:DropDownList>
                                </div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:DropDownList runat="server" ID="DropDownList1" 
                                        DataSourceID="SqlDataSource3" 
                                        DataTextField="first_name" DataValueField="first_name" 
                                        SelectedValue='<%# Bind("first_name") %>'
                                        CssClass="form-control"></asp:DropDownList>
                                </div>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblBorrower" 
                                    Text='<%# Bind("first_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="Album">
                            <EditItemTemplate>
                                <div class="col-xs-11 col-edit">
                                    <asp:DropDownList runat="server" ID="ddlAlbum" 
                                        DataSourceID="SqlDataSource2" 
                                        DataTextField="inv_name" DataValueField="inv_name" 
                                        SelectedValue='<%# Bind("inv_name") %>'
                                        CssClass="form-control"></asp:DropDownList>
                                </div>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="col-xs-11 col-insert">
                                    <asp:DropDownList runat="server" ID="DropDownList2" 
                                        DataSourceID="SqlDataSource3" 
                                        DataTextField="inv_name" DataValueField="inv_name" 
                                        SelectedValue='<%# Bind("inv_name") %>'
                                        CssClass="form-control"></asp:DropDownList>
                                </div>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblAlbum" 
                                    Text='<%# Bind("inv_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:CommandField ButtonType="Link" 
                            ShowDeleteButton="true" 
                            ShowEditButton="true" 
                            ShowInsertButton="true" />
                    </Fields>
                    <RowStyle BackColor="#e7e7e7" />
                    <CommandRowStyle BackColor="#8c8c8c" ForeColor="white" />
                </asp:DetailsView>
       <%-- -Update, Delete, Insert, Select commands---%>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                    ConflictDetection="CompareAllValues" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectCommand="SELECT inventory.inv_ID, inventory.inv_name, customer.first_name, customer.last_name, loan_status.borrow_date FROM inventory INNER JOIN loan_status ON inventory.inv_ID = loan_status.inv_ID INNER JOIN customer ON loan_status.cust_ID = customer.cust_ID" 
                    DeleteCommand="exec sp_del_inventory @original_inv_ID"                           
                    InsertCommand="INSERT INTO [inventory] ([inv_ID], [inv_name])                          
                        VALUES (@inv_ID, @inv_name)" 
                    UpdateCommand="UPDATE [inventory] SET [inv_name] = @inv_name                          
                        WHERE [inv_ID] = @original_inv_ID 
                          AND [inv_name] = @original_inv_name">                         
                    <DeleteParameters>
                        <asp:Parameter Name="original_inv_ID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="inv_ID" Type="String" /> 
                        <asp:Parameter Name="inv_name" Type="String" />                        
                        <asp:Parameter Name="originalinv_ID" Type="String" />
                        <asp:Parameter Name="original_inv_name" Type="String" />                       
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="inv_ID" Type="String" />
                        <asp:Parameter Name="inv_name" Type="String" />                       
                    </InsertParameters>
                </asp:SqlDataSource>  
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString='<%$ ConnectionStrings:disk_inventoryConnectionString %>' 
                    SelectCommand="SELECT [cust_ID], [first_name], [last_name] FROM [customer] ORDER BY [first_name]" DeleteCommand="DELETE FROM [customer] WHERE [cust_ID] = @cust_ID" InsertCommand="INSERT INTO [customer] ([first_name], [last_name]) VALUES (@first_name, @last_name)" UpdateCommand="UPDATE [customer] SET [first_name] = @first_name, [last_name] = @last_name WHERE [cust_ID] = @cust_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="cust_ID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="first_name" Type="String" />
                        <asp:Parameter Name="last_name" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="first_name" Type="String" />
                        <asp:Parameter Name="last_name" Type="String" />
                        <asp:Parameter Name="cust_ID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource> 

                <p><asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                        HeaderText="Please correct the following errors:" 
                        CssClass="text-danger" /></p>
                <p><asp:Label ID="lblError" runat="server" 
                    EnableViewState="false" CssClass="text-danger"></asp:Label></p>

            </div>

</asp:Content>
