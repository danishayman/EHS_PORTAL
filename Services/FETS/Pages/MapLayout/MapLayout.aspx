<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapLayout.aspx.cs" Inherits="FETS.Pages.MapLayout.MapLayout" MasterPageFile="~/Services/FETS/Site.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Base styles to match View Section and Data Entry */
        .dashboard-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .map-layout-section {
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

        h4 {
            color: #333;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }

        .upload-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
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

        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 1.2rem;
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

        /* Filter section styling */
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
        }

        .filter-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }

        .filter-group {
            flex: 1;
            min-width: 0;
        }

        /* Grid styling */
        .maps-grid {
            margin-top: 20px;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .grid-header th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
            padding: 12px;
            text-align: center;
            border: 1px solid #dee2e6;
        }

        .grid-row td, .grid-row-alt td {
            padding: 10px;
            border: 1px solid #dee2e6;
            text-align: center;
            vertical-align: middle;
        }

        .grid-row-alt {
            background-color: #f8f9fa;
        }

        .grid-row:hover, .grid-row-alt:hover {
            background-color: #f2f2f2;
        }

        .grid-pager {
            text-align: center;
            padding: 10px 0;
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        .grid-pager a, .grid-pager span {
            padding: 5px 10px;
            margin: 0 2px;
            border: 1px solid #dee2e6;
            border-radius: 3px;
            text-decoration: none;
            color: #007bff;
            background-color: #fff;
            display: inline-block;
            min-width: 32px;
        }

        .grid-pager span {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .grid-pager a:hover {
            background-color: #e9ecef;
            border-color: #dee2e6;
            color: #0056b3;
        }

        .map-preview {
            max-width: 120px;
            max-height: 80px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .action-buttons {
            display: flex;
            gap: 5px;
            justify-content: center;
        }

        .btn-sm {
            padding: 4px 8px;
            font-size: 0.875rem;
            min-width: 80px;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .empty-message {
            padding: 20px;
            text-align: center;
            font-size: 1.1em;
            color: #666;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
        }

        /* Modal Styles */
        .map-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.7);
            animation: fadeIn 0.3s;
        }

        .map-modal-content {
            position: relative;
            background-color: #fefefe;
            margin: 3% auto;
            padding: 0;
            border: 1px solid #888;
            width: 90%;
            max-width: 1200px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.4s;
        }

        .map-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
            background-color: #f8f9fa;
            border-radius: 8px 8px 0 0;
        }

        .map-modal-header h4 {
            margin: 0;
            color: #333;
            font-size: 1.3rem;
            font-weight: 600;
            border-bottom: none;
            padding-bottom: 0;
        }

        .close-modal {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.2s;
        }

        .close-modal:hover,
        .close-modal:focus {
            color: #333;
            text-decoration: none;
        }

        .map-modal-body {
            padding: 20px;
            text-align: center;
        }

        .full-screen-map {
            max-width: 100%;
            max-height: 80vh;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        @keyframes fadeIn {
            from {opacity: 0}
            to {opacity: 1}
        }

        @keyframes slideIn {
            from {transform: translateY(-50px); opacity: 0;}
            to {transform: translateY(0); opacity: 1;}
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .map-layout-section {
                min-width: auto;
                width: 100%;
                padding: 20px;
            }

            .filter-row {
                flex-direction: column;
                gap: 10px;
            }
        }

        /* Simplified file upload button styling */
        .custom-file-upload .file-upload-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: auto;
            min-width: 150px;
            margin-bottom: 10px;
        }

        .custom-file-upload .file-upload-btn:hover {
            background-color: #0056b3;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
            transform: translateY(-1px);
        }

        .custom-file-upload {
            position: relative;
            overflow: hidden;
            margin-top: 10px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 100%;
        }

        .custom-file-upload .file-upload-btn i {
            margin-right: 6px;
            font-size: 1rem;
        }

        .custom-file-upload input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .file-name-display {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 0.95rem;
            color: #495057;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: none;
        }

        .file-name-display.has-file {
            display: flex;
            align-items: center;
        }

        .file-name-display i {
            margin-right: 10px;
            color: #28a745;
            font-size: 1.1rem;
        }

        /* Image preview styling with delete button */
        .image-preview-container {
            margin-top: 15px;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            display: none;
            text-align: center;
        }

        .preview-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px solid #dee2e6;
        }

        .preview-header h5 {
            margin: 0;
            color: #333;
            font-size: 1rem;
            font-weight: 500;
        }

        .btn-delete-image {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 0.85rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.2s;
        }

        .btn-delete-image:hover {
            background-color: #c82333;
        }

        .btn-delete-image i {
            margin-right: 5px;
            font-size: 0.9rem;
        }

        .image-preview {
            max-width: 100%;
            max-height: 300px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Add Font Awesome for icons */
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-container">
        <div class="map-layout-section">
            <h3>Map Layout</h3>
            
            <div class="upload-section">
                <h4>Upload New Map</h4>
                <div class="form-group">
                    <asp:Label ID="lblPlant" runat="server" Text="Plant:" AssociatedControlID="ddlPlant"></asp:Label>
                    <asp:DropDownList ID="ddlPlant" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged" CausesValidation="false"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvPlant" runat="server" 
                        ControlToValidate="ddlPlant" 
                        ErrorMessage="Plant is required." 
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="UploadMap"
                        InitialValue="">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblLevel" runat="server" Text="Level:" AssociatedControlID="ddlLevel"></asp:Label>
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvLevel" runat="server" 
                        ControlToValidate="ddlLevel" 
                        ErrorMessage="Level is required." 
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="UploadMap"
                        InitialValue="">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:Label ID="lblMapFile" runat="server" Text="Map Image:" AssociatedControlID="fuMapImage"></asp:Label>
                    <div class="custom-file-upload">
                        <div class="file-upload-btn">
                            <i class="fas fa-upload"></i> Select Image
                        </div>
                        <asp:FileUpload ID="fuMapImage" runat="server" CssClass="form-control" onchange="updateFileName(this)" />
                        <div id="fileNameDisplay" class="file-name-display">
                            <i class="fas fa-file-image"></i>
                            <span id="fileName">No file chosen</span>
                        </div>
                    </div>
                    <div id="imagePreviewContainer" class="image-preview-container">
                        <div class="preview-header">
                            <h5>Map Preview</h5>
                            <button type="button" id="btnDeleteImage" class="btn-delete-image" onclick="deleteImage()">
                                <i class="fas fa-times"></i> Remove
                            </button>
                        </div>
                        <img id="imagePreview" class="image-preview" src="" alt="Preview" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvMapImage" runat="server" 
                        ControlToValidate="fuMapImage" 
                        ErrorMessage="Map image is required." 
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="UploadMap">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMapImage" runat="server"
                        ControlToValidate="fuMapImage"
                        ErrorMessage="Only image files (jpg, jpeg, png) are allowed."
                        ValidationExpression="^.*\.(jpg|jpeg|png|JPG|JPEG|PNG)$"
                        CssClass="validation-error"
                        Display="Dynamic"
                        ValidationGroup="UploadMap">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload Map" OnClick="btnUpload_Click" CssClass="btn btn-primary" ValidationGroup="UploadMap" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <div class="view-maps-section">
                <h4>View Maps</h4>
                <div class="filter-section">
                    <div class="filter-row">
                        <div class="filter-group">
                            <asp:Label ID="lblFilterPlant" runat="server" Text="Plant:" AssociatedControlID="ddlFilterPlant"></asp:Label>
                            <asp:DropDownList ID="ddlFilterPlant" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterPlant_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="filter-group">
                            <asp:Label ID="lblFilterLevel" runat="server" Text="Level:" AssociatedControlID="ddlFilterLevel"></asp:Label>
                            <asp:DropDownList ID="ddlFilterLevel" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterLevel_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="maps-grid">
                    <asp:GridView ID="gvMaps" runat="server" 
                        AutoGenerateColumns="False" 
                        CssClass="grid-view"
                        AllowPaging="True"
                        PageSize="5"
                        OnPageIndexChanging="gvMaps_PageIndexChanging"
                        OnRowCommand="gvMaps_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="PlantName" HeaderText="Plant" />
                            <asp:BoundField DataField="LevelName" HeaderText="Level" />
                            <asp:BoundField DataField="UploadDate" HeaderText="Upload Date" DataFormatString="{0:d}" />
                            <asp:TemplateField HeaderText="Preview">
                                <ItemTemplate>
                                    <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# GetMapImageUrl(Eval("ImagePath").ToString()) %>' CssClass="map-preview" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="action-buttons">
                                        <asp:LinkButton ID="btnView" runat="server" 
                                            CommandName="ViewMap" 
                                            CommandArgument='<%# Eval("ImagePath") + "," + Eval("PlantName") + "," + Eval("LevelName") %>'
                                            CssClass="btn btn-sm btn-primary"
                                            Text="View"
                                            OnClientClick='<%# "openMapModal(\"" + ResolveUrl("~/Uploads/Maps/" + Eval("ImagePath")) + "\", \"" + Eval("PlantName") + "\", \"" + Eval("LevelName") + "\"); return false;" %>' />
                                        <asp:LinkButton ID="btnDelete" runat="server" 
                                            CommandName="DeleteMap" 
                                            CommandArgument='<%# Eval("MapID") %>'
                                            CssClass="btn btn-sm btn-danger"
                                            Text="Delete"
                                            OnClientClick="return confirm('Are you sure you want to delete this map?');" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="grid-pager" />
                        <HeaderStyle CssClass="grid-header" />
                        <RowStyle CssClass="grid-row" />
                        <AlternatingRowStyle CssClass="grid-row-alt" />
                        <EmptyDataTemplate>
                            <div class="empty-message">No maps found.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Full Screen Map Modal -->
    <div id="mapModal" class="map-modal">
        <div class="map-modal-content">
            <div class="map-modal-header">
                <h4 id="mapModalTitle">Map View</h4>
                <span class="close-modal" onclick="closeMapModal()">&times;</span>
            </div>
            <div class="map-modal-body">
                <img id="fullScreenMap" class="full-screen-map" src="" alt="Floor Map" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function updateFileName(input) {
            var fileNameDisplay = document.getElementById('fileNameDisplay');
            var fileNameSpan = document.getElementById('fileName');
            var imagePreview = document.getElementById('imagePreview');
            var previewContainer = document.getElementById('imagePreviewContainer');
            
            if (input.files && input.files[0]) {
                // Update file name
                var fileName = input.files[0].name;
                fileNameSpan.textContent = fileName;
                fileNameDisplay.classList.add('has-file');
                
                // Show image preview
                var reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    previewContainer.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                // Reset file name
                fileNameSpan.textContent = 'No file chosen';
                fileNameDisplay.classList.remove('has-file');
                
                // Hide image preview
                previewContainer.style.display = 'none';
                imagePreview.src = '';
            }
        }
        
        function deleteImage() {
            // Clear the file input
            var fileInput = document.getElementById('<%= fuMapImage.ClientID %>');
            fileInput.value = '';
            
            // Reset file name display
            var fileNameDisplay = document.getElementById('fileNameDisplay');
            var fileNameSpan = document.getElementById('fileName');
            fileNameSpan.textContent = 'No file chosen';
            fileNameDisplay.classList.remove('has-file');
            
            // Hide image preview
            var imagePreview = document.getElementById('imagePreview');
            var previewContainer = document.getElementById('imagePreviewContainer');
            previewContainer.style.display = 'none';
            imagePreview.src = '';
            
            // Prevent the form from submitting
            return false;
        }

        // Modal functions
        function openMapModal(imageUrl, plantName, levelName) {
            var modal = document.getElementById('mapModal');
            var fullScreenMap = document.getElementById('fullScreenMap');
            var modalTitle = document.getElementById('mapModalTitle');
            
            // Set the map image source
            fullScreenMap.src = imageUrl;
            
            // Set the modal title
            modalTitle.innerText = plantName + ' - ' + levelName + ' Map';
            
            // Show the modal
            modal.style.display = 'block';
            
            // Disable scrolling on the body
            document.body.style.overflow = 'hidden';
            
            // Add escape key listener
            document.addEventListener('keydown', closeModalOnEscape);
        }
        
        function closeMapModal() {
            var modal = document.getElementById('mapModal');
            modal.style.display = 'none';
            
            // Re-enable scrolling on the body
            document.body.style.overflow = 'auto';
            
            // Remove escape key listener
            document.removeEventListener('keydown', closeModalOnEscape);
        }
        
        function closeModalOnEscape(e) {
            if (e.key === 'Escape') {
                closeMapModal();
            }
        }
        
        // Close modal when clicking outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('mapModal');
            if (event.target == modal) {
                closeMapModal();
            }
        }

        // Fallback for browsers that don't support our modal
        // This will redirect to a full page view if needed
        function fallbackToFullPage(plantId, levelId) {
            window.location.href = '<%=ResolveUrl("~/Pages/MapLayout/ViewMap.aspx")%>?PlantID=' + plantId + '&LevelID=' + levelId;
        }
    </script>
</asp:Content> 