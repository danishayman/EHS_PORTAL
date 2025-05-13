using System;
using System.ComponentModel.DataAnnotations;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class UserCompetency
    {
        public int Id { get; set; }
        
        [Required]
        public string UserId { get; set; }
        
        [Required]
        public int CompetencyModuleId { get; set; }
        
        [Required]
        [StringLength(50)]
        public string Status { get; set; } // 'Not Started', 'In Progress', 'Completed', 'Expired'
        
        public DateTime? CompletionDate { get; set; }
        
        public DateTime? ExpiryDate { get; set; }
        
        public string Remarks { get; set; }
        
        public string Building { get; set; }

        public virtual ApplicationUser User { get; set; }
        
        public virtual CompetencyModule CompetencyModule { get; set; }
    }
} 