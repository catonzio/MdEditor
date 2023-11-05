import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  // TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  double get _width => MediaQuery.of(this).size.width;

  double get _height => MediaQuery.of(this).size.height;
}

extension PaddingExtensions on BuildContext {
  EdgeInsets get padding8 => EdgeInsets.all((_width * 0.01).clamp(4, 12));

  EdgeInsets get padding16 => EdgeInsets.all((_width * 0.02).clamp(8, 24));

  EdgeInsets get padding24 => EdgeInsets.all((_width * 0.03).clamp(12, 36));

  EdgeInsets get padding32 => EdgeInsets.all((_width * 0.04).clamp(16, 48));

  EdgeInsets get padding64 => EdgeInsets.all((_width * 0.08).clamp(32, 96));
}
