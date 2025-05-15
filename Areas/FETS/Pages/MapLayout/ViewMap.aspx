<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMap.aspx.cs" Inherits="FETS.Pages.MapLayout.ViewMap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Map - FETS</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="../../Areas/FETS/Assets/css/styles.css" rel="stylesheet" />
    <style>
        .dashboard-container {
            min-height: 100vh;
            background-color: #f5f6fa;
        }

        .dashboard-header {
            background: #2c3e50;
            padding: 1rem 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .dashboard-header h2 {
            margin: 0;
            color: white;
            font-size: 1.5rem;
            font-weight: 500;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white;
        }

        .btn-logout {
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 4px;
            color: white;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-logout:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            color: white;
        }

        .content-container {
            padding: 2rem;
        }

        .map-container {
            width: 100%;
            height: 600px;
            overflow: hidden;
            position: relative;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: #f8f8f8;
        }

        .map-section {
            width: 100%;
            height: 100%;
            position: relative;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .map-header {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .map-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.2rem;
            font-weight: 500;
        }

        .map-wrapper {
            width: 100%;
            height: calc(100% - 60px);
            position: relative;
            overflow: hidden;
        }

        .map-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.2s ease;
            transform-origin: center center;
            cursor: grab;
            position: absolute;
        }

        .map-image:active {
            cursor: grabbing;
        }

        .last-updated {
            position: absolute;
            bottom: 10px;
            right: 10px;
            font-size: 0.8rem;
            color: #666;
            background: rgba(255, 255, 255, 0.7);
            padding: 5px 10px;
            border-radius: 4px;
        }

        .map-controls {
            position: absolute;
            top: 70px;
            right: 10px;
            z-index: 100;
            background: white;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .control-btn {
            width: 40px;
            height: 40px;
            border: none;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .control-btn:hover {
            background-color: #f0f0f0;
        }

        .control-btn:active {
            background-color: #e0e0e0;
        }

        .separator {
            height: 1px;
            background-color: #eee;
        }

        .mini-map {
            position: absolute;
            bottom: 10px;
            left: 10px;
            width: 150px;
            height: 100px;
            border: 1px solid #ddd;
            background: white;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 4px;
            z-index: 100;
        }

        .mini-map img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .mini-map-viewport {
            position: absolute;
            border: 2px solid #4285F4;
            background: rgba(66, 133, 244, 0.2);
            pointer-events: none;
        }

        .marker {
            position: absolute;
            width: 20px;
            height: 30px;
            transform: translate(-50%, -100%);
            cursor: pointer;
            z-index: 10;
        }

        .marker-icon {
            width: 100%;
            height: 100%;
            background-image: url('<%= ResolveUrl("~/Assets/images/fire-extinguisher-icon.png") %>');
            background-size: contain;
            background-repeat: no-repeat;
        }

        .marker-info {
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background: white;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            padding: 10px;
            width: 200px;
            display: none;
            z-index: 20;
        }

        .marker-info:after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 8px;
            border-style: solid;
            border-color: white transparent transparent transparent;
        }

        .marker.active .marker-info {
            display: block;
        }

        .search-container {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 100;
            width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 14px;
        }

        .zoom-display {
            position: absolute;
            bottom: 120px;
            left: 10px;
            background: white;
            padding: 5px 10px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 12px;
            z-index: 100;
        }

        .fe-count {
            position: absolute;
            bottom: 160px;
            left: 10px;
            background: white;
            padding: 5px 10px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 12px;
            z-index: 100;
        }

        .hidden-grid {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <header class="dashboard-header">
                <h2>Fire Extinguisher Tracking System</h2>
                <div class="user-info">
                    <asp:Label ID="lblUsername" runat="server"></asp:Label>
                    <asp:LinkButton ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="btn-logout">Back to Map Layout</asp:LinkButton>
                    <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" CssClass="btn-logout">Logout</asp:LinkButton>
                </div>
            </header>

            <div class="content-container">
                <div class="map-container">
                    <div class="map-section">
                        <div class="map-header">
                            <h3>
                                <asp:Label ID="lblPlantName" runat="server"></asp:Label> - 
                                <asp:Label ID="lblLevelName" runat="server"></asp:Label>
                            </h3>
                            <div class="last-updated">  
                                Last Updated: <asp:Label ID="lblLastUpdated" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="map-wrapper">
                            <asp:Image ID="imgMap" runat="server" CssClass="map-image" ClientIDMode="Static"/>
                            <div id="markersContainer"></div>
                        </div>
                        <div class="map-controls">
                            <button type="button" id="zoomIn" class="control-btn">+</button>
                            <div class="separator"></div>
                            <button type="button" id="zoomOut" class="control-btn">-</button>
                            <div class="separator"></div>
                            <button type="button" id="resetView" class="control-btn">↺</button>
                        </div>
                        <div class="mini-map">
                            <asp:Image ID="imgMiniMap" runat="server" ImageUrl='<%# Eval("imgMap.ImageUrl") %>' />
                            <div class="mini-map-viewport"></div>
                        </div>
                        <div class="zoom-display">Zoom: <span id="zoomLevel">100%</span></div>
                        <div class="fe-count">
                            Fire Extinguishers: <asp:Label ID="lblFECount" runat="server">0</asp:Label>
                        </div>
                        <div class="search-container">
                            <input type="text" id="searchInput" class="search-input" placeholder="Search for fire extinguisher ID or location..." />
                        </div>
                    </div>
                </div>
                
                <!-- Hidden grid for data binding -->
                <div class="hidden-grid">
                    <asp:GridView ID="gvFireExtinguishers" runat="server" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="ExtinguisherID" HeaderText="ID" />
                            <asp:BoundField DataField="ExtinguisherType" HeaderText="Type" />
                            <asp:BoundField DataField="LastInspection" HeaderText="Last Inspection" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="XCoordinate" HeaderText="X" />
                            <asp:BoundField DataField="YCoordinate" HeaderText="Y" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
        const mapContainer = document.querySelector(".map-wrapper");
        const mapImage = document.getElementById("<%= imgMap.ClientID %>");
        const miniMapViewport = document.querySelector(".mini-map-viewport");
        const miniMap = document.querySelector(".mini-map img");
        const zoomDisplay = document.getElementById("zoomLevel");
        const searchInput = document.getElementById("searchInput");
        let scale = 0.8; // Start at 80% zoom
        let isPanning = false;
        let startX = 0, startY = 0;
        let translateX = 0, translateY = 0;
        let mapWidth, mapHeight;
        let markers = [];

        // Initialize map size
        function initializeMap() {
            if (mapImage && mapImage.complete) {
                setupMap();
            } else if (mapImage) {
                mapImage.onload = setupMap;
            }
        }

        function setupMap() {
            mapWidth = mapImage.naturalWidth;
            mapHeight = mapImage.naturalHeight;
            
            // Set initial 80% zoom and center in container
            scale = 0.8;
            // Center the image in the container
            translateX = (mapContainer.clientWidth - mapWidth * scale) / 2;
            translateY = (mapContainer.clientHeight - mapHeight * scale) / 2;
            
            updateTransform();
            zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
            
            // Get extinguisher data from GridView
            loadExtinguisherData();
            
            // Update mini-map viewport
            updateMiniMapViewport();
        }

        // Add mouse leave event to reset position
        mapContainer.addEventListener("mouseleave", function() {
            // Only reset if we were panning
            if (isPanning) {
                isPanning = false;
                mapContainer.style.cursor = "grab";
                
                // Optional: Reset to default position
                scale = 0.8; // Back to 80% zoom
                translateX = (mapContainer.clientWidth - mapWidth * scale) / 2;
                translateY = (mapContainer.clientHeight - mapHeight * scale) / 2;
                
                updateTransform();
                updateMiniMapViewport();
                zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
            }
        });

        function updateTransform() {
            mapImage.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
            
            // Update markers position with same transform
            const markersContainer = document.getElementById("markersContainer");
            if (markersContainer) {
                markersContainer.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
            }
        }
    
    // The rest of your existing code...

            // Load extinguisher data from GridView
            function loadExtinguisherData() {
                const gridView = document.getElementById("<%= gvFireExtinguishers.ClientID %>");
                if (!gridView) return;
                
                const rows = gridView.getElementsByTagName("tr");
                const markersContainer = document.getElementById("markersContainer");
                
                // Skip header row
                for (let i = 1; i < rows.length; i++) {
                    const cells = rows[i].getElementsByTagName("td");
                    if (cells.length >= 6) {
                        const id = cells[0].textContent;
                        const type = cells[1].textContent;
                        const lastInspection = cells[2].textContent;
                        const status = cells[3].textContent;
                        const x = parseFloat(cells[4].textContent);
                        const y = parseFloat(cells[5].textContent);
                        
                        // Create marker
                        createMarker(markersContainer, {
                            id,
                            type,
                            lastInspected: lastInspection,
                            status,
                            x,
                            y
                        });
                    }
                }
                
                // If no data was loaded, add sample markers
                if (rows.length <= 1) {
                    addSampleMarkers();
                }
            }

            // Create a marker element
            function createMarker(container, markerData) {
                const markerElement = document.createElement("div");
                markerElement.className = "marker";
                markerElement.style.left = `${markerData.x * 100}%`;
                markerElement.style.top = `${markerData.y * 100}%`;
                
                const markerIcon = document.createElement("div");
                markerIcon.className = "marker-icon";
                
                const markerInfo = document.createElement("div");
                markerInfo.className = "marker-info";
                markerInfo.innerHTML = `
                    <strong>ID:</strong> ${markerData.id}<br>
                    <strong>Type:</strong> ${markerData.type}<br>
                    <strong>Last Inspected:</strong> ${markerData.lastInspected}<br>
                    <strong>Status:</strong> <span style="color: ${markerData.status.toLowerCase().includes('active') ? 'green' : 'red'}">${markerData.status}</span>
                `;
                
                markerElement.appendChild(markerIcon);
                markerElement.appendChild(markerInfo);
                container.appendChild(markerElement);
                
                markerElement.addEventListener("click", function() {
                    // Close any open marker info
                    document.querySelectorAll(".marker.active").forEach(m => {
                        if (m !== markerElement) m.classList.remove("active");
                    });
                    
                    // Toggle this marker's info
                    markerElement.classList.toggle("active");
                });
                
                markers.push({
                    element: markerElement,
                    data: markerData
                });
            }

            // Add sample markers - replace with actual data from your backend
            function addSampleMarkers() {
                // This is example data - replace with actual data from your backend
                const sampleMarkers = [
                    { id: "FE001", x: 0.2, y: 0.3, type: "CO2", lastInspected: "2024-10-15", status: "Active" },
                    { id: "FE002", x: 0.5, y: 0.6, type: "Dry Chemical", lastInspected: "2024-09-22", status: "Active" },
                    { id: "FE003", x: 0.8, y: 0.2, type: "Water", lastInspected: "2024-08-30", status: "Needs Inspection" }
                ];

                const markersContainer = document.getElementById("markersContainer");
                
                sampleMarkers.forEach(marker => {
                    createMarker(markersContainer, marker);
                });
            }

            // Update mini-map viewport based on current view
            function updateMiniMapViewport() {
                if (!miniMapViewport || !miniMap) return;
                
                const mapContainerRect = mapContainer.getBoundingClientRect();
                const miniMapRect = miniMap.getBoundingClientRect();
                
                const containerAspectRatio = mapContainerRect.width / mapContainerRect.height;
                const miniMapAspectRatio = miniMapRect.width / miniMapRect.height;
                
                let viewportWidth, viewportHeight;
                
                if (containerAspectRatio > miniMapAspectRatio) {
                    viewportWidth = miniMapRect.width;
                    viewportHeight = viewportWidth / containerAspectRatio;
                } else {
                    viewportHeight = miniMapRect.height;
                    viewportWidth = viewportHeight * containerAspectRatio;
                }
                
                // Adjust for scale
                viewportWidth /= scale;
                viewportHeight /= scale;
                
                // Calculate viewport position
                const viewportX = (miniMapRect.width - viewportWidth) / 2 - translateX / mapWidth * miniMapRect.width;
                const viewportY = (miniMapRect.height - viewportHeight) / 2 - translateY / mapHeight * miniMapRect.height;
                
                miniMapViewport.style.width = `${viewportWidth}px`;
                miniMapViewport.style.height = `${viewportHeight}px`;
                miniMapViewport.style.left = `${viewportX}px`;
                miniMapViewport.style.top = `${viewportY}px`;
            }

            // Map controls
            if (mapImage) {
                // Zoom and pan functionality
                mapContainer.addEventListener("wheel", function (e) {
                    e.preventDefault();
                    const scaleAmount = 0.1;
                    const oldScale = scale;
                    
                    // Get mouse position relative to map
                    const rect = mapContainer.getBoundingClientRect();
                    const mouseX = e.clientX - rect.left;
                    const mouseY = e.clientY - rect.top;
                    
                    // Calculate point on image where mouse is
                    const imageX = mouseX - translateX;
                    const imageY = mouseY - translateY;
                    
                    // Update scale
                    if (e.deltaY < 0) {
                        scale = Math.min(scale + scaleAmount, 5); // Max zoom 500%
                    } else {
                        scale = Math.max(scale - scaleAmount, 0.5); // Min zoom 50%
                    }
                    
                    // Adjust translation to zoom towards mouse position
                    translateX = mouseX - imageX * (scale / oldScale);
                    translateY = mouseY - imageY * (scale / oldScale);
                    
                    updateTransform();
                    updateMiniMapViewport();
                    zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
                });

                mapContainer.addEventListener("mousedown", function (e) {
                    // Only trigger pan on left mouse button
                    if (e.button !== 0) return;
                    
                    // Don't pan if clicked on a marker
                    if (e.target.closest('.marker')) return;
                    
                    // Set isPanning to true only when mouse is held down
                    isPanning = true;
                    startX = e.clientX - translateX;
                    startY = e.clientY - translateY;
                    mapContainer.style.cursor = "grabbing";
                });

                window.addEventListener("mouseup", function () {
                    isPanning = false;
                    mapContainer.style.cursor = "grab";
                });

                mapContainer.addEventListener("mousemove", function (e) {
                    if (!isPanning) return;
                    
                    translateX = e.clientX - startX;
                    translateY = e.clientY - startY;
                    
                    // Boundary checks can be added here if needed
                    
                    updateTransform();
                    updateMiniMapViewport();
                });

                // Double click to zoom in
                mapContainer.addEventListener("dblclick", function (e) {
                    e.preventDefault();
                    
                    // Get mouse position relative to map
                    const rect = mapContainer.getBoundingClientRect();
                    const mouseX = e.clientX - rect.left;
                    const mouseY = e.clientY - rect.top;
                    
                    // Calculate point on image where mouse is
                    const imageX = mouseX - translateX;
                    const imageY = mouseY - translateY;
                    
                    const oldScale = scale;
                    scale = Math.min(scale + 0.5, 5); // Zoom in by 50%
                    
                    // Adjust translation to zoom towards mouse position
                    translateX = mouseX - imageX * (scale / oldScale);
                    translateY = mouseY - imageY * (scale / oldScale);
                    
                    updateTransform();
                    updateMiniMapViewport();
                    zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
                });

                // Control buttons
                document.getElementById("zoomIn").addEventListener("click", function() {
                    const oldScale = scale;
                    scale = Math.min(scale + 0.2, 5);
                    
                    // Adjust translation to zoom towards center
                    const centerX = mapContainer.clientWidth / 2;
                    const centerY = mapContainer.clientHeight / 2;
                    const imageX = centerX - translateX;
                    const imageY = centerY - translateY;
                    
                    translateX = centerX - imageX * (scale / oldScale);
                    translateY = centerY - imageY * (scale / oldScale);
                    
                    updateTransform();
                    updateMiniMapViewport();
                    zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
                });

                document.getElementById("zoomOut").addEventListener("click", function() {
                    const oldScale = scale;
                    scale = Math.max(scale - 0.2, 0.5);
                    
                    // Adjust translation to zoom towards center
                    const centerX = mapContainer.clientWidth / 2;
                    const centerY = mapContainer.clientHeight / 2;
                    const imageX = centerX - translateX;
                    const imageY = centerY - translateY;
                    
                    translateX = centerX - imageX * (scale / oldScale);
                    translateY = centerY - imageY * (scale / oldScale);
                    
                    updateTransform();
                    updateMiniMapViewport();
                    zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
                });

                document.getElementById("resetView").addEventListener("click", function() {
                    scale = 1;
                    translateX = 0;
                    translateY = 0;
                    updateTransform();
                    updateMiniMapViewport();
                    zoomDisplay.textContent = `${Math.round(scale * 100)}%`;
                });

                // Mini-map click to navigate
                document.querySelector(".mini-map").addEventListener("click", function(e) {
                    const rect = this.getBoundingClientRect();
                    const miniMapX = e.clientX - rect.left;
                    const miniMapY = e.clientY - rect.top;
                    
                    const percentX = miniMapX / rect.width;
                    const percentY = miniMapY / rect.height;
                    
                    // Calculate new center position
                    const newCenterX = percentX * mapWidth;
                    const newCenterY = percentY * mapHeight;
                    
                    // Adjust translation to center on clicked point
                    translateX = mapContainer.clientWidth / 2 - newCenterX * scale;
                    translateY = mapContainer.clientHeight / 2 - newCenterY * scale;
                    
                    updateTransform();
                    updateMiniMapViewport();
                });

                // Search functionality
                searchInput.addEventListener("input", function() {
                    const searchTerm = this.value.toLowerCase();
                    
                    markers.forEach(marker => {
                        const markerData = marker.data;
                        const markerElement = marker.element;
                        
                        // Check if search term matches any marker data
                        const isMatch = markerData.id.toLowerCase().includes(searchTerm) || 
                                       markerData.type.toLowerCase().includes(searchTerm) ||
                                       markerData.status.toLowerCase().includes(searchTerm);
                        
                        if (searchTerm === '') {
                            // Reset all markers to normal state
                            markerElement.style.opacity = '1';
                            markerElement.classList.remove('active');
                        } else if (isMatch) {
                            // Highlight matching markers
                            markerElement.style.opacity = '1';
                            markerElement.classList.add('active');
                        } else {
                            // Fade non-matching markers
                            markerElement.style.opacity = '0.3';
                            markerElement.classList.remove('active');
                        }
                    });
                });
                
                // Close marker info when clicking outside
                document.addEventListener("click", function(e) {
                    if (!e.target.closest('.marker')) {
                        document.querySelectorAll(".marker.active").forEach(m => {
                            m.classList.remove("active");
                        });
                    }
                });
                
                // Keyboard shortcuts
                document.addEventListener("keydown", function(e) {
                    if (e.key === "=" || e.key === "+") {
                        // Zoom in
                        document.getElementById("zoomIn").click();
                    } else if (e.key === "-" || e.key === "_") {
                        // Zoom out
                        document.getElementById("zoomOut").click();
                    } else if (e.key === "0") {
                        // Reset view
                        document.getElementById("resetView").click();
                    } else if (e.key === "Escape") {
                        // Close all info windows
                        document.querySelectorAll(".marker.active").forEach(m => {
                            m.classList.remove("active");
                        });
                    }
                });
            }

            function updateTransform() {
                mapImage.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
                
                // Update markers position with same transform
                const markersContainer = document.getElementById("markersContainer");
                if (markersContainer) {
                    markersContainer.style.transform = `translate(${translateX}px, ${translateY}px) scale(${scale})`;
                }
            }
            
            // Initialize map
            initializeMap();
            
            // Update mini-map viewport on window resize
            window.addEventListener("resize", updateMiniMapViewport);
        });
    </script>
</body>
</html>