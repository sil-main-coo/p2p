import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/common/constants/type_payment_enum.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_dropdown.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/linking_payment_cubit/linking_payment_cubit.dart';

import 'payment_service_select_dialog.dart';

class FormLinkingPaymentWidget extends StatelessWidget {
  FormLinkingPaymentWidget({
    required this.ctrlPaymentService,
    required this.services,
    required this.serviceSelected,
    required this.typePayment,
    Key? key,
  }) : super(key: key) {
    switch (this.typePayment) {
      case TypePaymentEnum.Bank:
        selectPaymentLabel = S.current.selectBank;

        fullNameLabel =
            '${S.current.fullName} ${S.current.accountHolder.toLowerCase()}';
        hintFullNameLabel =
            '${S.current.fullName} ${S.current.account.toLowerCase()}';

        numberAccountLabel = S.current.numberAccount;
        hintNumberAccountLabel = '${S.current.example}: 2880444668770';
        break;
      case TypePaymentEnum.VirtualWallet:
        selectPaymentLabel = S.current.selectVirtualWallet;

        fullNameLabel =
            '${S.current.fullName} ${S.current.walletHolder.toLowerCase()}';
        hintFullNameLabel =
            '${S.current.fullName} ${S.current.walletHolder.toLowerCase()}';

        numberAccountLabel =
            '${S.current.phoneNumber} ${S.current.walletHolder.toLowerCase()}';
        hintNumberAccountLabel = '${S.current.example}: 0983155632';
        break;
    }
  }

  final TypePaymentEnum typePayment;
  final List<PaymentServiceResponse> services;
  final PaymentServiceResponse? serviceSelected;
  final TextEditingController ctrlPaymentService;

  late String selectPaymentLabel;

  late String fullNameLabel;
  late String hintFullNameLabel;

  late String numberAccountLabel;
  late String hintNumberAccountLabel;

  final _fcFullName = FocusNode();
  final _fcAccountNumber = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectPaymentWidget(context),
        VerticalSpace(
          height: 28,
        ),
        if (serviceSelected != null) _fieldWidgets(context)
      ],
    );
  }

  Widget _selectPaymentWidget(BuildContext context) {
    return AppTextFieldSuffixDropDown(
      initialValue: serviceSelected != null ? serviceSelected!.name! : null,
      controller: ctrlPaymentService,
      onTapFieldCallback: () {
        PaymentServiceSelectDialog.show(
          context: context,
          data: services,
          dataSelected: serviceSelected,
          callbackSelect: (selected) {
            ctrlPaymentService.text = selected.name!;
            BlocProvider.of<LinkingPaymentCubit>(context)
                .paymentChanged(selected, typePayment);
          },
        );
      },
      labelText: selectPaymentLabel,
      hintText: '- ${S.current.tapTo} ${selectPaymentLabel.toLowerCase()} -',
    );
  }

  Widget _fieldWidgets(BuildContext context) {
    return Visibility(
      visible: serviceSelected != null,
      child: Column(
        children: [
          _fullNameWidget(context),
          VerticalSpace(
            height: 28,
          ),
          _numberAccountWidget(context)
        ],
      ),
    );
  }

  Widget _fullNameWidget(BuildContext context) {
    return AppTextField(
      focusNode: _fcFullName,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        _fcAccountNumber.requestFocus();
      },
      onChanged: (value) {
        BlocProvider.of<LinkingPaymentCubit>(context).fullNameChanged(value);
      },
      initialValue: null,
      maxLen: 50,
      labelText: typePayment == TypePaymentEnum.Bank
          ? fullNameLabel
          : '$fullNameLabel ${serviceSelected!.name}',
      hintText: '$hintFullNameLabel ${serviceSelected!.name}',
    );
  }

  Widget _numberAccountWidget(BuildContext context) {
    return AppTextField.number(
      focusNode: _fcAccountNumber,
      onChanged: (value) {
        BlocProvider.of<LinkingPaymentCubit>(context)
            .numberAccountChanged(value, typePayment);
      },
      textInputAction: TextInputAction.done,
      initialValue: null,
      maxLen: 50,
      labelText: typePayment == TypePaymentEnum.Bank
          ? numberAccountLabel
          : '$numberAccountLabel ${serviceSelected!.name}',
      hintText: '$hintNumberAccountLabel',
    );
  }
}
