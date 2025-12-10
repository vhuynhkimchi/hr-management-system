# 🏨 HỆ THỐNG QUẢN LÝ NHÂN SỰ RESORT
## Human Resource Management System
**Database:** `QuanLyNhanSu`
---
## 📋 TỔNG QUAN
Hệ thống quản lý toàn bộ quy trình nhân sự trong Resort, bao gồm **14 bảng dữ liệu** với đầy đủ ràng buộc.
> **Lưu ý:** Phòng Nhân sự đóng vai trò **Admin** của hệ thống (không có chức vụ Giám đốc riêng)
---
## 👥 CÁC ACTOR VÀ CHỨC NĂNG
### 🔴 ADMIN (Phòng Nhân sự)
| STT | Chức năng | Mô tả |
|-----|-----------|-------|
| 1 | Quản lý tài khoản | Tạo, sửa, xóa, tìm kiếm, khóa tài khoản người dùng |
| 2 | Phân quyền | Gán vai trò (Admin, TruongBoPhan, NhanVien, KeToan) |
| 3 | **Reset mật khẩu** | Đặt lại mật khẩu cho tất cả nhân viên khi quên thông qua gửi mail |
| 4 | Quản lý phòng ban | Thêm, sửa, xóa phòng ban |
| 5 | Quản lý chức vụ | Thêm, sửa, xóa chức vụ và mức lương cơ sở |
| 6 | Quản lý nhân viên | Thêm, sửa, xóa thông tin tất cả nhân viên |
| 7 | Quản lý hợp đồng | Tạo, gia hạn, chấm dứt hợp đồng lao động |
| 8 | Xem báo cáo | Xem tất cả báo cáo trong hệ thống |
---
### 🟠 TRƯỞNG BỘ PHẬN (TruongBoPhan)
| STT | Chức năng | Mô tả |
|-----|-----------|-------|
| 1 | Quản lý nhân viên | Xem thông tin nhân viên trong phòng ban |
| 2 | Chấm công | Xác nhận giờ vào/ra, trạng thái làm việc |
| 3 | Phân ca làm việc | Xếp lịch làm việc cho nhân viên |
| 4 | Duyệt đơn nghỉ phép | Duyệt/từ chối đơn xin nghỉ của nhân viên |
| 5 | Xem báo cáo | Xem báo cáo chấm công, nghỉ phép của phòng ban |
---
### 🟢 NHÂN VIÊN (NhanVien)
| STT | Chức năng | Mô tả |
|-----|-----------|-------|
| 1 | Xem thông tin cá nhân | Xem hồ sơ, hợp đồng của bản thân |
| 2 | Chấm công | Check-in/Check-out hàng ngày |
| 3 | Xem lịch làm việc | Xem ca làm việc được phân công |
| 4 | Gửi đơn nghỉ phép | Tạo đơn xin nghỉ phép |
| 5 | Xem bảng lương | Xem lương hàng tháng của bản thân |
| 6 | Đổi mật khẩu | Thay đổi mật khẩu đăng nhập |
---
### 🔵 KẾ TOÁN (KeToan)
| STT | Chức năng | Mô tả |
|-----|-----------|-------|
| 1 | Tính lương | Tính lương hàng tháng cho nhân viên |
| 2 | Quản lý bảng lương | Tạo, sửa, xem bảng lương |
| 3 | Quản lý phụ cấp | Xem và cập nhật các loại phụ cấp |
| 4 | Thanh toán lương | Xác nhận thanh toán lương |
| 5 | Báo cáo tài chính | Xuất báo cáo lương, phụ cấp, khấu trừ |
---
## 🗂️ CẤU TRÚC DATABASE

### Danh sách 14 bảng:

| # | Tên bảng | Mô tả |
|---|----------|-------|
| 1 | PhongBan | Phòng ban (Lễ tân, Buồng phòng, Nhà hàng, Bảo vệ, Kế toán, Nhân sự, Kỹ thuật, Marketing) |
| 2 | ChucVu | Chức vụ (Trưởng phòng, Phó phòng, Nhân viên, Thực tập sinh) |
| 3 | LoaiHopDong | Loại hợp đồng (Thử việc, 1 năm, 3 năm, Vô thời hạn) |
| 4 | **NhanVien** | ⭐ Bảng chính - Thông tin nhân viên |
| 5 | HopDongLaoDong | Hợp đồng lao động |
| 6 | ChamCong | Chấm công hàng ngày |
| 7 | LoaiNghiPhep | Loại nghỉ phép (Phép năm, Ốm, Thai sản, Việc riêng, Cưới) |
| 8 | DonNghiPhep | Đơn xin nghỉ phép |
| 9 | BangLuong | Bảng lương (computed column: tongLuong) |
| 10 | LoaiPhuCap | Danh mục phụ cấp |
| 11 | PhuCapNhanVien | Phụ cấp của từng nhân viên |
| 12 | CaLamViec | Ca làm việc (Sáng, Chiều, Đêm, Hành chính) |
| 13 | LichLamViec | Lịch phân ca |
| 14 | TaiKhoan | Tài khoản đăng nhập |

---

## 💰 CẤU TRÚC BẢNG LƯƠNG (BangLuong)

| Cột | Mô tả |
|-----|-------|
| luongCoBan | Lương cơ bản |
| thuongHieuQua | Thưởng hiệu quả |
| luongTangCa | Lương tăng ca |
| khauTru | Khấu trừ |
| bhxh | Bảo hiểm xã hội |
| thueTNCN | Thuế thu nhập cá nhân |
| **tongLuong** | = luongCoBan + thuongHieuQua + luongTangCa - khauTru - bhxh - thueTNCN |

---
## 🔒 RÀNG BUỘC DỮ LIỆU

| Loại | Ràng buộc |
|------|-----------|
| Tuổi nhân viên | ≥ 18 tuổi |
| CCCD | 9 hoặc 12 ký tự |
| Số điện thoại | Bắt đầu bằng 0, ít nhất 10 số |
| Email | Định dạng xxx@xxx.xxx |
| Giới tính | Nam / Nữ / Khác |
| Vai trò TK | Admin / TruongBoPhan / NhanVien / KeToan |
## 📝 QUY TẮC ĐẶT TÊN
Tất cả thuộc tính sử dụng **camelCase**:
- Chữ đầu tiên viết thường
- Các từ sau viết hoa chữ cái đầu

Ví dụ: `maNhanVien`, `hoTen`, `ngaySinh`, `maPhongBan`, `trangThaiLamViec`

