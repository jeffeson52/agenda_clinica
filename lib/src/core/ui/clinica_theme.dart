
import 'package:agenda_clinica/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class ClinicaTheme {
  static const _defaulInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        ),
        borderSide: BorderSide(color: ColorsConstants.grey)
      );
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaulInputBorder,
      enabledBorder: _defaulInputBorder,
      focusedBorder: _defaulInputBorder,
      errorBorder: _defaulInputBorder.copyWith(
        borderSide: const BorderSide(color: ColorsConstants.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.brow,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    fontFamily: FontConstants.fontFamily
  );
}