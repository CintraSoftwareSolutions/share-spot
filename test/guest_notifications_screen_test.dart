import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/features/guest/notifications/screens/notifications_screen.dart';

void main() {
  testWidgets(
    'guest notifications stay readable and above Android system navigation',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 640);
      tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
      tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetPadding);
      addTearDown(tester.view.resetViewPadding);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const MaterialApp(home: NotificationsScreen()));
      await tester.pumpAndSettle();

      final heading = tester.widget<Text>(find.text('Notifications'));
      final title = tester.widget<Text>(find.text('Parking Spot Found'));
      final body = tester.widget<Text>(
        find.text('Sarah Wilson is leaving a parking spot 300m away.'),
      );

      expect(heading.style?.decoration, TextDecoration.none);
      expect(title.style?.decoration, TextDecoration.none);
      expect(body.style?.decoration, TextDecoration.none);
      expect(body.style?.fontSize, 12);
      expect(tester.takeException(), isNull);

      await tester.fling(
        find.byKey(const PageStorageKey<String>('guest-notifications-list')),
        const Offset(0, -1000),
        1000,
      );
      await tester.pumpAndSettle();

      final lastCard = find.byKey(
        const ValueKey<String>('guest-notification-New Parking Spot Available'),
      );
      expect(lastCard, findsOneWidget);
      expect(tester.getBottomRight(lastCard).dy, lessThanOrEqualTo(616));
      expect(tester.takeException(), isNull);
    },
  );
}
