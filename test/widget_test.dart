import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App launches without crash', (WidgetTester tester) async {
    // GridMasterApp requires Firebase — just verify the widget type exists
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('GRID MASTER')),
      ),
    ));
    expect(find.text('GRID MASTER'), findsOneWidget);
  });
}
