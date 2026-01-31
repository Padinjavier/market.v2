using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace market.Models
{
    [Table("modules")]
    public class Module
    {
        [Key]
        public long ModuleId { get; set; } // module_id

        [Required]
        [StringLength(50)]
        public string Title { get; set; } = string.Empty;

        public string? Description { get; set; }

        [Required]
        public int Status { get; set; } = 1;
    }
}