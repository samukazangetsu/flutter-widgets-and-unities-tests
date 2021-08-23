import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/cupertino.dart';

class AppDepdendencies extends InheritedWidget {
  final ContactDao contactDao;

  AppDepdendencies({
    @required this.contactDao,
    @required Widget child,
  }) : super(child: child);

  static AppDepdendencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDepdendencies>();
  }

  @override
  bool updateShouldNotify(AppDepdendencies oldWidget) {
    return contactDao != oldWidget.contactDao;
  }
}
