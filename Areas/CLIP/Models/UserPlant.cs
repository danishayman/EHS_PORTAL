using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class UserPlant
    {
        public int Id { get; set; }
        
        [Required]
        public string UserId { get; set; }
        
        [Required]
        public int PlantId { get; set; }
        
        // Navigation properties - using convention-based approach
        // Entity Framework will recognize UserId -> User relationship automatically
        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }
        
        // Entity Framework will recognize PlantId -> Plant relationship automatically
        [ForeignKey("PlantId")]
        public virtual Plant Plant { get; set; }
    }
} 