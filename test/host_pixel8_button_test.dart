import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sharespot/app/app_bootstrap.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/core/routes/app_route_names.dart';

void main() {
  for (final textScale in const [1.0, 1.3]) {
    testWidgets(
      'host button labels fit a Pixel 8 viewport at ${textScale}x text',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(412, 915);
        tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
        tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
        tester.platformDispatcher.textScaleFactorTestValue = textScale;
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetPadding);
        addTearDown(tester.view.resetViewPadding);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await tester.pumpWidget(const AppBootstrap());
        final appContext = tester.element(find.byType(MaterialApp));
        appContext.read<UserModeProvider>().switchTo(AppUserMode.host);
        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        navigator.pushReplacementNamed(AppRouteNames.home);
        await tester.pumpAndSettle();

        _expectVisibleButtonLabelsFit(tester, screen: 'host/home');

        for (final tab in const [
          'Activity',
          'Rewards',
          'Messages',
          'Profile',
        ]) {
          await tester.tap(find.text(tab).last);
          await tester.pumpAndSettle();
          _expectVisibleButtonLabelsFit(
            tester,
            screen: 'host/${tab.toLowerCase()}',
          );
        }

        await tester.scrollUntilVisible(
          find.text('Switch To Guest'),
          350,
          scrollable: find.byType(Scrollable).first,
        );
        _expectVisibleButtonLabelsFit(tester, screen: 'host/profile-bottom');

        await tester.tap(find.text('Switch To Guest'));
        await tester.pumpAndSettle();
        _expectVisibleButtonLabelsFit(tester, screen: 'switch-mode-dialog');
        await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Logout'));
        await tester.pumpAndSettle();
        _expectVisibleButtonLabelsFit(tester, screen: 'logout-dialog');
        await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Rewards').last);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Redeem Rewards'));
        await tester.pumpAndSettle();
        _expectVisibleButtonLabelsFit(tester, screen: 'redeem-dialog');
        await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
        await tester.pumpAndSettle();

        final rewardsScroll = find.byType(Scrollable).first;
        await tester.scrollUntilVisible(
          find.text('Refer Now'),
          500,
          scrollable: rewardsScroll,
        );
        _expectVisibleButtonLabelsFit(tester, screen: 'host/rewards-bottom');

        for (final route in const [
          AppRouteNames.hostProfileSettings,
          AppRouteNames.hostVehicleManagement,
          AppRouteNames.hostNotificationSettings,
        ]) {
          navigator.pushReplacementNamed(route);
          await tester.pumpAndSettle();
          _expectVisibleButtonLabelsFit(tester, screen: route);
        }

        navigator.pushReplacementNamed(AppRouteNames.hostChatDetail);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('Confirm Your Arrival'),
          400,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.drag(find.byType(Scrollable).first, const Offset(0, -120));
        await tester.pumpAndSettle();
        _expectVisibleButtonLabelsFit(tester, screen: 'host/chat-detail');

        await tester.tap(find.text('Confirm Your Arrival'));
        await tester.pumpAndSettle();
        _expectVisibleButtonLabelsFit(tester, screen: 'host/rating-sheet');

        expect(tester.takeException(), isNull);
      },
    );
  }
}

void _expectVisibleButtonLabelsFit(
  WidgetTester tester, {
  required String screen,
}) {
  expect(
    tester.takeException(),
    isNull,
    reason: '$screen must render without an overflow',
  );
  final buttons = find.byWidgetPredicate(
    (widget) => widget is ButtonStyleButton,
  );

  for (final buttonElement in buttons.evaluate()) {
    final buttonRect = tester.getRect(
      find.byElementPredicate((element) => identical(element, buttonElement)),
    );
    final textElements = <Element>[];
    void collectText(Element element) {
      if (element.widget is Text) textElements.add(element);
      element.visitChildElements(collectText);
    }

    buttonElement.visitChildElements(collectText);
    for (final textElement in textElements) {
      final text = textElement.widget as Text;
      final renderObject = textElement.renderObject;
      if (renderObject is! RenderParagraph) continue;

      final label = text.data ?? text.textSpan?.toPlainText() ?? '<rich text>';
      expect(
        renderObject.didExceedMaxLines,
        isFalse,
        reason: '$screen: "$label" is truncated',
      );

      final textRect = tester.getRect(
        find.byElementPredicate((element) => identical(element, textElement)),
      );
      expect(
        buttonRect.inflate(0.5).contains(textRect.topLeft) &&
            buttonRect.inflate(0.5).contains(textRect.bottomRight),
        isTrue,
        reason: '$screen: "$label" is clipped by its button bounds',
      );
    }
  }
}
