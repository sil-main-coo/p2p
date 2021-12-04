import 'package:p2p_borrower/common/constants/sex_enums.dart';
import 'package:p2p_borrower/generated/l10n.dart';

String mapSexFromEnum(SexEnum sexEnum) {
  switch (sexEnum) {
    case SexEnum.F:
      return S.current.female;
    case SexEnum.M:
      return S.current.male;
  }
}
