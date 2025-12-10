namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LoaiHopDong")]
    public partial class LoaiHopDong
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LoaiHopDong()
        {
            HopDongLaoDongs = new HashSet<HopDongLaoDong>();
        }

        [Key]
        public int maLoaiHD { get; set; }

        [Required]
        [StringLength(100)]
        public string tenLoaiHD { get; set; }

        [StringLength(500)]
        public string moTa { get; set; }

        public int? thoiHan { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HopDongLaoDong> HopDongLaoDongs { get; set; }
    }
}
