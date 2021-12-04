import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/constants/occupation_enums.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/app_alert_dialog_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';

class SelectOccupationDialog {
  static void show(
      {required BuildContext context,
      required List<OccupationResponse> data,
      OccupationResponse? dataSelected,
      required Function(OccupationResponse) callbackSelect}) {
    // add other element to last occupation array

    showDialog(
      context: context,
      builder: (ct) => _OccupationRadioDialogWidget(
        title: S.current.selectOccupation,
        callbackSelect: callbackSelect,
        data: data,
        dataSelected: dataSelected,
      ),
    );
  }
}

class _OccupationRadioDialogWidget extends StatefulWidget {
  _OccupationRadioDialogWidget(
      {Key? key,
      required this.title,
      required this.data,
      required this.callbackSelect,
      this.dataSelected})
      : super(key: key);

  final String title;
  final List<OccupationResponse> data;
  final OccupationResponse? dataSelected;
  final Function(OccupationResponse) callbackSelect;

  @override
  _OccupationRadioDialogWidgetState createState() =>
      _OccupationRadioDialogWidgetState();
}

class _OccupationRadioDialogWidgetState
    extends State<_OccupationRadioDialogWidget> {
  late int _iSelected;
  late bool _showOtherField;
  final _ctrlOtherField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();
  final _ctrlListView = ScrollController();

  @override
  void initState() {
    _iSelected = widget.dataSelected == null
        ? 0
        : widget.data
            .indexWhere((element) => element.code == widget.dataSelected!.code);

    // check: selected item is other widget?
    if (widget.dataSelected != null &&
        widget.dataSelected!.code ==
            OccupationEnums.Other.toString().enumToName) {
      _showOtherField = true;

      // init text field
      if (widget.dataSelected!.detail != null) {
        _ctrlOtherField.text = widget.dataSelected!.detail!;
      }
    } else {
      _showOtherField = false;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _ctrlListView.dispose();
    _ctrlOtherField.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppAlertDialogWidget(
      title: widget.title,
      contentPadding: EdgeInsets.only(top: 16.h),
      barrierDismissible: false,
      leftLabel: S.current.cancel,
      callBackLeft: () => Navigator.pop(context),
      rightLabel: S.current.select,
      callBackRight: () {
        if (_iSelected == widget.data.length - 1) {
          if (_formKey.currentState!.validate()) {
            widget.data[_iSelected].detail = _ctrlOtherField.text.trim();
            widget.callbackSelect(widget.data[_iSelected]);
            Navigator.pop(context);
          }
        } else {
          widget.callbackSelect(widget.data[_iSelected]);
          Navigator.pop(context);
        }
      },
      content: _radiosWidget(),
    );
  }

  Widget _radiosWidget() {
    final len = widget.data.length;

    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        controller: _ctrlListView,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: len,
        itemBuilder: (context, index) {
          if (index == len - 1) {
            return _itemOtherRadioWidget(index);
          }
          return _itemRadioWidget(index);
        },
      ),
    );
  }

  Widget _itemRadioWidget(int index) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _iSelected = index;
            if (_iSelected == widget.data.length - 1) {
              _showOtherField = true;
              _focusNode.requestFocus();

              // animate scroll to bottom item
              Future.delayed(Duration(milliseconds: 800), () {
                _ctrlListView.animateTo(_ctrlListView.position.extentAfter,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              });
            } else if (_showOtherField) {
              _showOtherField = false;
              _focusNode.unfocus();
            }
          });
        },
        child: Row(
          children: [
            SizedBox(
              height: 16.w,
              width: 16.w,
              child: Radio<int>(
                value: index,
                groupValue: _iSelected,
                onChanged: (value) {},
              ),
            ),
            HorizontalSpace.init16(),
            Text(
              widget.data[index].name!,
              style: titleStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemOtherRadioWidget(int index) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _itemRadioWidget(index),
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 24.w, right: 24.w),
            child: Visibility(
                visible: _showOtherField,
                child: AppTextField(
                  controller: _ctrlOtherField,
                  focusNode: _focusNode,
                  hintText: S.current.hintFiledOccupation,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  validator: (value) {
                    if (AppValidators.isEmptyStringData(value)) {
                      return '';
                    }

                    return null;
                  },
                  inputBorder: OutlineInputBorder(),
                )),
          )
        ],
      ),
    );
  }
}
