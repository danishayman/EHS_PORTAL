using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel;
using System.Web.Mvc;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    public class CertificateOfFitness
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [Display(Name = "Plant")]
        public int PlantId { get; set; }

        [Required]
        [Display(Name = "Registration Number")]
        [Remote("IsRegistrationNoAvailable", "CertificateOfFitness", AdditionalFields = "Id", ErrorMessage = "This Registration Number is already in use.")]
        public string RegistrationNo { get; set; }

        [Required]
        [Display(Name = "Expiry Date")]
        [DataType(DataType.Date)]
        public DateTime ExpiryDate { get; set; }

        [Display(Name = "Machine Name")]
        public string MachineName { get; set; }

        [Display(Name = "Status")]
        public string Status { get; set; }

        [Display(Name = "Remarks")]
        public string Remarks { get; set; }

        [Display(Name = "PDF Document")]
        public string DocumentPath { get; set; }

        [Display(Name = "Location")]
        public string Location { get; set; }

        [Display(Name = "Host Info")]
        [Description("First time machine registered owner")]
        public string HostInfo { get; set; }

        [Display(Name = "Department")]
        public string Department { get; set; }

        [Display(Name = "Resident Info")]
        [Description("Machine current location/owner")]
        public string ResidentInfo { get; set; }

        public virtual Plant Plant { get; set; }
    }
} 