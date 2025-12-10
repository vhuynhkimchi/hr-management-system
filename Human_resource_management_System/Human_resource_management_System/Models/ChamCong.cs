namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ChamCong")]
    public partial class ChamCong
    {
        [Key]
        public int maChamCong { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayLamViec { get; set; }

        public TimeSpan? gioVao { get; set; }

        public TimeSpan? gioRa { get; set; }

        [Required]
        [StringLength(30)]
        public string trangThai { get; set; }

        public decimal? soGioLam { get; set; }

        public decimal? soGioTangCa { get; set; }

        [StringLength(300)]
        public string ghiChu { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
