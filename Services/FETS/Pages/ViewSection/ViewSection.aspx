<%@ Page Language="C#" MasterPageFile="~/Services/FETS/Site.Master" AutoEventWireup="true" CodeBehind="ViewSection.aspx.cs"
    Inherits="FETS.Pages.ViewSection.ViewSection" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="../../Assets/css/styles.css" rel="stylesheet" />
</asp:Content>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="dashboard-container">
                            <div class="content-container">
                                <div class="panels-layout">
                                    <div class="view-section">
                                        <!-- STEP 1: First place the Monitoring Panel -->
                                        <asp:UpdatePanel ID="upMonitoring" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="monitoring-section">
                                                    <div class="monitoring-panel">
                                                        <h3 class="section-title">Monitoring Panel</h3>
                                                        <div class="tab-container">
                                                            <div class="panel-header">
                                                                <div class="tab-buttons">
                                                                    <asp:LinkButton ID="btnExpiredTab"
                                                                        runat="server" OnClick="btnExpiredTab_Click"
                                                                        CssClass='<%# GetTabButtonClass("expired") %>'
                                                                        CausesValidation="false">
                                                                        Expired (<%= ExpiredCount %>)
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnExpiringSoonTab"
                                                                        runat="server"
                                                                        OnClick="btnExpiringSoonTab_Click"
                                                                        CssClass='<%# GetTabButtonClass("expiringSoon") %>'
                                                                        CausesValidation="false">
                                                                        Expiring Soon (<%= ExpiringSoonCount %>)
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnUnderServiceTab"
                                                                        runat="server"
                                                                        OnClick="btnUnderServiceTab_Click"
                                                                        CssClass='<%# GetTabButtonClass("underService") %>'
                                                                        CausesValidation="false">
                                                                        Under Service (<%= UnderServiceCount %>)
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>

                                                            <asp:MultiView ID="mvMonitoring" runat="server"
                                                                ActiveViewIndex="0">
                                                                <asp:View ID="vwExpired" runat="server">
                                                                    <div class="grid-wrapper" style="width: 100%; overflow-x: auto;">
                                                                        <asp:GridView ID="gvExpired" runat="server"
                                                                            AutoGenerateColumns="False"
                                                                            CssClass="grid-view monitoring-grid"
                                                                            AllowPaging="True" PageSize="5"
                                                                            OnPageIndexChanging="gvExpired_PageIndexChanging"
                                                                            OnRowCommand="gvExpired_RowCommand"
                                                                            EmptyDataText="No expired fire extinguishers found."
                                                                            PagerStyle-CssClass="grid-pager"
                                                                            PagerSettings-Mode="NumericFirstLast"
                                                                            PagerSettings-FirstPageText="First"
                                                                            PagerSettings-LastPageText="Last"
                                                                            PagerSettings-PageButtonCount="5">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1
                                                                                            %>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle
                                                                                        HorizontalAlign="Center" />
                                                                                    <HeaderStyle
                                                                                        HorizontalAlign="Center" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="SerialNumber"
                                                                                    HeaderText="Serial Number"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="AreaCode"
                                                                                    HeaderText="Area Code"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="PlantName"
                                                                                    HeaderText="Plant"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="LevelName"
                                                                                    HeaderText="Level"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="Location"
                                                                                    HeaderText="Location"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="TypeName"
                                                                                    HeaderText="Type"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="DateExpired"
                                                                                    HeaderText="Expiry Date"
                                                                                    DataFormatString="{0:dd/MM/yy}"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="DaysExpired"
                                                                                    HeaderText="Days Expired"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </asp:View>

                                                                <asp:View ID="vwExpiringSoon" runat="server">
                                                                    <div class="grid-wrapper" style="width: 100%; overflow-x: auto;">
                                                                        <asp:GridView ID="gvExpiringSoon" runat="server"
                                                                            AutoGenerateColumns="False"
                                                                            CssClass="grid-view monitoring-grid"
                                                                            AllowPaging="True" PageSize="5"
                                                                            OnPageIndexChanging="gvExpiringSoon_PageIndexChanging"
                                                                            OnRowCommand="gvExpiringSoon_RowCommand"
                                                                            EmptyDataText="No fire extinguishers expiring soon."
                                                                            PagerStyle-CssClass="grid-pager"
                                                                            PagerSettings-Mode="NumericFirstLast"
                                                                            PagerSettings-FirstPageText="First"
                                                                            PagerSettings-LastPageText="Last"
                                                                            PagerSettings-PageButtonCount="5">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1
                                                                                            %>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle
                                                                                        HorizontalAlign="Center" />
                                                                                    <HeaderStyle
                                                                                        HorizontalAlign="Center" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="SerialNumber"
                                                                                    HeaderText="Serial Number"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="AreaCode"
                                                                                    HeaderText="Area Code"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="PlantName"
                                                                                    HeaderText="Plant"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="LevelName"
                                                                                    HeaderText="Level"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="Location"
                                                                                    HeaderText="Location"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="TypeName"
                                                                                    HeaderText="Type"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="DateExpired"
                                                                                    HeaderText="Expiry Date"
                                                                                    DataFormatString="{0:dd/MM/yy}"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="DaysLeft"
                                                                                    HeaderText="Days Left"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </asp:View>

                                                                <asp:View ID="vwUnderService" runat="server">
                                                                    <div class="grid-wrapper" style="width: 100%; overflow-x: auto;">
                                                                        <asp:GridView ID="gvUnderService" runat="server"
                                                                            AutoGenerateColumns="False"
                                                                            CssClass="grid-view monitoring-grid"
                                                                            AllowPaging="True" PageSize="5"
                                                                            OnPageIndexChanging="gvUnderService_PageIndexChanging"
                                                                            OnRowCommand="gvUnderService_RowCommand"
                                                                            EmptyDataText="No fire extinguishers under service."
                                                                            PagerStyle-CssClass="grid-pager"
                                                                            PagerSettings-Mode="NumericFirstLast"
                                                                            PagerSettings-FirstPageText="First"
                                                                            PagerSettings-LastPageText="Last"
                                                                            PagerSettings-PageButtonCount="5">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1
                                                                                            %>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle
                                                                                        HorizontalAlign="Center" />
                                                                                    <HeaderStyle
                                                                                        HorizontalAlign="Center" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="SerialNumber"
                                                                                    HeaderText="Serial Number"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="AreaCode"
                                                                                    HeaderText="Area Code"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="PlantName"
                                                                                    HeaderText="Plant"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="LevelName"
                                                                                    HeaderText="Level"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="Location"
                                                                                    HeaderText="Location"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="TypeName"
                                                                                    HeaderText="Type"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="DateExpired"
                                                                                    HeaderText="Previous Expiry Date"
                                                                                    DataFormatString="{0:dd/MM/yy}"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:TemplateField HeaderText="Date Sent To Service"
                                                                                    ItemStyle-HorizontalAlign="Center"
                                                                                    HeaderStyle-HorizontalAlign="Center">
                                                                                    <ItemTemplate>
                                                                                        <%# Eval("DateSentService") != DBNull.Value ? 
                                                                                            String.Format("{0:HH:mm dd/MM/yy}", Eval("DateSentService")) : 
                                                                                            "N/A" %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </asp:View>
                                                            </asp:MultiView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnExpiredTab"
                                                    EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="btnExpiringSoonTab"
                                                    EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="btnUnderServiceTab"
                                                    EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="gvExpired"
                                                    EventName="PageIndexChanging" />
                                                <asp:AsyncPostBackTrigger ControlID="gvExpiringSoon"
                                                    EventName="PageIndexChanging" />
                                                <asp:AsyncPostBackTrigger ControlID="gvUnderService"
                                                    EventName="PageIndexChanging" />
                                            </Triggers>
                                        </asp:UpdatePanel>

                                        <!-- STEP 2: Then place the Filter Section below Monitoring Panel -->
                                        <div class="expiry-filters">
                                            <div class="button-group">
                                                <asp:Label ID="lblExpiryStats" runat="server" CssClass="expiry-stats"></asp:Label>
                                            </div>
                                        </div>
                                    
                                        <!-- STEP 3: Finally place the Fire Extinguisher List grid in the same container -->
                                        <asp:UpdatePanel ID="upMainGrid" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="grid-section">
                                                    <h3 class="section-title">Fire Extinguisher List</h3>
                                                    
                                                    <!-- Moved Filter Section here - below the heading but above the grid -->
                                                    <div class="filter-section" style="margin: 20px 0; padding: 15px; background-color: #f8f9fa; border-radius: 5px; border: 1px solid #dee2e6;">
                                                        <div class="filter-row">
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterPlant" runat="server" Text="Plant:"
                                                                    AssociatedControlID="ddlFilterPlant"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterPlant" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ddlFilterPlant_SelectedIndexChanged">
                                                                </asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterLevel" runat="server" Text="Level:"
                                                                    AssociatedControlID="ddlFilterLevel"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterLevel" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ApplyFilters"></asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterStatus" runat="server" Text="Status:"
                                                                    AssociatedControlID="ddlFilterStatus"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterStatus" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ApplyFilters"></asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterType" runat="server" Text="Type:"
                                                                    AssociatedControlID="ddlFilterType"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterType" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ApplyFilters"></asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterMonth" runat="server" Text="Expiry Month:"
                                                                    AssociatedControlID="ddlFilterMonth"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterMonth" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ApplyFilters"></asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblFilterYear" runat="server" Text="Expiry Year:"
                                                                    AssociatedControlID="ddlFilterYear"></asp:Label>
                                                                <asp:DropDownList ID="ddlFilterYear" runat="server"
                                                                    CssClass="form-control" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ApplyFilters"></asp:DropDownList>
                                                            </div>
                                                            <div class="filter-group">
                                                                <asp:Label ID="lblSearch" runat="server" Text="Search:"
                                                                    AssociatedControlID="txtSearch"></asp:Label>
                                                                <div class="search-box">
                                                                    <asp:TextBox ID="txtSearch" runat="server"
                                                                        CssClass="form-control"
                                                                        placeholder="Search all fields..."></asp:TextBox>
                                                                </div>
                                                                <div class="button-group">
                                                                    <asp:Button ID="btnSearch" runat="server" Text="Search"
                                                                        OnClick="ApplyFilters" CssClass="btn btn-primary" />
                                                                    <asp:Button ID="btnClearFilters" runat="server"
                                                                        Text="Clear Filters" OnClick="btnClearFilters_Click"
                                                                        CssClass="btn btn-secondary" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="button-container" style="margin-bottom: 15px; text-align: right;">
                                                        <asp:Button ID="btnShowSelection" runat="server" Text="Send to Service" CssClass="btn btn-warning" OnClick="btnShowSelection_Click" OnClientClick="showServiceSelectionPanel(); return true;" style="margin-right: 10px;" />
                                                        <asp:Button ID="btnCompleteServiceList" runat="server" Text="Complete Service" CssClass="btn btn-success" OnClick="btnCompleteServiceList_Click" style="margin-right: 10px;" />
                                                        <!-- Export button will be placed here using HTML -->
                                                        <span id="exportButtonPlaceholder"></span>
                                                    </div>
                                                    
                                                    <!-- Add result count display -->
                                                    <div id="divResultCount" runat="server" class="result-count" style="margin-bottom: 10px; font-weight: 500;">
                                                        <asp:Label ID="lblResultCount" runat="server" Text="0"></asp:Label> fire extinguisher(s) found
                                                    </div>
                                                    
                                                    <div class="grid-wrapper" style="width: 100%; overflow-x: auto;">
                                                        <asp:GridView ID="gvFireExtinguishers" runat="server"
                                                            AutoGenerateColumns="False" CssClass="grid-view"
                                                            AllowPaging="True" AllowSorting="True" PageSize="10"
                                                            OnPageIndexChanging="gvFireExtinguishers_PageIndexChanging"
                                                            OnSorting="gvFireExtinguishers_Sorting"
                                                            OnRowDataBound="gvFireExtinguishers_RowDataBound"
                                                            OnRowCommand="gvFireExtinguishers_RowCommand"
                                                            EmptyDataText="No fire extinguishers found for the selected criteria."
                                                            EmptyDataRowStyle-CssClass="empty-data-message"
                                                            PagerStyle-CssClass="grid-pager"
                                                            PagerSettings-Mode="NumericFirstLast"
                                                            PagerSettings-FirstPageText="First"
                                                            PagerSettings-LastPageText="Last"
                                                            PagerSettings-PageButtonCount="5">
                                                            <RowStyle CssClass="grid-row" />
                                                            <AlternatingRowStyle CssClass="grid-row-alt" />
                                                            <HeaderStyle CssClass="grid-header" />
                                                            <PagerStyle CssClass="grid-pager" />
                                                            <Columns>
                                                                <asp:BoundField DataField="SerialNumber"
                                                                    HeaderText="Serial Number"
                                                                    SortExpression="SerialNumber">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AreaCode"
                                                                    HeaderText="Area Code"
                                                                    SortExpression="AreaCode">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PlantName" HeaderText="Plant"
                                                                    SortExpression="PlantName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="LevelName" HeaderText="Level"
                                                                    SortExpression="LevelName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Location"
                                                                    HeaderText="Location" SortExpression="Location">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TypeName" HeaderText="Type"
                                                                    SortExpression="TypeName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DateExpired"
                                                                    HeaderText="Expiry Date"
                                                                    SortExpression="DateExpired"
                                                                    DataFormatString="{0:dd/MM/yy}">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Status"
                                                                    SortExpression="StatusName">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblStatus" runat="server"
                                                                            CssClass="status-badge"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Replacement" HeaderText="Condition"
                                                                    SortExpression="Replacement">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Remarks" HeaderText="Remarks"
                                                                    SortExpression="Remarks">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Actions">
                                                                    <ItemTemplate>
                                                                        <div class="action-buttons">
                                                                            <asp:Button ID="btnEdit" runat="server"
                                                                                CommandName="EditRow"
                                                                                CommandArgument='<%# Eval("FEID") %>'
                                                                                data-feid='<%# Eval("FEID") %>'
                                                                                CssClass="btn btn-sm btn-primary"
                                                                                Text="Edit"
                                                                                OnClientClick="return showEditPanel(this);" />
                                                                            <asp:Button ID="btnDelete" runat="server"
                                                                                CommandName="DeleteRow"
                                                                                CommandArgument='<%# Eval("FEID") %>'
                                                                                CssClass="btn btn-sm btn-danger"
                                                                                Text="Delete"
                                                                                OnClientClick="return confirm('Are you sure you want to delete this fire extinguisher?');" />
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        
                                        <!-- Export to Excel button outside UpdatePanel - hidden but accessible -->
                                        <div style="position: absolute; top: -9999px; left: -9999px;">
                                            <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" 
                                                CssClass="btn btn-info" OnClick="btnExportToExcel_Click" />
                                        </div>
                                        
                                        <script type="text/javascript">
                                            // When the page is loaded, create the export button in the correct position
                                            document.addEventListener('DOMContentLoaded', function() {
                                                createExportButton();
                                            });
                                            
                                            // After each partial postback, recreate the export button
                                            if (typeof (Sys) !== 'undefined') {
                                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(createExportButton);
                                            }
                                            
                                            function createExportButton() {
                                                var placeholder = document.getElementById('exportButtonPlaceholder');
                                                if (placeholder) {
                                                    // Clear any existing button
                                                    placeholder.innerHTML = '';
                                                    
                                                    // Create a button that looks like the other buttons
                                                    var exportBtn = document.createElement('button');
                                                    exportBtn.innerText = 'Export to Excel';
                                                    exportBtn.className = 'btn btn-info';
                                                    exportBtn.onclick = function(e) {
                                                        e.preventDefault();
                                                        // Trigger the real export button
                                                        document.getElementById('<%= btnExportToExcel.ClientID %>').click();
                                                        return false;
                                                    };
                                                    
                                                    placeholder.appendChild(exportBtn);
                                                }
                                            }
                                        </script>
                                        
                                        <!-- Map Layout Section -->
                                        <asp:Panel ID="pnlMapLayout" runat="server" CssClass="map-section" Visible="false">
                                            <div class="grid-section">
                                                <h3 class="section-title">Plant Map Layout</h3>
                                                
                                                <div class="map-carousel">
                                                    <div class="map-carousel-controls">
                                                        <button type="button" id="btnPrevMap" class="map-nav-button map-prev" onclick="prevMap(); return false;">
                                                            <i class="fas fa-chevron-left"></i>
                                                        </button>
                                        </div>
                                                    
                                                    <div class="map-carousel-container">
                                                        <div id="mapLevelTitle" class="map-level-title">Level 1</div>
                                                        <div id="mapLastUpdated" class="map-date">Last Updated: </div>
                                                        <div class="map-display-container">
                                                            <img id="currentMapImage" src="" alt="Plant Map" class="map-display-image" 
                                                                onclick="openMapModal(this.src, document.getElementById('plantNameHidden').value, document.getElementById('mapLevelTitle').innerText);" />
                                    </div>
                                </div>
                                                    
                                                    <div class="map-carousel-controls">
                                                        <button type="button" id="btnNextMap" class="map-nav-button map-next" onclick="nextMap(); return false;">
                                                            <i class="fas fa-chevron-right"></i>
                                                        </button>
                            </div>
                        </div>
                                                
                                                <!-- Hidden elements to store map data -->
                                                <input type="hidden" id="plantNameHidden" value="" />
                                                <div id="mapDataContainer" style="display: none;">
                                                    <asp:Repeater ID="rptMaps" runat="server">
                                                        <ItemTemplate>
                                                            <div class="map-data-item" 
                                                                data-image-url="<%# ResolveUrl("~/Uploads/Maps/" + Eval("ImagePath")) %>"
                                                                data-level="<%# Eval("LevelName") %>" 
                                                                data-update-date="<%# Eval("UploadDate", "{0:MM/dd/yyyy}") %>"
                                                                data-plant="<%# Eval("PlantName") %>">
                    </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                </div>
                                                
                                                <asp:Panel ID="pnlNoMaps" runat="server" CssClass="no-maps-message" Visible="false">
                                                    <p>No maps have been uploaded for this plant yet.</p>
                                                </asp:Panel>
                                            </div>
                                        </asp:Panel>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="upServiceSelection" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Panel ID="pnlServiceSelection" runat="server" Width="100%" CssClass="modal-panel" Visible="false">
            <div class="modal-content service-selection-modal">
                <div class="modal-header">
                    <h4 class="modal-title">Select Fire Extinguishers to Service</h4>
                </div>
                <div class="modal-body">
                    <p class="selection-instruction">Select the fire extinguishers you want to send for service from the list below:</p>
                    <asp:GridView ID="gvServiceSelection" runat="server" Width="100%" AutoGenerateColumns="false" DataKeyNames="FEID" 
                        CssClass="grid-view selection-grid" HeaderStyle-CssClass="grid-header" RowStyle-CssClass="grid-row"
                        AlternatingRowStyle-CssClass="grid-row-alt" Style="max-height: 400px; overflow-y: auto;">
                        <Columns>
                            <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                <HeaderTemplate>
                                    <input type="checkbox" onclick="toggleAllCheckboxes(this)" id="chkSelectAll" class="selection-checkbox" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" CssClass="selection-checkbox" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="SerialNumber" HeaderText="Serial Number" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                            <asp:BoundField DataField="AreaCode" HeaderText="Area Code" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                            <asp:BoundField DataField="PlantName" HeaderText="Plant" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                            <asp:BoundField DataField="LevelName" HeaderText="Level" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                            <asp:BoundField DataField="TypeName" HeaderText="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                            <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="250px" />
                            <asp:TemplateField HeaderText="Condition" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlReplacement" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Inari" Value="Inari"></asp:ListItem>
                                        <asp:ListItem Text="Temporary" Value="Temporary"></asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" Text='<%# Eval("Remarks") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-data-message">No fire extinguishers available to send for service.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnConfirmSelection" runat="server" Text="Confirm Selection" CssClass="btn btn-primary btn-lg" OnClick="btnConfirmSelection_Click" />
                    <asp:Button ID="btnCancelSelection" runat="server" Text="Cancel" CssClass="btn btn-secondary btn-lg" OnClick="btnCancelSelection_Click" OnClientClick="hideServiceSelectionPanel(); return true;" />
                </div>
            </div>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>

    <!-- Send to Service Confirmation Modal -->
    <asp:UpdatePanel ID="upServiceConfirmation" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlSendToService" runat="server" CssClass="modal-panel" Style="display: none;">
                <div class="modal-content">
                    <h4>Send to Service Confirmation</h4>
                    <asp:HiddenField ID="hdnSelectedFEIDForService" runat="server" />
                    <div class="confirmation-message">
                        <p>The following fire extinguisher(s) will be sent for service:</p>
                        <asp:GridView ID="gvServiceConfirmation" runat="server" AutoGenerateColumns="False" CssClass="confirmation-grid">
                            <Columns>
                                <asp:BoundField DataField="SerialNumber" HeaderText="Serial Number" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="AreaCode" HeaderText="Area Code" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="PlantName" HeaderText="Plant" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="LevelName" HeaderText="Level" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="DateExpired" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="StatusName" HeaderText="Status" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Condition" HeaderText="Condition" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                            </Columns>
                        </asp:GridView>
                        <p>This will change their status to "Under Service".</p>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblServiceReplacement" runat="server" Text="Condition:" AssociatedControlID="ddlServiceReplacement"></asp:Label>
                        <asp:DropDownList ID="ddlServiceReplacement" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                            <asp:ListItem Text="Inari" Value="Inari"></asp:ListItem>
                            <asp:ListItem Text="Temporary" Value="Temporary"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblServiceRemarks" runat="server" Text="Service Remarks:" AssociatedControlID="txtServiceRemarks"></asp:Label>
                        <asp:TextBox ID="txtServiceRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter service remarks here..."></asp:TextBox>
                    </div>
                    <div class="button-group mt-3">
                        <asp:Button ID="btnConfirmSendToService" runat="server" Text="Confirm" CssClass="btn btn-warning" OnClick="btnConfirmSendToService_Click" UseSubmitBehavior="false" />
                        <asp:Button ID="btnCancelSendToService" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClientClick="hideSendToServicePanel(); return false;" UseSubmitBehavior="false" />
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="modalOverlay" class="modal-overlay" style="display: none;"></div>

    <!-- Fire Extinguisher Edit Panel -->
    <asp:UpdatePanel ID="upEditFireExtinguisher" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlEditFireExtinguisher" runat="server" CssClass="modal-panel" Style="display: none;">
                <div class="modal-content edit-modal">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Fire Extinguisher</h4>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnEditFEID" runat="server" />
                        
                        <div class="form-group">
                            <asp:Label ID="lblSerialNumber" runat="server" Text="Serial Number:" AssociatedControlID="txtSerialNumber"></asp:Label>
                            <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSerialNumber" runat="server" 
                                ControlToValidate="txtSerialNumber" 
                                ErrorMessage="Serial number is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblAreaCode" runat="server" Text="Area Code:" AssociatedControlID="txtAreaCode"></asp:Label>
                            <asp:TextBox ID="txtAreaCode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblPlant" runat="server" Text="Plant:" AssociatedControlID="ddlPlant"></asp:Label>
                            <asp:DropDownList ID="ddlPlant" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvPlant" runat="server" 
                                ControlToValidate="ddlPlant" 
                                ErrorMessage="Plant is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblLevel" runat="server" Text="Level:" AssociatedControlID="ddlLevel"></asp:Label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLevel" runat="server" 
                                ControlToValidate="ddlLevel" 
                                ErrorMessage="Level is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblLocation" runat="server" Text="Location:" AssociatedControlID="txtLocation"></asp:Label>
                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" 
                                ControlToValidate="txtLocation" 
                                ErrorMessage="Location is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblType" runat="server" Text="Type:" AssociatedControlID="ddlType"></asp:Label>
                            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvType" runat="server" 
                                ControlToValidate="ddlType" 
                                ErrorMessage="Type is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblStatus" runat="server" Text="Status:" AssociatedControlID="ddlStatus"></asp:Label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                                ControlToValidate="ddlStatus" 
                                ErrorMessage="Status is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblReplacement" runat="server" Text="Condition:" AssociatedControlID="ddlReplacement"></asp:Label>
                            <asp:DropDownList ID="ddlReplacement" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                                <asp:ListItem Text="Inari" Value="Inari"></asp:ListItem>
                                <asp:ListItem Text="Temporary" Value="Temporary"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date:" AssociatedControlID="txtExpiryDate"></asp:Label>
                            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" 
                                ControlToValidate="txtExpiryDate" 
                                ErrorMessage="Expiry date is required" 
                                ValidationGroup="EditFE" 
                                CssClass="validation-error" 
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label ID="lblRemarks" runat="server" Text="Remarks:" AssociatedControlID="txtRemarks"></asp:Label>
                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveEdit" runat="server" Text="Save Changes" 
                            CssClass="btn btn-primary" ValidationGroup="EditFE" 
                            OnClick="btnSaveEdit_Click" UseSubmitBehavior="false" />
                        <button type="button" class="btn btn-secondary" onclick="hideEditPanel()">Cancel</button>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSaveEdit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>

    <!-- Complete Service Panel -->
    <asp:UpdatePanel ID="upCompleteService" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlCompleteService" runat="server" Width="100%" CssClass="modal-panel" Visible="false">
                <div class="modal-content service-selection-modal">
                    <div class="modal-header">
                        <h4 class="modal-title">Complete Service for Fire Extinguishers</h4>
                    </div>
                    <div class="modal-body">
                        <p class="selection-instruction">Enter new expiry dates for the fire extinguishers below:</p>
                        <div class="grid-container">
                            <asp:GridView ID="gvCompleteService" runat="server" Width="100%" AutoGenerateColumns="false" DataKeyNames="FEID" 
                                CssClass="grid-view selection-grid" HeaderStyle-CssClass="grid-header" RowStyle-CssClass="grid-row"
                                AlternatingRowStyle-CssClass="grid-row-alt" OnRowDataBound="gvCompleteService_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="80px">
                                        <HeaderTemplate>
                                            <input type="checkbox" onclick="toggleAllCompleteCheckboxes(this)" id="chkSelectAllComplete" class="selection-checkbox" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelectForComplete" runat="server" CssClass="selection-checkbox" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="FEID" HeaderText="ID" Visible="false" />
                                    <asp:BoundField DataField="SerialNumber" HeaderText="Serial Number" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="AreaCode" HeaderText="Area Code" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="PlantName" HeaderText="Plant" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="LevelName" HeaderText="Level" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="DateExpired" HeaderText="Previous Expiry Date" DataFormatString="{0:dd/MM/yy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:TemplateField HeaderText="New Expiry Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNewExpiryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvNewExpiryDate" runat="server" 
                                                ControlToValidate="txtNewExpiryDate" 
                                                ErrorMessage="*" 
                                                Display="Dynamic" 
                                                ValidationGroup="CompleteService"
                                                CssClass="validation-error">
                                            </asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-data-message">No fire extinguishers currently under service.</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnConfirmCompleteService" runat="server" Text="Confirm" 
                            CssClass="btn btn-primary btn-lg" OnClick="btnConfirmCompleteService_Click" 
                            ValidationGroup="CompleteService" OnClientClick="return validateCompleteServiceSelection();" />
                        <asp:Button ID="btnCancelCompleteService" runat="server" Text="Cancel" 
                            CssClass="btn btn-secondary btn-lg" OnClick="btnCancelCompleteService_Click" />
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>

    <style type="text/css">
        /* Base styles with mobile-first approach */
        .filter-section,
        .monitoring-section,
        .grid-section,
        .monitoring-panel,
        .content-layout {
            width: 100%;
            max-width: 100%;
            margin: 0 auto;
            box-sizing: border-box;
            overflow-x: auto;
        }
        
        /* Reset min-width constraints that cause horizontal scrolling */
        .monitoring-panel,
        .content-layout,
        .tab-container,
        .monitoring-grid,
        .grid-section {
            min-width: auto !important;
        }

        /* Make tables responsive */
        .grid-view, 
        .monitoring-grid,
        .selection-grid,
        .confirmation-grid {
            width: 100%;
            table-layout: auto;
        }

        /* Container structure */
        .container-fluid {
            padding: 0 15px;
        }

        .dashboard-container {
            display: flex;
            flex-direction: column;
        }

        .content-container {
            width: 100%;
            padding: 10px;
        }

        .panels-layout {
            width: 100%;
        }

        .view-section {
            display: flex;
            flex-direction: column;
            width: 100%;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Monitoring Panel */
        .monitoring-section {
            width: 100%;
            margin-bottom: 20px;
        }

        .monitoring-panel {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: 100% !important; /* Force full width */
            margin-left: 0 !important; /* Remove any margin */
        }

        .section-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
            text-align: center;
        }

        /* Tab System */
        .tab-container {
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            width: 100%;
        }

        .tab-buttons {
            display: flex;
            gap: 8px;
            flex: 1;
            overflow-x: auto;
            padding-bottom: 5px; /* For scrollbar space */
        }

        .tab-button {
            flex: 1;
            padding: 8px 10px;
            border-radius: 4px;
            text-decoration: none;
            white-space: nowrap;
            color: #666;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            text-align: center;
            font-size: 0.85rem;
            min-width: 110px;
        }

        .tab-button:hover {
            background-color: #e9ecef;
            color: #333;
            text-decoration: none;
        }

        .tab-button.active {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        /* Filter section */
        .filter-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }

        .filter-group label {
            margin-bottom: 5px;
            font-weight: 500;
        }

        .search-box {
            display: flex;
            margin-bottom: 5px;
        }

        .filter-group .button-group {
            display: flex;
            justify-content: flex-start;
            gap: 10px;
            margin-top: 10px; /* Adjusted from 100px */
        }

        .filter-group .button-group .btn {
            padding: 8px 16px;
            font-size: 0.9rem;
            min-width: 100px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: auto;
            white-space: nowrap;
        }

        /* Content Layout - MODIFIED: Changed to match monitoring panel */
        .content-layout {
            display: block !important; /* Override flex display from external CSS */
            width: 100%;
            margin-top: 20px;
            gap: 0;
        }
        
        /* Grid section */
        .grid-section {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: 100% !important; /* Force full width */
        }

        /* Override any competing styles from external CSS */
        .main-grid {
            flex: none !important;
            min-width: 0 !important;
            width: 100% !important;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
        }

        .grid-header th {
            background-color: #007bff;
            color: white;
            padding: 10px;
            font-weight: 500;
        }

        .grid-row td, .grid-row-alt td {
            padding: 8px;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }

        .grid-row-alt {
            background-color: #f8f9fa;
        }

        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 8px;
            border-radius: 4px;
            color: white;
            text-align: center;
            font-size: 0.8rem;
            font-weight: 500;
            white-space: nowrap;
        }

        .status-valid {
            background-color: #28a745;
        }

        .status-expired {
            background-color: #dc3545;
        }

        .status-expiring-soon {
            background-color: #ffc107;
            color: #856404;
        }

        .status-under-service {
            background-color: #17a2b8;
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 5px;
            justify-content: center;
        }

        .btn-sm {
            padding: 4px 8px;
            font-size: 0.8rem;
            white-space: nowrap;
            transition: background-color 0.2s ease;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-success:hover:not(.disabled-service) {
            background-color: #218838;
        }

        .btn-primary:hover {
            background-color: #0069d9;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        /* Button container */
        .button-container {
            margin-bottom: 15px;
            text-align: right;
        }

        #btnShowSelection {
            margin-bottom: 10px;
            padding: 8px 15px;
            font-weight: 500;
            font-size: 0.95rem;
            color: white !important;
        }

        /* Override btn-warning class specifically for this button */
        .button-container .btn-warning {
            color: white !important;
        }

        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        
        .modal-panel {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px; /* Add padding */
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 400px;
            max-height: 85vh;
            overflow-y: auto;
            position: relative;
        }

        .service-selection-modal {
            max-width: 90%;
            width: 90%;
            padding: 20px;
            border-radius: 8px;
            max-height: 85vh;
            display: flex;
            flex-direction: column;
        }

        .service-selection-modal .modal-body {
            flex: 1;
            overflow-y: hidden;
            padding: 15px;
            display: flex;
            flex-direction: column;
        }

        .grid-container {
            margin-bottom: 15px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            background-color: #fff;
            height: calc(100% - 30px);
            width: 100%;
            overflow: auto;
            flex: 1;
        }

        .selection-grid {
            width: 100%;
            margin-bottom: 0;
            table-layout: fixed;
        }

        .selection-grid th,
        .selection-grid td {
            padding: 8px;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        /* Responsive grid columns */
        .selection-grid th:nth-child(1),
        .selection-grid td:nth-child(1) {
            width: 60px; /* Select checkbox column */
        }

        .selection-grid th:nth-child(2),
        .selection-grid td:nth-child(2) {
            width: 120px; /* Serial Number */
        }

        .selection-grid th:nth-child(3),
        .selection-grid td:nth-child(3) {
            width: 100px; /* Plant */
        }

        .selection-grid th:nth-child(4),
        .selection-grid td:nth-child(4) {
            width: 80px; /* Level */
        }

        .selection-grid th:nth-child(5),
        .selection-grid td:nth-child(5) {
            width: 100px; /* Type */
        }

        .selection-grid th:nth-child(6),
        .selection-grid td:nth-child(6) {
            width: auto; /* Location - takes remaining space */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .service-selection-modal {
                padding: 10px;
                width: 95%;
                margin: 10px;
            }

            .service-selection-modal .modal-body {
                padding: 10px;
            }

            .grid-container {
                margin-bottom: 10px;
            }

            .selection-grid {
                table-layout: auto;
            }

            /* Stack the grid on very small screens */
            @media (max-width: 480px) {
                .selection-grid th,
                .selection-grid td {
                    font-size: 12px;
                    padding: 4px;
                }

                .selection-grid th:nth-child(1),
                .selection-grid td:nth-child(1) {
                    width: 40px;
                }

                .selection-grid th:nth-child(2),
                .selection-grid td:nth-child(2) {
                    width: 80px;
                }

                .selection-grid th:nth-child(3),
                .selection-grid td:nth-child(3),
                .selection-grid th:nth-child(4),
                .selection-grid td:nth-child(4),
                .selection-grid th:nth-child(5),
                .selection-grid td:nth-child(5) {
                    width: 60px;
                }
            }
        }

        /* Modal components */
        .modal-header {
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .modal-title {
            color: #333;
            margin: 0;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .modal-body {
            padding: 0 0 20px 0;
            overflow-y: auto;
        }

        .modal-footer {
            border-top: 1px solid #dee2e6;
            padding-top: 15px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .selection-instruction {
            margin-bottom: 15px;
            color: #555;
            font-size: 1rem;
        }

        .selection-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        /* Pagination */
        .grid-pager {
            text-align: center;
            padding: 8px 0;
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
            font-size: 0.9rem;
        }

        .grid-pager table {
            margin: 0 auto;
        }

        .grid-pager a, .grid-pager span {
            padding: 4px 8px;
            margin: 0 2px;
            border: 1px solid #dee2e6;
            border-radius: 3px;
            text-decoration: none;
            color: #007bff;
            background-color: #fff;
            display: inline-block;
            min-width: 30px;
        }

        .grid-pager span {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        /* Toast notification */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 24px;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1050;
            display: flex;
            align-items: center;
            gap: 10px;
            opacity: 0;
            transform: translateY(-20px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .toast-notification.error {
            background-color: #f44336;
        }

        .toast-notification.show {
            opacity: 1;
            transform: translateY(0);
        }

        .toast-notification.hide {
            opacity: 0;
            transform: translateY(-20px);
        }
        
        /* Result Count Style */
        .result-count {
            background-color: #e9f4fe;
            padding: 8px 12px;
            border-radius: 4px;
            border-left: 4px solid #1e88e5;
            color: #37474f;
            font-size: 15px;
            display: inline-block;
        }

        /* Media Queries for Responsive Design */
        @media (min-width: 576px) {
            .view-section {
                padding: 20px;
            }
            
            .section-title {
                font-size: 1.4rem;
            }
            
            .tab-button {
                font-size: 0.9rem;
            }
            
            .modal-content {
                width: 80%;
            }
        }

        @media (min-width: 768px) {
            .container-fluid {
                padding: 0 20px;
            }
            
            .content-container {
                padding: 15px;
            }
            
            .view-section {
                padding: 25px;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .filter-row {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
            
            .modal-content {
                width: 70%;
                max-width: 500px;
            }
            
            .service-selection-modal {
                max-width: 80%;
            }
            
            .btn-sm {
                min-width: 90px;
            }
        }

        @media (min-width: 992px) {
            .filter-row {
                grid-template-columns: repeat(4, 1fr);
            }
            
            .service-selection-modal {
                max-width: 70%;
                width: 850px;
            }
            
            /* Adjustments for sidebar states */
            body:not(.sidebar-collapsed) .filter-section,
            body:not(.sidebar-collapsed) .monitoring-section,
            body:not(.sidebar-collapsed) .grid-section,
            body:not(.sidebar-collapsed) .monitoring-panel,
            body:not(.sidebar-collapsed) .content-layout {
                max-width: calc(100vw - 280px);
            }
            
            body.sidebar-collapsed .filter-section,
            body.sidebar-collapsed .monitoring-section,
            body.sidebar-collapsed .grid-section,
            body.sidebar-collapsed .monitoring-panel,
            body.sidebar-collapsed .content-layout {
                max-width: calc(100vw - 100px);
            }
        }

        @media (min-width: 1200px) {
            .service-selection-modal {
                width: 1000px;
            }
            
            .tab-button {
                font-size: 1rem;
            }
            
            .grid-view, 
            .monitoring-grid {
                font-size: 1rem;
            }
            
            body:not(.sidebar-collapsed) .filter-section,
            body:not(.sidebar-collapsed) .monitoring-section,
            body:not(.sidebar-collapsed) .grid-section,
            body:not(.sidebar-collapsed) .monitoring-panel,
            body:not(.sidebar-collapsed) .content-layout {
                max-width: calc(100vw - 290px);
            }
            
            body.sidebar-collapsed .filter-section,
            body.sidebar-collapsed .monitoring-section,
            body.sidebar-collapsed .grid-section,
            body.sidebar-collapsed .monitoring-panel,
            body.sidebar-collapsed .content-layout {
                max-width: calc(100vw - 110px);
            }
        }

        /* Table adjustments for small screens */
        @media (max-width: 767px) {
            .grid-view, 
            .monitoring-grid,
            .selection-grid {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .tab-buttons {
                overflow-x: auto;
                flex-wrap: nowrap;
                justify-content: flex-start;
                padding-bottom: 8px;
            }
            
            .tab-button {
                min-width: 120px;
            }
            
            .button-container {
                text-align: center;
            }
        }

        .edit-modal {
            max-width: 90%;
            width: 600px;
            max-height: 85vh;
            overflow-y: auto;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }
        
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .validation-error {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 5px;
            display: block;
        }
        
        .modal-body {
            max-height: 60vh;
            overflow-y: auto;
            padding: 15px;
        }

        .service-selection-modal .modal-body {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
        }

        .selection-grid {
            min-width: 800px; /* Minimum width to prevent squishing */
            width: 100%;
        }

        @media (max-width: 768px) {
            .service-selection-modal {
                margin: 10px;
                max-height: 85vh;
            }

            .service-selection-modal .modal-body {
                padding: 10px;
            }

            .grid-container {
                margin-bottom: 10px;
            }

            /* Adjust column widths for mobile */
            .selection-grid th,
            .selection-grid td {
                white-space: nowrap;
                padding: 8px 4px;
            }
        }

        @media (max-width: 576px) {
            .service-selection-modal .modal-header,
            .service-selection-modal .modal-footer {
                padding: 10px;
            }

            .service-selection-modal .modal-footer .btn {
                padding: 8px 16px;
                font-size: 14px;
            }
        }

        /* Add to your existing styles */
        .scroll-indicator {
            text-align: center;
            color: #666;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 5px;
            margin-bottom: 8px;
            border-radius: 4px;
            font-size: 0.9rem;
            animation: fadeIn 0.3s ease;
            transition: opacity 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Map Layout Styles */
        .map-section {
            width: 100%;
            margin: 20px 0;
        }

        .map-carousel {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            margin: 0 auto;
            position: relative;
        }

        .map-carousel-controls {
            flex: 0 0 60px;
            display: flex;
            justify-content: center;
        }

        .map-nav-button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .map-nav-button:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }

        .map-nav-button:active {
            transform: scale(0.95);
        }

        .map-carousel-container {
            flex: 1;
            max-width: 90%;
            text-align: center;
            padding: 0 20px;
        }

        .map-level-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }

        .map-date {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

        .map-display-container {
            background-color: #f5f5f5;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 500px;
            overflow: hidden;
        }

        .map-display-image {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .map-display-image:hover {
            transform: scale(1.02);
        }

        /* Import Font Awesome for icons if not already imported */
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
        
        /* No maps message */
        .no-maps-message {
            text-align: center;
            padding: 40px 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border: 1px dashed #dee2e6;
            color: #6c757d;
            font-size: 1.1rem;
            margin-top: 20px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .map-display-container {
                height: 350px;
            }
            
            .map-carousel-container {
                padding: 0 10px;
            }
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: 2000;
            display: none;
            justify-content: center;
            align-items: center;
        }
        
        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #007bff;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize responsive adjustments
                initResponsiveUI();
                
                // Add scroll position management
                var scrollPosition;

                function saveScrollPosition() {
                    scrollPosition = window.scrollY;
                }

                function restoreScrollPosition() {
                    if (scrollPosition !== undefined) {
                        window.scrollTo(0, scrollPosition);
                    }
                }

                // Enhance pagination for monitoring grids
                enhanceMonitoringPagination();

                // Setup PageRequestManager for ASP.NET AJAX handling
                if (typeof (Sys) !== 'undefined') {
                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    prm.add_beginRequest(function() {
                        saveScrollPosition();
                        // Show loading indicator
                        showLoadingOverlay();
                    });
                    prm.add_endRequest(function() {
                        restoreScrollPosition();
                        // Reinitialize touch events and responsive UI after partial postbacks
                        initResponsiveUI();
                        // Enhance pagination again after postback
                        enhanceMonitoringPagination();
                        // Hide loading indicator
                        hideLoadingOverlay();
                    });
                    
                    // Add error handling for AJAX requests
                    prm.add_endRequest(function(sender, args) {
                        if (args.get_error() != undefined) {
                            var errorMessage = args.get_error().message;
                            showNotification('❌ Error: ' + errorMessage, 'error');
                            args.set_errorHandled(true);
                            hideLoadingOverlay();
                        }
                    });
                }

            function enhanceMonitoringPagination() {
                // Add click handling for pagination links
                document.querySelectorAll('.grid-pager a').forEach(function(link) {
                    link.addEventListener('click', function() {
                        showLoadingOverlay();
                    });
                });
            }
            
            function showLoadingOverlay() {
                // Create loading overlay if it doesn't exist
                if (!document.getElementById('loadingOverlay')) {
                    var overlay = document.createElement('div');
                    overlay.id = 'loadingOverlay';
                    overlay.innerHTML = '<div class="spinner"></div><div class="loading-text">Loading...</div>';
                    document.body.appendChild(overlay);
                    
                    // Add styles if not already defined
                    if (!document.getElementById('loadingOverlayStyles')) {
                        var style = document.createElement('style');
                        style.id = 'loadingOverlayStyles';
                        style.innerHTML = `
                            #loadingOverlay {
                                position: fixed;
                                top: 0;
                                left: 0;
                                width: 100%;
                                height: 100%;
                                background-color: rgba(0, 0, 0, 0.5);
                                display: flex;
                                flex-direction: column;
                                justify-content: center;
                                align-items: center;
                                z-index: 9999;
                            }
                            .spinner {
                                border: 4px solid rgba(255, 255, 255, 0.3);
                                border-radius: 50%;
                                border-top: 4px solid #fff;
                                width: 40px;
                                height: 40px;
                                animation: spin 1s linear infinite;
                            }
                            .loading-text {
                                color: white;
                                margin-top: 10px;
                                font-weight: bold;
                            }
                            @keyframes spin {
                                0% { transform: rotate(0deg); }
                                100% { transform: rotate(360deg); }
                            }
                        `;
                        document.head.appendChild(style);
                    }
                }
                
                document.getElementById('loadingOverlay').style.display = 'flex';
            }
            
            function hideLoadingOverlay() {
                var overlay = document.getElementById('loadingOverlay');
                if (overlay) {
                    overlay.style.display = 'none';
                }
            }

            function initResponsiveUI() {
                // Check if user is on touch device
                const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
                
                // Apply touch-specific adjustments
                if (isTouchDevice) {
                    // Increase touch targets for better mobile experience
                    document.querySelectorAll('.btn, .tab-button, .form-control').forEach(function(elem) {
                        elem.classList.add('touch-friendly');
                    });
                    
                    // Add specific handling for tables on touch devices
                    document.querySelectorAll('.grid-view, .monitoring-grid').forEach(function(table) {
                        table.classList.add('touch-table');
                        
                        // Add horizontal swipe indication for tables if they overflow
                        if (table.scrollWidth > table.clientWidth) {
                            const container = table.parentElement;
                            const indicator = document.createElement('div');
                            indicator.className = 'swipe-indicator';
                            indicator.innerHTML = '<i class="swipe-icon">↔</i> Swipe to view more';
                            container.insertBefore(indicator, table);
                            
                            // Hide indicator after user has swiped
                            table.addEventListener('scroll', function() {
                                indicator.style.opacity = '0';
                                setTimeout(function() {
                                    indicator.style.display = 'none';
                                }, 300);
                            });
                        }
                    });
                }
                
                // Check sidebar state on page load
                const sidebarState = localStorage.getItem('sidebarState');
                if (sidebarState === 'collapsed') {
                    document.body.classList.add('sidebar-collapsed');
                } else {
                    document.body.classList.remove('sidebar-collapsed');
                }
                
                // Make button interactions more responsive
                document.querySelectorAll('.btn').forEach(function(btn) {
                    btn.addEventListener('mousedown', function() {
                        this.classList.add('btn-active');
                    });
                    
                    btn.addEventListener('mouseup mouseleave', function() {
                        this.classList.remove('btn-active');
                    });
                });
                
                // Ensure grid views are properly scrollable on mobile
                makeTableResponsive();
            }
            
            function makeTableResponsive() {
                document.querySelectorAll('.grid-view, .monitoring-grid').forEach(function(table) {
                    const parent = table.parentElement;
                    
                    // If table is wider than container, ensure container allows horizontal scrolling
                    if (table.scrollWidth > parent.clientWidth) {
                        parent.style.overflowX = 'auto';
                        parent.style.WebkitOverflowScrolling = 'touch'; // For smooth scrolling on iOS
                    }
                });
            }

            // Listen for sidebar state changes
            window.addEventListener('storage', function(e) {
                if (e.key === 'sidebarState') {
                    if (e.newValue === 'collapsed') {
                        document.body.classList.add('sidebar-collapsed');
                    } else {
                        document.body.classList.remove('sidebar-collapsed');
                    }
                    // Adjust table containers after sidebar state changes
                    makeTableResponsive();
                }
            });
            
            // Add a custom event listener for sidebar toggle
            document.addEventListener('sidebarToggled', function(e) {
                if (e.detail.collapsed) {
                    document.body.classList.add('sidebar-collapsed');
                } else {
                    document.body.classList.remove('sidebar-collapsed');
                }
                // Adjust table containers after sidebar toggle
                makeTableResponsive();
            });
            
            // Handle window resize events
            let resizeTimer;
            window.addEventListener('resize', function() {
                clearTimeout(resizeTimer);
                resizeTimer = setTimeout(function() {
                    makeTableResponsive();
                }, 250);
            });
        });

        function showEditPanel(button) {
            var feId = button.getAttribute('data-feid') || button.getAttribute('CommandArgument');
            document.getElementById('<%= hdnEditFEID.ClientID %>').value = feId;
            
            // Display the panel
            document.getElementById('<%= pnlEditFireExtinguisher.ClientID %>').style.display = 'flex';
            document.getElementById('modalOverlay').style.display = 'block';
            
            // Call server-side method to load fire extinguisher details
            var postbackArg = 'LoadFireExtinguisherDetails:' + feId;
            __doPostBack('<%= Page.UniqueID %>', postbackArg);
            
            return false;
        }

        function hideEditPanel() {
            document.getElementById('<%= pnlEditFireExtinguisher.ClientID %>').style.display = 'none';
            document.getElementById('modalOverlay').style.display = 'none';
            return false;
        }

        function showSendToServiceConfirmation(feId) {
            // Set the hidden field value
            document.getElementById('<%= hdnSelectedFEIDForService.ClientID %>').value = feId;
            
            // Show the panel and overlay
            document.getElementById('<%= pnlSendToService.ClientID %>').style.display = 'flex';
            document.getElementById('modalOverlay').style.display = 'block';
            
            return false;
        }

        function hideSendToServicePanel() {
            document.getElementById('<%= pnlSendToService.ClientID %>').style.display = 'none';
            document.getElementById('modalOverlay').style.display = 'none';
            return false;
        }

        // Close modal when clicking outside
        window.addEventListener('load', function() {
            document.getElementById('modalOverlay').onclick = function() {
                hideEditPanel();
                hideSendToServicePanel();
                hideCompleteServicePanel();
            };

            // Prevent modal from closing when clicking inside it
            document.querySelectorAll('.modal-panel').forEach(function(panel) {
                panel.onclick = function(event) {
                    event.stopPropagation();
                };
            });
        });

        function showNotification(message, type = 'success', duration = 3000) {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `toast-notification ${type === 'error' ? 'error' : ''}`;
            notification.innerHTML = message;
            
            // Add to DOM
            document.body.appendChild(notification);
            
            // Trigger animation
            setTimeout(() => {
                notification.classList.add('show');
            }, 10);
            
            // Auto-hide after duration
            setTimeout(() => {
                notification.classList.add('hide');
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, duration);
        }

        // Service Selection Panel functions
        function showServiceSelectionPanel() {
            document.getElementById('modalOverlay').style.display = 'block';
            return true; // Allow the postback to occur
        }
        
        function hideServiceSelectionPanel() {
            document.getElementById('modalOverlay').style.display = 'none';
            return true; // Allow the postback to occur
        }
        
        // Complete Service Panel functions
        function showCompleteServicePanel() {
            document.getElementById('modalOverlay').style.display = 'block';
            return true; // Allow the postback to occur
        }
        
        function hideCompleteServicePanel() {
            document.getElementById('modalOverlay').style.display = 'none';
            return true; // Allow the postback to occur
        }
        
        // Add select all functionality for the service selection grid
        function toggleAllCheckboxes(checkbox) {
            const grid = document.getElementById('<%= gvServiceSelection.ClientID %>');
            if (!grid) return;
            
            const checkboxes = grid.getElementsByTagName('input');
            for (let i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].type === 'checkbox' && checkboxes[i] !== checkbox) {
                    checkboxes[i].checked = checkbox.checked;
                }
            }
        }

        // Complete Service Panel functions
        function toggleAllCompleteCheckboxes(checkbox) {
            const grid = document.getElementById('<%= gvCompleteService.ClientID %>');
            if (!grid) return;
            
            const checkboxes = grid.getElementsByTagName('input');
            for (let i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].type === 'checkbox' && checkboxes[i] !== checkbox) {
                    checkboxes[i].checked = checkbox.checked;
                }
            }
        }
        
        function validateCompleteServiceSelection() {
            const grid = document.getElementById('<%= gvCompleteService.ClientID %>');
            if (!grid) return false;
            
            let anyChecked = false;
            const checkboxes = grid.getElementsByTagName('input');
            
            for (let i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].type === 'checkbox' && 
                    checkboxes[i].id !== 'chkSelectAllComplete' && 
                    checkboxes[i].checked) {
                    anyChecked = true;
                    break;
                }
            }
            
            if (!anyChecked) {
                showNotification('Please select at least one fire extinguisher to complete service for.', 'error');
                return false;
            }
            
            return true;
            }
        </script>

<style>
    /* Additional responsive styles */
    .touch-friendly {
        min-height: 44px; /* Minimum touch target size */
    }
    
    .btn-active {
        transform: scale(0.97);
    }
    
    .swipe-indicator {
        text-align: center;
        color: #666;
        font-size: 14px;
        padding: 5px;
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 4px;
        margin-bottom: 8px;
        transition: opacity 0.3s ease;
    }
    
    .swipe-icon {
        display: inline-block;
        animation: swipe-anim 1.5s infinite;
        font-style: normal;
        margin-right: 5px;
    }
    
    @keyframes swipe-anim {
        0% { transform: translateX(-5px); }
        50% { transform: translateX(5px); }
        100% { transform: translateX(-5px); }
    }
    
    /* Toast notifications */
    .toast-notification {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 12px 24px;
        background-color: #4CAF50;
        color: white;
        border-radius: 4px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 1050;
        display: flex;
        align-items: center;
        gap: 10px;
        opacity: 0;
        transform: translateY(-20px);
        transition: opacity 0.3s ease, transform 0.3s ease;
    }

    .toast-notification.error {
        background-color: #f44336;
    }

    .toast-notification.show {
        opacity: 1;
        transform: translateY(0);
    }

    .toast-notification.hide {
        opacity: 0;
        transform: translateY(-20px);
    }
    
    /* Result Count Style */
    .result-count {
        background-color: #e9f4fe;
        padding: 8px 12px;
        border-radius: 4px;
        border-left: 4px solid #1e88e5;
        color: #37474f;
        font-size: 15px;
        display: inline-block;
    }
    
    /* Better table behavior on small screens */
    @media (max-width: 767px) {
        .touch-table td, .touch-table th {
            padding: 10px 8px; /* Increase padding for touch targets */
        }
        
        .action-buttons .btn-sm {
            padding: 8px 10px;
            margin: 2px 0;
        }
    }
</style>
    
    <!-- Loading overlay will be created dynamically by JavaScript -->
</asp:Content>


