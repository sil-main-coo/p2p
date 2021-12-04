part of style;

//w100 Thin, the least thick
//w200 Extra-light
//w300 Light
//w400 Normal / regular / plain
//w500 Medium
//w600 Semi-bold
//w700 Bold
//w800 Extra-bold
//w900 Black, the most thick

class AppThemes {
  static ThemeData defaultTheme() {
    return ThemeData(
      // Define the default brightness and colors.
      primaryColor: mAccentColor,
      accentColor: mAccentColor,
      scaffoldBackgroundColor: mColorBackground,

      appBarTheme: AppBarTheme(
        color: mColorBackground,
        elevation: dimen_0,
        iconTheme: IconThemeData(color: mColorIconDark),
      ),
      buttonTheme: ButtonThemeData(
        height: 44.h,
        buttonColor: mColorBodyTextGreen,
        padding: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimen_4)),
        textTheme:
            ButtonTextTheme.primary, //  <-- this auto selects the right color
      ),
      textTheme: TextTheme(
        headline2: TextStyle(
            fontSize: fzHeadline2.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyText,
            letterSpacing: dimen_0_2),
        headline3: TextStyle(
            fontSize: fzHeadline3.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyText,
            letterSpacing: dimen_0_2),
        subtitle1: TextStyle(
            fontSize: fzSubTitle.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyText,
            letterSpacing: dimen_0_2),
        subtitle2: TextStyle(
            fontSize: fzSubTitle.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyTextGreen,
            letterSpacing: dimen_0_2),
        button: TextStyle(
            fontSize: fzBody.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyTextWhite,
            letterSpacing: dimen_0_2),
        bodyText1: TextStyle(
            fontSize: fzBody.sp,
            fontWeight: FontWeight.normal,
            color: mColorBodyText,
            letterSpacing: dimen_0_2),
        bodyText2: TextStyle(
            fontSize: fzCallOut.sp,
            fontWeight: FontWeight.bold,
            color: mColorBodyText,
            letterSpacing: dimen_0_2),
        caption: TextStyle(
            fontSize: fzCaption.sp,
            fontWeight: FontWeight.normal,
            color: mColorDescription,
            letterSpacing: dimen_0_2),
      ),
    );
  }
}

extension ThemeExtension on TextTheme {
  TextStyle get textTitleBodySize => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.w600,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textSub => TextStyle(
      fontSize: fzCaption.sp,
      fontWeight: FontWeight.normal,
      color: mColorSubtext,
      letterSpacing: dimen_0_2);

  TextStyle get textValueListTile => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.normal,
      color: mColorDescription,
      letterSpacing: dimen_0_2);

  TextStyle get textValueListTileSemiBold => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.w600,
      color: mColorSubtext,
      letterSpacing: dimen_0_2);

  TextStyle get textTitleItemLoanProduct => TextStyle(
      fontSize: fzCallOut.sp,
      fontWeight: FontWeight.w500,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textLabelTextField => TextStyle(
      fontSize: fzCaption.sp,
      fontWeight: FontWeight.w600,
      color: mColorDescription,
      letterSpacing: dimen_0_2);

  TextStyle get textContentTextField => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.normal,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textHintTextField =>
      textContentTextField.copyWith(color: mColorPlaceholder);

  TextStyle get textErrorTextField => TextStyle(
      fontSize: fzCaption.sp,
      fontWeight: FontWeight.normal,
      color: mColorBad,
      letterSpacing: dimen_0_2);

  TextStyle get textBodyNormal => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.normal,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textDescriptionGreyNormal => TextStyle(
      fontSize: fzCallOut.sp,
      fontWeight: FontWeight.normal,
      color: mColorDescription,
      letterSpacing: dimen_0_2);

  TextStyle get textDescriptionBlackNormal => TextStyle(
      fontSize: fzCallOut.sp,
      fontWeight: FontWeight.normal,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textDescriptionGreenNormal => TextStyle(
      fontSize: fzCallOut.sp,
      fontWeight: FontWeight.normal,
      color: mColorBodyTextGreen,
      letterSpacing: dimen_0_2);

  TextStyle get textAction => TextStyle(
      fontSize: fzSubTitle.sp,
      fontWeight: FontWeight.w600,
      color: mColorBodyTextGreen,
      letterSpacing: dimen_0_2);

  TextStyle get textBigTitle => TextStyle(
      fontSize: fzHeadline2.sp,
      fontWeight: FontWeight.bold,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textTitleAppbar => TextStyle(
      fontSize: fzSubTitle.sp,
      fontWeight: FontWeight.bold,
      color: mColorBodyText,
      letterSpacing: dimen_0_2);

  TextStyle get textButtonDark => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.w600,
      color: mTextButtonDark,
      letterSpacing: dimen_0_2);

  TextStyle get textFieldOTP => TextStyle(
      fontSize: fzHeadline1.sp,
      fontWeight: FontWeight.normal,
      color: mColorBodyTextGreen,
      letterSpacing: dimen_0_2);

  TextStyle get buttonText => TextStyle(
      fontSize: fzBody.sp,
      fontWeight: FontWeight.w600,
      color: mTextButtonDark,
      letterSpacing: dimen_0_2);
}
