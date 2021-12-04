import 'package:intl/intl.dart';

List<int> months31 = [1, 3, 5, 7, 8, 10, 12];

class DateTimeFormatConstants {
  static const iso8601WithMillisecondsOnly = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const defaultDateTimeFormat = 'dd/MM/yyyy';
  static const scheduleVideoKycCallDateFormat = 'dd-MM-yyyy';
  static const scheduleVideoKycCallTimeFormat = 'HH:mm';
  static const defaultDateTimeWithHourMinute = 'dd/MM/yyyy HH:mm';
}

class DateTimeCalendarConstants {
  static DateTime defaultTomorrowISODate =
      DateTime.now().add(const Duration(days: 1));
  static DateTime defaultMaxDate =
      defaultTomorrowISODate.add(const Duration(days: 3650));
  static DateTime defaultMinDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  static DateTime tomorrowDate = DateTime(defaultTomorrowISODate.year,
      defaultTomorrowISODate.month, defaultTomorrowISODate.day);
  static Duration timeDifferenceOfGMTWithWIB = const Duration(hours: 7);
  static const int totalHoursInDay = 24;
  static const int defaultHoursRemaining = 1;
}

extension DateTimeExtensions on DateTime {
  DateTime get yesterday {
    DateModel dateModel =
        DateModel(day: this.day, month: this.month, year: this.year);

    final bool isLeapYear = dateModel.isLeapYear();

    if (dateModel.day == 1) {
      switch (dateModel.month) {
        case 1:
          return dateModel.previousYear();
        case 3:
          if (isLeapYear) return dateModel.previousLeapMonth();
          return dateModel.previousMonth28();
        case 2:
        case 4:
        case 6:
        case 9:
        case 11:
          return dateModel.previousMonth31();
        default:
          return dateModel.previousDay();
      }
    } else {
      return dateModel.previousDay();
    }
  }

  bool isOldMonth(DateTime dateTime) {
    return this.year < dateTime.year ||
        (this.year == dateTime.year && this.month < dateTime.month);
  }

  bool isThisMonth(DateTime dateTime) {
    return this.year == dateTime.year && this.month == dateTime.month;
  }

  DateTime startOfWeek() {
    final result = this.subtract(Duration(days: this.weekday - 1));
    return DateTime(result.year, result.month, result.day);
  }

  DateTime endOfWeek() {
    final result =
        this.add(Duration(days: DateTime.daysPerWeek - this.weekday));
    return DateTime(result.year, result.month, result.day);
  }

  String get toStringDefault {
    final formatter = DateFormat(DateTimeFormatConstants.defaultDateTimeFormat);
    final String formatted = formatter.format(this);
    return formatted;
  }

  String get toStringDefaultWithHourMinute {
    final formatter = DateFormat(DateTimeFormatConstants.defaultDateTimeWithHourMinute);
    final String formatted = formatter.format(this);
    return formatted;
  }

  String get toISO8601WithMillisecondsOnly {
    final formatter =
        DateFormat(DateTimeFormatConstants.iso8601WithMillisecondsOnly);
    final String formatted = formatter.format(this);
    return formatted;
  }

  DateTime addMonth({required int value}) {
    var newDate = DateTime(this.year, this.month + value, this.day);
    return newDate;
  }

  DateTime subMonth({required int value}) {
    assert(value != null);
    var newDate = DateTime(this.year, this.month - value, this.day);
    return newDate;
  }

  DateTime addDay({required int value}) {
    assert(value != null);
    var newDate = DateTime(this.year, this.month, this.day + value);
    return newDate;
  }

  DateTime subDay({required int value}) {
    assert(value != null);
    var newDate = DateTime(this.year, this.month, this.day - value);
    return newDate;
  }

  bool get isToday {
    final now = DateTime.now();
    return (now.day == this.day &&
        now.month == this.month &&
        now.year == this.year);
  }

  DateTime get today {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime get lastDayOfMonth {
    return DateTime(this.year, this.month + 1, 0);
  }

  DateTime get firstDayOfMonth {
    return DateTime(this.year, this.month, 1);
  }

  DateTime get firstDayMonthOfOneYearBefore {
    return DateTime(this.year, this.month - 11, 1);
  }

  DateTime get firstDayOfYear {
    return DateTime(this.year, 1, 1);
  }

  DateTime get lastDayOfYear {
    return DateTime(this.year, 12, 31);
  }

  int differenceDay({required DateTime input}) {
    final result = input.difference(this).inDays;
    return result;
  }

  int get earlyMonth =>
      DateTime(this.year, this.month, 1).millisecondsSinceEpoch;

  int? get endMonth {
    switch (this.month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return DateTime(this.year, this.month, 31).millisecondsSinceEpoch;
      case 4:
      case 6:
      case 9:
      case 11:
        return DateTime(this.year, this.month, 30).millisecondsSinceEpoch;
      case 2:
        if (this.year % 4 == 0 && this.year % 100 != 0)
          return DateTime(this.year, this.month, 29).millisecondsSinceEpoch;
        else
          return DateTime(this.year, this.month, 28).millisecondsSinceEpoch;
    }
  }

  DateTime get tomorrow {
    DateModel dateModel =
        DateModel(day: this.day, month: this.month, year: this.year);
    final bool isLeapYear = dateModel.isLeapYear();

    switch (dateModel.day) {
      case 28:
        if (month == 2 && isLeapYear) return dateModel.nextDay();
        return dateModel.nextMonth();
      case 29:
        if (month == 2)
          return dateModel.nextMonth();
        else
          return dateModel.nextDay();
      case 30:
        if (months31.contains(month))
          return dateModel.nextDay();
        else
          return dateModel.nextMonth();
      case 31:
        if (month == 12) return dateModel.nextYear();
        return dateModel.nextMonth();
      default:
        return dateModel.nextDay();
    }
  }

  /// The ISO 8601 week of year [1..53].
  ///
  /// Algorithm from https://en.wikipedia.org/wiki/ISO_week_date#Algorithms
  int get weekOfYear {
    // Add 3 to always compare with January 4th, which is always in week 1
    // Add 7 to index weeks starting with 1 instead of 0
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  /// The ordinal date, the number of days since December 31st the previous year.
  ///
  /// January 1st has the ordinal date 1
  ///
  /// December 31st has the ordinal date 365, or 366 in leap years
  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  int get currentTimer {
    final int year = this.year;
    final int month = this.month;
    final int day = this.day;
    final DateTime mDay = DateTime(year, month, day);
    final currentTimerMs =
        this.millisecondsSinceEpoch - mDay.millisecondsSinceEpoch;
    return currentTimerMs;
  }
}

class DateModel {
  int? day;
  int? month;
  int? year;

  DateModel({this.day, this.month, this.year});

  DateTime nextDay() {
    day = day! + 1;
    return DateTime(year!, month!, day!);
  }

  DateTime previousDay() {
    day = day! - 1;
    return DateTime(year!, month!, day!);
  }

  DateTime nextMonth() {
    day = 1;
    month = month! + 1;
    return DateTime(year!, month!, day!);
  }

  DateTime previousMonth31() {
    month = month! - 1;
    day = 31;
    return DateTime(year!, month!, day!);
  }

  DateTime previousMonth30() {
    month = month! - 1;
    day = 30;
    return DateTime(year!, month!, day!);
  }

  DateTime previousLeapMonth() {
    month = 2;
    day = 29;
    return DateTime(year!, month!, day!);
  }

  DateTime previousMonth28() {
    month = 2;
    day = 28;
    return DateTime(year!, month!, day!);
  }

  DateTime nextYear() {
    day = 1;
    month = 1;
    year = year! + 1;
    return DateTime(year!, month!, day!);
  }

  DateTime previousYear() {
    day = 31;
    month = 12;
    year = year! - 1;
    return DateTime(year!, month!, day!);
  }

  bool isLeapYear() {
    if (year! % 4 == 0 && year! % 100 != 0) return true;
    return false;
  }
}
