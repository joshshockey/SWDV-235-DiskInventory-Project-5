<%@Page Title="Artists"  Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master"  CodeBehind="Artists.aspx.cs" Inherits="Project5.Artists" %>

<asp:Content ID="mainContent" ContentPlaceHolderID="mainPlaceholder" runat="server">
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                CssClass="text-danger summary"
                HeaderText="Please enter required fields." />    
  <%-- * Artist Table Data *--%>
     <div class="col-xs-12 table-responsive">
                <h1>Artist Information</h1>
                <asp:GridView ID="grdartist" runat="server"
                    AutoGenerateColumns="False" DataKeyNames="artist_ID"
                    DataSourceID="SqlDataSource1"
                    CssClass="table table-bordered table-condensed table-hover"
                    OnPreRender="grdartist_PreRender" 
                    OnRowDeleted="grdartist_RowDeleted" 
                    OnRowUpdated="grdartist_RowUpdated">
                    <Columns>    
                        <asp:BoundField DataField="artist_ID" HeaderText="Artist ID" 
                            SortExpression="artist_ID">
                            <ItemStyle CssClass="col-xs-1" />
                        </asp:BoundField>
                        <asp:BoundField DataField="artist_fname" HeaderText="First Name" 
                            SortExpression="artist_fname">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>
                        <asp:BoundField DataField="artist_lname" HeaderText="Last Name" 
                            SortExpression="artist_lname">
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
                    SelectCommand="SELECT [artist_ID], [artist_fname], [artist_lname]
                        FROM [artist]"
                    DeleteCommand="DELETE FROM [artist] 
                        WHERE [artist_ID] = @original_artist_ID 
                          AND [artist_fname] = @original_artist_fname 
                          AND [artist_lname] = @original_artist_lname"                           
                    InsertCommand="INSERT INTO [artist] 
                        ([artist_ID], [artist_fname], [artist_lname]) 
                        VALUES (@artist_ID, @artist_fname, @artist_lname)" 
                    UpdateCommand="UPDATE [artist] 
                          SET [artist_ID] = @artist_ID,
                              [artist_fname] = @artist_fname, 
                              [artist_lname] = @artist_lname                             
                        WHERE [artist_ID] = @artist_ID 
                          AND [artist_fname] = @original_artist_fname 
                          AND [artist_lname] = @original_artist_lname">                         
                    <DeleteParameters>
                        <asp:Parameter Name="original_artist_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_artist_fname" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_artist_lname" Type="String"></asp:Parameter>                        
                    </DeleteParameters>
                    <InsertParameters>  
                        <asp:Parameter Name="artist_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="artist_fname" Type="String"></asp:Parameter>
                        <asp:Parameter Name="artist_lname" Type="String"></asp:Parameter>                        
                    </InsertParameters>
                    <UpdateParameters>  
                        <asp:Parameter Name="artist_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="artist_fname" Type="String"></asp:Parameter>
                        <asp:Parameter Name="artist_lname" Type="String"></asp:Parameter> 
                         <asp:Parameter Name="original_artist_ID" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_artist_fname" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_artist_lname" Type="String"></asp:Parameter>                        
                    </UpdateParameters>
                </asp:SqlDataSource>    
            </div>
    <%--* Artist Data entry Fields *--%>
            <div class="col-xs-12">
                <p>To create a new artist, enter the artist information 
                    and click Add New Artist
                </p>
                <p><asp:Label ID="lblError" runat="server" EnableViewState="false" 
                        CssClass="text-danger"></asp:Label></p>
                 
                <div class="form-group">
                    <label for="txtartist_ID" class="col-sm-2">Artist ID</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtartist_ID" runat="server" MaxLength="10" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                 <div class="col-sm-2">
                        <asp:RequiredFieldValidator ID="rfvArtistID" runat="server" 
                        ControlToValidate="txtartist_ID" CssClass="text-danger" 
                        ErrorMessage="Artist ID is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                <div class="form-group">
                    <label for="txtartist_fname" class="col-sm-2">First Name</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtartist_fname" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-offset-2 col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvShortName" runat="server" 
                        ControlToValidate="txtartist_fname" CssClass="text-danger" 
                        ErrorMessage="First Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>              
                <div class="form-group">
                    <label for="txtartist_lname" class="col-sm-2">Last Name</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtartist_lname" runat="server" MaxLength="30" 
                            CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        <asp:RequiredFieldValidator ID="rfvLongName" runat="server" 
                        ControlToValidate="txtartist_lname" CssClass="text-danger" 
                        ErrorMessage="Last Name is a required field">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                
                <asp:Button ID="btnAdd" runat="server" Text="Add New Artist" 
                    CssClass="btn" OnClick="btnAdd_Click" />              
                </div>
            </div>
                
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="headPlaceholder">
    </asp:Content>
