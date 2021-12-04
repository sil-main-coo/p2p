import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class NotificationItemWidget extends StatefulWidget {
  const NotificationItemWidget(this.isNew, {Key? key}) : super(key: key);

  final bool isNew;

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  late Color _borderColor, _contentColor, _timeColor;
  late bool _isNew;

  final String _title = 'Bạn đã nhận tiền từ nhà đầu tư';
  final String _message =
      'Xin chào Minh, bạn đã nhận được 2.000.000đ từ nhà đầu tư.';
  final String _time = '2 giờ trước';

  @override
  void initState() {
    super.initState();
    _isNew = widget.isNew;
  }

  @override
  Widget build(BuildContext context) {
    if (_isNew) {
      _borderColor = mColorBorderGreen;
      _contentColor = mColorBodyText;
      _timeColor = mColorBodyTextGreen;
    } else {
      _borderColor = mColorBordersLines;
      _contentColor = mColorDescription;
      _timeColor = mColorSubtext;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_isNew) {
          setState(() {
            _isNew = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(color: _borderColor)),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: Theme.of(context)
                  .textTheme
                  .textTitleBodySize
                  .copyWith(color: _contentColor),
            ),
            VerticalSpace.init4(),
            Text(
              _message,
              style: Theme.of(context)
                  .textTheme
                  .textDescriptionBlackNormal
                  .copyWith(color: _contentColor),
            ),
            VerticalSpace.init8(),
            Text(
              _time,
              style: Theme.of(context)
                  .textTheme
                  .textDescriptionGreenNormal
                  .copyWith(color: _timeColor),
            ),
          ],
        ),
      ),
    );
  }
}
