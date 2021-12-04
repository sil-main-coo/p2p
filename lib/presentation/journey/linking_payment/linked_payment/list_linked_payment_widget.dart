import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/linked_payment_loan_detail_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/svg_icon_button.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_navigator_widget.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/payment_account_step/cubit/payment_account_step_cubit.dart';
import '../acttion_payment_screen_enum.dart';
import '../linking_payment_route.dart';
import 'linked_payment_bottom_sheet.dart';

class ListLinkedPaymentWidget extends StatelessWidget {
  ListLinkedPaymentWidget(
      {Key? key, required this.linkedPayments, required this.action})
      : super(key: key) {
    switch (action) {
      case ActionPaymentScreenEnum.SELECT:
        labelPaymentList = S.current.selectLinkedPayment;
        enableSelect = true;
        break;
      case ActionPaymentScreenEnum.MANAGER:
        labelPaymentList = S.current.linkedPayments;
        enableSelect = false;
        break;
    }
  }

  final List<LinkedPaymentResponse> linkedPayments;
  final ActionPaymentScreenEnum action;

  late String labelPaymentList;
  late bool enableSelect;

  void _pushToAddNewPayment(BuildContext context) async {
    final linkedPayment = await Navigator.pushNamed(
        context, LinkingPaymentRoute.addLinkingPaymentID);

    // add new payment to linked payment list
    if (linkedPayment != null && linkedPayment is LinkedPaymentResponse) {
      BlocProvider.of<PaymentManagerCubit>(context)
          .addLinkedPayment(linkedPayment);
    }
  }

  void _paymentSelected(
      BuildContext context, LinkedPaymentResponse linkedPayment) {
    BlocProvider.of<PaymentAccountStepCubit>(context)
        .linkedPaymentChanged(linkedPayment);
  }

  @override
  Widget build(BuildContext context) {
    if (action == ActionPaymentScreenEnum.SELECT) {
      return BlocBuilder<PaymentAccountStepCubit, PaymentAccountStepState>(
        builder: (context, state) {
          if (state is PaymentAccountStepLoaded) {
            return _bodyWidget(context,
                linkedPaymentSelected: state.linkedPaymentSelected);
          }
          return SizedBox();
        },
      );
    }

    return _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context,
      {LinkedPaymentLoanDetailResponse? linkedPaymentSelected}) {
    return CompactLayout(
      child: Column(
        children: [
          _listPayment(context, linkedPaymentSelected),
          VerticalSpace(
            height: 40,
          ),
          _addNewPayment(context)
        ],
      ),
    );
  }

  Widget _listPayment(BuildContext context,
      LinkedPaymentLoanDetailResponse? linkedPaymentSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelPaymentList,
          style: Theme.of(context).textTheme.textLabelTextField,
        ),
        VerticalSpace.init8(),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: linkedPayments.length,
          itemBuilder: (context, index) {
            final itemData = linkedPayments[index];
            final isSelected = (linkedPaymentSelected != null &&
                itemData.id == linkedPaymentSelected.id);

            return _paymentItem(context, itemData, isSelected);
          },
          separatorBuilder: (context, index) => VerticalSpace.init8(),
        )
      ],
    );
  }

  Widget _paymentItem(BuildContext context, LinkedPaymentResponse linkedPayment,
      bool isSelected) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;
    final numberPaymentStyle = Theme.of(context).textTheme.textValueListTile;

    return GestureDetector(
      onTap:
          enableSelect ? () => _paymentSelected(context, linkedPayment) : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? mColorBorderGreen : mColorBordersLines),
            borderRadius: BorderRadius.all(Radius.circular(8.w))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: linkedPayment.iconPath!,
                ),
                HorizontalSpace.init16(),
                Text(
                  linkedPayment.serviceName?? 'Unknown',
                  style: titleStyle,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '•••• ${linkedPayment.getFourLastNumberAccount}',
                  style: numberPaymentStyle,
                ),
                HorizontalSpace.init4(),
                SvgIconButton(
                  onTap: () => LinkedPaymentBottomSheet.show(
                      context: context,
                      paymentManagerCubit:
                          BlocProvider.of<PaymentManagerCubit>(context),
                      payment: linkedPayment),
                  size: 16.w,
                  iconColor: mColorIconGreen,
                  iconPath: IconConstants.icDetail,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _addNewPayment(BuildContext context) {
    return AppListTileNavigatorWidget(
      label: S.current.addNewAccount,
      title: S.current.addLinkedPayment,
      colorBgIcon: mColorPlaceholder,
      leadingIcon: Icon(
        Icons.add,
        size: 18.w,
        color: Colors.white,
      ),
      callBack: () => _pushToAddNewPayment(context),
    );
  }
}
