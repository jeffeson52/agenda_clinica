import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocussExtension on BuildContext {
  void unfocus() => FocusScope.of(this).unfocus();
}