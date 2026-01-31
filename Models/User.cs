using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace market.Models
{
    [Table("users")]
    public class User
    {
        [Key]
        public long UserId { get; set; } // maps to user_id

        [StringLength(30)]
        public string? Identification { get; set; }

        [Required]
        [StringLength(50)]
        public string FirstName { get; set; } = string.Empty;

        [StringLength(50)]
        public string? MiddleName { get; set; }

        [Required]
        [StringLength(50)]
        public string LastName { get; set; } = string.Empty;

        [StringLength(50)]
        public string? SecondLastName { get; set; }

        [Required]
        [StringLength(20)]
        public string Phone { get; set; } = string.Empty;

        [Required]
        [StringLength(100)]
        public string Email { get; set; } = string.Empty;

        [Required]
        [StringLength(255)]
        public string PasswordHash { get; set; } = string.Empty;

        public string? RememberToken { get; set; }

        [Required]
        public long RoleId { get; set; }

        [StringLength(100)]
        public string? Address { get; set; }

        public long? DistrictId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;

        [Required]
        public int Status { get; set; } = 1;
    }
}