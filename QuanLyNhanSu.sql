-- =====================================================
-- Hệ thống Quản lý Nhân sự Resort
-- Tạo Database
CREATE DATABASE QuanLyNhanSu;
GO
USE QuanLyNhanSu;
GO

-- =====================================================
-- 1. BẢNG PHÒNG BAN (Departments)
-- =====================================================
CREATE TABLE PhongBan (
    maPhongBan INT IDENTITY(1,1) PRIMARY KEY,
    tenPhongBan NVARCHAR(100) NOT NULL UNIQUE,
    moTa NVARCHAR(500),
    ngayThanhLap DATE DEFAULT GETDATE(),
    trangThai BIT DEFAULT 1,
    
    CONSTRAINT CK_PhongBan_TenPhongBan CHECK (LEN(TRIM(tenPhongBan)) >= 2)
);
GO

-- =====================================================
-- 2. BẢNG CHỨC VỤ (Positions)
-- =====================================================
CREATE TABLE ChucVu (
    maChucVu INT IDENTITY(1,1) PRIMARY KEY,
    tenChucVu NVARCHAR(100) NOT NULL UNIQUE,
    moTa NVARCHAR(500),
    mucLuongCoSo DECIMAL(15,2) NOT NULL CHECK (mucLuongCoSo >= 0),
    trangThai BIT DEFAULT 1
);
GO

-- =====================================================
-- 3. BẢNG LOẠI HỢP ĐỒNG (Contract Types)
-- =====================================================
CREATE TABLE LoaiHopDong (
    maLoaiHD INT IDENTITY(1,1) PRIMARY KEY,
    tenLoaiHD NVARCHAR(100) NOT NULL UNIQUE,
    moTa NVARCHAR(500),
    thoiHan INT,
    
    CONSTRAINT CK_LoaiHopDong_ThoiHan CHECK (thoiHan IS NULL OR thoiHan > 0)
);
GO

-- =====================================================
-- 4. BẢNG NHÂN VIÊN (Employees) - BẢNG CHÍNH
-- =====================================================
CREATE TABLE NhanVien (
    maNhanVien NVARCHAR(20) PRIMARY KEY,
    hoTen NVARCHAR(100) NOT NULL,
    gioiTinh NVARCHAR(10) NOT NULL,
    ngaySinh DATE NOT NULL,
    cccd NVARCHAR(20) NOT NULL UNIQUE,
    soDienThoai NVARCHAR(15) NOT NULL,
    email NVARCHAR(100),
    diaChi NVARCHAR(300),
    anhDaiDien NVARCHAR(500),
    
    maPhongBan INT NOT NULL,
    maChucVu INT NOT NULL,
    ngayVaoLam DATE NOT NULL DEFAULT GETDATE(),
    trangThaiLamViec NVARCHAR(20) DEFAULT N'Đang làm việc',
    
    ngayTao DATETIME DEFAULT GETDATE(),
    ngayCapNhat DATETIME,
    
    CONSTRAINT FK_NhanVien_PhongBan FOREIGN KEY (maPhongBan) 
        REFERENCES PhongBan(maPhongBan),
    CONSTRAINT FK_NhanVien_ChucVu FOREIGN KEY (maChucVu) 
        REFERENCES ChucVu(maChucVu),
    
    CONSTRAINT CK_NhanVien_GioiTinh CHECK (gioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    CONSTRAINT CK_NhanVien_NgaySinh CHECK (ngaySinh <= DATEADD(YEAR, -18, GETDATE())),
    CONSTRAINT CK_NhanVien_CCCD CHECK (LEN(cccd) IN (9, 12)),
    CONSTRAINT CK_NhanVien_SDT CHECK (soDienThoai LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
    CONSTRAINT CK_NhanVien_Email CHECK (email IS NULL OR email LIKE '%@%.%'),
    CONSTRAINT CK_NhanVien_TrangThai CHECK (trangThaiLamViec IN 
        (N'Đang làm việc', N'Nghỉ phép', N'Nghỉ việc', N'Tạm nghỉ'))
);
GO

-- =====================================================
-- 5. BẢNG HỢP ĐỒNG LAO ĐỘNG (Labor Contracts)
-- =====================================================
CREATE TABLE HopDongLaoDong (
    maHopDong INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    maLoaiHD INT NOT NULL,
    soHopDong NVARCHAR(50) NOT NULL UNIQUE,
    ngayKy DATE NOT NULL DEFAULT GETDATE(),
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE,
    luongCoBan DECIMAL(15,2) NOT NULL,
    trangThai NVARCHAR(20) DEFAULT N'Hiệu lực',
    ghiChu NVARCHAR(500),
    
    CONSTRAINT FK_HopDong_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    CONSTRAINT FK_HopDong_LoaiHD FOREIGN KEY (maLoaiHD) 
        REFERENCES LoaiHopDong(maLoaiHD),
    
    CONSTRAINT CK_HopDong_Ngay CHECK (ngayKetThuc IS NULL OR ngayKetThuc > ngayBatDau),
    CONSTRAINT CK_HopDong_Luong CHECK (luongCoBan > 0),
    CONSTRAINT CK_HopDong_TrangThai CHECK (trangThai IN 
        (N'Hiệu lực', N'Hết hạn', N'Chấm dứt', N'Tạm hoãn'))
);
GO

-- =====================================================
-- 6. BẢNG CHẤM CÔNG (Attendance)
-- =====================================================
CREATE TABLE ChamCong (
    maChamCong INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    ngayLamViec DATE NOT NULL,
    gioVao TIME,
    gioRa TIME,
    trangThai NVARCHAR(30) NOT NULL,
    soGioLam DECIMAL(4,2),
    soGioTangCa DECIMAL(4,2) DEFAULT 0,
    ghiChu NVARCHAR(300),
    
    CONSTRAINT FK_ChamCong_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    
    CONSTRAINT UQ_ChamCong_NV_Ngay UNIQUE (maNhanVien, ngayLamViec),
    -- Không check gioRa > gioVao vì ca đêm có gioVao > gioRa (ví dụ: 22:00 -> 06:00)
    CONSTRAINT CK_ChamCong_SoGio CHECK (soGioLam IS NULL OR soGioLam BETWEEN 0 AND 24),
    CONSTRAINT CK_ChamCong_TrangThai CHECK (trangThai IN 
        (N'Đi làm', N'Nghỉ phép', N'Nghỉ không phép', N'Đi trễ', N'Về sớm', N'Nghỉ bệnh', N'Công tác'))
);
GO

-- =====================================================
-- 7. BẢNG LOẠI NGHỈ PHÉP (Leave Types)
-- =====================================================
CREATE TABLE LoaiNghiPhep (
    maLoaiNP INT IDENTITY(1,1) PRIMARY KEY,
    tenLoaiNP NVARCHAR(100) NOT NULL UNIQUE,
    soNgayToiDa INT NOT NULL CHECK (soNgayToiDa > 0),
    coLuong BIT DEFAULT 1,
    moTa NVARCHAR(300)
);
GO

-- =====================================================
-- 8. BẢNG ĐƠN XIN NGHỈ PHÉP (Leave Requests)
-- =====================================================
CREATE TABLE DonNghiPhep (
    maDon INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    maLoaiNP INT NOT NULL,
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE NOT NULL,
    soNgayNghi INT NOT NULL,
    lyDo NVARCHAR(500) NOT NULL,
    trangThai NVARCHAR(20) DEFAULT N'Chờ duyệt',
    nguoiDuyet NVARCHAR(20),
    ngayDuyet DATETIME,
    ghiChu NVARCHAR(300),
    ngayTao DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_DonNghiPhep_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    CONSTRAINT FK_DonNghiPhep_LoaiNP FOREIGN KEY (maLoaiNP) 
        REFERENCES LoaiNghiPhep(maLoaiNP),
    CONSTRAINT FK_DonNghiPhep_NguoiDuyet FOREIGN KEY (nguoiDuyet) 
        REFERENCES NhanVien(maNhanVien),
    
    CONSTRAINT CK_DonNghiPhep_Ngay CHECK (ngayKetThuc >= ngayBatDau),
    CONSTRAINT CK_DonNghiPhep_SoNgay CHECK (soNgayNghi > 0),
    CONSTRAINT CK_DonNghiPhep_TrangThai CHECK (trangThai IN 
        (N'Chờ duyệt', N'Đã duyệt', N'Từ chối', N'Hủy'))
);
GO

-- =====================================================
-- 9. BẢNG LƯƠNG (Salary)
-- =====================================================
CREATE TABLE BangLuong (
    maBangLuong INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    thang INT NOT NULL,
    nam INT NOT NULL,
    luongCoBan DECIMAL(15,2) NOT NULL,
    thuongHieuQua DECIMAL(15,2) DEFAULT 0,
    luongTangCa DECIMAL(15,2) DEFAULT 0,
    khauTru DECIMAL(15,2) DEFAULT 0,
    bhxh DECIMAL(15,2) DEFAULT 0,
    thueTNCN DECIMAL(15,2) DEFAULT 0,
    tongLuong AS (luongCoBan + ISNULL(thuongHieuQua,0) 
                        + ISNULL(luongTangCa,0) - ISNULL(khauTru,0) 
                        - ISNULL(bhxh,0) - ISNULL(thueTNCN,0)) PERSISTED,
    trangThai NVARCHAR(20) DEFAULT N'Chưa thanh toán',
    ngayThanhToan DATETIME,
    ghiChu NVARCHAR(300),
    
    CONSTRAINT FK_BangLuong_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    
    CONSTRAINT UQ_BangLuong_NV_Thang UNIQUE (maNhanVien, thang, nam),
    CONSTRAINT CK_BangLuong_Thang CHECK (thang BETWEEN 1 AND 12),
    CONSTRAINT CK_BangLuong_Nam CHECK (nam >= 2020),
    CONSTRAINT CK_BangLuong_Luong CHECK (luongCoBan > 0),
    CONSTRAINT CK_BangLuong_TrangThai CHECK (trangThai IN 
        (N'Chưa thanh toán', N'Đã thanh toán', N'Tạm giữ'))
);
GO

-- =====================================================
-- 10. BẢNG LOẠI PHỤ CẤP (Allowance Types)
-- =====================================================
CREATE TABLE LoaiPhuCap (
    maPhuCap INT IDENTITY(1,1) PRIMARY KEY,
    tenPhuCap NVARCHAR(100) NOT NULL UNIQUE,
    soTien DECIMAL(15,2) NOT NULL CHECK (soTien >= 0),
    moTa NVARCHAR(300),
    trangThai BIT DEFAULT 1
);
GO

-- =====================================================
-- 11. BẢNG PHỤ CẤP NHÂN VIÊN
-- =====================================================
CREATE TABLE PhuCapNhanVien (
    id INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    maPhuCap INT NOT NULL,
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE,
    soTien DECIMAL(15,2) NOT NULL,
    
    CONSTRAINT FK_PhuCapNV_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    CONSTRAINT FK_PhuCapNV_LoaiPC FOREIGN KEY (maPhuCap) 
        REFERENCES LoaiPhuCap(maPhuCap),
    
    CONSTRAINT CK_PhuCapNV_Ngay CHECK (ngayKetThuc IS NULL OR ngayKetThuc > ngayBatDau)
);
GO

-- =====================================================
-- 12. BẢNG CA LÀM VIỆC (Work Shifts)
-- =====================================================
CREATE TABLE CaLamViec (
    maCa INT IDENTITY(1,1) PRIMARY KEY,
    tenCa NVARCHAR(50) NOT NULL UNIQUE,
    gioBatDau TIME NOT NULL,
    gioKetThuc TIME NOT NULL,
    moTa NVARCHAR(200),
    heSoLuong DECIMAL(3,2) DEFAULT 1.0,
    trangThai BIT DEFAULT 1
);
GO

-- =====================================================
-- 13. BẢNG LỊCH LÀM VIỆC
-- =====================================================
CREATE TABLE LichLamViec (
    id INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) NOT NULL,
    maCa INT NOT NULL,
    ngayLamViec DATE NOT NULL,
    ghiChu NVARCHAR(200),
    
    CONSTRAINT FK_LichLV_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    CONSTRAINT FK_LichLV_Ca FOREIGN KEY (maCa) 
        REFERENCES CaLamViec(maCa),
    
    CONSTRAINT UQ_LichLV_NV_Ngay UNIQUE (maNhanVien, ngayLamViec)
);
GO

-- =====================================================
-- 14. BẢNG TÀI KHOẢN NGƯỜI DÙNG (User Accounts)
-- =====================================================
CREATE TABLE TaiKhoan (
    maTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    maNhanVien NVARCHAR(20) UNIQUE,
    tenDangNhap NVARCHAR(50) NOT NULL UNIQUE,
    matKhau NVARCHAR(256) NOT NULL,
    vaiTro NVARCHAR(20) NOT NULL DEFAULT 'NhanVien',
    trangThai BIT DEFAULT 1,
    lanDangNhapCuoi DATETIME,
    ngayTao DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_TaiKhoan_NhanVien FOREIGN KEY (maNhanVien) 
        REFERENCES NhanVien(maNhanVien),
    
    CONSTRAINT CK_TaiKhoan_VaiTro CHECK (vaiTro IN 
        ('Admin', 'NhanVien', 'KeToan', 'TruongBoPhan'))
);
GO

-- =====================================================
-- DỮ LIỆU MẪU (Sample Data)
-- =====================================================

-- Phòng ban
INSERT INTO PhongBan (tenPhongBan, moTa) VALUES
(N'Lễ tân', N'Phòng tiếp đón và hỗ trợ khách hàng'),
(N'Buồng phòng', N'Phòng quản lý vệ sinh và bảo trì phòng'),
(N'Nhà hàng', N'Phòng phục vụ ẩm thực'),
(N'Bảo vệ', N'Phòng đảm bảo an ninh'),
(N'Kế toán', N'Phòng quản lý tài chính'),
(N'Nhân sự', N'Phòng quản lý nhân sự'),
(N'Kỹ thuật', N'Phòng bảo trì kỹ thuật'),
(N'Marketing', N'Phòng marketing và truyền thông');

-- Chức vụ
INSERT INTO ChucVu (tenChucVu, moTa, mucLuongCoSo) VALUES
(N'Trưởng phòng', N'Quản lý phòng ban', 25000000),
(N'Phó phòng', N'Hỗ trợ trưởng phòng', 18000000),
(N'Nhân viên', N'Nhân viên thực thi', 10000000),
(N'Thực tập sinh', N'Nhân viên thực tập', 5000000);

-- Loại hợp đồng
INSERT INTO LoaiHopDong (tenLoaiHD, moTa, thoiHan) VALUES
(N'Thử việc', N'Hợp đồng thử việc', 2),
(N'Có thời hạn 1 năm', N'Hợp đồng 12 tháng', 12),
(N'Có thời hạn 3 năm', N'Hợp đồng 36 tháng', 36),
(N'Không thời hạn', N'Hợp đồng vô thời hạn', NULL);

-- Loại nghỉ phép
INSERT INTO LoaiNghiPhep (tenLoaiNP, soNgayToiDa, coLuong, moTa) VALUES
(N'Nghỉ phép năm', 12, 1, N'Nghỉ phép thường niên'),
(N'Nghỉ ốm', 30, 1, N'Nghỉ do bệnh tật'),
(N'Nghỉ thai sản', 180, 1, N'Nghỉ sinh con'),
(N'Nghỉ việc riêng', 3, 0, N'Nghỉ việc cá nhân'),
(N'Nghỉ cưới', 3, 1, N'Nghỉ kết hôn');

-- Loại phụ cấp
INSERT INTO LoaiPhuCap (tenPhuCap, soTien, moTa) VALUES
(N'Phụ cấp ăn trưa', 1000000, N'Hỗ trợ bữa ăn'),
(N'Phụ cấp đi lại', 500000, N'Hỗ trợ xăng xe'),
(N'Phụ cấp điện thoại', 300000, N'Hỗ trợ liên lạc'),
(N'Phụ cấp độc hại', 800000, N'Phụ cấp công việc độc hại'),
(N'Phụ cấp trách nhiệm', 2000000, N'Phụ cấp cho quản lý');

-- Ca làm việc
INSERT INTO CaLamViec (tenCa, gioBatDau, gioKetThuc, moTa, heSoLuong) VALUES
(N'Ca sáng', '06:00', '14:00', N'Ca làm việc buổi sáng', 1.0),
(N'Ca chiều', '14:00', '22:00', N'Ca làm việc buổi chiều', 1.0),
(N'Ca đêm', '22:00', '06:00', N'Ca làm việc đêm', 1.3),
(N'Ca hành chính', '08:00', '17:00', N'Ca hành chính văn phòng', 1.0);

-- =====================================================
-- NHÂN VIÊN (Sample Employees)
-- maChucVu: 1=Trưởng phòng, 2=Phó phòng, 3=Nhân viên, 4=Thực tập sinh
-- maPhongBan: 1=Lễ tân, 2=Buồng phòng, 3=Nhà hàng, 4=Bảo vệ, 5=Kế toán, 6=Nhân sự
-- =====================================================
INSERT INTO NhanVien (maNhanVien, hoTen, gioiTinh, ngaySinh, cccd, soDienThoai, email, diaChi, maPhongBan, maChucVu, ngayVaoLam) VALUES
(N'NV001', N'Nguyễn Văn An', N'Nam', '1985-03-15', '079085001234', '0901234567', 'an.nguyen@hotel.com', N'123 Lê Lợi, Q1, TP.HCM', 6, 1, '2015-01-10'),
(N'NV002', N'Trần Thị Bình', N'Nữ', '1990-07-22', '079090007890', '0912345678', 'binh.tran@hotel.com', N'456 Nguyễn Huệ, Q1, TP.HCM', 6, 2, '2018-03-01'),
(N'NV003', N'Lê Hoàng Cường', N'Nam', '1988-11-05', '079088005678', '0923456789', 'cuong.le@hotel.com', N'789 Hai Bà Trưng, Q3, TP.HCM', 1, 1, '2019-06-15'),
(N'NV004', N'Trần Mai Ngọc Duy', N'Nam', '2005-02-28', '079095001111', '0934567890', 'tmnduy.a5.c3tqcap@gmail.com', N'321 Võ Văn Tần, Q3, TP.HCM', 1, 3, '2021-09-01'),
(N'NV005', N'Hoàng Văn Em', N'Nam', '1992-08-10', '079092002222', '0945678901', 'em.hoang@hotel.com', N'654 Điện Biên Phủ, Q10, TP.HCM', 2, 1, '2020-01-15'),
(N'NV006', N'Võ Thị Phương', N'Nữ', '1998-12-01', '079098003333', '0956789012', 'phuong.vo@hotel.com', N'987 Cách Mạng T8, Tân Bình, TP.HCM', 2, 3, '2022-03-01'),
(N'NV007', N'Đặng Minh Giang', N'Nam', '1987-05-20', '079087004444', '0967890123', 'giang.dang@hotel.com', N'147 Trường Chinh, Tân Phú, TP.HCM', 3, 1, '2017-08-01'),
(N'NV008', N'Bùi Thị Hạnh', N'Nữ', '1993-09-15', '079093005555', '0978901234', 'hanh.bui@hotel.com', N'258 Lũy Bán Bích, Tân Phú, TP.HCM', 3, 3, '2021-01-10'),
(N'NV009', N'Ngô Quốc Hưng', N'Nam', '1991-04-08', '079091006666', '0989012345', 'hung.ngo@hotel.com', N'369 Âu Cơ, Tân Bình, TP.HCM', 5, 1, '2019-11-01'),
(N'NV010', N'Lý Thị Kim', N'Nữ', '1996-06-25', '079096007777', '0990123456', 'kim.ly@hotel.com', N'741 Phan Văn Trị, Gò Vấp, TP.HCM', 4, 3, '2022-06-01');

-- =====================================================
-- HỢP ĐỒNG LAO ĐỘNG
-- =====================================================
INSERT INTO HopDongLaoDong (maNhanVien, maLoaiHD, soHopDong, ngayKy, ngayBatDau, ngayKetThuc, luongCoBan, trangThai) VALUES
(N'NV001', 4, N'HD2015-001', '2015-01-10', '2015-01-10', NULL, 25000000, N'Hiệu lực'),
(N'NV002', 4, N'HD2018-002', '2018-03-01', '2018-03-01', NULL, 18000000, N'Hiệu lực'),
(N'NV003', 3, N'HD2022-003', '2022-06-15', '2022-06-15', '2025-06-14', 25000000, N'Hiệu lực'),
(N'NV004', 2, N'HD2023-004', '2023-09-01', '2023-09-01', '2024-08-31', 10000000, N'Hiệu lực'),
(N'NV005', 4, N'HD2020-005', '2020-01-15', '2020-01-15', NULL, 25000000, N'Hiệu lực'),
(N'NV006', 2, N'HD2023-006', '2023-03-01', '2023-03-01', '2024-02-29', 10000000, N'Hiệu lực'),
(N'NV007', 4, N'HD2020-007', '2020-08-01', '2020-08-01', NULL, 25000000, N'Hiệu lực'),
(N'NV008', 2, N'HD2023-008', '2023-01-10', '2023-01-10', '2024-01-09', 10000000, N'Hiệu lực'),
(N'NV009', 3, N'HD2022-009', '2022-11-01', '2022-11-01', '2025-10-31', 25000000, N'Hiệu lực'),
(N'NV010', 1, N'HD2024-010', '2024-06-01', '2024-06-01', '2024-07-31', 10000000, N'Hiệu lực');

-- =====================================================
-- TÀI KHOẢN
-- =====================================================
INSERT INTO TaiKhoan (maNhanVien, tenDangNhap, matKhau, vaiTro, trangThai) VALUES
(N'NV001', 'admin', 'Admin@123', 'Admin', 1),
(N'NV002', 'binh.tran', 'Admin@123', 'Admin', 1),
(N'NV003', 'cuong.le', 'Truongbp@123', 'TruongBoPhan', 1),
(N'NV004', 'dung.pham', 'Nhanvien@123', 'NhanVien', 1),
(N'NV005', 'em.hoang', 'Truongbp@123', 'TruongBoPhan', 1),
(N'NV006', 'phuong.vo', 'Nhanvien@123', 'NhanVien', 1),
(N'NV007', 'giang.dang', 'Truongbp@123', 'TruongBoPhan', 1),
(N'NV008', 'hanh.bui', 'Nhanvien@123', 'NhanVien', 1),
(N'NV009', 'hung.ngo', 'Ketoan@123', 'KeToan', 1),
(N'NV010', 'kim.ly', 'Nhanvien@123', 'NhanVien', 1);

-- =====================================================
-- CHẤM CÔNG
-- =====================================================
INSERT INTO ChamCong (maNhanVien, ngayLamViec, gioVao, gioRa, trangThai, soGioLam, soGioTangCa) VALUES
(N'NV001', '2025-12-02', '08:00', '17:30', N'Đi làm', 8.5, 0.5),
(N'NV002', '2025-12-02', '08:00', '17:00', N'Đi làm', 8.0, 0),
(N'NV003', '2025-12-02', '06:00', '14:00', N'Đi làm', 8.0, 0),
(N'NV004', '2025-12-02', '06:15', '14:00', N'Đi trễ', 7.75, 0),
(N'NV005', '2025-12-02', '08:00', '17:00', N'Đi làm', 8.0, 0),
(N'NV006', '2025-12-02', NULL, NULL, N'Nghỉ phép', 0, 0),
(N'NV007', '2025-12-02', '14:00', '22:00', N'Đi làm', 8.0, 0),
(N'NV008', '2025-12-02', '14:00', '22:30', N'Đi làm', 8.5, 0.5),
(N'NV009', '2025-12-02', '08:00', '17:00', N'Đi làm', 8.0, 0),
(N'NV010', '2025-12-02', '22:00', '06:00', N'Đi làm', 8.0, 0);

-- =====================================================
-- BẢNG LƯƠNG
-- =====================================================
INSERT INTO BangLuong (maNhanVien, thang, nam, luongCoBan, thuongHieuQua, luongTangCa, khauTru, bhxh, thueTNCN, trangThai, ngayThanhToan) VALUES
(N'NV001', 11, 2025, 25000000, 3000000, 1500000, 0, 2625000, 1500000, N'Đã thanh toán', '2025-12-05'),
(N'NV002', 11, 2025, 18000000, 2000000, 0, 0, 1890000, 1000000, N'Đã thanh toán', '2025-12-05'),
(N'NV003', 11, 2025, 25000000, 2500000, 500000, 0, 2625000, 1500000, N'Đã thanh toán', '2025-12-05'),
(N'NV004', 11, 2025, 10000000, 500000, 0, 200000, 1050000, 0, N'Đã thanh toán', '2025-12-05'),
(N'NV005', 11, 2025, 25000000, 2000000, 0, 0, 2625000, 1500000, N'Đã thanh toán', '2025-12-05');

-- =====================================================
-- ĐƠN NGHỈ PHÉP
-- =====================================================
INSERT INTO DonNghiPhep (maNhanVien, maLoaiNP, ngayBatDau, ngayKetThuc, soNgayNghi, lyDo, trangThai, nguoiDuyet, ngayDuyet) VALUES
(N'NV006', 1, '2025-12-02', '2025-12-03', 2, N'Việc gia đình', N'Đã duyệt', N'NV005', '2025-11-30'),
(N'NV004', 2, '2025-12-10', '2025-12-11', 2, N'Khám bệnh định kỳ', N'Chờ duyệt', NULL, NULL);

-- =====================================================
-- LỊCH LÀM VIỆC
-- =====================================================
INSERT INTO LichLamViec (maNhanVien, maCa, ngayLamViec) VALUES
(N'NV001', 4, '2025-12-09'),
(N'NV002', 4, '2025-12-09'),
(N'NV003', 1, '2025-12-09'),
(N'NV004', 1, '2025-12-09'),
(N'NV007', 2, '2025-12-09'),
(N'NV008', 2, '2025-12-09'),
(N'NV010', 3, '2025-12-09');

-- =====================================================
-- PHỤ CẤP NHÂN VIÊN
-- =====================================================
INSERT INTO PhuCapNhanVien (maNhanVien, maPhuCap, ngayBatDau, ngayKetThuc, soTien) VALUES
(N'NV001', 1, '2024-01-01', NULL, 1000000),
(N'NV001', 2, '2024-01-01', NULL, 500000),
(N'NV001', 5, '2024-01-01', NULL, 2000000),
(N'NV002', 1, '2024-01-01', NULL, 1000000),
(N'NV002', 5, '2024-01-01', NULL, 1500000),
(N'NV003', 1, '2024-01-01', NULL, 1000000),
(N'NV003', 2, '2024-01-01', NULL, 500000);
