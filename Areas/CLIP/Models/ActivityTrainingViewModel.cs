using System;
using System.ComponentModel.DataAnnotations;
using System.Web;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class ActivityTrainingViewModel
    {
        [Required]
        [Display(Name = "Activity Name")]
        public string ActivityName { get; set; }

        [Required]
        [Display(Name = "Activity Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime ActivityDate { get; set; }

        [Display(Name = "Supporting Document")]
        public HttpPostedFileBase DocumentFile { get; set; }

        [Display(Name = "CEP Points")]
        [Range(0, 100, ErrorMessage = "CEP Points must be between 0 and 100")]
        public int? CEPPointsGained { get; set; }

        [Display(Name = "CPD Points")]
        [Range(0, 100, ErrorMessage = "CPD Points must be between 0 and 100")]
        public int? CPDPointsGained { get; set; }
    }
} 