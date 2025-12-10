namespace Human_resource_management_System.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("NhanVien")]
    public partial class NhanVien
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NhanVien()
        {
            BangLuongs = new HashSet<BangLuong>();
            ChamCongs = new HashSet<ChamCong>();
            DonNghiPheps = new HashSet<DonNghiPhep>();
            DonNghiPheps1 = new HashSet<DonNghiPhep>();
            HopDongLaoDongs = new HashSet<HopDongLaoDong>();
            LichLamViecs = new HashSet<LichLamViec>();
            PhuCapNhanViens = new HashSet<PhuCapNhanVien>();
            TaiKhoans = new HashSet<TaiKhoan>();
        }

        [Key]
        [StringLength(20)]
        public string maNhanVien { get; set; }

        [Required]
        [StringLength(100)]
        public string hoTen { get; set; }

        [Required]
        [StringLength(10)]
        public string gioiTinh { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngaySinh { get; set; }

        [Required]
        [StringLength(20)]
        public string cccd { get; set; }

        [Required]
        [StringLength(15)]
        public string soDienThoai { get; set; }

        [StringLength(100)]
        public string email { get; set; }

        [StringLength(300)]
        public string diaChi { get; set; }

        [StringLength(500)]
        public string anhDaiDien { get; set; }

        public int maPhongBan { get; set; }

        public int maChucVu { get; set; }

        [Column(TypeName = "date")]
        public DateTime ngayVaoLam { get; set; }

        [StringLength(20)]
        public string trangThaiLamViec { get; set; }

        public DateTime? ngayTao { get; set; }

        public DateTime? ngayCapNhat { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BangLuong> BangLuongs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ChamCong> ChamCongs { get; set; }

        public virtual ChucVu ChucVu { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonNghiPhep> DonNghiPheps { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonNghiPhep> DonNghiPheps1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HopDongLaoDong> HopDongLaoDongs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LichLamViec> LichLamViecs { get; set; }

        public virtual PhongBan PhongBan { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PhuCapNhanVien> PhuCapNhanViens { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TaiKhoan> TaiKhoans { get; set; }
    }
}
