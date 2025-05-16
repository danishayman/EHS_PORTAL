using System.Web.Mvc;

namespace EHS_PORTAL.Areas.CLIP
{
    public class CLIPAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "CLIP";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "CLIP_default",
                "CLIP/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
