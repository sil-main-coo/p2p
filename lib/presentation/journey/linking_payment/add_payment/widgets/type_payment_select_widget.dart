import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/linking_payment_cubit/linking_payment_cubit.dart';

class TypePaymentSelectWidget extends StatelessWidget {
  int? _selected;

  final _heightItem = 55.h;
  final _widthItem = 168.w;

  TypePaymentSelectWidget(this._selected);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(context),
        VerticalSpace.init8(),
        _paymentSelectWidget(),
      ],
    );
  }

  Widget _labelWidget(BuildContext context) {
    return Text(
      S.current.selectPaymentType,
      style: Theme.of(context).textTheme.textLabelTextField,
    );
  }

  Widget _paymentSelectWidget() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: (_widthItem / _heightItem)),
      // padding: EdgeInsets.all(8),
      shrinkWrap: true,
      primary: false,
      itemCount: 2,
      itemBuilder: (context, index) {
        return _paymentItemWidget(context, index);
      },
    );
  }

  Widget _paymentItemWidget(BuildContext context, int index) {
    final isSelected = _selected != null && _selected == index;

    return GestureDetector(
      onTap: () {
        _unFocusGlobal(context);
        BlocProvider.of<LinkingPaymentCubit>(context).tabChanged(index);
      },
      child: Container(
        height: _heightItem,
        width: _widthItem,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: isSelected ? mColorHighlight : mColorBordersLines),
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: isSelected ? 1 : 0.5,
              child: SvgPicture.asset(
                index == 0 ? IconConstants.icBank : IconConstants.icWallet,
                color: isSelected ? mColorIconGreen : mColorSubtext,
                fit: BoxFit.scaleDown,
                width: 24.w,
                height: 24.w,
              ),
            ),
            HorizontalSpace.init8(),
            SizedBox(
              height: 30.h,
              width: 107.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  index == 0 ? S.current.bank : S.current.virtualWallet,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: isSelected ? mColorBodyText : mColorDescription),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// UnFocus text field
  void _unFocusGlobal(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
