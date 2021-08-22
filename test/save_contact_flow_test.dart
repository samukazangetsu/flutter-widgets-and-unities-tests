import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should save a contact', (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
      ),
    );

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
    await tester.pumpAndSettle();

    final contacstList = find.byType(ContactsList);
    expect(contacstList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((Widget widget) {
      if (widget is TextField) {
        return widget.decoration.labelText == 'Full name';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);

    await tester.enterText(nameTextField, 'Samuel');

    final accountNumberTextField = find.byWidgetPredicate((Widget widget) {
      if (widget is TextField) {
        return widget.decoration.labelText == 'Account number';
      }
      return false;
    });
    expect(accountNumberTextField, findsOneWidget);

    await tester.enterText(accountNumberTextField, '1200');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}
