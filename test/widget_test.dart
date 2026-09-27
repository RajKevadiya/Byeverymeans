import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';

void main() {
  testWidgets('App loads home page', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const ByAllMeansApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('BY EVERY MEANS'), findsWidgets);
    expect(find.textContaining('recognised'), findsWidgets);
  });
}
