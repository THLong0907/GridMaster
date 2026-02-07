import 'package:flutter_test/flutter_test.dart';
import 'package:grid_master/main.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const GridMasterApp());
    expect(find.text('GRID'), findsOneWidget);
  });
}
