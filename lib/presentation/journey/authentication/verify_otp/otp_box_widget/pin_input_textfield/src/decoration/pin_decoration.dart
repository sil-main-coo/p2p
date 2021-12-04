import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_box_widget/pin_input_textfield/src/cursor/cursor_painter.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_box_widget/pin_input_textfield/src/util/radius_util.dart';

import '../../pin_input_text_field.dart';
import '../style/obscure.dart';
import '../util/utils.dart';

part 'decoration_boxloose.dart';
part 'decoration_boxtight.dart';
part 'decoration_circle.dart';
part 'decoration_underline.dart';
part 'decoration_no_border.dart';

enum PinEntryType {
  underline,
  boxTight,
  boxLoose,
  circle,
  customized,
  noBorder
}

class SupportGap {
  /// The adjacent box gap.
  double get getGapWidth => 0;

  /// The gaps between every two adjacent box, higher priority than [gapSpace].
  List<double>? get getGapWidthList => const [];
}

abstract class PinDecoration {
  /// The style of painting text.
  final TextStyle? textStyle;

  /// The style of obscure text.
  final ObscureStyle? obscureStyle;

  /// The error text that will be displayed if any error
  final String? errorText;

  /// The style of error text.
  final TextStyle? errorTextStyle;

  final String? hintText;

  final TextStyle? hintTextStyle;

  // The background color of index character
  final ColorBuilder? bgColorBuilder;

  PinEntryType get pinEntryType;

  const PinDecoration({
    this.textStyle,
    this.obscureStyle,
    this.errorText,
    this.errorTextStyle,
    this.hintText,
    this.hintTextStyle,
    this.bgColorBuilder,
  });

  void drawPin(
    Canvas canvas,
    Size size,
    String text,
    int pinLength,
    Cursor? cursor,
  );

  void notifyChange(String pin);

  /// Creates a copy of this pin decoration with the given fields replaced
  /// by the new values.
  PinDecoration copyWith({
    TextStyle? textStyle,
    ObscureStyle? obscureStyle,
    String? errorText,
    TextStyle? errorTextStyle,
    String? hintText,
    TextStyle? hintTextStyle,
    ColorBuilder? bgColorBuilder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinDecoration &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          obscureStyle == other.obscureStyle &&
          errorText == other.errorText &&
          errorTextStyle == other.errorTextStyle &&
          hintText == other.hintText &&
          hintTextStyle == other.hintTextStyle &&
          bgColorBuilder == other.bgColorBuilder;

  @override
  int get hashCode =>
      textStyle.hashCode ^
      obscureStyle.hashCode ^
      errorText.hashCode ^
      errorTextStyle.hashCode ^
      hintText.hashCode ^
      hintTextStyle.hashCode ^
      bgColorBuilder.hashCode;

  @override
  String toString() {
    return 'PinDecoration{textStyle: $textStyle, obscureStyle: $obscureStyle, errorText: $errorText, errorTextStyle: $errorTextStyle, hintText: $hintText, hintTextStyle: $hintTextStyle, bgColorBuilder: $bgColorBuilder}';
  }
}
