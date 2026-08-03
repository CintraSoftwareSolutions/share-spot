import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/features/shared/activity/widgets/dining_offer_card.dart';
import 'package:sharespot/features/shared/activity/widgets/wait_and_dine_view.dart';

void main() {
  testWidgets(
    'Wait & Dine stays above an edge-to-edge Android navigation inset',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 800);
      tester.view.padding = const FakeViewPadding();
      tester.view.viewPadding = const FakeViewPadding(bottom: 24);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetPadding);
      addTearDown(tester.view.resetViewPadding);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaitAndDineView(showBack: true)),
        ),
      );
      await tester.pumpAndSettle();

      final list = find.byType(ListView);
      expect(tester.getBottomRight(list).dy, lessThanOrEqualTo(776));

      await tester.fling(list, const Offset(0, -1200), 1200);
      await tester.pumpAndSettle();

      expect(find.text('The Night Kitchen'), findsOneWidget);
      expect(
        tester.getBottomRight(find.byType(DiningOfferCard).last).dy,
        lessThanOrEqualTo(tester.getBottomRight(list).dy),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
