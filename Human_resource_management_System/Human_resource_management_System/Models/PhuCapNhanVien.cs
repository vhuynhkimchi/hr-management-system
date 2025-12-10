namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("PhuCapNhanVien")]
    public partial class PhuCapNhanVien
    {
        public int id { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        public int maPhuCap { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayBatDau { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ngayKetThuc { get; set; }

        public decimal soTien { get; set; }

        public virtual LoaiPhuCap LoaiPhuCap { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
