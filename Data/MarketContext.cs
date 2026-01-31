using Microsoft.EntityFrameworkCore;
using market.Models;

namespace market.Data
{
    public class MarketContext : DbContext
    {
        public MarketContext(DbContextOptions<MarketContext> options) : base(options) { }

        public DbSet<Persona> Personas { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Module> Modules { get; set; }
        public DbSet<Permission> Permissions { get; set; }
        public DbSet<Role> Roles { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Mapping for legacy/personas
            modelBuilder.Entity<Persona>(entity =>
            {
                entity.HasKey(e => e.Idpersona);
                entity.Property(e => e.Idpersona).HasColumnName("idpersona");
                entity.Property(e => e.Identificacion).HasColumnName("identificacion");
                entity.Property(e => e.Nombres).HasColumnName("nombres");
                entity.Property(e => e.Apellidos).HasColumnName("apellidos");
                entity.Property(e => e.Telefono).HasColumnName("telefono");
                entity.Property(e => e.EmailUser).HasColumnName("email_user");
                entity.Property(e => e.Password).HasColumnName("password");
                entity.Property(e => e.Token).HasColumnName("token");
                entity.Property(e => e.Rolid).HasColumnName("rolid");
                entity.Property(e => e.Direccion).HasColumnName("direccion");
                entity.Property(e => e.DistritoId).HasColumnName("distrito_id");
                entity.Property(e => e.Datecreated).HasColumnName("datecreated");
                entity.Property(e => e.Status).HasColumnName("status");
            });

            // Nuevo mapping para users (DB actualizada)
            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.UserId);
                entity.Property(e => e.UserId).HasColumnName("user_id");
                entity.Property(e => e.Identification).HasColumnName("identification");
                entity.Property(e => e.FirstName).HasColumnName("first_name");
                entity.Property(e => e.MiddleName).HasColumnName("middle_name");
                entity.Property(e => e.LastName).HasColumnName("last_name");
                entity.Property(e => e.SecondLastName).HasColumnName("second_last_name");
                entity.Property(e => e.Phone).HasColumnName("phone");
                entity.Property(e => e.Email).HasColumnName("email");
                entity.Property(e => e.PasswordHash).HasColumnName("password_hash");
                entity.Property(e => e.RememberToken).HasColumnName("remember_token");
                entity.Property(e => e.RoleId).HasColumnName("role_id");
                entity.Property(e => e.Address).HasColumnName("address");
                entity.Property(e => e.DistrictId).HasColumnName("district_id");
                entity.Property(e => e.CreatedAt).HasColumnName("created_at");
                entity.Property(e => e.Status).HasColumnName("status");
            });

            modelBuilder.Entity<Module>(entity =>
            {
                entity.HasKey(e => e.ModuleId);
                entity.Property(e => e.ModuleId).HasColumnName("module_id");
                entity.Property(e => e.Title).HasColumnName("title");
                entity.Property(e => e.Description).HasColumnName("description");
                entity.Property(e => e.Status).HasColumnName("status");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.HasKey(e => e.RoleId);
                entity.Property(e => e.RoleId).HasColumnName("role_id");
                entity.Property(e => e.RoleName).HasColumnName("role_name");
                entity.Property(e => e.Description).HasColumnName("description");
                entity.Property(e => e.Status).HasColumnName("status");
            });

            modelBuilder.Entity<Permission>(entity =>
            {
                entity.HasKey(e => e.PermissionId);
                entity.Property(e => e.PermissionId).HasColumnName("permission_id");
                entity.Property(e => e.RoleId).HasColumnName("role_id");
                entity.Property(e => e.ModuleId).HasColumnName("module_id");
                entity.Property(e => e.CanRead).HasColumnName("can_read");
                entity.Property(e => e.CanWrite).HasColumnName("can_write");
                entity.Property(e => e.CanUpdate).HasColumnName("can_update");
                entity.Property(e => e.CanDelete).HasColumnName("can_delete");
            });
        }
    }
}