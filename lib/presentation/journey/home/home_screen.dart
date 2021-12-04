import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/failures/normal_failure_widget.dart';
import 'package:p2p_borrower/presentation/journey/home/widgets/home_loading_widget.dart';

import 'cubit/home_cubit.dart';
import 'widgets/home_loaded_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return HomeLoadedWidget();
          }
          if (state is HomeFailure) {
            return NormalFailureWidget(
              message: state.msg,
              label: S.current.tryAgain,
              onPressed: () =>
                  BlocProvider.of<HomeCubit>(context)..fetchAppData(),
            );
          }

          return HomeLoadingWidget();
        },
      ),
    );
  }
}
