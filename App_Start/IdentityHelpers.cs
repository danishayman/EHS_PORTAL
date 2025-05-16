using System;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using EHS_PORTAL.Areas.CLIP.Models;

namespace EHS_PORTAL
{
    /// <summary>
    /// Helper utilities for working with ASP.NET Identity types
    /// </summary>
    public static class IdentityHelpers
    {
        /// <summary>
        /// Helper method to safely convert between user types
        /// </summary>
        public static ApplicationUser ToRootUser(this Areas.CLIP.Models.ApplicationUser user)
        {
            if (user == null) return null;
            
            // If it's already the correct type, just return it
            if (user is ApplicationUser rootUser)
                return rootUser;
                
            // Otherwise create a new wrapper
            return new ApplicationUser
            {
                Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                PasswordHash = user.PasswordHash,
                SecurityStamp = user.SecurityStamp,
                PhoneNumber = user.PhoneNumber,
                PhoneNumberConfirmed = user.PhoneNumberConfirmed,
                TwoFactorEnabled = user.TwoFactorEnabled,
                LockoutEndDateUtc = user.LockoutEndDateUtc,
                LockoutEnabled = user.LockoutEnabled,
                AccessFailedCount = user.AccessFailedCount,
                EmpID = user.EmpID
            };
        }
        
        /// <summary>
        /// Helper method to convert root user back to area user
        /// </summary>
        public static Areas.CLIP.Models.ApplicationUser ToAreaUser(this ApplicationUser user)
        {
            if (user == null) return null;
            
            // If it's not a wrapper, create a new area user
            var areaUser = new Areas.CLIP.Models.ApplicationUser
            {
                Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                PasswordHash = user.PasswordHash,
                SecurityStamp = user.SecurityStamp,
                PhoneNumber = user.PhoneNumber,
                PhoneNumberConfirmed = user.PhoneNumberConfirmed,
                TwoFactorEnabled = user.TwoFactorEnabled,
                LockoutEndDateUtc = user.LockoutEndDateUtc,
                LockoutEnabled = user.LockoutEnabled,
                AccessFailedCount = user.AccessFailedCount,
                EmpID = user.EmpID
            };
            
            return areaUser;
        }
    }
} 