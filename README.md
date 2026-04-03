# 📚 ReadIt - Ứng dụng đọc truyện

Ứng dụng đọc truyện được xây dựng bằng **Flutter**, hướng đến trải nghiệm đọc hiện đại trên mobile. ReadIt hỗ trợ cả **người đọc** lẫn **tác giả**: người dùng có thể khám phá truyện, theo dõi truyện yêu thích, đọc offline; trong khi tác giả có thể tạo truyện mới, chỉnh sửa nội dung và tải chương lên hệ thống.

---

## 📸 Hình ảnh ứng dụng

### 🔐 Đăng ký & Đăng nhập
| Đăng ký | Đăng nhập |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/7eab63fe-afcf-4ab6-ae36-502ceea9de4c" width="280"> | <img src="https://github.com/user-attachments/assets/54ee53ea-acd1-4c8e-ab28-c8a02242edc7" width="280"> |

---

### 🏠 Màn hình chính
| Trang chủ | Trang lọc truyện |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/0d682fa3-ee84-4231-808d-d32025b48002" width="280"> | <img src="https://github.com/user-attachments/assets/205f3571-7dce-4af6-b976-d1daec3e1c48" width="280"> |

---

### 📖 Đọc truyện
| Trang giới thiệu | Danh sách chap | Đọc chapter |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/fe06981f-0d78-463e-9607-072716b840c8" width="280"> | <img src="https://github.com/user-attachments/assets/b02644f4-6ba0-410e-bc26-04578f4a84ce" width="280"> | <img src="https://github.com/user-attachments/assets/9bf32329-17bc-467c-9340-1ef540ad54cb" width="280"> |

---

### 📚 Thư viện & Quản lý truyện
| Truyện của tôi | Đọc offline | Thêm truyện |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/1507520b-7fd4-4e32-98f4-d773de08cd6f" width="220"> | <img src="https://github.com/user-attachments/assets/9b1e2f0b-6460-4038-bf70-703a2b168545" width="220"> | <img src="https://github.com/user-attachments/assets/cd8165e2-e5ef-4d92-ad5b-cdacc746a396" width="220"> |

| Sửa truyện | Thêm chap | Sửa chap |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/15324a6c-6947-4ee0-912e-16d76e42c79f" width="220"> | <img src="https://github.com/user-attachments/assets/1ea6f034-84b9-4c3c-8e35-d5ae692baae9" width="220"> | <img src="https://github.com/user-attachments/assets/1347acc6-dc03-459e-8fcf-65b2c00cb845" width="220"> |

---

### 👤 Trang cá nhân
| Trang cá nhân | Lịch sử đọc |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/4efc3ce5-5dc4-445c-a282-a65e6a19e182" width="280"> | <img src="https://github.com/user-attachments/assets/cb03306d-b6f2-47fa-976c-4837c04ce280" width="280"> |

---

## 🚀 Tính năng nổi bật

### 👤 Dành cho người đọc
- Đăng ký, đăng nhập tài khoản  
- Xem danh sách truyện mới và truyện phổ biến  
- Tìm kiếm truyện theo tên hoặc tác giả  
- Xem chi tiết truyện và danh sách chương  
- Đọc truyện online  
- Thêm / bỏ truyện yêu thích  
- Tải chương để đọc offline  
- Quản lý thư viện cá nhân:
  - Truyện yêu thích  
  - Chương đã tải  
  - Lịch sử đọc  

---

### ✍️ Dành cho tác giả
- Tạo và quản lý truyện  
- Cập nhật thông tin truyện  
- Đăng và chỉnh sửa chương  
- Xóa truyện hoặc chương  
- Quản lý danh sách truyện đã xuất bản  

---

## 🛠 Công nghệ sử dụng

- **Flutter** – Framework chính  
- **Dart** – Ngôn ngữ lập trình  
- **Riverpod** – Quản lý state & DI  
- **GoRouter** – Điều hướng  
- **Dio + Retrofit** – Gọi REST API  
- **Isar Database** – Lưu trữ dữ liệu offline  
- **SharedPreferences** – Lưu token đăng nhập  
- **Image Picker / File Picker / Photo Manager** – Upload ảnh & file  
- **Flutter SVG** – Hiển thị icon  

---

## 🏗 Kiến trúc

Dự án được tổ chức theo mô hình **MVVM**:

- `views/` – UI  
- `viewmodels/` – Xử lý logic  
- `repositories/` – Giao tiếp API  
- `services/` – Cấu hình service  
- `providers/` – State management  
- `database/` – Lưu trữ local  
- `widgets/` – Component tái sử dụng  

---

## 🔄 Luồng hoạt động

1. Người dùng đăng ký / đăng nhập  
2. Ứng dụng lấy dữ liệu từ backend và hiển thị  
3. Người dùng tìm kiếm, đọc truyện  
4. Tải chương để đọc offline (Isar)  
5. Tác giả có thể tạo và quản lý nội dung  

---

## 📡 API

- `auth` – đăng nhập, đăng ký  
- `users` – thông tin người dùng  
- `stories` – truyện, chương, yêu thích  

---

## 💾 Offline

Ứng dụng hỗ trợ lưu chapter để đọc offline:

- ID truyện, ID chương  
- Nội dung chapter  
- Thời điểm tải  

---

## 📌 Ghi chú

- Hỗ trợ **dark mode**  
- Token được lưu trong `SharedPreferences`  
- Tự động gắn vào header Authorization  

---

## 🚀 Hướng phát triển

- Social login (Google / Apple)  
- Bình luận & đánh giá  
- Đồng bộ đa thiết bị  
- Bộ lọc nâng cao  
- Tối ưu UI/UX  

---

## 👨‍💻 Tác giả

Developed by **PhamThiPhuongThanhGit3518**
