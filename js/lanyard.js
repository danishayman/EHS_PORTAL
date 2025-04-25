// Organization Chart with Lanyard Style JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Organization chart data
    const orgData = {
        executive: {
            title: 'Chief Safety Officer',
            name: 'Dr. Sarah Johnson',
            department: 'Executive Leadership'
        },
        directors: [
            {
                title: 'EHS Director',
                name: 'Michael Chen',
                department: 'Corporate EHS'
            },
            {
                title: 'Safety Manager',
                name: 'Robert Williams',
                department: 'Facility Safety'
            },
            {
                title: 'Environmental Manager',
                name: 'Lisa Rodriguez',
                department: 'Environmental Compliance'
            }
        ],
        managers: [
            {
                title: 'Safety Specialist',
                name: 'James Wilson',
                department: 'Corporate EHS',
                reportTo: 'Michael Chen'
            },
            {
                title: 'Safety Coordinator',
                name: 'Emily Davis',
                department: 'Corporate EHS',
                reportTo: 'Michael Chen'
            },
            {
                title: 'Industrial Hygienist',
                name: 'David Thompson',
                department: 'Facility Safety',
                reportTo: 'Robert Williams'
            },
            {
                title: 'Emergency Coordinator',
                name: 'Jennifer Martinez',
                department: 'Facility Safety',
                reportTo: 'Robert Williams'
            },
            {
                title: 'Compliance Specialist',
                name: 'Thomas Baker',
                department: 'Environmental Compliance',
                reportTo: 'Lisa Rodriguez'
            },
            {
                title: 'Sustainability Coordinator',
                name: 'Michelle Wong',
                department: 'Environmental Compliance',
                reportTo: 'Lisa Rodriguez'
            }
        ]
    };

    // Create a single standard person image element template that will be cloned
    const createStandardPersonImage = function() {
        // Create a wrapper div with fixed dimensions
        const imageWrapper = document.createElement('div');
        imageWrapper.className = 'standard-image-wrapper';
        imageWrapper.style.width = '90px';
        imageWrapper.style.height = '90px';
        imageWrapper.style.borderRadius = '50%';
        imageWrapper.style.overflow = 'hidden';
        imageWrapper.style.position = 'relative';
        imageWrapper.style.backgroundColor = '#f9f2e6';
        
        // Create an image element with precise positioning
        const img = document.createElement('img');
        img.src = 'images/person.jpeg';
        img.alt = 'Employee Photo';
        img.style.position = 'absolute';
        img.style.width = '90px';
        img.style.height = '115px';
        img.style.objectFit = 'cover';
        img.style.objectPosition = 'center 18%';
        img.style.left = '0';
        img.style.top = '-10px';
        
        // Append the image to the wrapper
        imageWrapper.appendChild(img);
        
        return imageWrapper;
    };
    
    // Pre-create the standard image element once
    const standardPersonImage = createStandardPersonImage();

    // Function to create a lanyard badge element
    function createLanyardBadge(person) {
        const lanyardContainer = document.createElement('div');
        lanyardContainer.className = 'lanyard-container';
        
        // Create V-shaped lanyard strap
        const lanyardStrap = document.createElement('div');
        lanyardStrap.className = 'lanyard-strap';
        
        // Add hook at the top of the lanyard
        const lanyardHook = document.createElement('div');
        lanyardHook.className = 'lanyard-hook';
        lanyardStrap.appendChild(lanyardHook);
        
        // Add the connecting piece between straps
        const lanyardConnector = document.createElement('div');
        lanyardConnector.className = 'lanyard-connector';
        lanyardStrap.appendChild(lanyardConnector);
        
        // Left side of the V
        const leftStrap = document.createElement('div');
        leftStrap.className = 'lanyard-strap-left';
        
        const leftText = document.createElement('div');
        leftText.className = 'lanyard-text-left';
        leftText.textContent = 'INARI';
        
        leftStrap.appendChild(leftText);
        lanyardStrap.appendChild(leftStrap);
        
        // Right side of the V
        const rightStrap = document.createElement('div');
        rightStrap.className = 'lanyard-strap-right';
        
        const rightText = document.createElement('div');
        rightText.className = 'lanyard-text-right';
        rightText.textContent = 'INARI';
        
        rightStrap.appendChild(rightText);
        lanyardStrap.appendChild(rightStrap);
        
        lanyardContainer.appendChild(lanyardStrap);
        
        // Create ID badge
        const idBadge = document.createElement('div');
        idBadge.className = 'id-badge';
        
        // Badge header with company name
        const badgeHeader = document.createElement('div');
        badgeHeader.className = 'badge-header';
        badgeHeader.textContent = 'INARI';
        
        // Badge photo using the cloned standard image
        const badgePhoto = document.createElement('div');
        badgePhoto.className = 'badge-photo';
        
        // Clone the standard image for consistent display
        const personImageClone = standardPersonImage.cloneNode(true);
        badgePhoto.appendChild(personImageClone);
        
        // Badge info (name and title)
        const badgeInfo = document.createElement('div');
        badgeInfo.className = 'badge-info';
        
        const badgeName = document.createElement('div');
        badgeName.className = 'badge-name';
        badgeName.textContent = person.name;
        
        const badgeTitle = document.createElement('div');
        badgeTitle.className = 'badge-title';
        badgeTitle.textContent = person.title;
        
        badgeInfo.appendChild(badgeName);
        badgeInfo.appendChild(badgeTitle);
        
        // Assemble the badge
        idBadge.appendChild(badgeHeader);
        idBadge.appendChild(badgePhoto);
        idBadge.appendChild(badgeInfo);
        
        lanyardContainer.appendChild(idBadge);
        
        return lanyardContainer;
    }

    // Create the organization chart
    function createOrgChart() {
        const orgChartSection = document.createElement('section');
        orgChartSection.className = 'org-chart-section';
        orgChartSection.innerHTML = `
            <div class="container">
                <h2 class="section-title">ORGANIZATION CHART</h2>
                <div class="org-chart-container">
                    <div id="org-chart" class="org-chart"></div>
                </div>
            </div>
        `;
        
        // Insert the org chart section after the cards section
        const cardsSection = document.querySelector('.cards-section');
        if (cardsSection) {
            cardsSection.parentNode.insertBefore(orgChartSection, cardsSection.nextSibling);
        } else {
            document.body.appendChild(orgChartSection);
        }
        
        const orgChart = document.getElementById('org-chart');
        
        // Create executive level
        const executiveLevel = document.createElement('div');
        executiveLevel.className = 'org-level';
        executiveLevel.appendChild(createLanyardBadge(orgData.executive));
        orgChart.appendChild(executiveLevel);
        
        // Create directors level
        const directorsLevel = document.createElement('div');
        directorsLevel.className = 'org-level';
        const directorsItems = document.createElement('div');
        directorsItems.className = 'org-level-items';
        
        orgData.directors.forEach(director => {
            directorsItems.appendChild(createLanyardBadge(director));
        });
        
        directorsLevel.appendChild(directorsItems);
        orgChart.appendChild(directorsLevel);
        
        // Create managers level (grouped by their reporting director)
        const managersLevel = document.createElement('div');
        managersLevel.className = 'org-level';
        
        // Group managers by who they report to
        const managerGroups = {};
        orgData.directors.forEach(director => {
            managerGroups[director.name] = [];
        });
        
        orgData.managers.forEach(manager => {
            if (managerGroups[manager.reportTo]) {
                managerGroups[manager.reportTo].push(manager);
            }
        });
        
        // Create each group in the managers level
        Object.keys(managerGroups).forEach(directorName => {
            const groupItems = document.createElement('div');
            groupItems.className = 'org-level-items';
            
            managerGroups[directorName].forEach(manager => {
                groupItems.appendChild(createLanyardBadge(manager));
            });
            
            managersLevel.appendChild(groupItems);
        });
        
        orgChart.appendChild(managersLevel);
    }

    // Initialize the organization chart
    createOrgChart();
}); 