using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using EHS_PORTAL.Areas.CLIP.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

// This file creates aliases for identity classes from the CLIP area
// so they can be used from the root namespace
namespace EHS_PORTAL
{
    // Root namespace ApplicationUser - inherits from CLIP.Models.ApplicationUser
    [NotMapped]
    public class ApplicationUser : Areas.CLIP.Models.ApplicationUser
    {
        // Override the GenerateUserIdentityAsync method to work with the root UserManager
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Convert to area user for identity generation
            var areaUser = this;
            var areaManager = (UserManager<Areas.CLIP.Models.ApplicationUser>)(object)manager;
            
            // Use the area user's identity generation method
            return await ((Areas.CLIP.Models.ApplicationUser)this).GenerateUserIdentityAsync(areaManager);
        }
        
        // Extension method to convert root type to area type
        public Areas.CLIP.Models.ApplicationUser ToAreaUser()
        {
            return this;
        }
    }

    // Root namespace ApplicationDbContext - inherits from CLIP.Models.ApplicationDbContext
    public class ApplicationDbContext : Areas.CLIP.Models.ApplicationDbContext
    {
        // Add static Create method to match what's expected
        public new static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        // Override OnModelCreating to avoid mapping the root ApplicationUser
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            
            // Ignore the root ApplicationUser to prevent duplicate mapping
            modelBuilder.Ignore<ApplicationUser>();
        }
    }
} 