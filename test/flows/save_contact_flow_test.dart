import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  testWidgets('Should save a contact', (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    final transactionWebClient = TransactionWebClient();
    await tester.pumpWidget(
      BytebankApp(
        transactionWebClient: transactionWebClient,
        contactDao: mockContactDao,
      ),
    );

    final dashboard = find.byType(Dashboard);

    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contacstList = find.byType(ContactsList);
    expect(contacstList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate(
      (Widget widget) => textByLabelTextMatcher(widget, 'Full name'),
    );
    expect(nameTextField, findsOneWidget);

    await tester.enterText(nameTextField, 'Samuel');

    final accountNumberTextField = find.byWidgetPredicate(
      (Widget widget) => textByLabelTextMatcher(widget, 'Account number'),
    );
    expect(accountNumberTextField, findsOneWidget);

    await tester.enterText(accountNumberTextField, '1200');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(0, 'Samuel', 1200)));

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}
