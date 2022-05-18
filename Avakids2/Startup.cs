using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Avakids2.Startup))]
namespace Avakids2
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
