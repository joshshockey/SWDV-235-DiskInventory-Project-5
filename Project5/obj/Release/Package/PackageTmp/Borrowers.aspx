<%@ Page Title="Borrowers" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Borrowers.aspx.cs" Inherits="Project5.Borrowers" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                CssClass="text-danger summary"
                HeaderText="Please enter required fields." />
 <%--   * Borrower Table Data *--%>
            <div class="col-xs-6 table-responsive">
                <h1>Borrower Information</h1>
                <asp:GridView ID="grdcustomer" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="cust_ID"
                    DataSourceID="SqlDataSource1"
                    CssClass="table table-bordered table-condensed table-hover"
                    OnPreRender="grdcustomer_PreRender" 
                    OnRowDeleted="grdcustomer_RowDeleted" 
                    OnRowUpdated="grdcustomer_RowUpdated">
                    <Columns>                        
                        <asp:BoundField DataField="first_name" HeaderText="First Name" 
                            SortExpression="first_name">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>
                        <asp:BoundField DataField="last_name" HeaderText="Last Name" 
                            SortExpression="last_name">
                            <ItemStyle CssClass="col-xs-5" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cust_email" HeaderText="Customer Email" 
                            SortExpression="cust_email">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:BoundField>
                        <asp:CommandField CausesValidation="False" ShowEditButton="True">
                            <ItemStyle CssClass="col-xs-1 text-danger" />
                        </asp:CommandField>
                        <asp:CommandField CausesValidation="False" ShowDeleteButton="True">
                            <ItemStyle CssClass="col-xs-1" /> 
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle CssClass="site.css" />
                    <AlternatingRowStyle CssClass="altRow" />
                    <EditRowStyle CssClass="warning" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>" 
                     ConflictDetection="CompareAllValues" 
                    OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT [cust_ID], [first_name], [last_name], [cust_email]
                        FROM [customer]"
                    DeleteCommand="DELETE FROM [customer] 
                        WHERE  [first_name] = @original_first_name 
                          AND [last_name] = @original_last_name
                          AND [cust_email] = @original_cust_email" 
                    InsertCommand="INSERT INTO [customer] 
                        ([first_name], [last_name], [cust_email]) 
                        VALUES (@first_name, @last_name, @cust_email)" 
                    UpdateCommand="UPDATE [customer] 
                          SET [first_name] = @first_name, 
                              [last_name] = @last_name, 
                              [cust_email] = @cust_email
                        WHERE  [first_name] = @original_first_name 
                          AND [last_name] = @original_last_name
                          AND [cust_email] = @original_cust_email">
                    <DeleteParameters>
                        <asp:Parameter Name="original_cust_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_first_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_last_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_cust_email" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>                        
                        <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="cust_email" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>                       
                        <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="cust_email" Type="String"></asp:Parameter>                   
                        <asp:Parameter Name="original_first_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_last_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_cust_email" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>    
            </div>
   <%--* Data insert fields *--%>
            <div class="col-xs-12">
                <p>To create a new borrower, enter the borrower information 
                    and click Add New Borrower
                </p>
                <p><asp:Label ID="lblError" runat="server" EnableViewState="false" 
                        CssClass="text-danger"></asp:Label></p>
                               
                <div class="form-group">
                    <label for="txtfirst_name" class="col-sm-2">First Name</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtfirst_name" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-offset-2 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvShortName" runat="server" 
                        ControlToValidate="txtfirst_name" CssClass="text-danger" 
                        ErrorMessage="First Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>              
                <div class="form-group">
                    <label for="txtlast_name" class="col-sm-2">Last Name</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtlast_name" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvLongName" runat="server" 
                        ControlToValidate="txtlast_name" CssClass="text-danger" 
                        ErrorMessage="Last Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                 <div class="form-group">
                    <label for="txtcust_email" class="col-sm-2">Email</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtcust_email" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-offset-3 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"                               
                             ControlToValidate="txtcust_email" CssClass="text-danger"
                             ErrorMessage="Valid Email required">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="refEmail" runat="server" 
                             CssClass="text-danger" ControlToValidate="txtcust_email" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                        </asp:RegularExpressionValidator>
                          
                    </div>
                </div>

                <asp:Button ID="btnAdd" runat="server" Text="Add New Borrower" 
                    CssClass="btn" OnClick="btnAdd_Click" />
            </div>  

           
           
            
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="headPlaceholder">
    </asp:Content>