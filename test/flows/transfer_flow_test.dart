import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  MockContactDao mockContactDao;
  MockTransactionWebClient mockTransactionWebClient;
  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockTransactionWebClient();
  });
  testWidgets('Should transfer to a contact', (WidgetTester tester) async {
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: mockTransactionWebClient,
      ),
    );

    final dashboard = find.byType(Dashboard);

    expect(dashboard, findsOneWidget);

    when(mockContactDao.findAll()).thenAnswer(
      (_) async => [
        Contact(0, 'Samuel', 1200),
      ],
    );

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contacstList = find.byType(ContactsList);
    expect(contacstList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Samuel' &&
            widget.contact.accountNumber == 1200;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);

    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Samuel');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('1200');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textByLabelTextMatcher(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);

    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transacationAuthDialog = find.byType(TransactionAuthDialog);
    expect(transacationAuthDialog, findsOneWidget);
  });
}
