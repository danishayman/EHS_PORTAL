using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class PlantMonitoring
    {
        public int Id { get; set; }
        
        [Display(Name = "Plant")]
        public int PlantID { get; set; }
        
        [Display(Name = "Monitoring Type")]
        public int MonitoringID { get; set; }
        
        public string Area { get; set; }
        
        public string Remarks { get; set; }
        
        [Display(Name = "Expiry Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? ExpDate { get; set; }
        
        // Quotation Phase
        [Display(Name = "Quote Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? QuoteDate { get; set; }
        
        [Display(Name = "Quote Submit Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? QuoteSubmitDate { get; set; }
        
        [Display(Name = "Quote Complete Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? QuoteCompleteDate { get; set; }
        
        [Display(Name = "Quote Assigned To")]
        public string QuoteUserAssign { get; set; }
        
        [Display(Name = "Quote Document")]
        public string QuoteDoc { get; set; }
        
        // Preparation Phase
        [Display(Name = "EPR Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? EprDate { get; set; }
        
        [Display(Name = "EPR Submit Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? EprSubmitDate { get; set; }
        
        [Display(Name = "EPR Complete Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? EprCompleteDate { get; set; }
        
        [Display(Name = "EPR Assigned To")]
        public string EprUserAssign { get; set; }
        
        [Display(Name = "EPR Document")]
        public string EprDoc { get; set; }
        
        // Work Execution Phase
        [Display(Name = "Work Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? WorkDate { get; set; }
        
        [Display(Name = "Work Submit Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? WorkSubmitDate { get; set; }
        
        [Display(Name = "Work Complete Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? WorkCompleteDate { get; set; }
        
        [Display(Name = "Work Assigned To")]
        public string WorkUserAssign { get; set; }
        
        [Display(Name = "Work Document")]
        public string WorkDoc { get; set; }
        
        // Navigation Properties
        [ForeignKey("PlantID")]
        public virtual Plant Plant { get; set; }
        
        [ForeignKey("MonitoringID")]
        public virtual Monitoring Monitoring { get; set; }

        // Helper properties for status determination  
        [NotMapped]
        public string Status
        {
            get
            {
                if (WorkCompleteDate.HasValue)
                    return "Completed";
                else if (WorkDate.HasValue)
                    return "In Progress";
                else if (EprDate.HasValue)
                    return "In Preparation";
                else if (QuoteDate.HasValue)
                    return "In Quotation";
                else
                    return "Not Started";
            }
        }

        [NotMapped]
        public string StatusCssClass
        {
            get
            {
                switch (Status)
                {
                    case "Completed":
                        return "bg-success";
                    case "In Progress":
                        return "bg-warning";
                    case "In Preparation":
                        return "bg-warning";
                    case "In Quotation":
                        return "bg-secondary";
                    default:
                        return "";
                }
            }
        }
    }
} 