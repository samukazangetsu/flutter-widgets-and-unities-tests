import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

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
