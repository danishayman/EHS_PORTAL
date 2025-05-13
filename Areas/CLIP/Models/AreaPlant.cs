using System.ComponentModel.DataAnnotations;
// Remove conflicting namespaces
// using System.ComponentModel.DataAnnotations.Schema;
// using SchemaAttr = System.ComponentModel.DataAnnotations.Schema;
// using System.Data.Entity.ModelConfiguration.Conventions;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class AreaPlant
    {
        public int Id { get; set; }
        
        [Required]
        [StringLength(100)]
        public string AreaName { get; set; }
        
        public int PlantId { get; set; }
        
        // Navigation property - using naming convention instead of attribute
        // Entity Framework will recognize the naming convention PlantId -> Plant
        public virtual Plant Plant { get; set; }
    }
} 