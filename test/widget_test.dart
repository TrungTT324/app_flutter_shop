import 'package:flutter_test/flutter_test.dart';
import 'package:app_flutter_shop/main.dart';

void main() {
  testWidgets('Home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const FashionStoreApp());
    expect(find.text('Fashion Store'), findsOneWidget);
  });
}
