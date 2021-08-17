import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpWidget({
    @required Widget widget,
    @required WidgetTester tester,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );
  }

  testWidgets(
    'Should display the main image when the Dashboard is opened',
    (WidgetTester tester) async {
      await pumpWidget(widget: Dashboard(), tester: tester);
      final mainImage = find.byType(Image);

      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
    'Shoud display the transfer feature when the Dashboard is opened',
    (WidgetTester tester) async {
      await pumpWidget(widget: Dashboard(), tester: tester);

      final transferFeatureItem = find.byWidgetPredicate(
        (Widget widget) => featureItemMatcher(
          widget: widget,
          name: 'Transfer',
          icon: Icons.monetization_on,
        ),
      );

      expect(transferFeatureItem, findsOneWidget);
    },
  );

  testWidgets(
      'Shoud display the transaction feed feature when the Dashboard is opened',
      (WidgetTester tester) async {
    await pumpWidget(widget: Dashboard(), tester: tester);

    final iconTransactionFeedFeatureItem =
        find.widgetWithIcon(FeatureItem, Icons.description);

    expect(iconTransactionFeedFeatureItem, findsOneWidget);

    final nameTransactionFeedFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(
        widget: widget,
        name: 'Transaction Feed',
        icon: Icons.description,
      ),
    );

    expect(nameTransactionFeedFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher({
  @required Widget widget,
  @required String name,
  @required IconData icon,
}) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}
