import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/app/app_bootstrap.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/routes/app_route_names.dart';

void main() {
  setUpAll(() async {
    final generalSans = FontLoader('GeneralSans')
      ..addFont(rootBundle.load('assets/fonts/GeneralSans-Variable.ttf'));
    await generalSans.load();
  });

  for (final textScale in [1.0, 1.3]) {
    testWidgets(
      'auth button labels stay complete on Pixel 8 at ${textScale}x text',
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
        await tester.pump(AppConstants.splashDuration);
        await tester.pumpAndSettle();
        _expectEveryButtonLabelFits(tester, route: AppRouteNames.login);

        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        const routes = [
          AppRouteNames.createAccount,
          AppRouteNames.verifyEmail,
          AppRouteNames.profileSetup,
          AppRouteNames.vehicleDetails,
          AppRouteNames.permissions,
          AppRouteNames.forgotPassword,
          AppRouteNames.resetPassword,
        ];

        for (final route in routes) {
          navigator.pushReplacementNamed(route);
          await tester.pumpAndSettle();
          _expectEveryButtonLabelFits(tester, route: route);
          expect(
            tester.takeException(),
            isNull,
            reason: '$route must not throw a layout exception.',
          );
        }
      },
    );
  }
}

void _expectEveryButtonLabelFits(WidgetTester tester, {required String route}) {
  final buttons = find.byWidgetPredicate(
    (widget) => widget is ButtonStyleButton,
  );

  for (final buttonElement in buttons.evaluate()) {
    final buttonFinder = find.byElementPredicate(
      (element) => identical(element, buttonElement),
    );
    final buttonRect = tester.getRect(buttonFinder);
    final labels = find.descendant(
      of: buttonFinder,
      matching: find.byType(Text),
    );

    for (final labelElement in labels.evaluate()) {
      final labelFinder = find.byElementPredicate(
        (element) => identical(element, labelElement),
      );
      final labelWidget = labelElement.widget as Text;
      final label =
          labelWidget.data ?? labelWidget.textSpan?.toPlainText() ?? '';
      final paragraph = tester.renderObject<RenderParagraph>(labelFinder);
      final textRect = tester.getRect(labelFinder);

      expect(
        labelWidget.overflow,
        isNot(TextOverflow.fade),
        reason: '"$label" must never silently fade on $route.',
      );
      expect(
        paragraph.didExceedMaxLines,
        isFalse,
        reason: '"$label" is truncated on $route.',
      );
      expect(
        buttonRect.inflate(0.5).contains(textRect.topLeft),
        isTrue,
        reason: 'The start of "$label" is clipped on $route.',
      );
      expect(
        buttonRect.inflate(0.5).contains(textRect.bottomRight),
        isTrue,
        reason: 'The end of "$label" is clipped on $route.',
      );
    }
  }
}
