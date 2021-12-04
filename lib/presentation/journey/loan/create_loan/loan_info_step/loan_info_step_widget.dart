part of '../create_loan_loaded_widget.dart';

class LoanInfoStepWidget extends StatelessWidget {
  LoanInfoStepWidget({required this.stepName});

  final String stepName;

  late LoanProductsResponse loanProductSelected;

  late LoanMasterDataResponse masterDataResponse;

  late List<LoanProductsResponse> loanProducts;

  Future _nextStep(BuildContext context) async {
    await BlocProvider.of<LoanInfoStepCubit>(context).saveData();

    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).incrementStep();
  }

  void _backStep(BuildContext context) {
    BlocProvider.of<StepCreateLoanNavigatorCubit>(context).decrementStep();
  }

  void _changeLoanProduct(BuildContext context, LoanProductsResponse item) {
    BlocProvider.of<CreateLoanCubit>(context).changeLoanProduct(item);
  }

  void _sliderLoanMountChanged(BuildContext context, num amount) {
    BlocProvider.of<LoanInfoStepCubit>(context).sliderLoanMountChanged(amount);
  }

  void _sliderLoanDurationChanged(BuildContext context, num duration) {
    BlocProvider.of<LoanInfoStepCubit>(context)
        .sliderLoanDurationChanged(duration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoanCubit, CreateLoanState>(
        builder: (context, createLoanState) {
      if (createLoanState is CreateLoanLoaded) {
        loanProductSelected = createLoanState.loanProductSelected;
        loanProducts = createLoanState.loanProducts;
        masterDataResponse = createLoanState.loanMasterDataResponse;

        return StepCreateLoanLayout(
          title: S.current.createLoanTitle,
          subTitle: '$stepName: ${S.current.loanInfo}',
          backStep: () => _backStep(context),
          nextStep: () => _nextStep(context),
          body: BlocBuilder<LoanInfoStepCubit, LoanInfoStepState>(
            builder: (context, state) {
              if (state is LoanInfoStepLoaded) {
                return _bodyStepWidget(context, state);
              }
              return SizedBox();
            },
          ),
        );
      }

      return SizedBox();
    });
  }

  Widget _bodyStepWidget(BuildContext context, LoanInfoStepLoaded state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          VerticalSpace.init8(),
          AppListTileTitleValueWidget.withSelectValue(
            titleLabel: S.current.purposeLoan,
            valueText: loanProductSelected.name!,
            hideTopBorder: true,
            selectValueDialog: SelectLoanProductDialogWidget(
              loanProducts: loanProducts,
              loanProductSelected: loanProductSelected,
              callbackSelect: (item) => _changeLoanProduct(context, item),
            ),
          ),
          AppListTileSliderValueWidget(
            initValue: state.initAmount,
            titleLabel: S.current.loanAmountMoney,
            formatValue: loanProductSelected.amountUnit!,
            onChanged: (value) => _sliderLoanMountChanged(context, value),
            valueCurrencyText: S.current.money_currency,
            labelCurrencyText: loanProductSelected.amountUnitTranslated,
            max: loanProductSelected.maximumAmount!,
            min: loanProductSelected.minimumAmount!,
            stepSize: loanProductSelected.amountUnit!
                .getStepOfSliderWithDurationUnit(),
            hideTopBorder: true,
          ),
          AppListTileSliderValueWidget(
            initValue: state.initDuration,
            titleLabel: S.current.loanDuration,
            onChanged: (value) => _sliderLoanDurationChanged(context, value),
            valueCurrencyText: ' ${loanProductSelected.durationUnitTranslated}',
            formatValue: loanProductSelected.durationUnit!,
            labelCurrencyText: loanProductSelected.durationUnitTranslated,
            max: loanProductSelected.maximumDuration!,
            min: loanProductSelected.minimumDuration!,
            stepSize: loanProductSelected.getStepOfAmountSlider,
            hideTopBorder: true,
          ),
          AppListTileTitleValueWidget.withDescriptionDialog(
            titleLabel: S.current.expectedInterestRate,
            hideTopBorder: true,
            valueText: '${masterDataResponse.userCreditRank!.interestRate}'
                '${masterDataResponse.userCreditRank!.unit}/${S.current.year.toLowerCase()}',
            descriptionButtonChar: '?',
            descriptionDialog: ExpectedInterestRateDialogWidget(
                masterDataResponse.creditRanks!),
          ),
          AppListTileTitleValueWidget.withTooltip(
            titleLabel: S.current.serviceCharge,
            valueText: '${state.serviceCharge}',
            tooltipMessage: S.current.serviceChargeNote,
            descriptionButtonChar: '?',
            hideTopBorder: true,
          ),
          AppListTileTitleValueWidget(
            titleFlex: 3,
            valueFlex: 1,
            verticalAlign: CrossAxisAlignment.start,
            titleLabel: S.current.expectedPayment,
            valueText: '${state.expectedAmountCharge}',
            isBoldValueText: true,
            hideTopBorder: true,
            hideBottomBorder: true,
            subTitleWidget: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.textSub,
                  text: S.current.createLoanStep1Note,
                  children: [
                    TextSpan(
                      text: ' ${S.current.calculatePaymentSchedule} >',
                      style: Theme.of(context)
                          .textTheme
                          .textSub
                          .copyWith(color: mColorBodyTextGreen),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
