import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/tooltip/tooltip_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'app_list_tile_widget.dart';

class AppListTileTitleValueWidget extends StatelessWidget {
  AppListTileTitleValueWidget(
      {Key? key,
      this.valueColor,
      this.isScaleDownTitle = false,
      this.isBoldValueText = false,
      required this.titleLabel,
      this.showTooltipButton = false,
      this.verticalAlign = CrossAxisAlignment.center,
      this.descriptionButtonChar,
      this.hideBottomBorder = false,
      this.hideTopBorder = false,
      this.selectValueDialog,
      this.titleFlex = 1,
      this.valueFlex = 1,
      this.descriptionDialog,
      this.showDialogDescription = false,
      this.showSelectValue = false,
      this.subTitleWidget,
      this.paddingZero = false,
      this.tooltipMessage,
      required this.valueText})
      : super(key: key);

  AppListTileTitleValueWidget.withTooltip(
      {Key? key,
      this.valueColor,
      this.isScaleDownTitle = false,
      this.isBoldValueText = false,
      required this.titleLabel,
      this.paddingZero = false,
      this.selectValueDialog,
      this.descriptionButtonChar,
      this.hideBottomBorder = false,
      this.titleFlex = 1,
      this.valueFlex = 1,
      this.hideTopBorder = false,
      this.verticalAlign = CrossAxisAlignment.center,
      this.showSelectValue = false,
      this.subTitleWidget,
      this.tooltipMessage,
      required this.valueText})
      : super(key: key) {
    showTooltipButton = true;
    showDialogDescription = false;
    descriptionDialog = null;
  }

  AppListTileTitleValueWidget.withDescriptionDialog(
      {Key? key,
      this.valueColor,
      this.isScaleDownTitle = false,
      this.isBoldValueText = false,
      required this.titleLabel,
      this.paddingZero = false,
      this.selectValueDialog,
      this.descriptionButtonChar,
      this.hideBottomBorder = false,
      this.titleFlex = 1,
      this.valueFlex = 1,
      this.hideTopBorder = false,
      this.showSelectValue = false,
      this.verticalAlign = CrossAxisAlignment.center,
      required this.descriptionDialog,
      this.subTitleWidget,
      required this.valueText})
      : super(key: key) {
    showTooltipButton = false;
    tooltipMessage = null;
    showDialogDescription = true;
  }

  AppListTileTitleValueWidget.withSelectValue(
      {Key? key,
      this.valueColor,
      this.isBoldValueText = false,
      this.isScaleDownTitle = false,
      required this.titleLabel,
      required this.selectValueDialog,
      this.verticalAlign = CrossAxisAlignment.center,
      this.paddingZero = false,
      this.descriptionButtonChar,
      this.hideBottomBorder = false,
      this.titleFlex = 1,
      this.valueFlex = 1,
      this.hideTopBorder = false,
      this.showSelectValue = true,
      this.subTitleWidget,
      required this.valueText})
      : super(key: key) {
    showTooltipButton = false;
    tooltipMessage = null;
    showDialogDescription = false;
    descriptionDialog = null;
  }

  final String titleLabel;
  final String valueText;
  final bool isBoldValueText;

  final String? descriptionButtonChar;

  late String? tooltipMessage;
  late final bool showTooltipButton;

  late final bool showDialogDescription;
  late final Widget? descriptionDialog;

  final bool hideTopBorder;
  final bool hideBottomBorder;

  final Widget? subTitleWidget;

  final bool paddingZero;

  final bool showSelectValue;
  final Widget? selectValueDialog;
  final int titleFlex, valueFlex;
  final CrossAxisAlignment verticalAlign;
  final bool isScaleDownTitle;
  final Color? valueColor;

  final toolTipKey = GlobalKey<State<Tooltip>>();

  @override
  Widget build(BuildContext context) {
    return AppListTileWidget(
        titleFlex: titleFlex,
        valueFlex: valueFlex,
        paddingZero: paddingZero,
        verticalAlign: verticalAlign,
        hideBottomBorder: hideBottomBorder,
        hideTopBorder: hideTopBorder,
        title: isScaleDownTitle
            ? FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: _titleWidget(context))
            : _titleWidget(context),
        value: _valueWidget(context));
  }

  Widget _titleWidget(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBodyNormal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                titleLabel,
                style: titleStyle,
                textAlign: TextAlign.start,
              ),
            ),
            if (showTooltipButton &&
                tooltipMessage != null &&
                descriptionButtonChar != null)
              _toolTipWidget(context),
            if (showDialogDescription) _callbackDialogDescription(context)
          ],
        ),
        if (subTitleWidget != null) _subTitleWidget()
      ],
    );
  }

  Widget _valueWidget(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.textValueListTile.copyWith(
        fontWeight: isBoldValueText ? FontWeight.w600 : null,
        color: valueColor);

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: showSelectValue ? () => _showSelectValueDialog(context) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              valueText,
              style: valueStyle,
              textAlign: TextAlign.end,
            ),
            if (showSelectValue)
              Row(
                children: [
                  VerticalSpace.init4(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: mColorBodyTextGreen,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }

  void _showSelectValueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ct) => selectValueDialog!,
    );
  }

  Widget _subTitleWidget() {
    return Column(
      children: [VerticalSpace.init8(), subTitleWidget!],
    );
  }

  Widget _callbackDialogDescription(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (ct) => descriptionDialog!);
      },
      child: _descriptionButton(),
    );
  }

  Widget _descriptionButton() {
    return Container(
      height: 12.w,
      width: 12.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: mColorPlaceholder,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        descriptionButtonChar!,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9.sp,
            color: Colors.white,
            letterSpacing: 0.2),
      ),
    );
  }

  Widget _toolTipWidget(BuildContext context) {
    return TooltipWidget(
      backgroundColor: Colors.black,
      content: Text(tooltipMessage!,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.white)),
      icon: _descriptionButton(),
      widthBox: 172.w,
    );
  }
}
