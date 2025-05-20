using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class ActivityTraining
    {
        [Key]
        public Guid Id { get; set; }

        [Required]
        public string UserId { get; set; }

        [Required]
        [Display(Name = "Activity Name")]
        public string ActivityName { get; set; }

        [Required]
        [Display(Name = "Activity Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime ActivityDate { get; set; }

        [Display(Name = "Document")]
        public string Document { get; set; }

        [Display(Name = "CEP Points")]
        public int? CEPPointsGained { get; set; }

        [Display(Name = "CPD Points")]
        public int? CPDPointsGained { get; set; }

        [ForeignKey("UserId")]
        public virtual ApplicationUser User { get; set; }
    }
} 