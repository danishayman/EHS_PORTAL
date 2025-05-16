using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class MonitoringDocument
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        public int PlantMonitoringId { get; set; }

        [Required]
        [StringLength(500)]
        [Display(Name = "Document Path")]
        public string DocumentPath { get; set; }

        [Required]
        [StringLength(255)]
        [Display(Name = "Original Filename")]
        public string OriginalFilename { get; set; }

        [StringLength(100)]
        [Display(Name = "Content Type")]
        public string ContentType { get; set; }

        [Display(Name = "Upload Date")]
        public DateTime UploadDate { get; set; }

        [StringLength(50)]
        [Display(Name = "Document Type")]
        public string DocumentType { get; set; }

        // Navigation property
        [ForeignKey("PlantMonitoringId")]
        public virtual PlantMonitoring PlantMonitoring { get; set; }
    }
} 