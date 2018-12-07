<%@ Page Title="Disk" Language="C#" AutoEventWireup="true"MasterPageFile="~/Site.Master" CodeBehind="Disk.aspx.cs" Inherits="Project5.Disk" %>

<%---Updated 11/28/2019-
-Modified Disk inventory to accept insert, updata, delete entries by changing InvId identity in SQL Server---%>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                CssClass="text-danger summary"
                HeaderText="Please enter required fields." />    
   <%--* Disk Table Data *--%>
     <div class="col-xs-12 table-responsive">
                <h1>Inventory Information</h1>
                <asp:GridView ID="grdinventory" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="inv_ID"
                    DataSourceID="SqlDataSource1"
                    CssClass="table table-bordered table-condensed table-hover"
                    OnPreRender="grdinventory_PreRender" 
                    OnRowDeleted="grdinventory_RowDeleted" 
                    OnRowUpdated="grdinventory_RowUpdated">
                    <Columns>    
                        <asp:BoundField DataField="inv_ID" HeaderText="Inventory ID"                             
                             SortExpression="inv_ID">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="inv_name" HeaderText="Album Name" 
                            SortExpression="inv_name">
                            <ItemStyle CssClass="col-xs-7" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="status" HeaderText="Status"                             
                            ReadOnly="True">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>                      
                        <asp:BoundField DataField="genre" HeaderText="Genre" 
                            SortExpression="genre">
                            <ItemStyle CssClass="col-xs-5" />
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
                    SelectCommand="SELECT [inv_ID], [inv_name], [status], [genre]
                        FROM [inventory]"
                    DeleteCommand="DELETE FROM [inventory] 
                        WHERE  [inv_ID] = @original_inv_ID
                          AND  [inv_name] = @original_inv_name
                          AND  [status] = @original_status
                          AND  [genre] = @original_genre"                                                    
                    InsertCommand="INSERT INTO [inventory] 
                        ([inv_ID], [inv_name], [status], [genre]) 
                        VALUES (@inv_ID, @inv_name, @status, @genre)" 
                    UpdateCommand="UPDATE [inventory] 
                          SET [inv_ID] = @inv_ID,
                              [inv_name] = @inv_name,                             
                              [genre] = @genre                                                           
                        WHERE [inv_ID] = @inv_ID 
                          AND [inv_name] = @original_inv_name
                          AND [status] = @original_status
                          AND [genre] = @original_genre"> 
                                                   
                    <DeleteParameters>
                        <asp:Parameter Name="original_inv_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_inv_name" Type="String"></asp:Parameter> 
                        <asp:Parameter Name="original_status" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_genre" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>  
                        <asp:Parameter Name="inv_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="inv_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="status" Type="String"></asp:Parameter>
                        <asp:Parameter Name="genre" Type="String"></asp:Parameter>
                    </InsertParameters>
                    <UpdateParameters>  
                        <asp:Parameter Name="inv_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="inv_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="status" Type="String"></asp:Parameter>
                        <asp:Parameter Name="genre" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_inv_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_inv_name" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_status" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_genre" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>    
            </div>
  <%--  * Disk Data entry Fields *--%>
            <div class="col-xs-12">
                <p>To create a new artist, enter the artist information 
                    and click Add New Artist
                </p>
                <p><asp:Label ID="lblError" runat="server" EnableViewState="false" 
                        CssClass="text-danger"></asp:Label></p>
                 
                <div class="form-group">
                    <label for="txtinv_ID" class="col-sm-2">Inventory ID</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtinv_ID" runat="server" MaxLength="10" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                 <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="rfvInvID" runat="server" 
                        ControlToValidate="txtinv_ID" CssClass="text-danger" 
                        ErrorMessage="Inventory ID is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                <div class="form-group">
                    <label for="txtinv_name" class="col-sm-2">Album Name</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtinv_name" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>                
                <div class="col-sm-offset-2 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvAlbumName" runat="server" 
                        ControlToValidate="txtinv_name" CssClass="text-danger" 
                        ErrorMessage="Album Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                 <div class="form-group">
                    <label for="txtstatus" class="col-sm-2">Status</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtstatus" runat="server" MaxLength="10" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                 <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                        ControlToValidate="txtstatus" CssClass="text-danger" 
                        ErrorMessage="Status is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>              
                 <div class="form-group">
                    <label for="txtgenre" class="col-sm-2">Genre</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtgenre" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>                
                <div class="col-sm-offset-2 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvGenre" runat="server" 
                        ControlToValidate="txtgenre" CssClass="text-danger" 
                        ErrorMessage="Genre is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>              
                </div>
                
                <asp:Button ID="btnAdd" runat="server" Text="Add New Artist" 
                    CssClass="btn" OnClick="btnAdd_Click" />              
                </div>
            </div>
           
                
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="headPlaceholder">
    </asp:Content>
