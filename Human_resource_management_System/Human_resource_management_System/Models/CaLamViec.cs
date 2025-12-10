namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CaLamViec")]
    public partial class CaLamViec
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CaLamViec()
        {
            LichLamViecs = new HashSet<LichLamViec>();
        }

        [Key]
        public int maCa { get; set; }

        [Required]
        [StringLength(50)]
        public string tenCa { get; set; }

        public TimeSpan gioBatDau { get; set; }

        public TimeSpan gioKetThuc { get; set; }

        [StringLength(200)]
        public string moTa { get; set; }

        public decimal? heSoLuong { get; set; }

        public bool? trangThai { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LichLamViec> LichLamViecs { get; set; }
    }
}
