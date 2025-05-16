using System;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

// This file creates aliases for identity classes from the CLIP area
// so they can be used from the root namespace with proper interface implementations
namespace EHS_PORTAL
{
    // Alias for ApplicationUser with proper IUser<string> implementation
    public class ApplicationUser : EHS_PORTAL.Areas.CLIP.Models.ApplicationUser, IUser<string>
    {
    }

    // Alias for ApplicationDbContext with proper DbContext implementation
    public class ApplicationDbContext : EHS_PORTAL.Areas.CLIP.Models.ApplicationDbContext, IDisposable
    {
        public new static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }
    }
} 