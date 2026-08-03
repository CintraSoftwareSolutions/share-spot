import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/app/app_bootstrap.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/utils/debug_rendering.dart';
import 'package:sharespot/features/shared/messages/widgets/parking_rating_sheet.dart';

void main() {
  setUpAll(() async {
    final generalSans = FontLoader('GeneralSans')
      ..addFont(rootBundle.load('assets/fonts/GeneralSans-Variable.ttf'));
    await generalSans.load();
  });

  testWidgets('app keeps Flutter Inspector paint overlays disabled', (
    tester,
  ) async {
    debugPaintBaselinesEnabled = true;
    debugPaintSizeEnabled = true;
    debugPaintLayerBordersEnabled = true;
    debugPaintTextLayoutBoxes = true;
    debugPaintPointersEnabled = true;
    debugRepaintRainbowEnabled = true;
    debugRepaintTextRainbowEnabled = true;
    addTearDown(() {
      debugPaintBaselinesEnabled = false;
      debugPaintSizeEnabled = false;
      debugPaintLayerBordersEnabled = false;
      debugPaintTextLayoutBoxes = false;
      debugPaintPointersEnabled = false;
      debugRepaintRainbowEnabled = false;
      debugRepaintTextRainbowEnabled = false;
      debugCurrentRepaintColor = const HSVColor.fromAHSV(0.4, 60, 1, 1);
    });

    await tester.pumpWidget(const AppBootstrap());

    expect(debugPaintBaselinesEnabled, isFalse);
    expect(debugPaintSizeEnabled, isFalse);
    expect(debugPaintLayerBordersEnabled, isFalse);
    expect(debugPaintTextLayoutBoxes, isFalse);
    expect(debugPaintPointersEnabled, isFalse);
    expect(debugRepaintRainbowEnabled, isFalse);
    expect(debugRepaintTextRainbowEnabled, isFalse);

    // Simulate Flutter Inspector enabling its paint toggles after app build.
    debugPaintBaselinesEnabled = true;
    debugPaintSizeEnabled = true;
    debugPaintLayerBordersEnabled = true;
    debugPaintTextLayoutBoxes = true;
    debugPaintPointersEnabled = true;
    debugRepaintRainbowEnabled = true;
    debugRepaintTextRainbowEnabled = true;

    await tester.pump();

    expect(debugPaintBaselinesEnabled, isFalse);
    expect(debugPaintSizeEnabled, isFalse);
    expect(debugPaintLayerBordersEnabled, isFalse);
    expect(debugPaintTextLayoutBoxes, isFalse);
    expect(debugPaintPointersEnabled, isFalse);
    expect(debugRepaintRainbowEnabled, isFalse);
    expect(debugRepaintTextRainbowEnabled, isFalse);
  });

  testWidgets('guard repaints away baselines already drawn by Inspector', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(240, 120);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(() => debugPaintBaselinesEnabled = false);

    installDebugRenderingGuard();
    const repaintBoundaryKey = ValueKey('debug-overlay-repaint-boundary');
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ColoredBox(
          color: Colors.black,
          child: Center(
            child: RepaintBoundary(
              key: repaintBoundaryKey,
              child: SizedBox(
                width: 200,
                height: 64,
                child: Center(
                  child: Text(
                    'Baseline probe',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    final boundaryFinder = find.byKey(repaintBoundaryKey);
    final cleanPixels = await _captureRawRgba(tester, boundaryFinder);

    // The test binding paints before the app's fallback callback. This mimics
    // a baseline layer already drawn by Inspector before the flag is cleared.
    debugPaintBaselinesEnabled = true;
    tester.renderObject<RenderRepaintBoundary>(boundaryFinder).markNeedsPaint();
    await tester.pump();
    await tester.pump();

    final repaintedPixels = await _captureRawRgba(tester, boundaryFinder);
    expect(debugPaintBaselinesEnabled, isFalse);
    expect(repaintedPixels, orderedEquals(cleanPixels));
  });

  testWidgets('splash matches the brand content', (tester) async {
    await tester.pumpWidget(const AppBootstrap());

    expect(find.text('viaO'), findsOneWidget);
    expect(find.text('Find parking before someone else does.'), findsOneWidget);
    final scaffoldWidth = tester.getSize(find.byType(Scaffold)).width;
    final taglineCenter = tester.getCenter(
      find.text('Find parking before someone else does.'),
    );
    expect(taglineCenter.dx, closeTo(scaffoldWidth / 2, 0.5));
  });

  testWidgets('splash opens the responsive login screen', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await tester.pump(AppConstants.splashDuration);
    await tester.pumpAndSettle();

    expect(find.text('viaO'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('Apple'), findsOneWidget);
  });

  testWidgets('login keeps the reference phone geometry', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final welcomeTop = tester.getTopLeft(find.text('Welcome back')).dy;
    final loginButton = find.widgetWithText(FilledButton, 'Login');

    expect(welcomeTop, closeTo(259, 3));
    expect(tester.getSize(loginButton).height, 48);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login stays above the Android system navigation inset', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    tester.view.padding = const FakeViewPadding(bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final signUpAction = find.byKey(const ValueKey('login-sign-up'));
    expect(tester.getBottomRight(signUpAction).dy, lessThanOrEqualTo(820));
    expect(tester.takeException(), isNull);
  });

  testWidgets('profile setup stays above the Android system navigation inset', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    tester.view.padding = const FakeViewPadding(bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushReplacementNamed(AppRouteNames.profileSetup);
    await tester.pumpAndSettle();

    final skipButton = find.widgetWithText(OutlinedButton, 'Skip For Now');
    expect(find.text('Set Up Your Profile'), findsOneWidget);
    expect(tester.getBottomRight(skipButton).dy, lessThanOrEqualTo(820));
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('permission controls stay readable and fit after being allowed', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushReplacementNamed(AppRouteNames.permissions);
    await tester.pumpAndSettle();

    expect(tester.widget<Text>(find.text('Location')).style?.fontSize, 14);
    expect(
      tester
          .widget<Text>(find.text('Need Permissions for better matchmaking'))
          .style
          ?.fontSize,
      12,
    );
    expect(
      tester.widget<Text>(find.text('Allow Access').first).style?.fontSize,
      12,
    );
    final accessText = find.text('Allow Access').first;
    final accessButton = find
        .ancestor(of: accessText, matching: find.byType(FilledButton))
        .first;
    final textRect = tester.getRect(accessText);
    final buttonRect = tester.getRect(accessButton);
    expect(buttonRect.contains(textRect.topLeft), isTrue);
    expect(buttonRect.contains(textRect.bottomRight), isTrue);

    await tester.tap(find.text('Allow Access').first);
    await tester.pump();
    await tester.tap(find.text('Allow Access'));
    await tester.pump();

    expect(find.text('Allowed'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('login validates empty fields', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();

    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('login validation fits a compact phone without overflow', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(384, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();

    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.byKey(const ValueKey('login-sign-up')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('signup opens the default guest account flow', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final signUpAction = find.byKey(const ValueKey('login-sign-up'));
    await tester.ensureVisible(signUpAction);
    await tester.tap(signUpAction);
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
    expect(
      find.text('Create a profile to find and reserve parking spots.'),
      findsOneWidget,
    );
  });

  testWidgets('onboarding screens fit a phone viewport', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    const screens = [
      (AppRouteNames.forgotPassword, "Let's Get You Back"),
      (AppRouteNames.resetPassword, 'Set a New Key'),
      (AppRouteNames.createAccount, 'Create your account'),
      (AppRouteNames.verifyEmail, 'Verify Email'),
      (AppRouteNames.profileSetup, 'Set Up Your Profile'),
      (AppRouteNames.vehicleDetails, 'Vehicle Details'),
      (AppRouteNames.permissions, 'Allow Permissions'),
    ];
    final overflowFailures = <String>[];

    for (final screen in screens) {
      navigator.pushReplacementNamed(screen.$1);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text(screen.$2), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsNothing);
      final exception = tester.takeException();
      if (exception != null) {
        overflowFailures.add('${screen.$1}: $exception');
      }
    }

    expect(
      overflowFailures,
      isEmpty,
      reason: 'Compact onboarding routes must not overflow: $overflowFailures',
    );
  });

  testWidgets('forgot password completes the reset flow', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    expect(find.text("Let's Get You Back"), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'alex66@gmail.com');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Reset Link'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Set a New Key'), findsOneWidget);

    final passwordFields = find.byType(TextFormField);
    await tester.enterText(passwordFields.at(0), 'secure123');
    await tester.enterText(passwordFields.at(1), 'secure123');
    await tester.tap(find.widgetWithText(FilledButton, 'Reset'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('valid login opens the home feature', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    expect(find.text('Best Match  ✦'), findsOneWidget);
    expect(find.text('Reserve Spot'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('bottom navigation opens activity and messages', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Activity'), findsWidgets);
    expect(find.text('Total Rewards'), findsOneWidget);

    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Messages'), findsWidgets);
    expect(find.text('Elena V.'), findsOneWidget);
  });

  testWidgets('guest and host primary tabs do not overflow on Android', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    final overflowFailures = <String>[];
    void recordOverflow(String screen) {
      final exception = tester.takeException();
      if (exception != null) overflowFailures.add('$screen: $exception');
    }

    recordOverflow('guest/home');
    for (final label in const ['Activity', 'Rewards', 'Messages', 'Profile']) {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      recordOverflow('guest/${label.toLowerCase()}');
    }

    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Switch To Host'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Switch to Host'));
    await tester.pumpAndSettle();
    recordOverflow('host/home');

    for (final label in const ['Activity', 'Rewards', 'Messages', 'Profile']) {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      recordOverflow('host/${label.toLowerCase()}');
    }

    expect(
      overflowFailures,
      isEmpty,
      reason: 'Primary guest/host tabs must not overflow: $overflowFailures',
    );
  });

  testWidgets('all pushed feature routes render without overflow on Android', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const AppBootstrap());
    await _openLogin(tester);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    const routes = [
      AppRouteNames.notifications,
      AppRouteNames.notificationSettings,
      AppRouteNames.hostNotificationSettings,
      AppRouteNames.hostNotifications,
      AppRouteNames.hostAvailableRewards,
      AppRouteNames.hostRecentRewardsActivity,
      AppRouteNames.waitAndDine,
      AppRouteNames.hostWaitAndDine,
      AppRouteNames.availableRewards,
      AppRouteNames.recentRewardsActivity,
      AppRouteNames.parkingInsights,
      AppRouteNames.profileSettings,
      AppRouteNames.hostProfileSettings,
      AppRouteNames.vehicleManagement,
      AppRouteNames.hostVehicleManagement,
      AppRouteNames.favorites,
      AppRouteNames.hostFavorites,
      AppRouteNames.chatDetail,
      AppRouteNames.hostChatDetail,
      AppRouteNames.settings,
    ];
    final overflowFailures = <String>[];

    for (final route in routes) {
      navigator.pushReplacementNamed(route);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      final exception = tester.takeException();
      if (exception != null) overflowFailures.add('$route: $exception');
    }

    expect(
      overflowFailures,
      isEmpty,
      reason: 'Pushed feature routes must not overflow: $overflowFailures',
    );
  });

  testWidgets('rating sheet handles the Android keyboard without overflow', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 24);
    tester.view.viewPadding = const FakeViewPadding(top: 24, bottom: 24);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: FilledButton(
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => ParkingRatingSheet(onSubmit: (_) {}),
                ),
                child: const Text('Open rating'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open rating'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('rating-feedback')));
    tester.view.viewInsets = const FakeViewPadding(bottom: 340);
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('How was your parking experience?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('activity filters and lower sections render responsively', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Central Mall'), findsOneWidget);
    expect(find.text('2,450'), findsOneWidget);
    expect(find.text('PTS'), findsOneWidget);

    await tester.tap(find.text('Upcoming'));
    await tester.pumpAndSettle();
    expect(find.text('Today • 2:45 PM'), findsOneWidget);

    await tester.tap(find.text('Cancelled'));
    await tester.pumpAndSettle();
    expect(find.text('Westfield Garage'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Community Feedback'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Earned Badges'), findsOneWidget);
    expect(find.text('Community Feedback'), findsOneWidget);
    expect(find.text('Sarah Miller'), findsOneWidget);
  });

  testWidgets('rewards sections and actions render responsively', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Rewards'));
    await tester.pumpAndSettle();
    expect(find.text('Available Points'), findsOneWidget);
    expect(find.text('Silver'), findsOneWidget);

    await tester.tap(find.text('View all').first);
    await tester.pumpAndSettle();
    expect(find.text('Available Rewards'), findsOneWidget);
    expect(find.text('Free Coffee with Any Sandwich'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Redeem Rewards'));
    await tester.pumpAndSettle();
    expect(find.text('Redeem Reward?'), findsOneWidget);
    expect(find.textContaining('20% Off Voucher'), findsOneWidget);
    await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Verona Italian'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Verona Italian'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Successful Swap'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Successful Swap'), findsOneWidget);
    expect(find.text('Redeemed Reward'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'View all').last);
    await tester.pumpAndSettle();
    expect(find.text('Recent Activity'), findsOneWidget);
    expect(find.text('Instant Redemption'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Invite & Earn'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Invite & Earn'), findsOneWidget);
  });

  testWidgets('chat filters and Elena handover flow work', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Chats'), findsOneWidget);

    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();
    expect(find.text('Marco Alvarez'), findsOneWidget);

    await tester.tap(find.text('Marco Alvarez'));
    await tester.pumpAndSettle();
    expect(find.text('Exchange completed'), findsOneWidget);
    expect(find.text('Swap Completed! +50 Points earned.'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Active'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Elena V.'));
    await tester.pumpAndSettle();
    expect(find.text('Handover in progress'), findsOneWidget);
    expect(find.text('Live Location Sharing'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -380));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm Your Arrival'));
    await tester.pumpAndSettle();
    expect(find.text('How was your parking experience?'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('rating-star-5')));
    await tester.tap(find.widgetWithText(FilledButton, 'Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Swap Completed! +50 Points earned.'), findsOneWidget);
  });

  testWidgets('profile stats, menus and actions render responsively', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Alex Carter'), findsOneWidget);
    expect(find.text('Community Rating'), findsOneWidget);
    expect(find.text('2,450'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Help & Support'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Privacy & Safety'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Switch To Host'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('profile settings, vehicle and favorites flows are connected', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile Settings'), findsOneWidget);
    expect(find.text('Upload Picture'), findsOneWidget);
    expect(find.text('Save Details'), findsOneWidget);

    await tester.tap(find.text('Change'));
    await tester.pumpAndSettle();
    expect(find.text('Change Your Password'), findsOneWidget);
    expect(find.text('Yes, Change'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Vehicle Management'));
    await tester.tap(find.text('Vehicle Management'));
    await tester.pumpAndSettle();
    expect(find.text('Vehicle Details'), findsOneWidget);
    expect(find.text('License Plate'), findsOneWidget);
    expect(find.text('Save Details'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Favorite Locations'));
    await tester.tap(find.text('Favorite Locations'));
    await tester.pumpAndSettle();
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('East Village Residence'), findsOneWidget);
    expect(find.text('The Highline Hub'), findsOneWidget);
    await tester.tap(find.text('East Village Residence'));
    await tester.pumpAndSettle();
    expect(find.text('Parking Stats'), findsOneWidget);
    expect(find.text('94%'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('AI Insight'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('AI Insight'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Find Parking'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Find Parking'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('notification preferences and logout dialog work', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Notifications'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();
    expect(find.text('Parking Alerts'), findsOneWidget);
    expect(find.text('Push Notifications'), findsOneWidget);
    expect(find.byType(Switch), findsNWidgets(6));

    await tester.tap(find.byType(Switch).first);
    await tester.tap(find.widgetWithText(FilledButton, 'Save Details'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Notification preferences saved.'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Logout'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsNothing);
    expect(find.text('Logout'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Log Out'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('profile switches from guest to the host experience', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Switch To Host'));
    await tester.pumpAndSettle();
    expect(find.text('Switch to Host?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Switch to Host'));
    await tester.pumpAndSettle();
    expect(find.text('3,250 pts'), findsOneWidget);
    expect(find.text('Share your parking spot'), findsOneWidget);
    expect(find.text('Active Listing Card'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('home-notifications-button')));
    await tester.pumpAndSettle();
    expect(find.text('New Parking Request'), findsOneWidget);
    expect(find.text('Reward Earned'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Host • San Francisco, CA'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Switch To Guest'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Switch To Guest'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('host rewards wallet and detail pages are connected', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Switch To Host'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Switch to Host'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rewards'));
    await tester.pumpAndSettle();
    expect(find.text('Host Points'), findsOneWidget);
    expect(find.text('3,250'), findsOneWidget);
    expect(find.text('Bronze Host'), findsOneWidget);
    expect(find.text('Silver Host'), findsOneWidget);

    await tester.tap(find.text('Redeem Rewards'));
    await tester.pumpAndSettle();
    expect(find.text('Redeem Reward?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('View all').first);
    await tester.pumpAndSettle();
    expect(find.text('Available Rewards'), findsOneWidget);
    expect(find.text('50% Off First Drink'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Buy Two Get One Free Pizza'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Buy Two Get One Free Pizza'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Recent Activity'),
      450,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Priority Matching'), findsOneWidget);
    expect(find.text('Featured Listing'), findsOneWidget);
    expect(find.text('Café Reward'), findsOneWidget);
    expect(find.text('Spot Shared Successfully'), findsOneWidget);
    await tester.tap(find.text('View all').last);
    await tester.pumpAndSettle();
    expect(find.text('Shared Parking Spot'), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('Weekly Hosting Streak'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Weekly Hosting Streak'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('host activity uses host stats, timeline and feedback', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Switch To Host'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Switch to Host'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('3,250'), findsOneWidget);
    expect(find.text('Active\nListings'), findsOneWidget);
    expect(find.text('Downtown Plaza'), findsOneWidget);
    expect(find.text('Guest: Sarah Wilson'), findsOneWidget);

    await tester.tap(find.text('Upcoming'));
    await tester.pumpAndSettle();
    expect(find.text('Central Mall Parking'), findsOneWidget);
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Community Favorite'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Trusted Host'), findsOneWidget);
    expect(find.text('Fast Responder'), findsOneWidget);
    expect(find.text('Community Favorite'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Community Feedback'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Community Feedback'), findsOneWidget);
    expect(find.text('Sarah Miller'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('host active and completed chats open their detail flow', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Switch To Host'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Switch To Host'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Switch to Host'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('Elena V.'), findsOneWidget);
    expect(find.text('Marcus T.'), findsOneWidget);
    expect(find.text('Omar Khalid'), findsOneWidget);
    expect(find.text('James K.'), findsOneWidget);

    await tester.tap(find.text('Marcus T.'));
    await tester.pumpAndSettle();
    expect(find.text('Handover in progress'), findsOneWidget);
    expect(find.textContaining('Hey Marcus!'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();
    expect(find.text('Marco Alvarez'), findsOneWidget);
    expect(find.text('Jessica Chen'), findsOneWidget);
    expect(find.text('Noah Bennett'), findsOneWidget);
    await tester.tap(find.text('Marco Alvarez'));
    await tester.pumpAndSettle();
    expect(find.text('Exchange completed'), findsOneWidget);
    expect(find.text('Swap Completed! +50 Points earned.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('parking insights flow renders all responsive sections', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.byTooltip('Use current location'));
    await tester.pumpAndSettle();
    expect(find.text('The Highline Hub'), findsOneWidget);
    expect(find.text('East Village Residence'), findsOneWidget);
    expect(find.text('Parking Stats'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Live Nearby Hosts'),
      350,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Live Nearby Hosts'), findsOneWidget);
    expect(find.text('Marcus'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('AI Insight'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Nearby Rewards'), findsOneWidget);
    expect(find.text('AI Insight'), findsOneWidget);
    expect(find.text('Find Parking'), findsOneWidget);
  });

  testWidgets('home notification bell opens notifications', (tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.tap(find.byKey(const ValueKey('home-notifications-button')));
    await tester.pumpAndSettle();

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Parking Spot Found'), findsOneWidget);
  });

  testWidgets('home View All opens Wait and Dine', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const AppBootstrap());
    await _signIn(tester);

    await tester.drag(find.text('Reserve Spot'), const Offset(0, -420));
    await tester.pumpAndSettle();
    await tester.drag(find.text('Reserve Spot'), const Offset(0, -420));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View All'));
    await tester.pumpAndSettle();

    expect(find.text('Wait & Dine'), findsOneWidget);
    expect(find.text('Bella Italia'), findsOneWidget);
  });
}

Future<void> _openLogin(WidgetTester tester) async {
  await tester.pump(AppConstants.splashDuration);
  await tester.pumpAndSettle();
}

Future<void> _signIn(WidgetTester tester) async {
  await _openLogin(tester);
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), 'user@example.com');
  await tester.enterText(fields.at(1), 'password123');
  await tester.tap(find.widgetWithText(FilledButton, 'Login'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pumpAndSettle();
}

Future<List<int>> _captureRawRgba(
  WidgetTester tester,
  Finder boundaryFinder,
) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(boundaryFinder);
  final pixels = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    return data!.buffer.asUint8List().toList(growable: false);
  });
  return pixels!;
}
