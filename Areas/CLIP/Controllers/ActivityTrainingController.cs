using System;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using EHS_PORTAL.Areas.CLIP.Models;

namespace EHS_PORTAL.Areas.CLIP.Controllers
{
    [Authorize]
    public class ActivityTrainingController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        
        // GET: CLIP/ActivityTraining
        public ActionResult Index()
        {
            string userId = User.Identity.GetUserId();
            var activities = db.ActivityTrainings
                .Where(a => a.UserId == userId)
                .OrderByDescending(a => a.ActivityDate)
                .ToList();
            
            return View(activities);
        }
        
        // GET: CLIP/ActivityTraining/Create
        public ActionResult Create()
        {
            return View(new ActivityTrainingViewModel 
            { 
                ActivityDate = DateTime.Today 
            });
        }
        
        // POST: CLIP/ActivityTraining/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ActivityTrainingViewModel model)
        {
            if (ModelState.IsValid)
            {
                string userId = User.Identity.GetUserId();
                string fileName = null;
                
                // Handle document upload if provided
                if (model.DocumentFile != null && model.DocumentFile.ContentLength > 0)
                {
                    string uploadsFolder = Server.MapPath("~/Areas/CLIP/uploads/ActivityTraining");
                    
                    // Create directory if it doesn't exist
                    if (!Directory.Exists(uploadsFolder))
                    {
                        Directory.CreateDirectory(uploadsFolder);
                    }
                    
                    // Generate a unique filename
                    fileName = Guid.NewGuid().ToString() + Path.GetExtension(model.DocumentFile.FileName);
                    var filePath = Path.Combine(uploadsFolder, fileName);
                    
                    // Save the file
                    model.DocumentFile.SaveAs(filePath);
                }
                
                // Create and save the activity training record
                var activity = new ActivityTraining
                {
                    Id = Guid.NewGuid(),
                    UserId = userId,
                    ActivityName = model.ActivityName,
                    ActivityDate = model.ActivityDate,
                    Document = fileName,
                    CEPPointsGained = model.CEPPointsGained ?? 0,
                    CPDPointsGained = model.CPDPointsGained ?? 0
                };
                
                db.ActivityTrainings.Add(activity);
                
                // Update user's points
                var user = db.Users.Find(userId);
                if (user != null)
                {
                    if (model.CEPPointsGained.HasValue)
                    {
                        user.CEP_Points = (user.CEP_Points ?? 0) + (int)model.CEPPointsGained.Value;
                    }
                    
                    if (model.CPDPointsGained.HasValue)
                    {
                        user.CPD_Points = (user.CPD_Points ?? 0) + (int)model.CPDPointsGained.Value;
                    }
                }
                
                db.SaveChanges();
                
                TempData["SuccessMessage"] = "Training activity logged successfully.";
                return RedirectToAction("Index");
            }
            
            return View(model);
        }
        
        // GET: CLIP/ActivityTraining/Details/5
        public ActionResult Details(Guid id)
        {
            var activity = db.ActivityTrainings
                .Include(a => a.User)
                .FirstOrDefault(a => a.Id == id);
                
            if (activity == null)
            {
                TempData["ErrorMessage"] = "Activity not found.";
                return RedirectToAction("Index");
            }
            
            return View(activity);
        }
        
        // GET: CLIP/ActivityTraining/Edit/5
        public ActionResult Edit(Guid id)
        {
            var activity = db.ActivityTrainings.Find(id);
            if (activity == null)
            {
                TempData["ErrorMessage"] = "Activity not found.";
                return RedirectToAction("Index");
            }
            
            // Check if current user is the owner of this activity
            string userId = User.Identity.GetUserId();
            if (activity.UserId != userId)
            {
                TempData["ErrorMessage"] = "You are not authorized to edit this activity.";
                return RedirectToAction("Index");
            }
            
            var viewModel = new ActivityTrainingViewModel
            {
                ActivityName = activity.ActivityName,
                ActivityDate = activity.ActivityDate,
                CEPPointsGained = activity.CEPPointsGained,
                CPDPointsGained = activity.CPDPointsGained
            };
            
            ViewBag.CurrentDocumentName = activity.Document;
            
            return View(viewModel);
        }
        
        // POST: CLIP/ActivityTraining/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Guid id, ActivityTrainingViewModel model)
        {
            if (ModelState.IsValid)
            {
                var activity = db.ActivityTrainings.Find(id);
                if (activity == null)
                {
                    TempData["ErrorMessage"] = "Activity not found.";
                    return RedirectToAction("Index");
                }
                
                // Check if current user is the owner of this activity
                string userId = User.Identity.GetUserId();
                if (activity.UserId != userId)
                {
                    TempData["ErrorMessage"] = "You are not authorized to edit this activity.";
                    return RedirectToAction("Index");
                }
                
                // Track point changes for updating user's total points
                float? originalCEP = activity.CEPPointsGained;
                float? originalCPD = activity.CPDPointsGained;
                
                // Update the activity properties
                activity.ActivityName = model.ActivityName;
                activity.ActivityDate = model.ActivityDate;
                activity.CEPPointsGained = model.CEPPointsGained ?? 0;
                activity.CPDPointsGained = model.CPDPointsGained ?? 0;
                
                // Handle document upload if provided
                if (model.DocumentFile != null && model.DocumentFile.ContentLength > 0)
                {
                    string uploadsFolder = Server.MapPath("~/Areas/CLIP/uploads/ActivityTraining");
                    
                    // Create directory if it doesn't exist
                    if (!Directory.Exists(uploadsFolder))
                    {
                        Directory.CreateDirectory(uploadsFolder);
                    }
                    
                    // Delete previous file if exists
                    if (!string.IsNullOrEmpty(activity.Document))
                    {
                        string previousFilePath = Path.Combine(uploadsFolder, activity.Document);
                        if (System.IO.File.Exists(previousFilePath))
                        {
                            System.IO.File.Delete(previousFilePath);
                        }
                    }
                    
                    // Generate a unique filename
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(model.DocumentFile.FileName);
                    var filePath = Path.Combine(uploadsFolder, fileName);
                    
                    // Save the file
                    model.DocumentFile.SaveAs(filePath);
                    
                    // Update document filename in the database
                    activity.Document = fileName;
                }
                
                // Update user's points based on the difference
                var user = db.Users.Find(userId);
                if (user != null)
                {
                    // Update CEP points
                    int oldPoints = (int)originalCEP;
                    int newPoints = model.CEPPointsGained.HasValue ? (int)model.CEPPointsGained.Value : 0;
                    user.CEP_Points = (user.CEP_Points ?? 0) - oldPoints + newPoints;
                    
                    // Update CPD points
                    int oldPointsCPD = (int)originalCPD;
                    int newPointsCPD = model.CPDPointsGained.HasValue ? (int)model.CPDPointsGained.Value : 0;
                    user.CPD_Points = (user.CPD_Points ?? 0) - oldPointsCPD + newPointsCPD;
                }
                
                db.SaveChanges();
                
                TempData["SuccessMessage"] = "Training activity updated successfully.";
                return RedirectToAction("Index");
            }
            
            ViewBag.CurrentDocumentName = db.ActivityTrainings.Find(id)?.Document;
            return View(model);
        }
        
        // POST: CLIP/ActivityTraining/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Guid id)
        {
            var activity = db.ActivityTrainings.Find(id);
            if (activity != null)
            {
                // Check if current user is the owner of this activity
                string userId = User.Identity.GetUserId();
                if (activity.UserId != userId)
                {
                    TempData["ErrorMessage"] = "You are not authorized to delete this activity.";
                    return RedirectToAction("Index");
                }
                
                // Update user's points by subtracting this activity's points
                var user = db.Users.Find(userId);
                if (user != null)
                {
                    user.CEP_Points = (user.CEP_Points ?? 0) - (int)activity.CEPPointsGained;
                    if (user.CEP_Points < 0) user.CEP_Points = 0;
                    
                    user.CPD_Points = (user.CPD_Points ?? 0) - (int)activity.CPDPointsGained;
                    if (user.CPD_Points < 0) user.CPD_Points = 0;
                }
                
                // Delete file if exists
                if (!string.IsNullOrEmpty(activity.Document))
                {
                    string uploadsFolder = Server.MapPath("~/Areas/CLIP/uploads/ActivityTraining");
                    string filePath = Path.Combine(uploadsFolder, activity.Document);
                    if (System.IO.File.Exists(filePath))
                    {
                        System.IO.File.Delete(filePath);
                    }
                }
                
                db.ActivityTrainings.Remove(activity);
                db.SaveChanges();
                
                TempData["SuccessMessage"] = "Training activity deleted successfully.";
            }
            
            return RedirectToAction("Index");
        }
        
        // GET: CLIP/ActivityTraining/DownloadDocument/5
        public ActionResult DownloadDocument(Guid id)
        {
            var activity = db.ActivityTrainings.Find(id);
            if (activity == null || string.IsNullOrEmpty(activity.Document))
            {
                TempData["ErrorMessage"] = "Document not found.";
                return RedirectToAction("Index");
            }
            
            string uploadsFolder = Server.MapPath("~/Areas/CLIP/uploads/ActivityTraining");
            string filePath = Path.Combine(uploadsFolder, activity.Document);
            
            if (!System.IO.File.Exists(filePath))
            {
                TempData["ErrorMessage"] = "Document file not found.";
                return RedirectToAction("Index");
            }
            
            // Determine content type based on file extension
            string contentType = MimeMapping.GetMimeMapping(filePath);
            
            return File(filePath, contentType, "Document_" + activity.ActivityName + Path.GetExtension(filePath));
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
} 