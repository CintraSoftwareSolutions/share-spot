import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/app/app_bootstrap.dart';
import 'package:sharespot/core/routes/app_route_names.dart';

void main() {
  for (final textScale in <double>[1, 1.3]) {
    testWidgets('guest button labels fit a Pixel 8 at ${textScale}x text', (
      tester,
    ) async {
      _configurePixel8(tester, textScale);
      await tester.pumpWidget(const AppBootstrap());
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pushReplacementNamed(AppRouteNames.home);
      await tester.pumpAndSettle();

      final failures = <String>[];
      _auditVisibleButtonLabels(tester, 'home', failures);

      for (final label in const [
        'Activity',
        'Rewards',
        'Messages',
        'Profile',
      ]) {
        await tester.tap(find.text(label).last);
        await tester.pumpAndSettle();
        _auditVisibleButtonLabels(tester, label.toLowerCase(), failures);
      }

      for (final route in const [
        AppRouteNames.notifications,
        AppRouteNames.notificationSettings,
        AppRouteNames.waitAndDine,
        AppRouteNames.availableRewards,
        AppRouteNames.recentRewardsActivity,
        AppRouteNames.parkingInsights,
        AppRouteNames.profileSettings,
        AppRouteNames.vehicleManagement,
        AppRouteNames.favorites,
        AppRouteNames.chatDetail,
      ]) {
        navigator.pushReplacementNamed(route);
        await tester.pumpAndSettle();
        _auditVisibleButtonLabels(tester, route, failures);
      }

      expect(
        failures,
        isEmpty,
        reason: 'Every visible guest button must show its complete label.',
      );
    });
  }
}

void _configurePixel8(WidgetTester tester, double textScale) {
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
}

void _auditVisibleButtonLabels(
  WidgetTester tester,
  String screen,
  List<String> failures,
) {
  for (final textElement in find.byType(Text).evaluate()) {
    Element? buttonElement;
    textElement.visitAncestorElements((ancestor) {
      if (ancestor.widget is ButtonStyleButton) {
        buttonElement = ancestor;
        return false;
      }
      return true;
    });
    if (buttonElement == null) continue;

    final textWidget = textElement.widget as Text;
    final label = textWidget.data ?? textWidget.textSpan?.toPlainText() ?? '';
    if (label.isEmpty) continue;
    final textRenderObject = textElement.renderObject;
    final buttonRenderObject = buttonElement!.renderObject;
    if (textRenderObject is! RenderParagraph ||
        buttonRenderObject is! RenderBox ||
        !textRenderObject.attached ||
        !buttonRenderObject.attached) {
      continue;
    }

    final textRect = MatrixUtils.transformRect(
      textRenderObject.getTransformTo(null),
      Offset.zero & textRenderObject.size,
    );
    final buttonRect = MatrixUtils.transformRect(
      buttonRenderObject.getTransformTo(null),
      Offset.zero & buttonRenderObject.size,
    );
    const tolerance = 0.5;
    if (textRect.left < buttonRect.left - tolerance ||
        textRect.top < buttonRect.top - tolerance ||
        textRect.right > buttonRect.right + tolerance ||
        textRect.bottom > buttonRect.bottom + tolerance) {
      failures.add('$screen: "$label" text=$textRect button=$buttonRect');
    }
  }

  final exception = tester.takeException();
  if (exception != null) failures.add('$screen: $exception');
}
