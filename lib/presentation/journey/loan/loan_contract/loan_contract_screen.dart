import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/layout/platform_layout_constants.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../loan_route.dart';

class LoanContractScreen extends StatelessWidget {
  LoanContractScreen({Key? key, required this.isSigned, this.loanSimple})
      : super(key: key);

  final bool isSigned;
  late String title;
  late Widget button;
  LoanApplicationResponse? loanSimple;

  WebViewController? _controller;
  final _loadingDialog = AppLoadingDialog();

  Future _signContract(BuildContext context) async {
    // push to otp screen
    final phone = SessionPref.getUserName();

    if (phone != null) {
      final otp = await Navigator.pushNamed(
          context, AuthenticationRoute.verifyOtpID,
          arguments: {
            AuthenticationRoute.phoneArg: phone,
            AuthenticationRoute.verifyTypeArg: VerifyConstants.SignContract
          });

      if (otp != null && loanSimple != null) {
        //   // verify otp success -> sign contract
        print('>>> sign');
        BlocProvider.of<LoanCubit>(context).signLoanContract(loanSimple!);
      }
    }
  }

  void _signContractSuccess(BuildContext context) {
    debugPrint('>>> sign contract success');
    Navigator.pushNamedAndRemoveUntil(context, LoanRoute.signContractSuccessID,
        ModalRoute.withName(HomeRoute.id));
  }

  void _showFailureDialog(BuildContext context, String msg) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.createLoanTitle,
        message: msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    if (isSigned) {
      title = S.current.loanContract;
      button = RaisedGradientButton(
        label: S.current.signed,
      );
    } else {
      title = S.current.signContract;
      button = RaisedGradientButton(
        label: S.current.agreeToSignContract,
        onPressed: () => _signContract(context),
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<LoanCubit, LoanState>(
          listener: (context, state) {
            if (state is LoanLoaded &&
                state.actionEnum == LoanAppActionEnum.SIGN_CONTRACT) {
              _signContractSuccess(context);
            }
          },
        ),
        BlocListener<LoaderCubit, LoaderState>(
            bloc: BlocProvider.of<LoanCubit>(context).loaderCubit,
            listener: (context, state) {
              if (state is LoanLoaded) {
                switch (state.runtimeType) {
                  case LoaderLoaded:
                    _loadingDialog.popDialog();
                    break;
                  case LoaderSuccess:
                    break;
                  case LoaderFailure:
                    _showFailureDialog(
                        context, (state as LoaderFailure).messages[0]);
                    break;
                  default:
                    _loadingDialog.showDefault(context);
                }
              }
            })
      ],
      child: Scaffold(
          appBar: AppbarAction(
            titleText: title,
            callbackLeading: () => Navigator.pop(context),
          ),
          body: Padding(
            padding:
                EdgeInsets.all(PlatformLayoutConstants.marginCompactLayout),
            child: Column(
              children: [_boxContract(), VerticalSpace.init16(), button],
            ),
          )),
    );
  }

  Widget _boxContract() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: mColorBordersLines),
            borderRadius: BorderRadius.circular(8.w)),
        child: WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssets();
          },
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/html/contract.html');
    _controller?.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
