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
            // Special route for Admin pages
            context.MapRoute(
                "FETS_Admin",
                "FETS/ActivityLogs",
                new { controller = "Admin", action = "ActivityLogs" }
            );

            // Special route for MapLayout/ViewMap
            context.MapRoute(
                "FETS_ViewMap",
                "FETS/ViewMap",
                new { controller = "MapLayout", action = "ViewMap" }
            );

            // Default route for FETS pages
            context.MapRoute(
                "FETS_default",
                "FETS/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );

            // Route for simple page access (FETS/PageName)
            context.MapRoute(
                "FETS_pages",
                "FETS/{pageName}",
                new { controller = "{pageName}", action = "Index" },
                new { pageName = @"^(?!ActivityLogs|ViewMap).*$" }  // Exclude pages with special routes
            );
        }
    }
} 