﻿using System.Collections.Generic;
using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace EHS_PORTAL.Areas.CLIP.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit https://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public ApplicationUser()
        {
            UserPlants = new HashSet<UserPlant>();
            UserCompetencies = new HashSet<UserCompetency>();
        }

        public string EmpID { get; set; }

        // Navigation properties
        public virtual ICollection<UserPlant> UserPlants { get; set; }
        public virtual ICollection<UserCompetency> UserCompetencies { get; set; }

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        public DbSet<CompetencyModule> CompetencyModules { get; set; }
        public DbSet<UserCompetency> UserCompetencies { get; set; }
        public DbSet<Plant> Plants { get; set; }
        public DbSet<UserPlant> UserPlants { get; set; }
        public DbSet<AreaPlant> AreaPlants { get; set; }
        public DbSet<CertificateOfFitness> CertificateOfFitness { get; set; }
        public DbSet<Monitoring> Monitorings { get; set; }
        public DbSet<PlantMonitoring> PlantMonitorings { get; set; }
        public DbSet<MonitoringDocument> MonitoringDocuments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure UserCompetency relationships
            modelBuilder.Entity<UserCompetency>()
                .HasRequired(uc => uc.User)
                .WithMany(u => u.UserCompetencies)
                .HasForeignKey(uc => uc.UserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserCompetency>()
                .HasRequired(uc => uc.CompetencyModule)
                .WithMany(cm => cm.UserCompetencies)
                .HasForeignKey(uc => uc.CompetencyModuleId)
                .WillCascadeOnDelete(false);

            // Configure UserPlant relationships
            modelBuilder.Entity<UserPlant>()
                .HasRequired(up => up.User)
                .WithMany(u => u.UserPlants)
                .HasForeignKey(up => up.UserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<UserPlant>()
                .HasRequired(up => up.Plant)
                .WithMany(p => p.UserPlants)
                .HasForeignKey(up => up.PlantId)
                .WillCascadeOnDelete(false);

            // Configure unique constraint for CompetencyModule.ModuleName
            modelBuilder.Entity<CompetencyModule>()
                .Property(c => c.ModuleName)
                .IsRequired()
                .HasMaxLength(256);
                
            modelBuilder.Entity<CompetencyModule>()
                .HasIndex(c => c.ModuleName)
                .IsUnique();

            // Configure CertificateOfFitness relationships
            modelBuilder.Entity<CertificateOfFitness>()
                .ToTable("CertificateOfFitness")
                .HasRequired(cf => cf.Plant)
                .WithMany()
                .HasForeignKey(cf => cf.PlantId)
                .WillCascadeOnDelete(false);
            
            // Configure PlantMonitoring relationships
            modelBuilder.Entity<PlantMonitoring>()
                .HasRequired(pm => pm.Plant)
                .WithMany()
                .HasForeignKey(pm => pm.PlantID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PlantMonitoring>()
                .HasRequired(pm => pm.Monitoring)
                .WithMany(m => m.PlantMonitorings)
                .HasForeignKey(pm => pm.MonitoringID)
                .WillCascadeOnDelete(false);

            // Configure Monitoring table name
            modelBuilder.Entity<Monitoring>()
                .ToTable("Monitoring");
            
            // Configure PlantMonitoring table name
            modelBuilder.Entity<PlantMonitoring>()
                .ToTable("PlantMonitoring");
                
            // Configure MonitoringDocument relationships
            modelBuilder.Entity<MonitoringDocument>()
                .ToTable("MonitoringDocument")
                .HasRequired(md => md.PlantMonitoring)
                .WithMany()
                .HasForeignKey(md => md.PlantMonitoringId)
                .WillCascadeOnDelete(false);
        }
    }
}