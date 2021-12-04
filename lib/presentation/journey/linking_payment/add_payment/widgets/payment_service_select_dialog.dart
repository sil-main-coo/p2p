import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/app_alert_dialog_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';

class PaymentServiceSelectDialog {
  static void show(
      {required BuildContext context,
      required List<PaymentServiceResponse> data,
      PaymentServiceResponse? dataSelected,
      required Function(PaymentServiceResponse) callbackSelect}) {
    // add other element to last occupation array

    showDialog(
      context: context,
      builder: (ct) => _PaymentServiceSelectDialogWidget(
        title: S.current.selectOccupation,
        callbackSelect: callbackSelect,
        data: data,
        dataSelected: dataSelected,
      ),
    );
  }
}

class _PaymentServiceSelectDialogWidget extends StatefulWidget {
  _PaymentServiceSelectDialogWidget(
      {Key? key,
      required this.title,
      required this.data,
      required this.callbackSelect,
      this.dataSelected})
      : super(key: key);

  final String title;
  final List<PaymentServiceResponse> data;
  final PaymentServiceResponse? dataSelected;
  final Function(PaymentServiceResponse) callbackSelect;

  @override
  _PaymentServiceSelectWidgetState createState() =>
      _PaymentServiceSelectWidgetState();
}

class _PaymentServiceSelectWidgetState
    extends State<_PaymentServiceSelectDialogWidget> {
  late PaymentServiceResponse _itemSelected;

  @override
  void initState() {
    print('Init: ${widget.data[0].type}');
    _itemSelected = widget.dataSelected ?? widget.data[0];
    super.initState();
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
        widget.callbackSelect(_itemSelected);
        Navigator.pop(context);
      },
      content: _radiosWidget(),
    );
  }

  Widget _radiosWidget() {
    final len = widget.data.length;

    return SizedBox(
      width: double.maxFinite,
      height: 280.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: len,
        itemBuilder: (context, index) {
          return _itemRadioWidget(widget.data[index]);
        },
      ),
    );
  }

  Widget _itemRadioWidget(PaymentServiceResponse data) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;
    final subStyle = Theme.of(context).textTheme.caption;

    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _itemSelected = data;
          });
        },
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: data.iconPath!,
            ),
            HorizontalSpace.init16(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name!,
                    style: titleStyle,
                  ),
                  Text(
                    data.fullName!,
                    style: subStyle,
                  ),
                ],
              ),
            ),
            HorizontalSpace.init4(),
            SizedBox(
              height: 16.w,
              width: 16.w,
              child: Radio<PaymentServiceResponse>(
                value: data,
                groupValue: _itemSelected,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
