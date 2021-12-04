import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/linking_payment_route.dart';

class LinkedPaymentsEmptyWidget extends StatelessWidget {
  const LinkedPaymentsEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Stack(
        children: [
          Center(
            child: Text(
              S.current.linkedPaymentsEmpty,
              style: Theme.of(context).textTheme.textSub,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedGradientButton.icon(
                label: S.current.addLinkedPayment,
                icon: Icons.add,
                onPressed: () async {
                  final linkedPayment = await Navigator.pushNamed(
                      context, LinkingPaymentRoute.addLinkingPaymentID);
                  // add new payment to linked payment list
                  if (linkedPayment != null) {
                    BlocProvider.of<PaymentManagerCubit>(context)
                        .addLinkedPayment(
                            linkedPayment as LinkedPaymentResponse);
                  }
                }),
          )
        ],
      ),
    );
  }
}
