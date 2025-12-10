namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LoaiPhuCap")]
    public partial class LoaiPhuCap
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LoaiPhuCap()
        {
            PhuCapNhanViens = new HashSet<PhuCapNhanVien>();
        }

        [Key]
        public int maPhuCap { get; set; }

        [Required]
        [StringLength(100)]
        public string tenPhuCap { get; set; }

        public decimal soTien { get; set; }

        [StringLength(300)]
        public string moTa { get; set; }

        public bool? trangThai { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PhuCapNhanVien> PhuCapNhanViens { get; set; }
    }
}
