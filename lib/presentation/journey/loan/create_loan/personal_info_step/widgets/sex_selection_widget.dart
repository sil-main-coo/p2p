import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:p2p_borrower/common/constants/sex_enums.dart';
import 'package:p2p_borrower/common/utils/map_string_value.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class SexSelectionWidget extends StatefulWidget {
  final Function(String) onChanged;
  final String? initValue;
  final String? errorText;

  const SexSelectionWidget(
      {Key? key, required this.onChanged, this.initValue, this.errorText})
      : super(key: key);

  @override
  _SexSelectionWidgetState createState() => _SexSelectionWidgetState();
}

class _SexSelectionWidgetState extends State<SexSelectionWidget> {
  late String selected;
  final items = SexEnum.values;

  @override
  void initState() {
    super.initState();
    selected = widget.initValue ?? items[0].toString().enumToName;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (widget.errorText != null) {
          return widget.errorText;
        }
        return null;
      },
      builder: (FormFieldState<String> state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                S.current.sex,
                style: Theme.of(context).textTheme.textLabelTextField,
              ),
              Text(
                ' *',
                style: Theme.of(context)
                    .textTheme
                    .textLabelTextField
                    .copyWith(color: mColorBad),
              ),
            ],
          ),
          VerticalSpace.init8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: TagWidget(
                  label: mapSexFromEnum(items[0]),
                  hasError: widget.errorText != null || state.hasError,
                  isSelected: selected == items[0].toString().enumToName,
                  onTap: () {
                    setState(() {
                      selected = items[0].toString().enumToName;
                      widget.onChanged(selected);
                      state.setValue(selected);
                    });
                  },
                ),
              ),
              HorizontalSpace.init8(),
              Expanded(
                flex: 1,
                child: TagWidget(
                  label: mapSexFromEnum(items[1]),
                  isSelected: selected == items[1].toString().enumToName,
                  onTap: () {
                    setState(() {
                      selected = items[1].toString().enumToName;
                      widget.onChanged(selected);
                    });
                  },
                ),
              ),
            ],
          ),
          if (widget.errorText != null || state.hasError)
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                state.errorText ?? widget.errorText!,
                style: Theme.of(context).textTheme.textErrorTextField,
              ),
            )
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget(
      {Key? key,
      this.hasError = false,
      required this.label,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  final String label;
  final bool isSelected;
  final Function onTap;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final labelStyle = isSelected
        ? Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: hasError ? mColorBad : null)
        : Theme.of(context).textTheme.bodyText1!.copyWith(color: mColorSubtext);

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.w)),
            border: Border.all(
                width: 1,
                color: isSelected
                    ? (hasError ? mColorBad : mColorIconGreen)
                    : mColorBordersLines)),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          label,
          style: labelStyle,
        ),
      ),
    );
  }
}
