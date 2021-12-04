import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/domain/usecases/home_usecases.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeUseCase homeUseCase;

  HomeCubit({required this.homeUseCase}) : super(HomeInitial());

  Future fetchAppData() async {
    emit(HomeLoading());
    try {
      final loanProducts = await homeUseCase.fetchLoanTypeProducts();
      emit(HomeLoaded(loanProducts: loanProducts));
    } on ApiException catch (apiError) {
      emit(HomeFailure(msg: apiError.errorMessage));
    } on LocalException {
      emit(HomeFailure(msg: SConfig.current.deviceError));
    } catch (e) {
      emit(HomeFailure(msg: SConfig.current.unKnowError));
    }
  }
}
