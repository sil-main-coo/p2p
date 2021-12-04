part of style;

final Color mColorNavigationBar = mColorBackground;
const Color mColorBackground = Colors.white;
final Color mStatusColor = mColorBackground;

final Color mPrimaryColor = HexColor.fromHex('#3FAA61');
final Color mAccentColor = mColorHighlight;

// button
final Color mButtonColorNoActive = mColorPlaceholder;
final Color mTextButtonDark = mColorDescription;

final Color mColorDots = mColorBodyTextGreen;
final Color mColorBodyTextGreen = HexColor.fromHex('#3EAA5F');
final Color mColorBodyTextWhite = Colors.white;
final Color mColorIconDark = HexColor.fromHex('#00142A');
const Color mColorIconWhite = Colors.white;
final Color mColorIconGreen = HexColor.fromHex('#3EAA5F');
final Color mColorBorderGreen = HexColor.fromHex('#3EAA5F');
final Color mColorDottedBorder = HexColor.fromHex('#C0C5D1');

// base color
final Color mColorHighlight = HexColor.fromHex('#3BAB63');
final Color mColorGradient = HexColor.fromHex('#218043');
final Color mColorLight = HexColor.fromHex('#E7F9EE');
final Color mColorAvg = HexColor.fromHex('#ED8A17');
final Color mColorBad = HexColor.fromHex('#DA3535');
final Color mColorBodyText = HexColor.fromHex('#08121E');
final Color mColorDescription = HexColor.fromHex('#4D6678');
final Color mColorSubtext = HexColor.fromHex('#8EA3AF');
final Color mColorPlaceholder = HexColor.fromHex('#B8C9D3');
final Color mColorBordersLines = HexColor.fromHex('#E3EBF0');
final Color mColorBorderLinesLight = HexColor.fromHex('#C9E8D4');
final Color mColorTabBarBg = HexColor.fromHex('#F1F5F8');
final Color mColorFacebook = HexColor.fromHex('#3B6FAB');
final Color mColorBgPaidGreen = HexColor.fromHex('#94D4AB');

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
