<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataEntry.aspx.cs" Inherits="FETS.Pages.DataEntry.DataEntry"
    MasterPageFile="~/Services/FETS/Site.Master" %>

    <asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
        <!-- Styles for the data entry form and UI elements -->
        <style>
            .content-container {
                flex: 1;
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
                width: 100%;
            }

            .data-entry-form {
                width: 100%;
                max-width: 1100px;
                min-width: 1000px;
                margin: 0 auto;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 30px;
                box-sizing: border-box;
            }

            h3 {
                text-align: center;
                margin: 0 0 30px 0;
                color: #333;
                font-size: 1.75rem;
                font-weight: 600;
                padding-bottom: 15px;
                border-bottom: 2px solid #007bff;
            }

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-col {
                flex: 1;
                min-width: 0;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #333;
                font-weight: 500;
                font-size: 0.95rem;
            }

            .form-control {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 0.95rem;
                min-height: 38px;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                outline: none;
            }

            textarea.form-control {
                min-height: 100px;
                resize: vertical;
            }

            .btn-primary {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 1.5rem;
                min-width: 120px;
                height: auto;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .validation-error {
                color: #dc3545;
                font-size: 0.875rem;
                margin-top: 5px;
                display: block;
            }

            .message {
                padding: 15px;
                margin-top: 20px;
                border-radius: 4px;
                text-align: center;
                font-size: 0.95rem;
                display: block;
            }

            .message.success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .message.error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* Responsive layout for smaller screens */
            @media (max-width: 1200px) {
                .data-entry-form {
                    min-width: auto;
                    width: 100%;
                    padding: 20px;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .form-col {
                    width: 100%;
                }
            }

            /* Submit button styling */
            #btnSubmit {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 16px 32px;
                font-size: 1.1rem;
                min-width: 250px;
                height: 60px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.2s;
                margin-top: 15px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            #btnSubmit:hover {
                background-color: #0056b3;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .text-center {
                text-align: center;
                margin-top: 20px;
                margin-bottom: 10px;
            }

            /* Confirmation popup styling */
            .popup-panel {
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
            }

            .popup-content {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                width: 400px;
            }

            .popup-content table {
                width: 100%;
                margin-bottom: 20px;
            }

            .popup-content td {
                padding: 5px;
            }

            .popup-buttons {
                text-align: center;
            }

            .button {
                padding: 8px 15px;
                margin-left: 10px;
                cursor: pointer;
            }

            .confirm {
                background-color: #007bff;
                color: white;
                font-weight: 500;
                border: none;
                align-items: center;
                border-radius: 4px;
                font-size: 1.2rem;
                transition: background-color 0.2s;
            }

            .confirm:hover {
                background-color: #0056b3;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .cancel {
                background-color: #f44336;
                color: white;
                font-weight: 500;
                border: none;
                align-items: center;
                border-radius: 4px;
                font-size: 1.2rem;
                transition: background-color 0.2s;
            }

            .cancel:hover {
                background-color: #c03026;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            /* Add spacing between forms */
            .data-entry-form + .data-entry-form {
                margin-top: 40px;
                border-top: 2px solid #eee;
                padding-top: 40px;
            }

            /* Style for section headers */
            h4 {
                color: #333;
                font-size: 1.3rem;
                margin: 20px 0;
                padding-bottom: 10px;
                border-bottom: 1px solid #ddd;
            }

            /* Plant Management specific styles */
            .plant-management {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 30px;
            }

            .section-card {
                background: white;
                border-radius: 8px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                border: 1px solid #e9ecef;
            }

            .section-title {
                font-size: 1.4rem;
                color: #2c3e50;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title i {
                color: #007bff;
                font-size: 1.2rem;
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 1.1rem;
                font-weight: 500;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-danger:hover {
                background-color: #c82333;
                transform: translateY(-1px);
            }

            .warning-text {
                color: #dc3545;
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .checkbox-wrapper {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px;
                background-color: #fff3cd;
                border: 1px solid #ffeeba;
                border-radius: 4px;
                margin-top: 10px;
            }

            .checkbox-wrapper input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
            }

            .input-hint {
                color: #6c757d;
                font-size: 0.85rem;
                margin-top: 5px;
            }

            /* Update the existing message styles */
            .message {
                margin: 20px 0;
                padding: 15px 20px;
                border-radius: 6px;
                font-size: 1rem;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .message.success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .message.error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .message:before {
                font-family: "Font Awesome 5 Free";
                font-weight: 900;
            }

            .message.success:before {
                content: "\f00c";
            }

            .message.error:before {
                content: "\f071";
            }
        </style>

        <script type="text/javascript">
            // Show confirmation dialog before submitting the form
            function showConfirmationPopup() {
                document.getElementById('<%= pnlConfirmation.ClientID %>').style.display = 'flex';
            }

            // Hide the confirmation dialog
            function hideConfirmationPopup() {
                document.getElementById('<%= pnlConfirmation.ClientID %>').style.display = 'none';
            }
            
            window.onload = function() {
                // Set minimum date for expiry date field to today
                var today = new Date().toISOString().split('T')[0];
                document.getElementById('<%= txtExpiryDate.ClientID %>').setAttribute('min', today);
            }

            // Prevent form resubmission on page refresh
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
    </asp:Content>

    <asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="content-container">
            <!-- First: Add New Fire Extinguisher Section -->
            <div class="data-entry-form">
                <h3 class="text-center">Add New Fire Extinguisher</h3>
                
                <!-- Serial Number Row -->
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblSerialNumber" runat="server" Text="Serial Number:" AssociatedControlID="txtSerialNumber"></asp:Label>
                            <asp:TextBox ID="txtSerialNumber" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSerialNumber" runat="server" ControlToValidate="txtSerialNumber" 
                                ErrorMessage="Serial Number is required." CssClass="validation-error" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <!-- Plant Selection and Area Code -->
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblPlant" runat="server" Text="Plant:" AssociatedControlID="ddlPlant"></asp:Label>
                            <asp:DropDownList ID="ddlPlant" runat="server" CssClass="form-control" AutoPostBack="true" 
                                OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvPlant" runat="server" ControlToValidate="ddlPlant"
                                ErrorMessage="Plant is required." CssClass="validation-error" Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    
                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblAreaCode" runat="server" Text="Area Code:" AssociatedControlID="txtAreaCode"></asp:Label>
                            <asp:TextBox ID="txtAreaCode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Level and Location Information -->
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblLevel" runat="server" Text="Level:" AssociatedControlID="ddlLevel"></asp:Label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLevel" runat="server" ControlToValidate="ddlLevel"
                                ErrorMessage="Level is required." CssClass="validation-error" Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblLocation" runat="server" Text="Location:" AssociatedControlID="txtLocation"></asp:Label>
                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation"
                                ErrorMessage="Location is required." CssClass="validation-error" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <!-- Extinguisher Type and Expiry Date -->
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblType" runat="server" Text="Type:" AssociatedControlID="ddlType"></asp:Label>
                            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvType" runat="server" ControlToValidate="ddlType"
                                ErrorMessage="Type is required." CssClass="validation-error" Display="Dynamic"
                                InitialValue="">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-col">
                        <div class="form-group">
                            <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date:" AssociatedControlID="txtExpiryDate"></asp:Label>
                            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" ControlToValidate="txtExpiryDate" 
                                ErrorMessage="Expiry Date is required." CssClass="validation-error" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <!-- Additional Remarks -->
                <div class="form-group">
                    <asp:Label ID="lblRemarks" runat="server" Text="Remarks:" AssociatedControlID="txtRemarks"></asp:Label>
                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>

                <!-- Submit Button -->
                <div class="form-group text-center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Add Fire Extinguisher" OnClick="btnSubmit_Click" 
                        CssClass="btn btn-primary" />
                </div>

                <!-- Message Display Area -->
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Second: Plant Management Section (visible only for admin) -->
            <div class="data-entry-form plant-management" id="divPlantManagement" runat="server" visible="false" style="margin-top: 30px;">
                <h3 class="text-center">Plant Management</h3>
                
                <!-- Add New Plant Section -->
                <div class="section-card">
                    <h4 class="section-title">
                        <i class="fas fa-plus-circle"></i>
                        Add New Plant
                    </h4>
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <asp:Label ID="lblPlantName" runat="server" Text="Plant Name:" AssociatedControlID="txtPlantName"></asp:Label>
                                <asp:TextBox ID="txtPlantName" runat="server" CssClass="form-control" placeholder="Enter plant name"></asp:TextBox>
                                <div class="input-hint">Enter a unique name for the plant</div>
                                <asp:RequiredFieldValidator ID="rfvPlantName" runat="server" ControlToValidate="txtPlantName" 
                                    ErrorMessage="Plant name is required." CssClass="validation-error" Display="Dynamic" 
                                    ValidationGroup="PlantGroup">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <asp:Label ID="lblLevelCount" runat="server" Text="Number of Levels:" AssociatedControlID="txtLevelCount"></asp:Label>
                                <asp:TextBox ID="txtLevelCount" runat="server" CssClass="form-control" TextMode="Number" min="1" max="20" Text="1"></asp:TextBox>
                                <div class="input-hint">Choose between 1 and 20 levels</div>
                                <asp:RangeValidator ID="rvLevelCount" runat="server" ControlToValidate="txtLevelCount" 
                                    ErrorMessage="Level count must be between 1 and 20." CssClass="validation-error" Display="Dynamic" 
                                    MinimumValue="1" MaximumValue="20" Type="Integer" ValidationGroup="PlantGroup">
                                </asp:RangeValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <asp:Button ID="btnAddPlant" runat="server" Text="Add Plant" CssClass="btn btn-primary" 
                            OnClick="btnAddPlant_Click" ValidationGroup="PlantGroup" />
                    </div>
                </div>
                
                <!-- Delete Plant Section -->
                <div class="section-card">
                    <h4 class="section-title">
                        <i class="fas fa-trash-alt" style="color: #dc3545;"></i>
                        Delete Plant
                    </h4>
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <asp:Label ID="lblDeletePlant" runat="server" Text="Select Plant:" AssociatedControlID="ddlDeletePlant"></asp:Label>
                                <asp:DropDownList ID="ddlDeletePlant" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <div class="input-hint">Select the plant you want to delete</div>
                                <asp:RequiredFieldValidator ID="rfvDeletePlant" runat="server" ControlToValidate="ddlDeletePlant" 
                                    ErrorMessage="Please select a plant to delete." CssClass="validation-error" Display="Dynamic" 
                                    ValidationGroup="DeletePlantGroup" InitialValue="">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <div class="checkbox-wrapper">
                                    <asp:CheckBox ID="chkConfirmDelete" runat="server" Text="I understand this will permanently delete the plant and all its levels" />
                                </div>
                                <asp:CustomValidator ID="cvConfirmDelete" runat="server" 
                                    ErrorMessage="You must confirm deletion by checking the box." 
                                    CssClass="validation-error" Display="Dynamic" ValidationGroup="DeletePlantGroup"
                                    OnServerValidate="cvConfirmDelete_ServerValidate">
                                </asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <asp:Button ID="btnDeletePlant" runat="server" Text="Delete Plant" CssClass="btn btn-danger" 
                            OnClick="btnDeletePlant_Click" ValidationGroup="DeletePlantGroup" 
                            OnClientClick="return confirm('⚠️ Warning: This action cannot be undone. Are you absolutely sure you want to delete this plant?');" />
                    </div>
                </div>
                
                <!-- Plant Management Messages -->
                <asp:Label ID="lblPlantMessage" runat="server" CssClass="message"></asp:Label>
            </div>
        </div>

        <!-- Confirmation Popup Panel -->
        <asp:Panel ID="pnlConfirmation" runat="server" CssClass="popup-panel" Style="display: none;">
            <div class="popup-content">
                <h3>Confirm Fire Extinguisher Details</h3>
                <table>
                    <tr>
                        <td>Serial Number:</td>
                        <td><asp:Label ID="lblConfirmSerialNumber" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Area Code:</td>
                        <td><asp:Label ID="lblConfirmAreaCode" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Plant:</td>
                        <td><asp:Label ID="lblConfirmPlant" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Level:</td>
                        <td><asp:Label ID="lblConfirmLevel" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Location:</td>
                        <td><asp:Label ID="lblConfirmLocation" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Type:</td>
                        <td><asp:Label ID="lblConfirmType" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Expiry Date:</td>
                        <td><asp:Label ID="lblConfirmExpiryDate" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Remarks:</td>
                        <td><asp:Label ID="lblConfirmRemarks" runat="server"></asp:Label></td>
                    </tr>
                </table>
                <div class="popup-buttons">
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                        OnClientClick="hideConfirmationPopup(); return false;" CssClass="button cancel" />
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" OnClick="btnConfirm_Click" 
                        CssClass="button confirm" />
                </div>
            </div>
        </asp:Panel>

        <!-- Custom Validator for Expiry Date -->
        <asp:CustomValidator ID="cvExpiryDate" runat="server" ControlToValidate="txtExpiryDate"
            ErrorMessage="Expiry date cannot be in the past." CssClass="validation-error" Display="Dynamic"
            OnServerValidate="cvExpiryDate_ServerValidate">
        </asp:CustomValidator>
    </asp:Content>