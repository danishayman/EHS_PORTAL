<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FETS.Pages.Profile.Profile" MasterPageFile="~/Areas/FETS/Site.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Main layout and container styling */
        .dashboard-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .profile-section {
            width: 100%;
            max-width: 1100px;
            min-width: 1000px;
            margin: 0 auto 30px auto;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 30px;
            box-sizing: border-box;
        }

        /* Typography styling */
        h3 {
            text-align: center;
            margin: 0 0 30px 0;
            color: #333;
            font-size: 1.75rem;
            font-weight: 600;
            padding-bottom: 15px;
            border-bottom: 2px solid #007bff;
        }

        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }

        /* Form element styling */
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

        /* Button styling */
        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 1rem;
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

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 4px 8px;
            font-size: 0.875rem;
            min-width: 80px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        /* Validation and message styling */
        .validation-error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 5px;
            display: block;
        }

        .message {
            padding: 15px;
            margin: 0 auto 20px auto;
            border-radius: 4px;
            text-align: center;
            font-size: 0.95rem;
            max-width: 1100px;
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

        .btn-section {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* Grid styling for tables */
        .user-management {
            margin-top: 30px;
            overflow-x: auto;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            min-width: 800px;
        }

        .grid-header th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
            padding: 12px;
            text-align: center;
            border: 1px solid #dee2e6;
            white-space: nowrap;
        }

        .grid-row td, .grid-row-alt td {
            padding: 10px;
            border: 1px solid #dee2e6;
            text-align: center;
            vertical-align: middle;
            white-space: nowrap;
        }

        .grid-row-alt {
            background-color: #f8f9fa;
        }

        .grid-row:hover, .grid-row-alt:hover {
            background-color: #f2f2f2;
        }

        /* Form layout for responsive design */
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .form-col {
            flex: 1;
            min-width: 250px;
        }

        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .profile-section {
                min-width: auto;
                width: 100%;
                padding: 20px;
                overflow-x: hidden;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .form-col {
                width: 100%;
                min-width: 100%;
            }

            .btn-section {
                flex-wrap: wrap;
                gap: 10px;
            }

            .btn-section .btn {
                width: 100%;
                margin-bottom: 10px;
            }
        }

        /* Action buttons container */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 5px;
            flex-wrap: wrap;
        }

        .action-buttons .btn {
            margin: 2px;
            white-space: nowrap;
            max-width: 100px;
            width: auto !important;
            display: inline-block !important;
        }
        
        /* Grid button styling - make buttons in grids smaller and more compact */
        .grid-view .btn-sm {
            padding: 3px 8px;
            font-size: 12px;
            min-width: 50px;
        }

        /* Status indicator styling */
        .status-active {
            color: #28a745;
            font-weight: 600;
        }
        
        .status-inactive {
            color: #dc3545;
            font-weight: 600;
        }
        
        /* Additional button styles */
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 1rem;
            min-width: 120px;
            height: auto;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-right: 10px;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
            border: none;
            padding: 4px 8px;
            font-size: 0.875rem;
            min-width: 80px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .btn-warning:hover {
            background-color: #e0a800;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 4px 8px;
            font-size: 0.875rem;
            min-width: 80px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-container">
        <h3>Profile Management</h3>
        
        <!-- Status message area -->
        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>

        <!-- Password change section - available to all users -->
        <section class="profile-section">
            <h4 class="section-title">Change Password</h4>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtCurrentPassword">Current Password:</asp:Label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" 
                            ControlToValidate="txtCurrentPassword"
                            ErrorMessage="Current password is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="ChangePassword">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtNewPassword">New Password:</asp:Label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" 
                            ControlToValidate="txtNewPassword"
                            ErrorMessage="New password is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="ChangePassword">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtConfirmPassword">Confirm New Password:</asp:Label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Confirm password is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="ChangePassword">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPasswordMatch" runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtNewPassword"
                            ErrorMessage="New password and confirmation password do not match"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="ChangePassword">
                        </asp:CompareValidator>
                    </div>
                </div>
            </div>

            <div class="btn-section">
                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" CssClass="btn btn-primary" ValidationGroup="ChangePassword" />
            </div>
        </section>

        <!-- User Management Section - Admin only interface for creating and managing users -->
        <asp:Panel ID="pnlUserManagement" runat="server" CssClass="profile-section" Visible="false">
            <h4 class="section-title">User Management</h4>
            
            <!-- User creation form -->
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtNewUsername">Username:</asp:Label>
                        <asp:TextBox ID="txtNewUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNewUsername" runat="server"
                            ControlToValidate="txtNewUsername"
                            ErrorMessage="Username is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="AddUser">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtUserPassword">Password:</asp:Label>
                        <asp:TextBox ID="txtUserPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUserPassword" runat="server"
                            ControlToValidate="txtUserPassword"
                            ErrorMessage="Password is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="AddUser">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlRole">Role:</asp:Label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                            <asp:ListItem Text="User" Value="User" />
                            <asp:ListItem Text="Administrator" Value="Administrator" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlPlant">Assigned Plant:</asp:Label>
                        <asp:DropDownList ID="ddlPlant" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="btn-section">
                <asp:Button ID="btnCancelUserEdit" runat="server" Text="Cancel" OnClick="btnCancelUserEdit_Click" CssClass="btn btn-secondary" Visible="false" />
                <asp:Button ID="btnUpdateUser" runat="server" Text="Update User" OnClick="btnUpdateUser_Click" CssClass="btn btn-primary" ValidationGroup="AddUser" Visible="false" />
                <asp:Button ID="btnAddUser" runat="server" Text="Add User" OnClick="btnAddUser_Click" CssClass="btn btn-primary" ValidationGroup="AddUser" />
            </div>

            <!-- Add a hidden field for the user ID -->
            <asp:HiddenField ID="hdnUserID" runat="server" />

            <!-- Users data grid - displays all system users -->
            <div class="user-management">
                <h4 class="section-title">Existing Users</h4>
                <asp:GridView ID="gvUsers" runat="server" 
                    AutoGenerateColumns="False" 
                    CssClass="grid-view"
                    OnRowCommand="gvUsers_RowCommand"
                    HeaderStyle-CssClass="grid-header"
                    RowStyle-CssClass="grid-row"
                    AlternatingRowStyle-CssClass="grid-row-alt">
                    <Columns>
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="Role" HeaderText="Role" />
                        <asp:BoundField DataField="PlantName" HeaderText="Assigned Plant" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnEdit" runat="server" 
                                        CommandName="EditUser" 
                                        CommandArgument='<%# Eval("UserID") %>'
                                        CssClass="btn btn-primary btn-sm" style="width: auto; display: inline-block;">
                                        Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CommandName="DeleteUser" 
                                        CommandArgument='<%# Eval("UserID") %>'
                                        CssClass="btn btn-danger btn-sm"
                                        OnClientClick="return confirm('Are you sure you want to delete this user?');"
                                        Visible='<%# Eval("Username").ToString() != "admin" %>'>
                                        Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>

        <!-- Email Recipients Management - Admin only interface for notification configuration -->
        <asp:Panel ID="pnlEmailRecipients" runat="server" CssClass="profile-section" Visible="false">
            <h4 class="section-title">Email Recipients Management</h4>
            
            <!-- Email recipient creation/editing form -->
            <asp:HiddenField ID="hdnRecipientID" runat="server" />
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtEmailAddress">Email Address:</asp:Label>
                        <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmailAddress" runat="server"
                            ControlToValidate="txtEmailAddress"
                            ErrorMessage="Email address is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="AddRecipient">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmailAddress" runat="server"
                            ControlToValidate="txtEmailAddress"
                            ErrorMessage="Please enter a valid email address"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="AddRecipient">
                        </asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtRecipientName">Recipient Name:</asp:Label>
                        <asp:TextBox ID="txtRecipientName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRecipientName" runat="server"
                            ControlToValidate="txtRecipientName"
                            ErrorMessage="Recipient name is required"
                            CssClass="validation-error"
                            Display="Dynamic"
                            ValidationGroup="AddRecipient">
                        </asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ddlNotificationType">Notification Type:</asp:Label>
                        <asp:DropDownList ID="ddlNotificationType" runat="server" CssClass="form-control">
                            <asp:ListItem Text="All Notifications" Value="All" />
                            <asp:ListItem Text="Expiry Notifications Only" Value="Expiry" />
                            <asp:ListItem Text="Service Reminders Only" Value="Service" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-col">
                    <!-- Spacer column for layout balance -->
                </div>
            </div>

            <div class="btn-section">
                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" CssClass="btn btn-secondary" Visible="false" />
                <asp:Button ID="btnUpdateRecipient" runat="server" Text="Update Recipient" OnClick="btnUpdateRecipient_Click" CssClass="btn btn-primary" ValidationGroup="AddRecipient" Visible="false" />
                <asp:Button ID="btnAddRecipient" runat="server" Text="Add Recipient" OnClick="btnAddRecipient_Click" CssClass="btn btn-primary" ValidationGroup="AddRecipient" />
            </div>

            <!-- Email recipients data grid - displays all notification recipients -->
            <div class="user-management">
                <h4 class="section-title">Existing Email Recipients</h4>
                <asp:GridView ID="gvEmailRecipients" runat="server" 
                    AutoGenerateColumns="False" 
                    CssClass="grid-view"
                    OnRowCommand="gvEmailRecipients_RowCommand"
                    HeaderStyle-CssClass="grid-header"
                    RowStyle-CssClass="grid-row"
                    AlternatingRowStyle-CssClass="grid-row-alt">
                    <Columns>
                        <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                        <asp:BoundField DataField="RecipientName" HeaderText="Recipient Name" />
                        <asp:BoundField DataField="NotificationType" HeaderText="Notification Type" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" 
                                    Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "status-active" : "status-inactive" %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnEdit" runat="server" 
                                        CommandName="EditRecipient" 
                                        CommandArgument='<%# Eval("RecipientID") %>'
                                        CssClass="btn btn-primary btn-sm" style="width: auto; display: inline-block;">
                                        Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnToggle" runat="server" 
                                        CommandName="ToggleStatus" 
                                        CommandArgument='<%# Eval("RecipientID") %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "btn btn-warning btn-sm" : "btn btn-success btn-sm" %>'>
                                        <%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CommandName="DeleteRecipient" 
                                        CommandArgument='<%# Eval("RecipientID") %>'
                                        CssClass="btn btn-danger btn-sm"
                                        OnClientClick="return confirm('Are you sure you want to delete this recipient?');">
                                        Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>
    </div>
</asp:Content>