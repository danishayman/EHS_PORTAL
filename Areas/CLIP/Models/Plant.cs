using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class Plant
    {
        public Plant()
        {
            UserPlants = new HashSet<UserPlant>();
            PlantMonitorings = new HashSet<PlantMonitoring>();
        }

        public int Id { get; set; }
        
        [Required]
        [StringLength(100)]
        public string PlantName { get; set; }
        
        // Navigation properties
        public virtual ICollection<UserPlant> UserPlants { get; set; }
        public virtual ICollection<PlantMonitoring> PlantMonitorings { get; set; }
    }
} 