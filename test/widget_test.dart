import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator_app/main.dart';

void main() {
  testWidgets('guide example calculates 275 per person and updates live',
      (tester) async {
    await tester.pumpWidget(const TipCalculatorApp());
    expect(find.text('₹275.00'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    expect(find.text('₹0.00'), findsNWidgets(3));

    await tester.enterText(find.byType(TextField), 'invalid');
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('people count never goes below one', (tester) async {
    await tester.pumpWidget(const TipCalculatorApp());
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byTooltip('Remove one person'));
      await tester.pump();
    }
    expect(find.text('1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

