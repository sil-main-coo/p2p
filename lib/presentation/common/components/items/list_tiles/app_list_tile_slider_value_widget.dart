import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'app_list_tile_title_value_widget.dart';

@immutable
class AppListTileSliderValueWidget extends StatefulWidget {
  final bool hideTopBorder;
  final bool hideBottomBorder;
  final int min;
  final int max;

  final String titleLabel;
  final Function(dynamic) onChanged;
  final double stepSize;
  final String valueCurrencyText;
  final String labelCurrencyText;
  final String formatValue; // ex: "million" or "day" , ...
  final int? initValue;

  AppListTileSliderValueWidget(
      {Key? key,
      this.initValue,
      this.hideBottomBorder = false,
      this.hideTopBorder = false,
      required this.titleLabel,
      required this.max,
      required this.min,
      required this.onChanged,
      required this.stepSize,
      required this.formatValue,
      required this.valueCurrencyText,
      required this.labelCurrencyText})
      : super(key: key);

  @override
  _AppListTileSliderValueWidgetState createState() =>
      _AppListTileSliderValueWidgetState();
}

class _AppListTileSliderValueWidgetState
    extends State<AppListTileSliderValueWidget> {
  late num _value;

  @override
  void initState() {
    if (widget.initValue == null) {
      _value = widget.min;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initValue != null) {
      _value = widget.initValue!;
    }

    if (_value > widget.max) {
      _value = widget.min;
    }

    final border = BorderSide(width: 1, color: mColorBordersLines);

    final borderSetup = (widget.hideTopBorder && widget.hideBottomBorder)
        ? null
        : (!widget.hideTopBorder && !widget.hideBottomBorder)
            ? Border.symmetric(horizontal: border)
            : widget.hideTopBorder
                ? Border(bottom: border)
                : Border(top: border);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: borderSetup,
        ),
        child: Column(
          children: [
            AppListTileTitleValueWidget(
              titleLabel: widget.titleLabel,
              valueText:
                  '${_value.toFormatNumberStringWithUnit(widget.formatValue)}'
                  '${widget.valueCurrencyText.toLowerCase()}',
              hideBottomBorder: true,
              hideTopBorder: true,
              paddingZero: true,
              isBoldValueText: true,
            ),
            SfSliderTheme(
              data: SfSliderThemeData(
                  thumbStrokeWidth: 2.w,
                  thumbStrokeColor: mColorGradient,
                  thumbRadius: 8.w,
                  thumbColor: Colors.white,
                  inactiveTrackHeight: 4.h,
                  activeTrackHeight: 4.h,
                  inactiveTrackColor: mColorBordersLines),
              child: Column(
                children: [
                  VerticalSpace(height: 8),
                  SizedBox(
                    height: 8.h,
                    child: SfSlider(
                      min: widget.min,
                      max: widget.max,
                      value: _value,
                      trackShape: CustomTrackShape(),
                      stepSize: widget.stepSize,
                      labelFormatterCallback: (actualValue, formattedText) {
                        return '$formattedText ${widget.labelCurrencyText.toUpperCase()}';
                      },
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = (value as num).toInt();
                          widget.onChanged(value);
                        });
                      },
                    ),
                  ),
                  VerticalSpace(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.min} ${widget.labelCurrencyText.toUpperCase()}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '${widget.max} ${widget.labelCurrencyText.toUpperCase()}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends SfTrackShape {
  @override
  Rect getPreferredRect(
      RenderBox parentBox, SfSliderThemeData sliderTheme, Offset offset,
      {bool? isActive}) {
    final double? trackHeight = sliderTheme.activeTrackHeight;
    final double trackTop = offset.dy;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(16, trackTop, trackWidth, trackHeight!);
  }
}
