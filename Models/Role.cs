using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace market.Models
{
    [Table("roles")]
    public class Role
    {
        [Key]
        public long RoleId { get; set; } // role_id

        [Required]
        [StringLength(50)]
        public string RoleName { get; set; } = string.Empty;

        public string? Description { get; set; }

        [Required]
        public int Status { get; set; } = 1;
    }
}