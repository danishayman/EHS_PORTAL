using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class UserPoint
    {
        public int Id { get; set; }
        
        [Required]
        public string UserId { get; set; }
        
        [Required]
        public int CompetencyModuleId { get; set; }
        
        public int? PointsEarned { get; set; }
        
        public int? PointsRemaining { get; set; }
        
        public DateTime? LastEvaluatedDate { get; set; }

        // Navigation properties - using convention-based approach
        // Entity Framework will recognize UserId -> User relationship automatically
        public virtual ApplicationUser User { get; set; }
        
        // Entity Framework will recognize CompetencyModuleId -> CompetencyModule relationship automatically
        public virtual CompetencyModule CompetencyModule { get; set; }
    }
} 