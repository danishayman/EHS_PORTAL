using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

// This file creates aliases for identity classes from the CLIP area
// so they can be used from the root namespace
namespace EHS_PORTAL
{
    // Alias for ApplicationUser
    public class ApplicationUser : EHS_PORTAL.Areas.CLIP.Models.ApplicationUser
    {
    }

    // Alias for ApplicationDbContext
    public class ApplicationDbContext : EHS_PORTAL.Areas.CLIP.Models.ApplicationDbContext
    {
    }
} 