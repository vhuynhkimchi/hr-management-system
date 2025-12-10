namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LoaiNghiPhep")]
    public partial class LoaiNghiPhep
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LoaiNghiPhep()
        {
            DonNghiPheps = new HashSet<DonNghiPhep>();
        }

        [Key]
        public int maLoaiNP { get; set; }

        [Required]
        [StringLength(100)]
        public string tenLoaiNP { get; set; }

        public int soNgayToiDa { get; set; }

        public bool? coLuong { get; set; }

        [StringLength(300)]
        public string moTa { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonNghiPhep> DonNghiPheps { get; set; }
    }
}
