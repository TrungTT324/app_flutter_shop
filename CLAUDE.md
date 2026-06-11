# ShopApp — Flutter Shopping App

## Tổng quan
Ứng dụng mua sắm (e-commerce) trên mobile bằng Flutter. Người dùng duyệt sản phẩm,
thêm vào giỏ hàng, đặt hàng và quản lý tài khoản.

## Tech stack
- **Flutter** stable channel, Dart null-safety
- **State management**: Riverpod (`flutter_riverpod` + `riverpod_annotation`)
- **Routing**: go_router
- **HTTP**: dio
- **Local storage**: shared_preferences (token, cài đặt), hive (cache sản phẩm/giỏ hàng)
- **Model/serialization**: freezed + json_serializable
- **DI**: dùng provider của Riverpod, KHÔNG dùng get_it

## Kiến trúc — feature-first + clean layers
```
lib/
  core/
    constants/      # app_colors, app_strings, app_sizes, api_endpoints
    theme/          # app_theme.dart
    network/        # dio_client.dart, interceptors
    router/         # app_router.dart (go_router config)
    utils/          # formatters, validators
    widgets/        # widget dùng chung: AppButton, AppTextField, LoadingView
  features/
    <feature>/
      data/         # models (freezed), repositories impl, data sources
      domain/       # entities, repository interfaces
      presentation/ # screens/, widgets/, providers/ (Riverpod)
  main.dart
```
Các feature chính: `auth`, `products`, `product_detail`, `cart`, `checkout`, `orders`, `profile`.

## Quy ước code
- Tên file: `snake_case.dart`
- Tên class: `PascalCase`; biến/hàm: `camelCase`
- Hằng số: đặt trong `core/constants`, KHÔNG hardcode string/số/màu trong widget
- 1 widget public / 1 file (trừ widget phụ private nhỏ)
- Provider Riverpod đặt cùng feature trong `presentation/providers/`
- Mọi text hiển thị lấy từ `core/constants/app_strings.dart`
- Mọi màu lấy từ `core/theme` hoặc `core/constants/app_colors.dart`

## Lệnh thường dùng
- Cài deps: `flutter pub get`
- Sinh code freezed/riverpod: `dart run build_runner build --delete-conflicting-outputs`
- Phân tích: `flutter analyze`
- Format: `dart format .`
- Test: `flutter test`

## Quy tắc BẮT BUỘC (chế độ tự động — không có người review từng bước)
1. Sau khi code xong, LUÔN chạy `dart run build_runner build --delete-conflicting-outputs`
   nếu có thay đổi model/provider có annotation.
2. LUÔN chạy `flutter analyze` và sửa HẾT lỗi + warning trước khi coi là xong.
3. LUÔN chạy `dart format .`.
4. Mọi màn hình mới phải xử lý đủ 3 trạng thái: loading, error, data.
5. Gọi API phải bọc try/catch và trả về trạng thái lỗi rõ ràng (dùng AsyncValue của Riverpod).
6. Widget/feature mới nên có ít nhất 1 test trong `test/` phản chiếu cấu trúc `lib/`.
7. KHÔNG tự chạy `git push`. Việc commit/push do workflow ngoài xử lý.
8. KHÔNG thêm package mới nếu chưa nêu trong issue; nếu cần, ghi rõ lý do trong phần tóm tắt.

## Khi nhận một issue
- Đọc kỹ phần "Yêu cầu chi tiết" và "Tiêu chí hoàn thành".
- Bám đúng kiến trúc và package có sẵn ở trên.
- Nếu yêu cầu mơ hồ, chọn cách giải đơn giản, đúng convention, ghi chú giả định đã đặt ra.
