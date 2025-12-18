CREATE DATABASE QuanLyNhanSu;
GO
USE QuanLyNhanSu;
GO

-- 1. Phòng Ban
CREATE TABLE PhongBan (
    maPB VARCHAR(20) PRIMARY KEY,
    tenPB NVARCHAR(100) UNIQUE NOT NULL
);

-- 2. Nhân Viên
CREATE TABLE NhanVien (
    maNV VARCHAR(20) PRIMARY KEY,
    hoTen NVARCHAR(100) NOT NULL,
    ngaySinh DATE NOT NULL,
    diaChi NVARCHAR(200),
    sdt VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    gioiTinh BIT NOT NULL,  -- 1: Nam, 0: Nữ
    chucVu NVARCHAR(50),
    trangThaiLamViec NVARCHAR(50) NOT NULL DEFAULT N'Đang làm việc',
    maPB VARCHAR(20),
    CONSTRAINT FK_NhanVien_PhongBan
        FOREIGN KEY (maPB) REFERENCES PhongBan(maPB)
        ON DELETE SET NULL
);

-- 3. Tài Khoản
CREATE TABLE TaiKhoan (
    maTK INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    passwordHash VARCHAR(255) NOT NULL,
    vaiTro SMALLINT NOT NULL,  -- 1: Admin(Nhân sự), 2:Trưởng bộ phận 3:Nhân viên 4: Kế toán
    maNV VARCHAR(20) UNIQUE NOT NULL,
    CONSTRAINT FK_TaiKhoan_NhanVien
        FOREIGN KEY (maNV) REFERENCES NhanVien(maNV)
        ON DELETE CASCADE
);

-- 4. Hợp Đồng Lao Động
CREATE TABLE HopDong (
    maHD VARCHAR(20) PRIMARY KEY,
    loaiHD NVARCHAR(50) NOT NULL,
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE,
    maNV VARCHAR(20) NOT NULL,
    CONSTRAINT FK_HopDong_NhanVien
        FOREIGN KEY (maNV) REFERENCES NhanVien(maNV)
        ON DELETE CASCADE
);

-- 5. Chấm Công
CREATE TABLE ChamCong (
    maChamCong VARCHAR(20) PRIMARY KEY,
    ngayLamViec DATE NOT NULL,
    gioVao TIME,
    gioRa TIME,
    thoiGianTangCa DECIMAL(5,2) DEFAULT 0,
    maNV VARCHAR(20) NOT NULL,
    CONSTRAINT FK_ChamCong_NhanVien
        FOREIGN KEY (maNV) REFERENCES NhanVien(maNV)
        ON DELETE CASCADE
);

-- 6. Bảng Lương
CREATE TABLE BangLuong (
    maBangLuong VARCHAR(20) PRIMARY KEY,
    thangNam DATE NOT NULL,
    luongCoBan DECIMAL(15,2) NOT NULL,
    phuCap DECIMAL(15,2) DEFAULT 0,
    khauTru DECIMAL(15,2) DEFAULT 0,
    tongTienNhan AS (luongCoBan + phuCap - khauTru) PERSISTED,
    trangThaiThanhToan BIT DEFAULT 0,
    maNV VARCHAR(20) NOT NULL,
    CONSTRAINT FK_BangLuong_NhanVien
        FOREIGN KEY (maNV) REFERENCES NhanVien(maNV)
        ON DELETE CASCADE,
    UNIQUE(maNV, thangNam)
);
INSERT INTO PhongBan (maPB, tenPB) VALUES 
('PB01', N'Phòng Hành chính Nhân sự'),
('PB02', N'Phòng Kỹ thuật phần mềm'),
('PB03', N'Phòng Tài chính Kế toán'),
('PB04', N'Phòng Kinh doanh');
INSERT INTO NhanVien (maNV, hoTen, ngaySinh, diaChi, sdt, email, gioiTinh, chucVu, maPB) VALUES 
('NV001', N'Nguyễn Thị Hà', '1988-02-10', N'Quận 1, TP.HCM', '0912345678', 'ha.nt@company.com', 0, N'Trưởng phòng HR', 'PB01'),
('NV002', N'Trần Văn Nam', '1992-05-20', N'Quận 7, TP.HCM', '0987654321', 'nam.tv@company.com', 1, N'Trưởng phòng Kỹ thuật', 'PB02'),
('NV003', N'Lê Minh Anh', '1995-11-15', N'Bình Thạnh, TP.HCM', '0905556667', 'anh.lm@company.com', 1, N'Lập trình viên', 'PB02'),
('NV004', N'Phạm Thu Thảo', '1990-08-30', N'Quận 3, TP.HCM', '0933445566', 'thao.pt@company.com', 0, N'Kế toán trưởng', 'PB03');
INSERT INTO TaiKhoan (username, passwordHash, vaiTro, maNV) VALUES 
('admin_ha', 'hashed_pw_001', 1, 'NV001'), -- Admin/Nhân sự
('manager_nam', 'hashed_pw_002', 2, 'NV002'), -- Trưởng bộ phận
('staff_anh', 'hashed_pw_003', 3, 'NV003'), -- Nhân viên
('acc_thao', 'hashed_pw_004', 4, 'NV004'); -- Kế toán
INSERT INTO HopDong (maHD, loaiHD, ngayBatDau, ngayKetThuc, maNV) VALUES 
('HD-2023-001', N'Không xác định thời hạn', '2023-01-01', NULL, 'NV001'),
('HD-2023-002', N'Xác định thời hạn (2 năm)', '2023-06-01', '2025-06-01', 'NV002'),
('HD-2024-001', N'Thử việc', '2025-11-01', '2025-12-31', 'NV003'),
('HD-2023-003', N'Xác định thời hạn (3 năm)', '2023-03-01', '2026-03-01', 'NV004');
INSERT INTO ChamCong (maChamCong, ngayLamViec, gioVao, gioRa, thoiGianTangCa, maNV) VALUES 
('CC-121801', '2025-12-18', '08:00:00', '17:00:00', 0, 'NV001'),
('CC-121802', '2025-12-18', '08:15:00', '19:15:00', 2.0, 'NV002'),
('CC-121803', '2025-12-18', '07:55:00', '17:30:00', 0.5, 'NV003'),
('CC-121804', '2025-12-18', '08:05:00', '17:05:00', 0, 'NV004');
INSERT INTO BangLuong (maBangLuong, thangNam, luongCoBan, phuCap, khauTru, trangThaiThanhToan, maNV) VALUES 
('BL-1225-01', '2025-12-01', 25000000, 3000000, 1500000, 1, 'NV001'),
('BL-1225-02', '2025-12-01', 35000000, 5000000, 2000000, 0, 'NV002'),
('BL-1225-03', '2025-12-01', 15000000, 1000000, 500000, 0, 'NV003'),
('BL-1225-04', '2025-12-01', 20000000, 2500000, 1000000, 1, 'NV004');