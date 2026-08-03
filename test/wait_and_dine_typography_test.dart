import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/features/shared/activity/widgets/wait_and_dine_view.dart';

void main() {
  testWidgets('Wait & Dine text never inherits an underline decoration', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultTextStyle(
          style: TextStyle(decoration: TextDecoration.underline),
          child: WaitAndDineView(showBack: true),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final waitAndDineText = tester.widgetList<Text>(
      find.descendant(
        of: find.byType(WaitAndDineView),
        matching: find.byType(Text),
      ),
    );

    expect(waitAndDineText, isNotEmpty);
    for (final text in waitAndDineText) {
      expect(
        text.style?.decoration,
        TextDecoration.none,
        reason: 'Unexpected decoration on "${text.data}"',
      );
    }
    expect(tester.takeException(), isNull);
  });
}
