import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Thêm và hiển thị ghi chú mới', (WidgetTester tester) async {
    // Khởi tạo ứng dụng NoteApp


    // Kiểm tra ban đầu chưa có ghi chú
    expect(find.text('Chưa có ghi chú nào'), findsOneWidget);

    // Nhấn nút '+' để mở hộp thoại thêm ghi chú
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Nhập tiêu đề và nội dung
    await tester.enterText(find.byType(TextField).at(0), 'IT HUTECH');
    await tester.enterText(find.byType(TextField).at(1), 'Bùi Phu Khuyến');

    // Nhấn nút 'Lưu'
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();

    // Kiểm tra ghi chú mới đã hiển thị
    expect(find.text('IT HUTECH'), findsOneWidget);
    expect(find.text('Bùi Phu Khuyến'), findsOneWidget);
  });
}
