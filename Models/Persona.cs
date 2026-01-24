using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace market.Models
{
    [Table("personas")]
    public class Persona
    {
        [Key]
        public long Idpersona { get; set; }

        [StringLength(30)]
        public string? Identificacion { get; set; }

        [Required]
        [StringLength(80)]
        public string Nombres { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string Apellidos { get; set; } = string.Empty;

        [Required]
        public long Telefono { get; set; }

        [Required]
        [StringLength(100)]
        public string EmailUser { get; set; } = string.Empty;

        [Required]
        [StringLength(75)]
        public string Password { get; set; } = string.Empty;

        [StringLength(100)]
        public string? Token { get; set; }

        [Required]
        public long Rolid { get; set; }

        [StringLength(100)]
        public string? Direccion { get; set; }

        public long? DistritoId { get; set; }

        [Required]
        public DateTime Datecreated { get; set; } = DateTime.Now;

        [Required]
        public int Status { get; set; } = 1;
    }
}