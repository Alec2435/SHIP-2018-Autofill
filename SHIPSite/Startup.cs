using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SHIPAutofill.Startup))]
namespace SHIPAutofill
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
