namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DonNghiPhep")]
    public partial class DonNghiPhep
    {
        [Key]
        public int maDon { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        public int maLoaiNP { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayBatDau { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayKetThuc { get; set; }

        public int soNgayNghi { get; set; }

        [Required]
        [StringLength(500)]
        public string lyDo { get; set; }

        [StringLength(20)]
        public string trangThai { get; set; }

        [StringLength(20)]
        public string nguoiDuyet { get; set; }

        public DateTime? ngayDuyet { get; set; }

        [StringLength(300)]
        public string ghiChu { get; set; }

        public DateTime? ngayTao { get; set; }

        public virtual LoaiNghiPhep LoaiNghiPhep { get; set; }

        public virtual NhanVien NhanVien { get; set; }

        public virtual NhanVien NhanVien1 { get; set; }
    }
}
