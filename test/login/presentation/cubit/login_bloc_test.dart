// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_configuration_module/generated/l10n.dart';
// import 'package:p2p_borrower/data/model/response/login_response.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// import '../../../config/config.dart';
// import '../../mock.dart';
//
// void main() {
//   LoginUserCaseMock mockUseCase;
//   TestUseCaseMock testUseCaseMock;
//
//   LoginCubit loginCubit;
//
//   setUp(() async {
//     await TestUtilities.setupLocalization();
//   });
//
//   final response = LoginResponse('KbseWdVo87DkmNDO9klriT8SNOkEWRZC');
//
//   blocTest<LoginCubit, LoginState>(
//     'Test login bloc yield the right state successfully',
//     build: () {
//       mockUseCase = LoginUserCaseMock();
//       testUseCaseMock = TestUseCaseMock();
//       loginCubit =
//           LoginCubit(loginUseCase: mockUseCase, testUseCase: testUseCaseMock);
//       when(mockUseCase.login('test', 'test')).thenAnswer((_) async => response);
//       return loginCubit;
//     },
//     act: (cubit) async => await cubit.login(user: 'test', password: 'test'),
//     expect: () => [
//       LoadingLoginState(),
//       LoginSuccessfullyState(response: response, testMsg: "hello")
//     ],
//   );
//
//   blocTest<LoginCubit, LoginState>(
//     'Test login bloc with type cast error',
//     build: () {
//       mockUseCase = LoginUserCaseMock();
//       testUseCaseMock = TestUseCaseMock();
//
//       loginCubit =
//           LoginCubit(loginUseCase: mockUseCase, testUseCase: testUseCaseMock);
//       when(mockUseCase.login(null, null)).thenAnswer((_) => throw TypeError());
//       return loginCubit;
//     },
//     act: (cubit) async => await cubit.login(user: 'test', password: 'test'),
//     expect: () => [
//       LoadingLoginState(),
//       ErrorLoginState(errorMessage: S.current.connectionProblem)
//     ],
//   );
// }
