namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TaiKhoan")]
    public partial class TaiKhoan
    {
        [Key]
        public int maTaiKhoan { get; set; }

        [StringLength(20)]
        public string maNhanVien { get; set; }

        [Required]
        [StringLength(50)]
        public string tenDangNhap { get; set; }

        [Required]
        [StringLength(256)]
        public string matKhau { get; set; }

        [Required]
        [StringLength(20)]
        public string vaiTro { get; set; }

        public bool? trangThai { get; set; }

        public DateTime? lanDangNhapCuoi { get; set; }

        public DateTime? ngayTao { get; set; }

        public virtual NhanVien NhanVien { get; set; }
    }
}
