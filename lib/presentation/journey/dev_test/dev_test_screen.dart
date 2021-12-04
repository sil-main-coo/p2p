import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/linking_payment_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/create_loan_loaded_widget.dart';

class DevTestScreen extends StatelessWidget {
  const DevTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buttonWidget(
              label: 'Otp screen',
              onPressed: () => Navigator.pushNamed(
                      context, AuthenticationRoute.verifyOtpID,
                      arguments: {
                        AuthenticationRoute.phoneArg: "0333333331",
                        AuthenticationRoute.verifyTypeArg:
                            VerifyConstants.Registration
                      })),
          _buttonWidget(
              label: 'Sign Up screen',
              onPressed: () => // push to registration
                  Navigator.pushNamed(context, AuthenticationRoute.signUpID,
                      arguments: {AuthenticationRoute.phoneArg: "0333333336"})),
          _buttonWidget(
              label: 'Step2CreateLoan',
              onPressed: () => // push to registration
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PersonalInfoWidget(
                                stepName: 'Bước 2',
                              )))),
          _buttonWidget(
              label: 'Linking payment',
              onPressed: () async {
                // push to registration
                final isSuccess = await Navigator.pushNamed(
                    context, LinkingPaymentRoute.addLinkingPaymentID);
                print(isSuccess);
              }),
          _buttonWidget(
              label: 'Step 5',
              onPressed: () => // push to registration
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => IDInfoStepWidget(
                                stepName: 'Bước 5',
                              )))),
        ],
      ),
    );
  }

  Widget _buttonWidget({required String label, required Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
