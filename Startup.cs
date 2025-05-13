using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EHS_PORTAL.Startup))]
namespace EHS_PORTAL
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
