using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
        public bool IsRead { get; set; }
        
        // Helper properties for UI presentation
        public string IconClass 
        { 
            get
            {
                switch (Type)
                {
                    case NotificationType.Expiring:
                        return "fa-calendar-exclamation text-warning";
                    case NotificationType.Assignment:
                        return "fa-user-check text-info";
                    case NotificationType.PhaseComplete:
                        return "fa-check-circle text-success";
                    case NotificationType.NextPhaseReady:
                        return "fa-arrow-right text-primary";
                    case NotificationType.Overdue:
                        return "fa-exclamation-circle text-danger";
                    default:
                        return "fa-bell text-secondary";
                }
            }
        }
        
        public string BadgeClass
        {
            get
            {
                switch (Type)
                {
                    case NotificationType.Expiring:
                        return "bg-warning";
                    case NotificationType.Assignment:
                        return "bg-info";
                    case NotificationType.PhaseComplete:
                        return "bg-success";
                    case NotificationType.NextPhaseReady:
                        return "bg-primary";
                    case NotificationType.Overdue:
                        return "bg-danger";
                    default:
                        return "bg-secondary";
                }
            }
        }
    }
    
    public enum NotificationType
    {
        Expiring,
        Assignment,
        PhaseComplete,
        NextPhaseReady,
        Overdue
    }
} 