// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_configuration_module/generated/l10n.dart';
// import 'package:p2p_borrower/common/exceptions/api_exception.dart';
// import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
// import 'package:p2p_borrower/domain/usecases/notification_usecase.dart';
// import 'package:p2p_borrower/presentation/common/cubits/authentication_cubit/authentication_cubit.dart';
//
// part 'sign_out_state.dart';
//
// class SignOutCubit extends Cubit<SignOutState> {
//   SignOutCubit(
//       {required this.authenticationUseCase,
//       required this.authenticationCubit,
//       required this.notificationUseCase})
//       : super(SignOutInitial());
//
//   final AuthenticationUseCase authenticationUseCase;
//   final AuthenticationCubit authenticationCubit;
//   final NotificationUseCase notificationUseCase;
//
//   Future signOut() async {
//     emit(SignOutLoading());
//
//     try {
//       await authenticationCubit.signedOut(); // call sign out
//       emit(SignOutSuccess());
//     } on ApiException catch (apiError) {
//       emit(SignOutFailure(msg: apiError.errorMessage));
//     } catch (e) {
//       emit(SignOutFailure(msg: SConfig.current.unKnowError));
//     }
//   }
// }
