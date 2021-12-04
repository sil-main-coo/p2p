extension IntegerExtension on int {
  String get toStandardized {
    if (this < 10 && -10 < this) {
      return "0$this";
    }
    return this.toString();
  }

  String get toMinuteSecond {
    int minute = this ~/ 60;
    int second = this - minute * 60;

    return '${minute.toStandardized}:${second.toStandardized}';
  }
}
