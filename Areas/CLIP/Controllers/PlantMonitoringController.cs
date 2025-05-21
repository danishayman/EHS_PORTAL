using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using EHS_PORTAL.Areas.CLIP.Models;
using System.Globalization;
using System.IO;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.AspNet.Identity.EntityFramework;

namespace EHS_PORTAL.Areas.CLIP.Controllers
{
    [Authorize]
    public class PlantMonitoringController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: PlantMonitoring
        public ActionResult Index(string category = null, int? plantId = null, string status = null, string monitoringType = null, int? frequency = null)
        {
            // Get all plant monitoring items with plant and monitoring details
            var query = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .AsQueryable();

            // Filter by user's plants if user is not admin
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userPlantIds = db.UserPlants
                    .Where(up => up.UserId == userId)
                    .Select(up => up.PlantId)
                    .ToList();
                
                query = query.Where(p => userPlantIds.Contains(p.PlantID));
            }
            
            // Apply filters if provided
            if (!string.IsNullOrEmpty(category))
            {
                query = query.Where(p => p.Monitoring.MonitoringCategory == category);
                ViewBag.SelectedCategory = category;
            }

            if (plantId.HasValue)
            {
                query = query.Where(p => p.PlantID == plantId.Value);
                ViewBag.SelectedPlantId = plantId.Value;
            }

            if (!string.IsNullOrEmpty(status))
            {
                // Process and expiry statuses
                if (status == "Completed" || status == "Work In Progress" || status == "ePR Raised" || 
                    status == "Quotation Requested" || status == "Not Started" || status == "In Progress" || 
                    status == "In Preparation" || status == "In Quotation")
                {
                    // Handle legacy status names
                    if (status == "In Progress") status = "Work In Progress";
                    if (status == "In Preparation") status = "ePR Raised";
                    if (status == "In Quotation") status = "Quotation Requested";
                    
                    query = query.Where(p => p.ProcStatus == status);
                }
                else
                {
                    query = query.Where(p => p.ExpStatus == status);
                }

                ViewBag.SelectedStatus = status;
            }

            // New filter for monitoring type
            if (!string.IsNullOrEmpty(monitoringType))
            {
                query = query.Where(p => p.Monitoring.MonitoringName == monitoringType);
                ViewBag.SelectedMonitoringType = monitoringType;
            }

            // New filter for frequency
            if (frequency.HasValue)
            {
                query = query.Where(p => p.Monitoring.MonitoringFreq == frequency.Value);
                ViewBag.SelectedFrequency = frequency.Value;
            }

            // Load plants and monitoring categories for filtering
            // If user is admin, get all plants, otherwise get only the user's plants
            if (User.IsInRole("Admin"))
            {
                ViewBag.Plants = db.Plants.OrderBy(p => p.PlantName).ToList();
            }
            else
            {
                var userId = User.Identity.GetUserId();
                ViewBag.Plants = db.UserPlants
                    .Where(up => up.UserId == userId)
                    .Select(up => up.Plant)
                    .OrderBy(p => p.PlantName)
                    .ToList();
            }
            
            ViewBag.Categories = db.Monitorings
                .Select(m => m.MonitoringCategory)
                .Distinct()
                .OrderBy(c => c)
                .ToList();

            // Add monitoring types for the filter
            ViewBag.MonitoringTypes = db.Monitorings
                .Select(m => m.MonitoringName)
                .Distinct()
                .OrderBy(t => t)
                .ToList();

            ViewBag.StatusList = new List<string>
            {
                "All",
                // Process Statuses
                "Completed",
                "Work In Progress",
                "ePR Raised",
                "Quotation Requested",
                "Not Started",
                // Expiration Statuses
                "Valid",
                "Expiring Soon",
                "Expired",
                "No Expiry"
            };

            // Get monitoring notifications for the current user
            ViewBag.Notifications = GetMonitoringNotifications();
            
            // Group by Month for schedule view
            var currentYear = DateTime.Now.Year;
            var result = query.ToList();

            return View(result);
        }

        // GET: PlantMonitoring/Schedule
        public ActionResult Schedule()
        {
            // Get all monitoring types
            var monitoringTypes = db.Monitorings
                .OrderBy(m => m.MonitoringCategory)
                .ThenBy(m => m.MonitoringName)
                .ToList();

            // Get plants based on user role
            var plants = new List<Plant>();
            if (User.IsInRole("Admin"))
            {
                plants = db.Plants.OrderBy(p => p.PlantName).ToList();
            }
            else
            {
                var userId = User.Identity.GetUserId();
                plants = db.UserPlants
                    .Where(up => up.UserId == userId)
                    .Select(up => up.Plant)
                    .OrderBy(p => p.PlantName)
                    .ToList();
            }

            // Get plant monitoring records based on user role
            var plantMonitoringsQuery = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .AsQueryable();

            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userPlantIds = db.UserPlants
                    .Where(up => up.UserId == userId)
                    .Select(up => up.PlantId)
                    .ToList();
                
                plantMonitoringsQuery = plantMonitoringsQuery.Where(p => userPlantIds.Contains(p.PlantID));
            }

            var plantMonitorings = plantMonitoringsQuery.ToList();

            // Create a dictionary to group by monitoring type and plant
            var currentYear = DateTime.Now.Year;
            var data = new Dictionary<int, Dictionary<int, List<PlantMonitoringViewModel>>>();

            foreach (var pm in plantMonitorings)
            {
                if (!data.ContainsKey(pm.MonitoringID))
                {
                    data[pm.MonitoringID] = new Dictionary<int, List<PlantMonitoringViewModel>>();
                }

                if (!data[pm.MonitoringID].ContainsKey(pm.PlantID))
                {
                    data[pm.MonitoringID][pm.PlantID] = new List<PlantMonitoringViewModel>();
                }

                var viewModel = new PlantMonitoringViewModel
                {
                    Id = pm.Id,
                    Area = pm.Area,
                    ProcStatus = pm.ProcStatus,
                    ExpStatus = pm.ExpStatus,
                    ExpDate = pm.ExpDate,
                    QuoteDate = pm.QuoteDate,
                    QuoteSubmitDate = pm.QuoteSubmitDate,
                    QuoteCompleteDate = pm.QuoteCompleteDate,
                    EprDate = pm.EprDate,
                    EprSubmitDate = pm.EprSubmitDate,
                    EprCompleteDate = pm.EprCompleteDate,
                    WorkDate = pm.WorkDate,
                    WorkSubmitDate = pm.WorkSubmitDate,
                    WorkCompleteDate = pm.WorkCompleteDate,
                    Remarks = pm.Remarks
                };

                data[pm.MonitoringID][pm.PlantID].Add(viewModel);
            }

            ViewBag.MonitoringTypes = monitoringTypes;
            ViewBag.Plants = plants;
            ViewBag.Data = data;
            ViewBag.CurrentYear = currentYear;
            ViewBag.MonthNames = CultureInfo.CurrentCulture.DateTimeFormat.MonthNames;
            ViewBag.IsAdmin = User.IsInRole("Admin");

            return View();
        }

        // GET: PlantMonitoring/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PlantMonitoring plantMonitoring = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .FirstOrDefault(p => p.Id == id);

            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
            }

            ViewBag.IsAdmin = User.IsInRole("Admin");
            
            // Get monitoring notifications for the current user
            ViewBag.Notifications = GetMonitoringNotifications();
            
            return View(plantMonitoring);
        }

        // GET: PlantMonitoring/Create
        [Authorize(Roles = "Admin")]
        public ActionResult Create()
        {
            ViewBag.PlantID = new SelectList(db.Plants.OrderBy(p => p.PlantName), "Id", "PlantName");
            ViewBag.MonitoringID = new SelectList(db.Monitorings.OrderBy(m => m.MonitoringName), "MonitoringID", "MonitoringName");
            return View();
        }

        // POST: PlantMonitoring/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public ActionResult Create(PlantMonitoring plantMonitoring)
        {
            if (ModelState.IsValid)
            {
                // If WorkCompleteDate is present (meaning the monitoring is completed),
                // set the renewal date (ExpDate) based on monitoring frequency
                if (plantMonitoring.WorkCompleteDate.HasValue)
                {
                    // Get the monitoring type to determine frequency
                    var monitoring = db.Monitorings.Find(plantMonitoring.MonitoringID);
                    if (monitoring != null)
                    {
                        // Set the expiry date based on the monitoring frequency
                        int frequencyMonths = monitoring.MonitoringFreq;
                        plantMonitoring.ExpDate = plantMonitoring.WorkCompleteDate.Value.AddMonths(frequencyMonths);
                    }
                }
                
                plantMonitoring.CalculateStatuses();
                db.PlantMonitorings.Add(plantMonitoring);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.PlantID = new SelectList(db.Plants.OrderBy(p => p.PlantName), "Id", "PlantName", plantMonitoring.PlantID);
            ViewBag.MonitoringID = new SelectList(db.Monitorings.OrderBy(m => m.MonitoringName), "MonitoringID", "MonitoringName", plantMonitoring.MonitoringID);
            return View(plantMonitoring);
        }

        // GET: PlantMonitoring/Edit/5
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PlantMonitoring plantMonitoring = db.PlantMonitorings.Find(id);
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }
            ViewBag.MonitoringID = new SelectList(db.Monitorings, "MonitoringID", "MonitoringName", plantMonitoring.MonitoringID);
            ViewBag.PlantID = new SelectList(db.Plants, "Id", "PlantName", plantMonitoring.PlantID);
            
            // Get users for dropdown lists - no need to filter since only admins can access this page
            var users = db.Users.OrderBy(u => u.UserName).ToList();
            
            // Create SelectList for user assignments
            ViewBag.UsersList = new SelectList(users, "UserName", "UserName");
            
            return View(plantMonitoring);
        }

        // POST: PlantMonitoring/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(PlantMonitoring plantMonitoring)
        {
            if (ModelState.IsValid)
            {
                // If WorkCompleteDate is present (meaning the monitoring is completed),
                // set the renewal date (ExpDate) based on monitoring frequency
                if (plantMonitoring.WorkCompleteDate.HasValue)
                {
                    // Get the monitoring type to determine frequency
                    var monitoring = db.Monitorings.Find(plantMonitoring.MonitoringID);
                    if (monitoring != null)
                    {
                        // Set the expiry date based on the monitoring frequency
                        int frequencyMonths = monitoring.MonitoringFreq;
                        plantMonitoring.ExpDate = plantMonitoring.WorkCompleteDate.Value.AddMonths(frequencyMonths);
                    }
                }
                
                plantMonitoring.CalculateStatuses();
                db.Entry(plantMonitoring).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.PlantID = new SelectList(db.Plants.OrderBy(p => p.PlantName), "Id", "PlantName", plantMonitoring.PlantID);
            ViewBag.MonitoringID = new SelectList(db.Monitorings.OrderBy(m => m.MonitoringName), "MonitoringID", "MonitoringName", plantMonitoring.MonitoringID);
            return View(plantMonitoring);
        }

        // GET: PlantMonitoring/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PlantMonitoring plantMonitoring = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .FirstOrDefault(p => p.Id == id);
                
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }
            return View(plantMonitoring);
        }

        // POST: PlantMonitoring/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public ActionResult DeleteConfirmed(int id)
        {
            PlantMonitoring plantMonitoring = db.PlantMonitorings.Find(id);
            db.PlantMonitorings.Remove(plantMonitoring);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: PlantMonitoring/UpdateStatus/5
        public ActionResult UpdateStatus(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PlantMonitoring plantMonitoring = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .FirstOrDefault(p => p.Id == id);
                
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
            }

            // Get users for dropdown lists
            var users = db.Users.OrderBy(u => u.UserName).ToList();
            
            // Filter out admin users if the current user is not an admin
            if (!User.IsInRole("Admin"))
            {
                try
                {
                    // Get the admin role
                    var adminRole = db.Roles.FirstOrDefault(r => r.Name == "Admin");
                    
                    if (adminRole != null)
                    {
                        // Use SQL to get usernames directly from database
                        var adminUsernames = db.Database.SqlQuery<string>(@"
                            SELECT u.UserName 
                            FROM AspNetUsers u
                            INNER JOIN AspNetUserRoles ur ON u.Id = ur.UserId
                            WHERE ur.RoleId = @roleId",
                            new System.Data.SqlClient.SqlParameter("@roleId", adminRole.Id)
                        ).ToList();
                        
                        // Filter out admin users
                        users = users.Where(u => !adminUsernames.Contains(u.UserName)).ToList();
                    }
                }
                catch (Exception ex)
                {
                    // Log the error but don't break the page
                    System.Diagnostics.Debug.WriteLine("Failed to filter admin users: " + ex.Message);
                }
            }

            // Create SelectList for user assignments
            ViewBag.UsersList = new SelectList(users, "UserName", "UserName");

            ViewBag.IsAdmin = User.IsInRole("Admin");
            return View(plantMonitoring);
        }

        // POST: PlantMonitoring/UpdateStatus/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateStatus(int id, PlantMonitoring model, HttpPostedFileBase quoteDocument, HttpPostedFileBase eprDocument, HttpPostedFileBase workDocument)
        {
            if (ModelState.IsValid)
            {
                var plantMonitoring = db.PlantMonitorings.Find(id);
                if (plantMonitoring == null)
                {
                    return HttpNotFound();
                }

                // Check if user has access to this plant monitoring record
                if (!User.IsInRole("Admin"))
                {
                    var userId = User.Identity.GetUserId();
                    var userHasAccessToPlant = db.UserPlants
                        .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                    
                    if (!userHasAccessToPlant)
                    {
                        return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                    }
                    
                    // For non-admin users, enforce self-assignment to all phases
                    model.QuoteUserAssign = User.Identity.Name;
                    model.EprUserAssign = User.Identity.Name;
                    model.WorkUserAssign = User.Identity.Name;
                }

                // Update properties
                plantMonitoring.ExpDate = model.ExpDate;
                plantMonitoring.Remarks = model.Remarks;
                
                // Quotation Phase
                plantMonitoring.QuoteDate = model.QuoteDate;
                plantMonitoring.QuoteSubmitDate = model.QuoteSubmitDate;
                plantMonitoring.QuoteCompleteDate = model.QuoteCompleteDate;
                plantMonitoring.QuoteUserAssign = model.QuoteUserAssign;
                
                // Preparation Phase
                plantMonitoring.EprDate = model.EprDate;
                plantMonitoring.EprSubmitDate = model.EprSubmitDate;
                plantMonitoring.EprCompleteDate = model.EprCompleteDate;
                plantMonitoring.EprUserAssign = model.EprUserAssign;
                
                // Work Execution Phase
                plantMonitoring.WorkDate = model.WorkDate;
                plantMonitoring.WorkSubmitDate = model.WorkSubmitDate;
                plantMonitoring.WorkCompleteDate = model.WorkCompleteDate;
                plantMonitoring.WorkUserAssign = model.WorkUserAssign;
                
                // Auto-fill dates based on phase completion
                if (plantMonitoring.QuoteCompleteDate.HasValue && !plantMonitoring.EprDate.HasValue)
                {
                    plantMonitoring.EprDate = plantMonitoring.QuoteCompleteDate;
                }
                
                if (plantMonitoring.EprCompleteDate.HasValue && !plantMonitoring.WorkDate.HasValue)
                {
                    plantMonitoring.WorkDate = plantMonitoring.EprCompleteDate;
                }

                // If WorkCompleteDate is present (meaning the monitoring is completed),
                // set the renewal date (ExpDate) based on monitoring frequency
                if (model.WorkCompleteDate.HasValue)
                {
                    // Get the monitoring frequency in months
                    int frequencyMonths = plantMonitoring.Monitoring.MonitoringFreq;
                    // Set the expiry date based on the frequency
                    plantMonitoring.ExpDate = model.WorkCompleteDate.Value.AddMonths(frequencyMonths);
                }

                // Calculate and set statuses
                plantMonitoring.CalculateStatuses();

                // Handle file uploads
                if (quoteDocument != null && quoteDocument.ContentLength > 0)
                {
                    // Check file size (20MB limit)
                    if (quoteDocument.ContentLength > 20 * 1024 * 1024)
                    {
                        ModelState.AddModelError("", "The quote document exceeds the maximum file size of 20MB.");
                        var quoteDocumentValidationEntity = db.PlantMonitorings
                            .Include(p => p.Plant)
                            .Include(p => p.Monitoring)
                            .FirstOrDefault(p => p.Id == id);
                        
                        if (quoteDocumentValidationEntity != null)
                        {
                            model.Plant = quoteDocumentValidationEntity.Plant;
                            model.Monitoring = quoteDocumentValidationEntity.Monitoring;
                        }
                        ViewBag.IsAdmin = User.IsInRole("Admin");
                        return View(model);
                    }

                    string fileName = Path.GetFileName(quoteDocument.FileName);
                    string uniqueFileName = $"Quote_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                    string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                    
                    // Ensure directory exists
                    Directory.CreateDirectory(Path.GetDirectoryName(path));
                    
                    quoteDocument.SaveAs(path);
                    plantMonitoring.QuoteDoc = "~/uploads/Monitoring/" + uniqueFileName;
                }

                if (eprDocument != null && eprDocument.ContentLength > 0)
                {
                    // Check file size (20MB limit)
                    if (eprDocument.ContentLength > 20 * 1024 * 1024)
                    {
                        ModelState.AddModelError("", "The EPR document exceeds the maximum file size of 20MB.");
                        var eprDocumentValidationEntity = db.PlantMonitorings
                            .Include(p => p.Plant)
                            .Include(p => p.Monitoring)
                            .FirstOrDefault(p => p.Id == id);
                        
                        if (eprDocumentValidationEntity != null)
                        {
                            model.Plant = eprDocumentValidationEntity.Plant;
                            model.Monitoring = eprDocumentValidationEntity.Monitoring;
                        }
                        ViewBag.IsAdmin = User.IsInRole("Admin");
                        return View(model);
                    }

                    string fileName = Path.GetFileName(eprDocument.FileName);
                    string uniqueFileName = $"EPR_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                    string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                    
                    // Ensure directory exists
                    Directory.CreateDirectory(Path.GetDirectoryName(path));
                    
                    eprDocument.SaveAs(path);
                    plantMonitoring.EprDoc = "~/uploads/Monitoring/" + uniqueFileName;
                }

                if (workDocument != null && workDocument.ContentLength > 0)
                {
                    // Check file size (20MB limit)
                    if (workDocument.ContentLength > 20 * 1024 * 1024)
                    {
                        ModelState.AddModelError("", "The work document exceeds the maximum file size of 20MB.");
                        var workDocumentValidationEntity = db.PlantMonitorings
                            .Include(p => p.Plant)
                            .Include(p => p.Monitoring)
                            .FirstOrDefault(p => p.Id == id);
                        
                        if (workDocumentValidationEntity != null)
                        {
                            model.Plant = workDocumentValidationEntity.Plant;
                            model.Monitoring = workDocumentValidationEntity.Monitoring;
                        }
                        ViewBag.IsAdmin = User.IsInRole("Admin");
                        return View(model);
                    }

                    string fileName = Path.GetFileName(workDocument.FileName);
                    string uniqueFileName = $"Work_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                    string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                    
                    // Ensure directory exists
                    Directory.CreateDirectory(Path.GetDirectoryName(path));
                    
                    workDocument.SaveAs(path);
                    plantMonitoring.WorkDoc = "~/uploads/Monitoring/" + uniqueFileName;
                }

                db.Entry(plantMonitoring).State = EntityState.Modified;
                db.SaveChanges();

                // Success message
                TempData["SuccessMessage"] = "Expiry date and remarks successfully updated.";

                return RedirectToAction("Details", new { id = plantMonitoring.Id });
            }

            // If we got this far, something failed, redisplay form
            var plantMonitoringFromDb = db.PlantMonitorings
                .Include(p => p.Plant)
                .Include(p => p.Monitoring)
                .FirstOrDefault(p => p.Id == id);

            if (plantMonitoringFromDb == null)
            {
                return HttpNotFound();
            }

            // Copy document paths back from DB entity to model to preserve them
            model.QuoteDoc = plantMonitoringFromDb.QuoteDoc;
            model.EprDoc = plantMonitoringFromDb.EprDoc;
            model.WorkDoc = plantMonitoringFromDb.WorkDoc;
            
            // Set navigation properties
            model.Plant = plantMonitoringFromDb.Plant;
            model.Monitoring = plantMonitoringFromDb.Monitoring;

            // Recreate user list for dropdown
            var users = db.Users.OrderBy(u => u.UserName).ToList();
            
            // Filter out admin users if the current user is not an admin
            if (!User.IsInRole("Admin"))
            {
                try
                {
                    // Get the admin role
                    var adminRole = db.Roles.FirstOrDefault(r => r.Name == "Admin");
                    
                    if (adminRole != null)
                    {
                        // Use SQL to get usernames directly from database
                        var adminUsernames = db.Database.SqlQuery<string>(@"
                            SELECT u.UserName 
                            FROM AspNetUsers u
                            INNER JOIN AspNetUserRoles ur ON u.Id = ur.UserId
                            WHERE ur.RoleId = @roleId",
                            new System.Data.SqlClient.SqlParameter("@roleId", adminRole.Id)
                        ).ToList();
                        
                        // Filter out admin users
                        users = users.Where(u => !adminUsernames.Contains(u.UserName)).ToList();
                    }
                }
                catch (Exception ex)
                {
                    // Log the error but don't break the page
                    System.Diagnostics.Debug.WriteLine("Failed to filter admin users: " + ex.Message);
                }
            }
            
            // Create SelectList for user assignments
            ViewBag.UsersList = new SelectList(users, "UserName", "UserName");

            ViewBag.IsAdmin = User.IsInRole("Admin");
            return View(model);
        }

        // POST: PlantMonitoring/UpdateExpiry/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateExpiry(int id, PlantMonitoring model)
        {
            var plantMonitoring = db.PlantMonitorings.Find(id);
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
            }

            // Update only expiry and remarks
            plantMonitoring.ExpDate = model.ExpDate;
            plantMonitoring.Remarks = model.Remarks;
            
            // Calculate statuses after update
            plantMonitoring.CalculateStatuses();
            
            db.Entry(plantMonitoring).State = EntityState.Modified;
            db.SaveChanges();

            // Success message
            TempData["SuccessMessage"] = "Expiry date and remarks successfully updated.";

            // Redirect back to the update page
            return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
        }

        // POST: PlantMonitoring/UpdateQuotation/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateQuotation(int id, PlantMonitoring model, HttpPostedFileBase quoteDocument)
        {
            var plantMonitoring = db.PlantMonitorings.Find(id);
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
                
                // For non-admin users, always set the current user as the assignee
                model.QuoteUserAssign = User.Identity.Name;
            }

            // Update only quotation phase
            plantMonitoring.QuoteDate = model.QuoteDate;
            plantMonitoring.QuoteSubmitDate = model.QuoteSubmitDate;
            plantMonitoring.QuoteCompleteDate = model.QuoteCompleteDate;
            plantMonitoring.QuoteUserAssign = model.QuoteUserAssign;

            // If Quotation phase is completed, set the EPR phase date if not already set
            if (model.QuoteCompleteDate.HasValue && !plantMonitoring.EprDate.HasValue)
            {
                plantMonitoring.EprDate = model.QuoteCompleteDate;
            }

            // Handle document upload
            if (quoteDocument != null && quoteDocument.ContentLength > 0)
            {
                // Check file size (20MB limit)
                if (quoteDocument.ContentLength > 20 * 1024 * 1024)
                {
                    TempData["ErrorMessage"] = "The quote document exceeds the maximum file size of 20MB.";
                    return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
                }

                string fileName = Path.GetFileName(quoteDocument.FileName);
                string uniqueFileName = $"Quote_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                
                // Ensure directory exists
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                
                quoteDocument.SaveAs(path);
                plantMonitoring.QuoteDoc = "~/uploads/Monitoring/" + uniqueFileName;
            }
            
            // Calculate statuses after update
            plantMonitoring.CalculateStatuses();
            
            db.Entry(plantMonitoring).State = EntityState.Modified;
            db.SaveChanges();

            // Success message
            TempData["SuccessMessage"] = "Quotation phase successfully updated.";

            // Redirect back to the update page
            return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
        }

        // POST: PlantMonitoring/UpdateEpr/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateEpr(int id, PlantMonitoring model, HttpPostedFileBase eprDocument)
        {
            var plantMonitoring = db.PlantMonitorings.Find(id);
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
                
                // For non-admin users, always set the current user as the assignee
                model.EprUserAssign = User.Identity.Name;
            }

            // Update only ePR phase
            plantMonitoring.EprDate = model.EprDate;
            plantMonitoring.EprSubmitDate = model.EprSubmitDate;
            plantMonitoring.EprCompleteDate = model.EprCompleteDate;
            plantMonitoring.EprUserAssign = model.EprUserAssign;

            // If EPR phase is completed, set the Work phase date if not already set
            if (model.EprCompleteDate.HasValue && !plantMonitoring.WorkDate.HasValue)
            {
                plantMonitoring.WorkDate = model.EprCompleteDate;
            }

            // Handle document upload
            if (eprDocument != null && eprDocument.ContentLength > 0)
            {
                // Check file size (20MB limit)
                if (eprDocument.ContentLength > 20 * 1024 * 1024)
                {
                    TempData["ErrorMessage"] = "The EPR document exceeds the maximum file size of 20MB.";
                    return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
                }

                string fileName = Path.GetFileName(eprDocument.FileName);
                string uniqueFileName = $"EPR_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                
                // Ensure directory exists
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                
                eprDocument.SaveAs(path);
                plantMonitoring.EprDoc = "~/uploads/Monitoring/" + uniqueFileName;
            }
            
            // Calculate statuses after update
            plantMonitoring.CalculateStatuses();
            
            db.Entry(plantMonitoring).State = EntityState.Modified;
            db.SaveChanges();

            // Success message
            TempData["SuccessMessage"] = "EPR phase successfully updated.";

            // Redirect back to the update page
            return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
        }

        // POST: PlantMonitoring/UpdateWork/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateWork(int id, PlantMonitoring model, HttpPostedFileBase workDocument)
        {
            var plantMonitoring = db.PlantMonitorings.Find(id);
            if (plantMonitoring == null)
            {
                return HttpNotFound();
            }

            // Check if user has access to this plant monitoring record
            if (!User.IsInRole("Admin"))
            {
                var userId = User.Identity.GetUserId();
                var userHasAccessToPlant = db.UserPlants
                    .Any(up => up.UserId == userId && up.PlantId == plantMonitoring.PlantID);
                
                if (!userHasAccessToPlant)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
                }
                
                // For non-admin users, always set the current user as the assignee
                model.WorkUserAssign = User.Identity.Name;
            }

            // Update only work execution phase
            plantMonitoring.WorkDate = model.WorkDate;
            plantMonitoring.WorkSubmitDate = model.WorkSubmitDate;
            plantMonitoring.WorkCompleteDate = model.WorkCompleteDate;
            plantMonitoring.WorkUserAssign = model.WorkUserAssign;

            // If WorkCompleteDate is present (meaning the monitoring is completed),
            // set the renewal date (ExpDate) based on monitoring frequency
            if (model.WorkCompleteDate.HasValue)
            {
                // Get the monitoring frequency in months
                int frequencyMonths = plantMonitoring.Monitoring.MonitoringFreq;
                // Set the expiry date based on the frequency
                plantMonitoring.ExpDate = model.WorkCompleteDate.Value.AddMonths(frequencyMonths);
            }

            // Handle document upload
            if (workDocument != null && workDocument.ContentLength > 0)
            {
                // Check file size (20MB limit)
                if (workDocument.ContentLength > 20 * 1024 * 1024)
                {
                    TempData["ErrorMessage"] = "The work document exceeds the maximum file size of 20MB.";
                    return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
                }

                string fileName = Path.GetFileName(workDocument.FileName);
                string uniqueFileName = $"Work_{id}_{DateTime.Now.ToString("yyyyMMddHHmmss")}_{fileName}";
                string path = Path.Combine(Server.MapPath("~/uploads/Monitoring"), uniqueFileName);
                
                // Ensure directory exists
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                
                workDocument.SaveAs(path);
                plantMonitoring.WorkDoc = "~/uploads/Monitoring/" + uniqueFileName;
            }
            
            // Calculate statuses after update
            plantMonitoring.CalculateStatuses();
            
            db.Entry(plantMonitoring).State = EntityState.Modified;
            db.SaveChanges();

            // Success message
            TempData["SuccessMessage"] = "Work execution phase successfully updated.";

            // Redirect back to the update page
            return RedirectToAction("UpdateStatus", new { id = plantMonitoring.Id });
        }

        // Generates monitoring notifications for the current user
        private List<MonitoringNotification> GetMonitoringNotifications()
        {
            var notifications = new List<MonitoringNotification>();
            var currentUser = User.Identity.Name;
            var today = DateTime.Now.Date;
            
            try
            {
                // 1. Items expiring soon (30, 14, and 7 days)
                var expiringItems = db.PlantMonitorings
                    .Include(p => p.Plant)
                    .Include(p => p.Monitoring)
                    .Where(p => p.ExpDate.HasValue && 
                           p.ExpDate.Value >= today &&
                           p.ExpDate.Value <= today.AddDays(30) &&
                           p.ProcStatus != "Completed")
                    .ToList();
                
                foreach (var item in expiringItems)
                {
                    var daysRemaining = (item.ExpDate.Value - today).Days;
                    string urgency = "";
                    
                    if (daysRemaining <= 7)
                        urgency = "Very soon (7 days)";
                    else if (daysRemaining <= 14)
                        urgency = "Soon (14 days)";
                    else
                        urgency = "Within 30 days";
                    
                    notifications.Add(new MonitoringNotification
                    {
                        Type = NotificationType.Expiring,
                        Title = "Monitoring Expiring",
                        Message = $"{item.Monitoring.MonitoringName} for {item.Plant.PlantName} {(string.IsNullOrEmpty(item.Area) ? "" : "(" + item.Area + ")")} is expiring {urgency}",
                        Link = Url.Action("Details", new { id = item.Id }),
                        ItemId = item.Id,
                        IsRead = false
                    });
                }
                
                // 2. Items assigned to the current user
                var assignedItems = db.PlantMonitorings
                    .Include(p => p.Plant)
                    .Include(p => p.Monitoring)
                    .Where(p => (p.QuoteUserAssign == currentUser && p.QuoteCompleteDate == null) || 
                           (p.EprUserAssign == currentUser && p.EprCompleteDate == null) ||
                           (p.WorkUserAssign == currentUser && p.WorkCompleteDate == null))
                    .ToList();
                
                foreach (var item in assignedItems)
                {
                    string phase = "";
                    if (item.QuoteUserAssign == currentUser && item.QuoteCompleteDate == null)
                        phase = "Quotation";
                    else if (item.EprUserAssign == currentUser && item.EprCompleteDate == null)
                        phase = "ePR";
                    else if (item.WorkUserAssign == currentUser && item.WorkCompleteDate == null)
                        phase = "Work Execution";
                    
                    notifications.Add(new MonitoringNotification
                    {
                        Type = NotificationType.Assignment,
                        Title = "Task Assigned",
                        Message = $"You are assigned to the {phase} phase for {item.Monitoring.MonitoringName} at {item.Plant.PlantName}",
                        Link = Url.Action("UpdateStatus", new { id = item.Id }),
                        ItemId = item.Id,
                        IsRead = false
                    });
                }
                
                // 3. Items with completed phase needing next phase initiation
                var readyForNextPhase = db.PlantMonitorings
                    .Include(p => p.Plant)
                    .Include(p => p.Monitoring)
                    .Where(p => (p.QuoteCompleteDate.HasValue && !p.EprCompleteDate.HasValue && p.EprUserAssign == currentUser) ||
                           (p.EprCompleteDate.HasValue && !p.WorkCompleteDate.HasValue && p.WorkUserAssign == currentUser))
                    .ToList();
                
                foreach (var item in readyForNextPhase)
                {
                    string phase = "";
                    if (item.QuoteCompleteDate.HasValue && !item.EprCompleteDate.HasValue)
                        phase = "ePR";
                    else
                        phase = "Work Execution";
                    
                    notifications.Add(new MonitoringNotification
                    {
                        Type = NotificationType.NextPhaseReady,
                        Title = "Next Phase Ready",
                        Message = $"The {phase} phase is ready to begin for {item.Monitoring.MonitoringName} at {item.Plant.PlantName}",
                        Link = Url.Action("UpdateStatus", new { id = item.Id }),
                        ItemId = item.Id,
                        IsRead = false
                    });
                }
                
                // 4. Overdue items (for items with dates set but not completed)
                var overdueItems = db.PlantMonitorings
                    .Include(p => p.Plant)
                    .Include(p => p.Monitoring)
                    .Where(p => (p.QuoteSubmitDate.HasValue && p.QuoteSubmitDate.Value < today && !p.QuoteCompleteDate.HasValue && p.QuoteUserAssign == currentUser) ||
                           (p.EprSubmitDate.HasValue && p.EprSubmitDate.Value < today && !p.EprCompleteDate.HasValue && p.EprUserAssign == currentUser) ||
                           (p.WorkSubmitDate.HasValue && p.WorkSubmitDate.Value < today && !p.WorkCompleteDate.HasValue && p.WorkUserAssign == currentUser))
                    .ToList();
                
                foreach (var item in overdueItems)
                {
                    string phase = "";
                    if (item.QuoteSubmitDate.HasValue && !item.QuoteCompleteDate.HasValue && item.QuoteUserAssign == currentUser)
                        phase = "Quotation";
                    else if (item.EprSubmitDate.HasValue && !item.EprCompleteDate.HasValue && item.EprUserAssign == currentUser)
                        phase = "ePR";
                    else
                        phase = "Work Execution";
                    
                    notifications.Add(new MonitoringNotification
                    {
                        Type = NotificationType.Overdue,
                        Title = "Overdue Task",
                        Message = $"The {phase} phase for {item.Monitoring.MonitoringName} at {item.Plant.PlantName} is overdue",
                        Link = Url.Action("UpdateStatus", new { id = item.Id }),
                        ItemId = item.Id,
                        IsRead = false
                    });
                }
            }
            catch (Exception ex)
            {
                // Log error but don't break the page
                System.Diagnostics.Debug.WriteLine("Error generating monitoring notifications: " + ex.Message);
            }
            
            return notifications.OrderByDescending(n => n.Type == NotificationType.Overdue)  // Overdue first
                               .ThenByDescending(n => n.Type == NotificationType.Expiring)  // Then expiring
                               .ThenBy(n => n.CreatedDate)  // Then by date
                               .Take(10)  // Limit to 10 items
                               .ToList();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }

    // View Model for Schedule view
    public class PlantMonitoringViewModel
    {
        public int Id { get; set; }
        public string Area { get; set; }
        public string ProcStatus { get; set; }
        public string ExpStatus { get; set; }
        public DateTime? ExpDate { get; set; }
        public DateTime? QuoteDate { get; set; }
        public DateTime? QuoteSubmitDate { get; set; }
        public DateTime? QuoteCompleteDate { get; set; }
        public DateTime? EprDate { get; set; }
        public DateTime? EprSubmitDate { get; set; }
        public DateTime? EprCompleteDate { get; set; }
        public DateTime? WorkDate { get; set; }
        public DateTime? WorkSubmitDate { get; set; }
        public DateTime? WorkCompleteDate { get; set; }
        public string Remarks { get; set; }

        public string ProcStatusCssClass
        {
            get
            {
                switch (ProcStatus)
                {
                    case "Completed":
                        return "bg-success";
                    case "Work In Progress":
                    case "In Progress": // For backward compatibility
                        return "bg-warning";
                    case "ePR Raised":
                    case "In Preparation": // For backward compatibility
                        return "bg-info";
                    case "Quotation Requested":
                    case "In Quotation": // For backward compatibility
                        return "bg-primary";
                    case "Not Started":
                        return "bg-notstarted";
                    default:
                        return "";
                }
            }
        }

        public string ExpStatusCssClass
        {
            get
            {
                switch (ExpStatus)
                {
                    case "Expired":
                        return "bg-danger";
                    case "Expiring Soon":
                        return "bg-warning";
                    case "Active":
                        return "bg-success";
                    case "No Expiry":
                        return "bg-secondary";
                    default:
                        return "";
                }
            }
        }
    }
} 