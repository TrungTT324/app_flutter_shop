import 'package:flutter_test/flutter_test.dart';
import 'package:jollyshop/main.dart';

void main() {
  testWidgets('JollyShop app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JollyShopApp());
    expect(find.text('JollyShop'), findsNothing);
  });
}
