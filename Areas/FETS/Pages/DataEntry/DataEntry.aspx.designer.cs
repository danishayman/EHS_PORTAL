namespace FETS.Pages.DataEntry
{
    /// <summary>
    /// Represents the data entry page for fire extinguisher information
    /// </summary>
    public partial class DataEntry
    {
        // Form controls
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;
        
        // Header controls
        protected global::System.Web.UI.WebControls.Label lblUsername;
        protected global::System.Web.UI.WebControls.LinkButton btnBack;
        protected global::System.Web.UI.WebControls.LinkButton btnLogout;
        
        // Input fields and validators
        protected global::System.Web.UI.WebControls.Label lblSerialNumber;
        protected global::System.Web.UI.WebControls.TextBox txtSerialNumber;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSerialNumber;
        
        protected global::System.Web.UI.WebControls.Label lblAreaCode;
        protected global::System.Web.UI.WebControls.TextBox txtAreaCode;
        
        protected global::System.Web.UI.WebControls.Label lblPlant;
        protected global::System.Web.UI.WebControls.DropDownList ddlPlant;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPlant;
        
        protected global::System.Web.UI.WebControls.Label lblLevel;
        protected global::System.Web.UI.WebControls.DropDownList ddlLevel;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvLevel;
        
        protected global::System.Web.UI.WebControls.Label lblLocation;
        protected global::System.Web.UI.WebControls.TextBox txtLocation;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvLocation;
        
        protected global::System.Web.UI.WebControls.Label lblType;
        protected global::System.Web.UI.WebControls.DropDownList ddlType;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvType;
        
        protected global::System.Web.UI.WebControls.Label lblExpiryDate;
        protected global::System.Web.UI.WebControls.TextBox txtExpiryDate;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvExpiryDate;
        
        protected global::System.Web.UI.WebControls.Label lblRemarks;
        protected global::System.Web.UI.WebControls.TextBox txtRemarks;
        
        // Action controls
        protected global::System.Web.UI.WebControls.Button btnSubmit;
        protected global::System.Web.UI.WebControls.Label lblMessage;

        // Confirmation panel and its controls
        protected global::System.Web.UI.WebControls.Panel pnlConfirmation;
        protected global::System.Web.UI.WebControls.Label lblConfirmSerialNumber;
        protected global::System.Web.UI.WebControls.Label lblConfirmAreaCode;
        protected global::System.Web.UI.WebControls.Label lblConfirmPlant;
        protected global::System.Web.UI.WebControls.Label lblConfirmLevel;
        protected global::System.Web.UI.WebControls.Label lblConfirmLocation;
        protected global::System.Web.UI.WebControls.Label lblConfirmType;
        protected global::System.Web.UI.WebControls.Label lblConfirmExpiryDate;
        protected global::System.Web.UI.WebControls.Label lblConfirmRemarks;
        protected global::System.Web.UI.WebControls.Button btnConfirm;
        protected global::System.Web.UI.WebControls.Button btnCancel;

        /// <summary>
        /// divPlantManagement control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divPlantManagement;
        
        /// <summary>
        /// lblPlantName control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblPlantName;
        
        /// <summary>
        /// txtPlantName control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.TextBox txtPlantName;
        
        /// <summary>
        /// rfvPlantName control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPlantName;
        
        /// <summary>
        /// lblLevelCount control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblLevelCount;
        
        /// <summary>
        /// txtLevelCount control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.TextBox txtLevelCount;
        
        /// <summary>
        /// rvLevelCount control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.RangeValidator rvLevelCount;
        
        /// <summary>
        /// btnAddPlant control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnAddPlant;
        
        /// <summary>
        /// lblDeletePlant control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblDeletePlant;
        
        /// <summary>
        /// ddlDeletePlant control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.DropDownList ddlDeletePlant;
        
        /// <summary>
        /// rfvDeletePlant control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvDeletePlant;
        
        /// <summary>
        /// chkConfirmDelete control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.CheckBox chkConfirmDelete;
        
        /// <summary>
        /// cvConfirmDelete control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.CustomValidator cvConfirmDelete;
        
        /// <summary>
        /// btnDeletePlant control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Button btnDeletePlant;
        
        /// <summary>
        /// lblPlantMessage control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        protected global::System.Web.UI.WebControls.Label lblPlantMessage;
    }
}