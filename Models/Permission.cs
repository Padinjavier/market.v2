using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace market.Models
{
    [Table("permissions")]
    public class Permission
    {
        [Key]
        public long PermissionId { get; set; } // permission_id

        [Required]
        public long RoleId { get; set; }

        [Required]
        public long ModuleId { get; set; }

        public int CanRead { get; set; }
        public int CanWrite { get; set; }
        public int CanUpdate { get; set; }
        public int CanDelete { get; set; }
    }
}