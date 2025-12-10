namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("HopDongLaoDong")]
    public partial class HopDongLaoDong
    {
        [Key]
        public int maHopDong { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        public int maLoaiHD { get; set; }

        [Required]
        [StringLength(50)]
        public string soHopDong { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayKy { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayBatDau { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ngayKetThuc { get; set; }

        public decimal luongCoBan { get; set; }

        [StringLength(20)]
        public string trangThai { get; set; }

        [StringLength(500)]
        public string ghiChu { get; set; }

        public virtual LoaiHopDong LoaiHopDong { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
