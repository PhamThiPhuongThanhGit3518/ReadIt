# ReadIt

Ứng dụng đọc truyện được xây dựng bằng **Flutter**, hướng đến trải nghiệm đọc hiện đại trên mobile. ReadIt hỗ trợ cả **người đọc** lẫn **tác giả**: người dùng có thể khám phá truyện, theo dõi truyện yêu thích, đọc offline; trong khi tác giả có thể tạo truyện mới, chỉnh sửa nội dung và tải chương lên hệ thống.

## Tính năng chính

### Dành cho người đọc

* Đăng ký, đăng nhập tài khoản.
* Xem danh sách truyện mới cập nhật.
* Xem truyện phổ biến theo lượt xem.
* Tìm kiếm truyện theo tên truyện hoặc tác giả.
* Xem chi tiết truyện, danh sách chương và thông tin cơ bản.
* Đọc chương online.
* Thêm / bỏ truyện khỏi danh sách yêu thích.
* Tải chương về để đọc offline.
* Quản lý thư viện cá nhân gồm:

  * Truyện yêu thích
  * Chương đã tải offline
  * Lịch sử đọc

### Dành cho tác giả

* Tạo truyện mới.
* Cập nhật thông tin truyện.
* Tải chương truyện lên hệ thống.
* Chỉnh sửa chương đã đăng.
* Xóa truyện hoặc xóa chương.
* Quản lý danh sách truyện đã xuất bản trong thư viện cá nhân.

## Công nghệ sử dụng

* **Flutter**
* **Dart**
* **Riverpod / Flutter Riverpod** để quản lý state
* **GoRouter** để điều hướng màn hình
* **Dio + Retrofit** để gọi REST API
* **Isar Community** để lưu dữ liệu offline
* **SharedPreferences** để lưu token đăng nhập
* **Image Picker / File Picker / Photo Manager** để chọn ảnh và file chương truyện
* **Flutter SVG** để hiển thị icon SVG

## Kiến trúc tổng quan

Dự án được tổ chức theo hướng tách lớp rõ ràng:

* `views/`: giao diện người dùng
* `viewmodels/`: xử lý logic hiển thị và state
* `repositories/`: trung gian làm việc với API service
* `services/`: cấu hình API, file picker và các service liên quan
* `providers/`: khai báo Riverpod providers
* `database/`: model và xử lý dữ liệu local bằng Isar
* `widgets/`: các widget tái sử dụng

## Luồng chức năng chính

1. Người dùng đăng nhập hoặc đăng ký tài khoản.
2. Ứng dụng lấy dữ liệu truyện từ backend và hiển thị ở màn hình Home.
3. Người dùng có thể tìm kiếm truyện, mở trang chi tiết và đọc từng chương.
4. Khi muốn đọc offline, người dùng tải chương về và dữ liệu được lưu local bằng Isar.
5. Nếu tài khoản có quyền tác giả, người dùng có thể tạo truyện mới, cập nhật truyện và đăng chương.

Một số nhóm endpoint chính:

* `auth`: đăng ký, đăng nhập, lấy thông tin người dùng
* `users`: hồ sơ người dùng, phân quyền
* `stories`: tạo truyện, tìm kiếm, lấy truyện mới, truyện phổ biến, yêu thích, chương truyện


## Tính năng offline

ReadIt hỗ trợ lưu chương truyện để đọc ngoại tuyến bằng **Isar**. Dữ liệu offline gồm các thông tin:

* ID truyện
* ID chương
* Tên truyện
* Tên chương
* Số thứ tự chương
* Nội dung chương
* Thời điểm tải về

## Ghi chú

* Ứng dụng hiện được cấu hình theme tối (dark theme).
* Token xác thực được lưu trong `SharedPreferences` và tự động gắn vào header `Authorization` khi gọi API.
* Một số màn hình social login (Google / Apple) mới dừng ở giao diện, chưa thấy phần xử lý hoàn chỉnh trong luồng hiện tại.
* Tab Reviews ở trang chi tiết truyện hiện mới là placeholder giao diện.

## Hướng phát triển đề xuất

* Hoàn thiện đăng nhập Google / Apple.
* Bổ sung hệ thống đánh giá và bình luận truyện.
* Đồng bộ tiến độ đọc giữa nhiều thiết bị.
* Bổ sung bộ lọc theo thể loại, trạng thái truyện và tác giả.
* Tối ưu giao diện hồ sơ cá nhân và phần cài đặt.

## Tác giả

Developed by **PhamThiPhuongThanhGit3518**.

---
