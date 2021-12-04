import 'package:p2p_borrower/di/module/api_module.dart';
import 'package:p2p_borrower/di/module/bloc_module.dart';
import 'package:p2p_borrower/di/module/components_module.dart';
import 'package:p2p_borrower/di/module/local_module.dart';
import 'package:p2p_borrower/di/module/repo_module.dart';
import 'package:p2p_borrower/di/module/use_case_module.dart';

class Injection {
  static Future inject() async {
    await ComponentsModule().provides();
    await LocalModule().provides();
    await ApiModule().provides();
    await RepoModule().provides();
    await UseCaseModule().provides();
    await BlocModule().provides();
  }
}
