using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using FETS.Models;

namespace FETS.Pages.DataEntry
{
    public partial class DataEntry : System.Web.UI.Page
    {
        // Property to store the user's assigned plant ID
        private int? UserPlantID { get; set; }
        private bool IsAdministrator { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect unauthenticated users to login page
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/Login/Login.aspx");
                return;
            }

            // Get user's assigned plant and role
            GetUserPlantAndRole();

            if (!IsPostBack)
            {
                // Show plant management section for admin users
                divPlantManagement.Visible = (User.Identity.Name.ToLower() == "admin");
                
                LoadDropDownLists();
                
                // Load plants for the deletion dropdown
                if (divPlantManagement.Visible)
                {
                    LoadPlantsForDeletion();
                }
                
                // Display any success messages from previous operations
                if (Session["SuccessMessage"] != null)
                {
                    lblMessage.Text = Session["SuccessMessage"].ToString();
                    lblMessage.CssClass = "message success";
                    Session["SuccessMessage"] = null;
                }
            }
        }

        /// <summary>
        /// Gets the current user's assigned plant and role from the database
        /// </summary>
        private void GetUserPlantAndRole()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT PlantID, Role FROM Users WHERE Username = @Username", conn))
                {
                    cmd.Parameters.AddWithValue("@Username", User.Identity.Name);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Get the user's plant ID
                            if (!reader.IsDBNull(reader.GetOrdinal("PlantID")))
                            {
                                UserPlantID = reader.GetInt32(reader.GetOrdinal("PlantID"));
                            }
                            else
                            {
                                UserPlantID = null;
                            }

                            // Check if user is an administrator
                            IsAdministrator = reader["Role"].ToString() == "Administrator";
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Loads Plants and Fire Extinguisher Types into their respective dropdowns
        /// </summary>
        private void LoadDropDownLists()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Load Plants dropdown - with restriction based on user's assigned plant
                LoadPlantsDropdown(conn);

                // Load Fire Extinguisher Types dropdown
                using (SqlCommand cmd = new SqlCommand("SELECT TypeID, TypeName FROM FireExtinguisherTypes ORDER BY TypeName", conn))
                {
                    ddlType.Items.Clear();
                    ddlType.Items.Add(new ListItem("-- Select Type --", ""));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlType.Items.Add(new ListItem(
                                reader["TypeName"].ToString(),
                                reader["TypeID"].ToString()
                            ));
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Loads all plants into the deletion dropdown
        /// </summary>
        private void LoadPlantsForDeletion()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Load Plants dropdown for deletion
                using (SqlCommand cmd = new SqlCommand("SELECT PlantID, PlantName FROM Plants ORDER BY PlantName", conn))
                {
                    ddlDeletePlant.Items.Clear();
                    ddlDeletePlant.Items.Add(new ListItem("-- Select Plant --", ""));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlDeletePlant.Items.Add(new ListItem(
                                reader["PlantName"].ToString(),
                                reader["PlantID"].ToString()
                            ));
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Loads the Plants dropdown with appropriate restrictions based on user role
        /// </summary>
        private void LoadPlantsDropdown(SqlConnection conn)
        {
            ddlPlant.Items.Clear();
            
            // If user is not administrator and has no assigned plant, disable everything
            if (!IsAdministrator && !UserPlantID.HasValue)
            {
                ddlPlant.Items.Add(new ListItem("No plant assigned to your account", ""));
                ddlPlant.Enabled = false;
                ddlLevel.Enabled = false;
                btnSubmit.Enabled = false;
                lblMessage.Text = "You do not have permission to add fire extinguishers. Please contact your administrator.";
                lblMessage.CssClass = "message error";
                lblMessage.Visible = true;
                return;
            }

            // For regular users with an assigned plant, only show that plant
            if (!IsAdministrator && UserPlantID.HasValue)
            {
                using (SqlCommand cmd = new SqlCommand("SELECT PlantID, PlantName FROM Plants WHERE PlantID = @PlantID", conn))
                {
                    cmd.Parameters.AddWithValue("@PlantID", UserPlantID.Value);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ddlPlant.Items.Add(new ListItem(
                                reader["PlantName"].ToString(),
                                reader["PlantID"].ToString()
                            ));
                        }
                    }
                }
                
                // Pre-select the plant and trigger the level dropdown load
                if (ddlPlant.Items.Count > 0)
                {
                    ddlPlant.SelectedIndex = 0;
                    ddlPlant.Enabled = false; // Disable changing the plant
                    ddlLevel.Enabled = true;
                    
                    // Load levels for the pre-selected plant
                    LoadLevelsForPlant(UserPlantID.Value);
                }
            }
            // For administrators, show all plants
            else if (IsAdministrator)
            {
                using (SqlCommand cmd = new SqlCommand("SELECT PlantID, PlantName FROM Plants ORDER BY PlantName", conn))
                {
                    ddlPlant.Items.Add(new ListItem("-- Select Plant --", ""));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlPlant.Items.Add(new ListItem(
                                reader["PlantName"].ToString(),
                                reader["PlantID"].ToString()
                            ));
                        }
                    }
                }
                
                // If admin also has an assigned plant, pre-select it
                if (UserPlantID.HasValue)
                {
                    ListItem item = ddlPlant.Items.FindByValue(UserPlantID.Value.ToString());
                    if (item != null)
                    {
                        ddlPlant.SelectedValue = UserPlantID.Value.ToString();
                        LoadLevelsForPlant(UserPlantID.Value);
                        ddlLevel.Enabled = true;
                    }
                }
                else
                {
                    ddlLevel.Enabled = false;
                }
            }
        }
        
        /// <summary>
        /// Loads levels for a specific plant
        /// </summary>
        private void LoadLevelsForPlant(int plantId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                
                // Load levels for selected plant
                using (SqlCommand cmd = new SqlCommand("SELECT LevelID, LevelName FROM Levels WHERE PlantID = @PlantID ORDER BY LevelName", conn))
                {
                    cmd.Parameters.AddWithValue("@PlantID", plantId);
                    ddlLevel.Items.Clear();
                    ddlLevel.Items.Add(new ListItem("-- Select Level --", ""));
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlLevel.Items.Add(new ListItem(
                                reader["LevelName"].ToString(),
                                reader["LevelID"].ToString()
                            ));
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Populates the Level dropdown when a plant is selected
        /// </summary>
        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlPlant.SelectedValue))
            {
                ddlLevel.Items.Clear();
                ddlLevel.Items.Add(new ListItem("-- Select Level --", ""));
                ddlLevel.Enabled = false;
                return;
            }
            
            ddlLevel.Enabled = true;
            int plantId = Convert.ToInt32(ddlPlant.SelectedValue);
            LoadLevelsForPlant(plantId);
        }

        /// <summary>
        /// Determines the status ID based on the extinguisher's expiry date
        /// </summary>
        /// <param name="expiryDate">The extinguisher's expiry date</param>
        /// <param name="conn">An open SQL connection</param>
        /// <returns>Status ID from the database</returns>
        private int GetStatusIdBasedOnExpiryDate(DateTime expiryDate, SqlConnection conn)
        {
            try
            {
                string statusName;
                DateTime today = DateTime.Now.Date;
                TimeSpan timeUntilExpiry = expiryDate.Date - today;

                // Determine status based on time until expiry
                if (expiryDate.Date < today)
                {
                    statusName = "Expired";
                }
                else if (timeUntilExpiry.TotalDays <= 60) // Within 2 months of expiry
                {
                    statusName = "Expiring Soon";
                }
                else
                {
                    statusName = "Active";
                }

                System.Diagnostics.Debug.WriteLine(string.Format("Determined status: {0} for expiry date: {1}", statusName, expiryDate));

                // Get status ID from database
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT TOP 1 StatusID FROM Status WITH (NOLOCK) WHERE StatusName = @StatusName", conn))
                {
                    cmd.Parameters.AddWithValue("@StatusName", statusName);
                    var result = cmd.ExecuteScalar();
                    
                    if (result != null)
                    {
                        int statusId = Convert.ToInt32(result);
                        System.Diagnostics.Debug.WriteLine(string.Format("Found StatusID: {0} for StatusName: {1}", statusId, statusName));
                        return statusId;
                    }

                    // Log available statuses for debugging
                    using (SqlCommand debugCmd = new SqlCommand(
                        "SELECT StatusID, StatusName FROM Status WITH (NOLOCK)", conn))
                    {
                        using (SqlDataReader reader = debugCmd.ExecuteReader())
                        {
                            System.Diagnostics.Debug.WriteLine("Available statuses in database:");
                            while (reader.Read())
                            {
                                System.Diagnostics.Debug.WriteLine(string.Format("StatusID: {0}, StatusName: {1}", reader["StatusID"], reader["StatusName"]));
                            }
                        }
                    }

                    throw new Exception(string.Format("Status '{0}' not found in the database. Please ensure the Status table is properly initialized.", statusName));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(string.Format("Error in GetStatusIdBasedOnExpiryDate: {0}", ex.Message));
                throw;
            }
        }

        /// <summary>
        /// Handles the initial submission and shows the confirmation dialog
        /// </summary>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if(!Page.IsValid)
            {
                return;
            }

            // Security check - verify the user is allowed to add data for this plant
            int selectedPlantId = Convert.ToInt32(ddlPlant.SelectedValue);
            if (!IsAdministrator && UserPlantID != selectedPlantId)
            {
                lblMessage.Text = "You do not have permission to add data for this plant.";
                lblMessage.CssClass = "message error";
                return;
            }

            // Validate dropdown selections
            int plantId, levelId, typeId;
            if (!int.TryParse(ddlPlant.SelectedValue, out plantId) ||
                !int.TryParse(ddlLevel.SelectedValue, out levelId) ||
                !int.TryParse(ddlType.SelectedValue, out typeId))
            {
                lblMessage.Text = "Please select valid Plant, Level and Type.";
                lblMessage.CssClass = "message error";
                return;
            }

            // Check if serial number is unique
            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM FireExtinguishers WHERE SerialNumber = @SerialNumber", conn))
                {
                    cmd.Parameters.AddWithValue("@SerialNumber", txtSerialNumber.Text);
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count > 0)
                    {
                        lblMessage.Text = "Serial number already exists.";
                        lblMessage.CssClass = "message error";
                        return;
                    }
                }
            }

            // Populate confirmation dialog fields
            lblConfirmSerialNumber.Text = txtSerialNumber.Text.Trim();
            lblConfirmAreaCode.Text = txtAreaCode.Text.Trim();
            lblConfirmPlant.Text = ddlPlant.SelectedItem.Text;
            lblConfirmLevel.Text = ddlLevel.SelectedItem.Text;
            lblConfirmLocation.Text = txtLocation.Text.Trim();
            lblConfirmType.Text = ddlType.SelectedItem.Text;
            DateTime expiryDate;
            if (DateTime.TryParse(txtExpiryDate.Text, out expiryDate))
            {
                lblConfirmExpiryDate.Text = expiryDate.ToString("dd/MM/yyyy");
            }
            else
            {
                lblConfirmExpiryDate.Text = txtExpiryDate.Text;
            }
            lblConfirmRemarks.Text = string.IsNullOrEmpty(txtRemarks.Text) ? "N/A" : txtRemarks.Text.Trim();

            // Show confirmation dialog
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showConfirmationPopup();", true);
        }

        /// <summary>
        /// Saves the new fire extinguisher to the database after confirmation
        /// </summary>
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            // Additional security check before saving
            int selectedPlantId = Convert.ToInt32(ddlPlant.SelectedValue);
            if (!IsAdministrator && UserPlantID != selectedPlantId)
            {
                lblMessage.Text = "You do not have permission to add data for this plant.";
                lblMessage.CssClass = "message error";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    DateTime expiryDate = DateTime.Parse(txtExpiryDate.Text);
                    int statusId = GetStatusIdBasedOnExpiryDate(expiryDate, conn);

                    // Final validation of dropdown selections
                    int plantId, levelId, typeId;
                    if (!int.TryParse(ddlPlant.SelectedValue, out plantId) ||
                        !int.TryParse(ddlLevel.SelectedValue, out levelId) ||
                        !int.TryParse(ddlType.SelectedValue, out typeId))
                    {
                        lblMessage.Text = "Please select valid values for Plant, Level, and Type.";
                        lblMessage.CssClass = "message error";
                        return;
                    }

                    // Insert new fire extinguisher record
                    string insertQuery = "INSERT INTO FireExtinguishers (SerialNumber, AreaCode, PlantID, LevelID, Location, TypeID, DateExpired, Remarks, StatusID) VALUES (@SerialNumber, @AreaCode, @PlantID, @LevelID, @Location, @TypeID, @DateExpired, @Remarks, @StatusID)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SerialNumber", txtSerialNumber.Text.Trim());
                        cmd.Parameters.AddWithValue("@AreaCode", string.IsNullOrEmpty(txtAreaCode.Text) ? DBNull.Value : (object)txtAreaCode.Text.Trim());
                        cmd.Parameters.AddWithValue("@PlantID", plantId);
                        cmd.Parameters.AddWithValue("@LevelID", levelId);
                        cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                        cmd.Parameters.AddWithValue("@TypeID", typeId);
                        cmd.Parameters.AddWithValue("@DateExpired", expiryDate);
                        cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(txtRemarks.Text) ? DBNull.Value : (object)txtRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@StatusID", statusId);
                        cmd.ExecuteNonQuery();

                        // Get the newly inserted fire extinguisher ID
                        int newFireExtinguisherId = 0;
                        using (SqlCommand getIdCmd = new SqlCommand("SELECT MAX(FEID) FROM FireExtinguishers WHERE SerialNumber = @SerialNumber", conn))
                        {
                            getIdCmd.Parameters.AddWithValue("@SerialNumber", txtSerialNumber.Text.Trim());
                            object result = getIdCmd.ExecuteScalar();
                            if (result != null && result != DBNull.Value)
                            {
                                newFireExtinguisherId = Convert.ToInt32(result);
                            }
                        }

                        // Log the activity
                        try
                        {
                            ActivityLogger.LogActivity(
                                "Add Fire Extinguisher", 
                                string.Format("Added fire extinguisher with serial number {0}", txtSerialNumber.Text.Trim()), 
                                "FireExtinguisher", 
                                newFireExtinguisherId.ToString());
                        }
                        catch (Exception logEx)
                        {
                            // Don't let logging failure prevent successful operation
                            System.Diagnostics.Debug.WriteLine(string.Format("Error logging activity: {0}", logEx.Message));
                        }

                        // Store success message and redirect to prevent form resubmission
                        Session["SuccessMessage"] = "Fire extinguisher added successfully.";
                        Response.Redirect(Request.Url.PathAndQuery, false);
                    }
                }
                catch (SqlException sqlEx)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("SQL Error: {0}", sqlEx.Message));
                    System.Diagnostics.Debug.WriteLine(string.Format("SQL Error Number: {0}", sqlEx.Number));
                    System.Diagnostics.Debug.WriteLine(string.Format("SQL State: {0}", sqlEx.State));
                    lblMessage.Text = string.Format("Database error: {0}", sqlEx.Message);
                    lblMessage.CssClass = "message error";
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("Error: {0}", ex.Message));
                    System.Diagnostics.Debug.WriteLine(string.Format("Stack Trace: {0}", ex.StackTrace));
                    lblMessage.Text = string.Format("Error adding fire extinguisher: {0}", ex.Message);
                    lblMessage.CssClass = "message error";
                }
            }
        }

        /// <summary>
        /// Resets all form fields to their default values
        /// </summary>
        private void ClearForm()
        {
            txtSerialNumber.Text = "";
            txtAreaCode.Text = "";
            txtLocation.Text = "";
            txtExpiryDate.Text = "";
            txtRemarks.Text = "";
            ddlPlant.SelectedIndex = 0;
            ddlLevel.Items.Clear();
            ddlLevel.Enabled = false; 
            ddlType.SelectedIndex = 0;
        }

        /// <summary>
        /// Validates that the expiry date is not in the past
        /// </summary>
        protected void cvExpiryDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime enteredDate;
            if (DateTime.TryParse(args.Value, out enteredDate)) {
                args.IsValid = enteredDate.Date >= DateTime.Now.Date;
            }
            else {
                args.IsValid = false;
            }
        }

        /// <summary>
        /// Adds a new plant with the specified number of levels
        /// </summary>
        protected void btnAddPlant_Click(object sender, EventArgs e)
        {
            // Check validation for the plant form
            Page.Validate("PlantGroup");
            if (!Page.IsValid)
            {
                return;
            }

            string plantName = txtPlantName.Text.Trim();
            int levelCount;
            
            if (!int.TryParse(txtLevelCount.Text, out levelCount) || levelCount < 1 || levelCount > 20)
            {
                lblPlantMessage.Text = "Please enter a valid number of levels (between 1 and 20).";
                lblPlantMessage.CssClass = "message error";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                
                // Check if plant name already exists
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Plants WHERE PlantName = @PlantName", conn))
                {
                    cmd.Parameters.AddWithValue("@PlantName", plantName);
                    int count = (int)cmd.ExecuteScalar();
                    
                    if (count > 0)
                    {
                        lblPlantMessage.Text = "A plant with this name already exists.";
                        lblPlantMessage.CssClass = "message error";
                        return;
                    }
                }
                
                // Use a transaction to ensure data consistency
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        int plantId;
                        
                        // Insert new plant
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Plants (PlantName) OUTPUT INSERTED.PlantID VALUES (@PlantName)", conn))
                        {
                            cmd.Parameters.AddWithValue("@PlantName", plantName);
                            plantId = (int)cmd.ExecuteScalar();
                        }
                        
                        if (plantId > 0)
                        {
                            // Insert levels for the plant
                            for (int i = 1; i <= levelCount; i++)
                            {
                                using (SqlCommand cmd = new SqlCommand("INSERT INTO Levels (PlantID, LevelName) VALUES (@PlantID, @LevelName)", conn))
                                {
                                    cmd.Parameters.AddWithValue("@PlantID", plantId);
                                    cmd.Parameters.AddWithValue("@LevelName", string.Format("Level {0}", i));
                                    cmd.ExecuteNonQuery();
                                }
                            }

                            // Log the activity
                            try
                            {
                                ActivityLogger.LogActivity(
                                    "Add Plant", 
                                    string.Format("Added plant '{0}' with {1} levels", plantName, levelCount), 
                                    "Plant", 
                                    plantId.ToString());
                            }
                            catch (Exception logEx)
                            {
                                // Don't let logging failure prevent successful operation
                                System.Diagnostics.Debug.WriteLine(string.Format("Error logging activity: {0}", logEx.Message));
                            }

                            // Show success message and refresh dropdown
                            lblPlantMessage.Text = string.Format("Plant '{0}' and {1} levels added successfully.", plantName, levelCount);
                            lblPlantMessage.CssClass = "message success";
                            txtPlantName.Text = "";
                            txtLevelCount.Text = "";

                            // Reload dropdowns to show the new data
                            LoadDropDownLists();
                        }
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction in case of error
                        transaction.Rollback();
                        
                        // Display error message
                        lblPlantMessage.Text = "Error adding plant: " + ex.Message;
                        lblPlantMessage.CssClass = "message error";
                        
                        // Log error details for debugging
                        System.Diagnostics.Debug.WriteLine(string.Format("Error in btnAddPlant_Click: {0}", ex.Message));
                        System.Diagnostics.Debug.WriteLine(string.Format("Stack Trace: {0}", ex.StackTrace));
                    }
                }
            }
        }

        /// <summary>
        /// Custom validator to ensure the confirmation checkbox is checked
        /// </summary>
        protected void cvConfirmDelete_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkConfirmDelete.Checked;
        }
        
        /// <summary>
        /// Deletes the selected plant and all its levels
        /// </summary>
        protected void btnDeletePlant_Click(object sender, EventArgs e)
        {
            // Check validation for the delete plant form
            Page.Validate("DeletePlantGroup");
            if (!Page.IsValid)
            {
                return;
            }

            int plantId;
            if (!int.TryParse(ddlDeletePlant.SelectedValue, out plantId))
            {
                lblPlantMessage.Text = "Please select a valid plant to delete.";
                lblPlantMessage.CssClass = "message error";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["FETSConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                
                // Check if there are fire extinguishers associated with this plant
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM FireExtinguishers WHERE PlantID = @PlantID", conn))
                {
                    cmd.Parameters.AddWithValue("@PlantID", plantId);
                    int count = (int)cmd.ExecuteScalar();
                    
                    if (count > 0)
                    {
                        lblPlantMessage.Text = string.Format(
                            "Cannot delete this plant. {0} fire extinguisher(s) are associated with it. " +
                            "Remove or reassign these fire extinguishers first.", count);
                        lblPlantMessage.CssClass = "message error";
                        return;
                    }
                }
                
                // Check if there are map images associated with this plant
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM MapImages WHERE PlantID = @PlantID", conn))
                {
                    cmd.Parameters.AddWithValue("@PlantID", plantId);
                    int count = (int)cmd.ExecuteScalar();
                    
                    if (count > 0)
                    {
                        lblPlantMessage.Text = string.Format(
                            "Cannot delete this plant. {0} map image(s) are associated with it. " +
                            "Delete these map images first.", count);
                        lblPlantMessage.CssClass = "message error";
                        return;
                    }
                }
                
                // Store the plant name for the success message
                string plantName = ddlDeletePlant.SelectedItem.Text;
                
                // Use a transaction to ensure data consistency
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Delete all levels associated with the plant
                        using (SqlCommand cmd = new SqlCommand(
                            "DELETE FROM Levels WHERE PlantID = @PlantID", conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@PlantID", plantId);
                            int levelsDeleted = cmd.ExecuteNonQuery();
                            
                            // Now delete the plant
                            using (SqlCommand cmdPlant = new SqlCommand(
                                "DELETE FROM Plants WHERE PlantID = @PlantID", conn, transaction))
                            {
                                cmdPlant.Parameters.AddWithValue("@PlantID", plantId);
                                int result = cmdPlant.ExecuteNonQuery();
                                
                                if (result > 0)
                                {
                                    // Commit the transaction
                                    transaction.Commit();
                                    
                                    // Log the activity
                                    try
                                    {
                                        ActivityLogger.LogActivity(
                                            "Delete Plant", 
                                            string.Format("Deleted plant '{0}'", ddlDeletePlant.SelectedItem.Text), 
                                            "Plant", 
                                            plantId.ToString());
                                    }
                                    catch (Exception logEx)
                                    {
                                        // Don't let logging failure prevent successful operation
                                        System.Diagnostics.Debug.WriteLine(string.Format("Error logging activity: {0}", logEx.Message));
                                    }

                                    // Success message
                                    lblPlantMessage.Text = string.Format(
                                        "Plant '{0}' and its {1} level(s) have been deleted successfully.", 
                                        plantName, levelsDeleted);
                                    lblPlantMessage.CssClass = "message success";
                                    
                                    // Reload dropdowns
                                    LoadDropDownLists();
                                    LoadPlantsForDeletion();
                                    
                                    // Reset the checkbox
                                    chkConfirmDelete.Checked = false;
                                }
                                else
                                {
                                    transaction.Rollback();
                                    lblPlantMessage.Text = "Delete failed. Plant not found.";
                                    lblPlantMessage.CssClass = "message error";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction in case of error
                        transaction.Rollback();
                        
                        // Display error message
                        lblPlantMessage.Text = "Error deleting plant: " + ex.Message;
                        lblPlantMessage.CssClass = "message error";
                        
                        // Log error details for debugging
                        System.Diagnostics.Debug.WriteLine(string.Format("Error in btnDeletePlant_Click: {0}", ex.Message));
                        System.Diagnostics.Debug.WriteLine(string.Format("Stack Trace: {0}", ex.StackTrace));
                    }
                }
            }
        }
    }
}