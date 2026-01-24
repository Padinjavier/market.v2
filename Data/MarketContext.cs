using Microsoft.EntityFrameworkCore;
using market.Models;

namespace market.Data
{
    public class MarketContext : DbContext
    {
        public MarketContext(DbContextOptions<MarketContext> options) : base(options) { }

        public DbSet<Persona> Personas { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
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
        }
    }
}