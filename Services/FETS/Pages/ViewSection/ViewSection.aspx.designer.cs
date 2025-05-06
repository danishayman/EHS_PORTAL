namespace FETS.Pages.ViewSection
{
    public partial class ViewSection
    {
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;
        protected global::System.Web.UI.WebControls.Label lblUsername;
        protected global::System.Web.UI.WebControls.LinkButton btnBack;
        protected global::System.Web.UI.WebControls.LinkButton btnLogout;

        protected global::System.Web.UI.WebControls.Label lblFilterPlant;
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterPlant;
        protected global::System.Web.UI.WebControls.Label lblFilterLevel;
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterLevel;
        protected global::System.Web.UI.WebControls.Label lblFilterStatus;
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterStatus;
        protected global::System.Web.UI.WebControls.Label lblFilterType;
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterType;
        
        /// <summary>
        /// lblFilterMonth control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblFilterMonth;
        
        /// <summary>
        /// ddlFilterMonth control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterMonth;
        
        /// <summary>
        /// lblFilterYear control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblFilterYear;
        
        /// <summary>
        /// ddlFilterYear control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.DropDownList ddlFilterYear;
        protected global::System.Web.UI.WebControls.Label lblSearch;
        protected global::System.Web.UI.WebControls.TextBox txtSearch;
        protected global::System.Web.UI.WebControls.Button btnSearch;
        protected global::System.Web.UI.WebControls.Button btnClearFilters;

        protected global::System.Web.UI.WebControls.Button btnShowExpired;
        protected global::System.Web.UI.WebControls.Button btnShowExpiringSoon;
        protected global::System.Web.UI.WebControls.Label lblExpiryStats;

        protected global::System.Web.UI.WebControls.GridView gvFireExtinguishers;

        // Monitoring Panel Controls
        protected global::System.Web.UI.WebControls.LinkButton btnExpiredTab;
        protected global::System.Web.UI.WebControls.LinkButton btnExpiringSoonTab;
        protected global::System.Web.UI.WebControls.LinkButton btnUnderServiceTab;

        protected global::System.Web.UI.WebControls.MultiView mvMonitoring;
        protected global::System.Web.UI.WebControls.View vwExpired;
        protected global::System.Web.UI.WebControls.View vwExpiringSoon;
        protected global::System.Web.UI.WebControls.View vwUnderService;
        protected global::System.Web.UI.WebControls.GridView gvExpired;
        protected global::System.Web.UI.WebControls.GridView gvExpiringSoon;
        protected global::System.Web.UI.WebControls.GridView gvUnderService;

        protected global::System.Web.UI.WebControls.Button btnSendAllToService;
        protected global::System.Web.UI.WebControls.Button btnSendAllExpiredToService;
        protected global::System.Web.UI.WebControls.Button btnSendAllExpiringSoonToService;

        /// <summary>
        /// pnlExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Panel pnlExpiryDate;

        /// <summary>
        /// hdnSelectedFEID control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.HiddenField hdnSelectedFEID;

        /// <summary>
        /// lblNewExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblNewExpiryDate;

        /// <summary>
        /// txtNewExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.TextBox txtNewExpiryDate;

        /// <summary>
        /// rfvNewExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvNewExpiryDate;

        /// <summary>
        /// btnSaveExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnSaveExpiryDate;

        /// <summary>
        /// btnCancelExpiryDate control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnCancelExpiryDate;

        /// <summary>
        /// pnlSendToService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Panel pnlSendToService;

        /// <summary>
        /// hdnSelectedFEIDForService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.HiddenField hdnSelectedFEIDForService;

        /// <summary>
        /// lblServiceReplacement control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblServiceReplacement;

        /// <summary>
        /// ddlServiceReplacement control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.DropDownList ddlServiceReplacement;

        /// <summary>
        /// lblServiceRemarks control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblServiceRemarks;

        /// <summary>
        /// txtServiceRemarks control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.TextBox txtServiceRemarks;

        /// <summary>
        /// btnConfirmSendToService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnConfirmSendToService;

        /// <summary>
        /// btnCancelSendToService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnCancelSendToService;

        /// <summary>
        /// btnCompleteServiceList control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnCompleteServiceList;

        /// <summary>
        /// upCompleteService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.UpdatePanel upCompleteService;

        /// <summary>
        /// pnlCompleteService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Panel pnlCompleteService;

        /// <summary>
        /// gvCompleteService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.GridView gvCompleteService;

        /// <summary>
        /// btnConfirmCompleteService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnConfirmCompleteService;

        /// <summary>
        /// btnCancelCompleteService control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnCancelCompleteService;

        protected global::System.Web.UI.ScriptManager ScriptManager1;
        protected global::System.Web.UI.UpdatePanel UpdatePanel1;
        
        // Edit Panel Controls
        protected global::System.Web.UI.UpdatePanel upEditFireExtinguisher;
        protected global::System.Web.UI.WebControls.Panel pnlEditFireExtinguisher;
        protected global::System.Web.UI.WebControls.HiddenField hdnEditFEID;
        protected global::System.Web.UI.WebControls.TextBox txtSerialNumber;
        protected global::System.Web.UI.WebControls.TextBox txtAreaCode;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSerialNumber;
        protected global::System.Web.UI.WebControls.DropDownList ddlPlant;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPlant;
        protected global::System.Web.UI.WebControls.DropDownList ddlLevel;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvLevel;
        protected global::System.Web.UI.WebControls.TextBox txtLocation;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvLocation;
        protected global::System.Web.UI.WebControls.DropDownList ddlType;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvType;
        protected global::System.Web.UI.WebControls.DropDownList ddlStatus;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvStatus;
        protected global::System.Web.UI.WebControls.TextBox txtExpiryDate;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvExpiryDate;
        protected global::System.Web.UI.WebControls.TextBox txtRemarks;
        protected global::System.Web.UI.WebControls.DropDownList ddlReplacement;
        protected global::System.Web.UI.WebControls.Button btnSaveEdit;
    }
} 