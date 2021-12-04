import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'big_title_layout.dart';

class GreenAlertLayout extends StatelessWidget {
  const GreenAlertLayout(
      {Key? key,
      this.btnLabel2,
      this.onPressed2,
      required this.title,
      required this.msg,
      required this.btnLabel1,
      required this.onPressed1})
      : super(key: key);

  final String title, msg;
  final String btnLabel1;
  final String? btnLabel2;
  final Function onPressed1;
  final Function? onPressed2;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.textBigTitle.copyWith(color: Colors.white);
    final messageStyle = Theme.of(context)
        .textTheme
        .textDescriptionGreyNormal
        .copyWith(color: mColorLight);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [mColorHighlight, mColorGradient],
          )),
          child: BigTitleLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(
                  height: 72,
                ),
                Text(
                  title,
                  style: titleStyle,
                ),
                VerticalSpace.init16(),
                Text(
                  msg,
                  style: messageStyle,
                ),
                VerticalSpace.init32(),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white,
                    child: Text(
                      btnLabel1,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: mColorDescription),
                    ),
                    onPressed: () {
                      onPressed1();
                    },
                  ),
                ),
                VerticalSpace.init16(),
                if (btnLabel2 != null)
                  Center(
                    child: AppTextButton(
                        label: btnLabel2!,
                        textColor: Colors.white,
                        onPressed: () {
                          onPressed2!();
                        }),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
