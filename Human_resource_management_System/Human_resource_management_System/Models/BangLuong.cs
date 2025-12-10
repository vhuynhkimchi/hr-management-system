namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BangLuong")]
    public partial class BangLuong
    {
        [Key]
        public int maBangLuong { get; set; }

        [Required]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        public int thang { get; set; }

        public int nam { get; set; }

        public decimal luongCoBan { get; set; }

        public decimal? thuongHieuQua { get; set; }

        public decimal? luongTangCa { get; set; }

        public decimal? khauTru { get; set; }

        public decimal? bhxh { get; set; }

        public decimal? thueTNCN { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public decimal? tongLuong { get; set; }

        [StringLength(20)]
        public string trangThai { get; set; }

        public DateTime? ngayThanhToan { get; set; }

        [StringLength(300)]
        public string ghiChu { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
