import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'events/events.dart';

void main() {
  testWidgets('Should transfer to a contact', (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(
      BytebankApp(
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
  });
}
