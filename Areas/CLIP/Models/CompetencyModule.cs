using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web.Mvc;
using System.Web.Mvc.Html;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class CompetencyModule
    {
        public CompetencyModule()
        {
            UserCompetencies = new HashSet<UserCompetency>();
            UserPoints = new HashSet<UserPoint>();
        }

        public int Id { get; set; }
        
        [Required]
        [Index(IsUnique = true)]
        public string ModuleName { get; set; }
        
        public string Description { get; set; }
        
        public int? ValidityMonths { get; set; }
        
        public bool IsMandatory { get; set; }

        // Navigation properties
        public virtual ICollection<UserCompetency> UserCompetencies { get; set; }
        public virtual ICollection<UserPoint> UserPoints { get; set; }
    }
} 