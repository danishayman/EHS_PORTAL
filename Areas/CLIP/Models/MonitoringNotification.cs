using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    /// <summary>
    /// Represents a notification for plant monitoring
    /// </summary>
    public class MonitoringNotification
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public string Link { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public NotificationType Type { get; set; }
        public int ItemId { get; set; }
        public bool IsRead { get; set; } = false;
        
        // Helper properties for UI presentation
        public string IconClass 
        { 
            get { return GetIconClass(); }
        }
        
        public string BadgeClass
        {
            get { return GetBadgeClass(); }
        }

        private string GetIconClass()
        {
            switch (Type)
            {
                case NotificationType.Expiring:
                    return "fa-clock";
                case NotificationType.Assignment:
                    return "fa-tasks";
                case NotificationType.NextPhaseReady:
                    return "fa-arrow-right";
                case NotificationType.Overdue:
                    return "fa-exclamation-triangle";
                case NotificationType.PhaseComplete:
                    return "fa-check-circle";
                default:
                    return "fa-bell";
            }
        }

        private string GetBadgeClass()
        {
            switch (Type)
            {
                case NotificationType.Expiring:
                    return "bg-warning";
                case NotificationType.Assignment:
                    return "bg-info";
                case NotificationType.NextPhaseReady:
                    return "bg-primary";
                case NotificationType.Overdue:
                    return "bg-danger";
                case NotificationType.PhaseComplete:
                    return "bg-success";
                default:
                    return "bg-secondary";
            }
        }
    }
    
    public enum NotificationType
    {
        Expiring,        // When items are about to expire
        Assignment,      // Tasks assigned to the user
        NextPhaseReady,  // When previous phase is completed and next phase can begin
        Overdue,         // When items are past their due date
        PhaseComplete    // When a monitoring item is completed
    }
} 