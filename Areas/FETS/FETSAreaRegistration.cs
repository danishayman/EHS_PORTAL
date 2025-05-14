using System.Web.Mvc;

namespace EHS_PORTAL.Areas.FETS
{
    public class FETSAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get { return "FETS"; }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "FETS_default",
                "FETS/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
} 