import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  testWidgets('Should save a contact', (WidgetTester tester) async {
    await tester.pumpWidget(BytebankApp());

    final dashboard = find.byType(Dashboard);

    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(
        widget: widget,
        name: 'Transfer',
        icon: Icons.monetization_on,
      ),
    );

    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    await tester.pump();
    await tester.pump();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    await tester.tap(fabNewContact);
    await tester.pump();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
  });
}
