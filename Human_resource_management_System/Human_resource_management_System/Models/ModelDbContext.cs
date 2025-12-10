using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace Human_resource_management_System.Models
{
    public partial class ModelDbContext : DbContext
    {
        public ModelDbContext()
            : base("name=ModelDbContext")
        {
        }

        public virtual DbSet<BangLuong> BangLuongs { get; set; }
        public virtual DbSet<CaLamViec> CaLamViecs { get; set; }
        public virtual DbSet<ChamCong> ChamCongs { get; set; }
        public virtual DbSet<ChucVu> ChucVus { get; set; }
        public virtual DbSet<DonNghiPhep> DonNghiPheps { get; set; }
        public virtual DbSet<HopDongLaoDong> HopDongLaoDongs { get; set; }
        public virtual DbSet<LichLamViec> LichLamViecs { get; set; }
        public virtual DbSet<LoaiHopDong> LoaiHopDongs { get; set; }
        public virtual DbSet<LoaiNghiPhep> LoaiNghiPheps { get; set; }
        public virtual DbSet<LoaiPhuCap> LoaiPhuCaps { get; set; }
        public virtual DbSet<NhanVien> NhanViens { get; set; }
        public virtual DbSet<PhongBan> PhongBans { get; set; }
        public virtual DbSet<PhuCapNhanVien> PhuCapNhanViens { get; set; }
        public virtual DbSet<TaiKhoan> TaiKhoans { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BangLuong>()
                .Property(e => e.luongCoBan)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.thuongHieuQua)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.luongTangCa)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.khauTru)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.bhxh)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.thueTNCN)
                .HasPrecision(15, 2);

            modelBuilder.Entity<BangLuong>()
                .Property(e => e.tongLuong)
                .HasPrecision(20, 2);

            modelBuilder.Entity<CaLamViec>()
                .Property(e => e.heSoLuong)
                .HasPrecision(3, 2);

            modelBuilder.Entity<CaLamViec>()
                .HasMany(e => e.LichLamViecs)
                .WithRequired(e => e.CaLamViec)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ChamCong>()
                .Property(e => e.soGioLam)
                .HasPrecision(4, 2);

            modelBuilder.Entity<ChamCong>()
                .Property(e => e.soGioTangCa)
                .HasPrecision(4, 2);

            modelBuilder.Entity<ChucVu>()
                .Property(e => e.mucLuongCoSo)
                .HasPrecision(15, 2);

            modelBuilder.Entity<ChucVu>()
                .HasMany(e => e.NhanViens)
                .WithRequired(e => e.ChucVu)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<HopDongLaoDong>()
                .Property(e => e.luongCoBan)
                .HasPrecision(15, 2);

            modelBuilder.Entity<LoaiHopDong>()
                .HasMany(e => e.HopDongLaoDongs)
                .WithRequired(e => e.LoaiHopDong)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LoaiNghiPhep>()
                .HasMany(e => e.DonNghiPheps)
                .WithRequired(e => e.LoaiNghiPhep)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LoaiPhuCap>()
                .Property(e => e.soTien)
                .HasPrecision(15, 2);

            modelBuilder.Entity<LoaiPhuCap>()
                .HasMany(e => e.PhuCapNhanViens)
                .WithRequired(e => e.LoaiPhuCap)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.BangLuongs)
                .WithRequired(e => e.NhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.ChamCongs)
                .WithRequired(e => e.NhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.DonNghiPheps)
                .WithOptional(e => e.NhanVien)
                .HasForeignKey(e => e.nguoiDuyet);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.DonNghiPheps1)
                .WithRequired(e => e.NhanVien1)
                .HasForeignKey(e => e.maNhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.HopDongLaoDongs)
                .WithRequired(e => e.NhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.LichLamViecs)
                .WithRequired(e => e.NhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhanVien>()
                .HasMany(e => e.PhuCapNhanViens)
                .WithRequired(e => e.NhanVien)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PhongBan>()
                .HasMany(e => e.NhanViens)
                .WithRequired(e => e.PhongBan)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PhuCapNhanVien>()
                .Property(e => e.soTien)
                .HasPrecision(15, 2);
        }
    }
}
