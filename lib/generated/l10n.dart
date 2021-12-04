// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `© Five9 Vietnam Corporation`
  String get splashText {
    return Intl.message(
      '© Five9 Vietnam Corporation',
      name: 'splashText',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang sử dụng phiên bản cũ. Vui lòng cập nhật phiên bản mới nhất để sử dụng.`
  String get MSG01 {
    return Intl.message(
      'Bạn đang sử dụng phiên bản cũ. Vui lòng cập nhật phiên bản mới nhất để sử dụng.',
      name: 'MSG01',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại để tiếp tục.`
  String get MSG02 {
    return Intl.message(
      'Vui lòng nhập số điện thoại để tiếp tục.',
      name: 'MSG02',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không hợp lệ. Vui lòng thử lại!`
  String get MSG03 {
    return Intl.message(
      'Số điện thoại không hợp lệ. Vui lòng thử lại!',
      name: 'MSG03',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không hợp lệ.`
  String get MSG03A {
    return Intl.message(
      'Số điện thoại không hợp lệ.',
      name: 'MSG03A',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại đã tồn tại. Vui lòng sử dụng số điện thoại khác!`
  String get MSG04 {
    return Intl.message(
      'Số điện thoại đã tồn tại. Vui lòng sử dụng số điện thoại khác!',
      name: 'MSG04',
      desc: '',
      args: [],
    );
  }

  /// `Sai mã OTP. Quý khách vui lòng nhập lại mã OTP. Nếu quý khách nhập sai mã OTP quá 3 lần thì hệ thống sẽ xóa toàn bộ thông tin đã điền và kết thúc quá trình đăng ký tài khoản.`
  String get MSG05 {
    return Intl.message(
      'Sai mã OTP. Quý khách vui lòng nhập lại mã OTP. Nếu quý khách nhập sai mã OTP quá 3 lần thì hệ thống sẽ xóa toàn bộ thông tin đã điền và kết thúc quá trình đăng ký tài khoản.',
      name: 'MSG05',
      desc: '',
      args: [],
    );
  }

  /// `Quý khách đã nhập sai mã OTP 3 lần.`
  String get MSG06 {
    return Intl.message(
      'Quý khách đã nhập sai mã OTP 3 lần.',
      name: 'MSG06',
      desc: '',
      args: [],
    );
  }

  /// `Sai mật khẩu tạm thời OTP. Quý khách vui lòng nhập lại mật khẩu tạm thời OTP. Nếu quý khách nhập sai mật khẩu tạm thời OTP quá 3 lần thì hệ thống sẽ xóa toàn bộ thông tin đã điền và kết thúc quá trình đăng ký tài khoản.`
  String get MSG07 {
    return Intl.message(
      'Sai mật khẩu tạm thời OTP. Quý khách vui lòng nhập lại mật khẩu tạm thời OTP. Nếu quý khách nhập sai mật khẩu tạm thời OTP quá 3 lần thì hệ thống sẽ xóa toàn bộ thông tin đã điền và kết thúc quá trình đăng ký tài khoản.',
      name: 'MSG07',
      desc: '',
      args: [],
    );
  }

  /// `Quý khách đã nhập sai mật khẩu tạm thời OTP 3 lần. Thông tin của quý khách sẽ bị xóa, vui lòng điền lại thông tin để đăng nhập tài khoản.`
  String get MSG08 {
    return Intl.message(
      'Quý khách đã nhập sai mật khẩu tạm thời OTP 3 lần. Thông tin của quý khách sẽ bị xóa, vui lòng điền lại thông tin để đăng nhập tài khoản.',
      name: 'MSG08',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu nhập vào không hợp lệ. Mật khẩu chỉ gồm 6 số, không bao gồm chữ cái và các ký tự khác.`
  String get MSG09 {
    return Intl.message(
      'Mật khẩu nhập vào không hợp lệ. Mật khẩu chỉ gồm 6 số, không bao gồm chữ cái và các ký tự khác.',
      name: 'MSG09',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu xác nhận không hợp lệ. Mật khẩu chỉ gồm 6 số, không bao gồm chữ cái và các ký tự khác.`
  String get MSG10 {
    return Intl.message(
      'Mật khẩu xác nhận không hợp lệ. Mật khẩu chỉ gồm 6 số, không bao gồm chữ cái và các ký tự khác.',
      name: 'MSG10',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu và mật khẩu xác nhận không giống nhau. Vui lòng thử lại!`
  String get MSG11 {
    return Intl.message(
      'Mật khẩu và mật khẩu xác nhận không giống nhau. Vui lòng thử lại!',
      name: 'MSG11',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập lại số điện thoại theo đầu số mới của nhà mạng.`
  String get MSG12 {
    return Intl.message(
      'Vui lòng nhập lại số điện thoại theo đầu số mới của nhà mạng.',
      name: 'MSG12',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn xóa đơn vay hiện tại không?`
  String get MSG22 {
    return Intl.message(
      'Bạn có muốn xóa đơn vay hiện tại không?',
      name: 'MSG22',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn hủy yêu cầu vay hiện tại không?`
  String get MSG23 {
    return Intl.message(
      'Bạn có muốn hủy yêu cầu vay hiện tại không?',
      name: 'MSG23',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập họ và tên của bạn để tiếp tục.`
  String get MSG24 {
    return Intl.message(
      'Vui lòng nhập họ và tên của bạn để tiếp tục.',
      name: 'MSG24',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên không hợp lệ. Vui lòng thử lại!`
  String get MSG25 {
    return Intl.message(
      'Họ và tên không hợp lệ. Vui lòng thử lại!',
      name: 'MSG25',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số chứng minh nhân dân của bạn để tiếp tục.`
  String get MSG26 {
    return Intl.message(
      'Vui lòng nhập số chứng minh nhân dân của bạn để tiếp tục.',
      name: 'MSG26',
      desc: '',
      args: [],
    );
  }

  /// `Số chứng minh nhân dân không hợp lệ. Vui lòng thử lại!`
  String get MSG27 {
    return Intl.message(
      'Số chứng minh nhân dân không hợp lệ. Vui lòng thử lại!',
      name: 'MSG27',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập SĐT người thân để tiếp tục.`
  String get MSG28 {
    return Intl.message(
      'Vui lòng nhập SĐT người thân để tiếp tục.',
      name: 'MSG28',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại người thân không hợp lệ.`
  String get MSG29 {
    return Intl.message(
      'Số điện thoại người thân không hợp lệ.',
      name: 'MSG29',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập tên cơ quan để tiếp tục.`
  String get MSG30 {
    return Intl.message(
      'Vui lòng nhập tên cơ quan để tiếp tục.',
      name: 'MSG30',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập mức thu nhập hàng tháng để tiếp tục.`
  String get MSG31 {
    return Intl.message(
      'Vui lòng nhập mức thu nhập hàng tháng để tiếp tục.',
      name: 'MSG31',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng tải lên ảnh bạn đang cầm CMND để tiếp tục.`
  String get MSG32 {
    return Intl.message(
      'Vui lòng tải lên ảnh bạn đang cầm CMND để tiếp tục.',
      name: 'MSG32',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng tải lên ảnh mặt trước CMND của bạn để tiếp tục.`
  String get MSG33 {
    return Intl.message(
      'Vui lòng tải lên ảnh mặt trước CMND của bạn để tiếp tục.',
      name: 'MSG33',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng tải lên ảnh mặt sau CMND của bạn để tiếp tục.`
  String get MSG34 {
    return Intl.message(
      'Vui lòng tải lên ảnh mặt sau CMND của bạn để tiếp tục.',
      name: 'MSG34',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng tải lên ảnh bảng lương của bạn để tiếp tục.`
  String get MSG35 {
    return Intl.message(
      'Vui lòng tải lên ảnh bảng lương của bạn để tiếp tục.',
      name: 'MSG35',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin bổ sung không hợp lệ. Vui lòng thử lại!`
  String get MSG36 {
    return Intl.message(
      'Thông tin bổ sung không hợp lệ. Vui lòng thử lại!',
      name: 'MSG36',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ thường trú của bạn để tiếp tục.`
  String get MSG37 {
    return Intl.message(
      'Vui lòng nhập địa chỉ thường trú của bạn để tiếp tục.',
      name: 'MSG37',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ tạm trú của bạn để tiếp tục.`
  String get MSG38 {
    return Intl.message(
      'Vui lòng nhập địa chỉ tạm trú của bạn để tiếp tục.',
      name: 'MSG38',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập địa chỉ công ty của bạn để tiếp tục.`
  String get MSG39 {
    return Intl.message(
      'Vui lòng nhập địa chỉ công ty của bạn để tiếp tục.',
      name: 'MSG39',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập họ và tên chủ tài khoản ví để tiếp tục.`
  String get MSG40 {
    return Intl.message(
      'Vui lòng nhập họ và tên chủ tài khoản ví để tiếp tục.',
      name: 'MSG40',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên chủ tài khoản ví không hợp lệ. Vui lòng thử lại!`
  String get MSG41 {
    return Intl.message(
      'Họ và tên chủ tài khoản ví không hợp lệ. Vui lòng thử lại!',
      name: 'MSG41',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số tài khoản ví của bạn.`
  String get MSG42 {
    return Intl.message(
      'Vui lòng nhập số tài khoản ví của bạn.',
      name: 'MSG42',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản ví không hợp lệ. Vui lòng thử lại!`
  String get MSG43 {
    return Intl.message(
      'Số tài khoản ví không hợp lệ. Vui lòng thử lại!',
      name: 'MSG43',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số tài khoản ví xác nhận để tiếp tục.`
  String get MSG44 {
    return Intl.message(
      'Vui lòng nhập số tài khoản ví xác nhận để tiếp tục.',
      name: 'MSG44',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản ví xác nhận không hợp lệ. Vui lòng thử lại!`
  String get MSG45 {
    return Intl.message(
      'Số tài khoản ví xác nhận không hợp lệ. Vui lòng thử lại!',
      name: 'MSG45',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản ví và số tài khoản ví xác nhận không giống nhau. Vui lòng thử lại!`
  String get MSG46 {
    return Intl.message(
      'Số tài khoản ví và số tài khoản ví xác nhận không giống nhau. Vui lòng thử lại!',
      name: 'MSG46',
      desc: '',
      args: [],
    );
  }

  /// `Sai mã OTP. Quý khách vui lòng nhập lại mã OTP. `
  String get MSG47 {
    return Intl.message(
      'Sai mã OTP. Quý khách vui lòng nhập lại mã OTP. ',
      name: 'MSG47',
      desc: '',
      args: [],
    );
  }

  /// `Quý khách đã nhập sai mã OTP 3 lần. Thông tin đã điền của quý khách sẽ bị xóa, vui lòng điền lại thông tin để tạo khoản vay.`
  String get MSG48 {
    return Intl.message(
      'Quý khách đã nhập sai mã OTP 3 lần. Thông tin đã điền của quý khách sẽ bị xóa, vui lòng điền lại thông tin để tạo khoản vay.',
      name: 'MSG48',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập lại số điện thoại theo đầu số mới của nhà mạng.`
  String get MSG48A {
    return Intl.message(
      'Vui lòng nhập lại số điện thoại theo đầu số mới của nhà mạng.',
      name: 'MSG48A',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi trong quá trình xác nhận. Vui lòng thử lại!`
  String get MSG49 {
    return Intl.message(
      'Đã có lỗi trong quá trình xác nhận. Vui lòng thử lại!',
      name: 'MSG49',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn đã sẵn sàng trên sàn giao dịch. Chúng tôi sẽ cập nhật thông tin khi khoản vay được huy động. Vui lòng giữ liên lạc để cập nhật trạng thái của khoản vay.`
  String get MSG50 {
    return Intl.message(
      'Đơn vay của bạn đã sẵn sàng trên sàn giao dịch. Chúng tôi sẽ cập nhật thông tin khi khoản vay được huy động. Vui lòng giữ liên lạc để cập nhật trạng thái của khoản vay.',
      name: 'MSG50',
      desc: '',
      args: [],
    );
  }

  /// `Chúc mừng bạn đã ký hợp đồng thành công. Tiền sẽ được giải ngân về tài khoản của bạn khi hợp đồng được duyệt.`
  String get MSG51 {
    return Intl.message(
      'Chúc mừng bạn đã ký hợp đồng thành công. Tiền sẽ được giải ngân về tài khoản của bạn khi hợp đồng được duyệt.',
      name: 'MSG51',
      desc: '',
      args: [],
    );
  }

  /// `Xin cảm ơn!`
  String get MSG51A {
    return Intl.message(
      'Xin cảm ơn!',
      name: 'MSG51A',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi trong quá trình ký hợp đồng. Vui lòng thử lại!`
  String get MSG52 {
    return Intl.message(
      'Đã có lỗi trong quá trình ký hợp đồng. Vui lòng thử lại!',
      name: 'MSG52',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng đồng ý với điều khoản hợp đồng để tiếp tục ký hợp đồng.`
  String get MSG53 {
    return Intl.message(
      'Vui lòng đồng ý với điều khoản hợp đồng để tiếp tục ký hợp đồng.',
      name: 'MSG53',
      desc: '',
      args: [],
    );
  }

  /// `Vay trực tiếp từ nhà đầu tư`
  String get boarding1Title {
    return Intl.message(
      'Vay trực tiếp từ nhà đầu tư',
      name: 'boarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Tạo các khoản vay để kêu gọi huy động vốn trực tiếp từ những nhà đầu tư cá nhân trên sàn giao dịch của chúng tôi.`
  String get boarding1Msg {
    return Intl.message(
      'Tạo các khoản vay để kêu gọi huy động vốn trực tiếp từ những nhà đầu tư cá nhân trên sàn giao dịch của chúng tôi.',
      name: 'boarding1Msg',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ qua`
  String get skip {
    return Intl.message(
      'Bỏ qua',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp`
  String get next {
    return Intl.message(
      'Tiếp',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Bắt đầu`
  String get start {
    return Intl.message(
      'Bắt đầu',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Cho vay và nhận lãi`
  String get boarding2Title {
    return Intl.message(
      'Cho vay và nhận lãi',
      name: 'boarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Nhà đầu tư sẽ lựa chọn để đầu tư phù hợp và nhận được lãi suất sau đó. Hai bên người vay và người đầu tư đều có lợi!`
  String get boarding2Msg {
    return Intl.message(
      'Nhà đầu tư sẽ lựa chọn để đầu tư phù hợp và nhận được lãi suất sau đó. Hai bên người vay và người đầu tư đều có lợi!',
      name: 'boarding2Msg',
      desc: '',
      args: [],
    );
  }

  /// `An toàn, dễ dùng và tin cậy`
  String get boarding3Title {
    return Intl.message(
      'An toàn, dễ dùng và tin cậy',
      name: 'boarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Tất cả các giao dịch đều được mã hóa an toàn, bảo mật và luôn đặt người dùng lên hàng đầu. Hãy yên tâm sử dụng và kiếm tiền từ hôm nay!`
  String get boarding3Msg {
    return Intl.message(
      'Tất cả các giao dịch đều được mã hóa an toàn, bảo mật và luôn đặt người dùng lên hàng đầu. Hãy yên tâm sử dụng và kiếm tiền từ hôm nay!',
      name: 'boarding3Msg',
      desc: '',
      args: [],
    );
  }

  /// `Khác loại tài khoản`
  String get dialogTypeAccountTitle {
    return Intl.message(
      'Khác loại tài khoản',
      name: 'dialogTypeAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phoneNumber {
    return Intl.message(
      'Số điện thoại',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `đã được đăng ký làm nhà đầu tư, bạn có muốn chuyển sang app cho nhà đầu tư không?`
  String get dialogTypeAccountMsg {
    return Intl.message(
      'đã được đăng ký làm nhà đầu tư, bạn có muốn chuyển sang app cho nhà đầu tư không?',
      name: 'dialogTypeAccountMsg',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển`
  String get switchTypeAcc {
    return Intl.message(
      'Chuyển',
      name: 'switchTypeAcc',
      desc: '',
      args: [],
    );
  }

  /// `Không`
  String get no {
    return Intl.message(
      'Không',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số điện thoại`
  String get loginInputPhoneTitle {
    return Intl.message(
      'Nhập số điện thoại',
      name: 'loginInputPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại của bạn để đăng ký mới hoặc đăng nhập nếu bạn đã có tài khoản`
  String get loginInputPhoneSubTitle {
    return Intl.message(
      'Vui lòng nhập số điện thoại của bạn để đăng ký mới hoặc đăng nhập nếu bạn đã có tài khoản',
      name: 'loginInputPhoneSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bằng cách ấn nút ‘Tiếp tục’ ở trên, tôi đã hiểu và đồng ý với`
  String get loginMessageLeadTermsText {
    return Intl.message(
      'Bằng cách ấn nút ‘Tiếp tục’ ở trên, tôi đã hiểu và đồng ý với',
      name: 'loginMessageLeadTermsText',
      desc: '',
      args: [],
    );
  }

  /// `điều khoản sử dụng`
  String get termOfUse {
    return Intl.message(
      'điều khoản sử dụng',
      name: 'termOfUse',
      desc: '',
      args: [],
    );
  }

  /// `của FinSmart`
  String get ofFinSmart {
    return Intl.message(
      'của FinSmart',
      name: 'ofFinSmart',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get continueText {
    return Intl.message(
      'Tiếp tục',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số điện thoại của bạn`
  String get loginInputPhoneHint {
    return Intl.message(
      'Nhập số điện thoại của bạn',
      name: 'loginInputPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Xác thực mã`
  String get verifyOTPTitle {
    return Intl.message(
      'Xác thực mã',
      name: 'verifyOTPTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hãy điền 6 số được gửi kèm tin nhắn được gửi vào số điện thoại của bạn. Nếu không nhận được bạn có thể yêu cầu gửi lại trong:`
  String get verifyOTPDescription {
    return Intl.message(
      'Hãy điền 6 số được gửi kèm tin nhắn được gửi vào số điện thoại của bạn. Nếu không nhận được bạn có thể yêu cầu gửi lại trong:',
      name: 'verifyOTPDescription',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get verifyOTPAccept {
    return Intl.message(
      'Xác nhận',
      name: 'verifyOTPAccept',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại tin nhắn`
  String get verifyOTPResend {
    return Intl.message(
      'Gửi lại tin nhắn',
      name: 'verifyOTPResend',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực mới đã được gửi vào số điện thoại của bạn.`
  String get resendOTPSuccess {
    return Intl.message(
      'Mã xác thực mới đã được gửi vào số điện thoại của bạn.',
      name: 'resendOTPSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực sai`
  String get verifyOTPFailureTitle {
    return Intl.message(
      'Mã xác thực sai',
      name: 'verifyOTPFailureTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực không chính xác, vui lòng kiểm tra lại mã hoặc gửi lại mã mới.`
  String get verifyOTPFailureMsg {
    return Intl.message(
      'Mã xác thực không chính xác, vui lòng kiểm tra lại mã hoặc gửi lại mã mới.',
      name: 'verifyOTPFailureMsg',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get tryAgain {
    return Intl.message(
      'Thử lại',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản mới`
  String get signUpTitle {
    return Intl.message(
      'Tạo tài khoản mới',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào`
  String get signUpDescription1 {
    return Intl.message(
      'Xin chào',
      name: 'signUpDescription1',
      desc: '',
      args: [],
    );
  }

  /// `bạn chưa có tài khoản. Vui lòng thiết lập mật khẩu để bắt đầu.`
  String get signUpDescription2 {
    return Intl.message(
      'bạn chưa có tài khoản. Vui lòng thiết lập mật khẩu để bắt đầu.',
      name: 'signUpDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `6 ký tự dạng chữ số`
  String get hintPassword {
    return Intl.message(
      '6 ký tự dạng chữ số',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nhập lại 6 ký tự dạng chữ số`
  String get hintConfirmPassword {
    return Intl.message(
      'Nhập lại 6 ký tự dạng chữ số',
      name: 'hintConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get signIn {
    return Intl.message(
      'Đăng nhập',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào`
  String get signInDescription1 {
    return Intl.message(
      'Xin chào',
      name: 'signInDescription1',
      desc: '',
      args: [],
    );
  }

  /// `vui lòng nhập mật khẩu của bạn để tiếp tục.`
  String get signInDescription2 {
    return Intl.message(
      'vui lòng nhập mật khẩu của bạn để tiếp tục.',
      name: 'signInDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu`
  String get forgotPassword {
    return Intl.message(
      'Quên mật khẩu',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hủy`
  String get cancel {
    return Intl.message(
      'Hủy',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Email hỗ trợ`
  String get emailSupport {
    return Intl.message(
      'Email hỗ trợ',
      name: 'emailSupport',
      desc: '',
      args: [],
    );
  }

  /// `Gọi hotline`
  String get callHotline {
    return Intl.message(
      'Gọi hotline',
      name: 'callHotline',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất`
  String get signOut {
    return Intl.message(
      'Đăng xuất',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Lựa chọn`
  String get option {
    return Intl.message(
      'Lựa chọn',
      name: 'option',
      desc: '',
      args: [],
    );
  }

  /// `Trợ giúp`
  String get support {
    return Intl.message(
      'Trợ giúp',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Đặt lại mật khẩu`
  String get resetPassword {
    return Intl.message(
      'Đặt lại mật khẩu',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mã xác thực sẽ được gửi tới`
  String get sendOTPDescription1 {
    return Intl.message(
      'Mã xác thực sẽ được gửi tới',
      name: 'sendOTPDescription1',
      desc: '',
      args: [],
    );
  }

  /// `qua tin nhắn SMS sau khi bạn đồng ý. Bạn chắc chắn không?`
  String get sendOTPDescription2 {
    return Intl.message(
      'qua tin nhắn SMS sau khi bạn đồng ý. Bạn chắc chắn không?',
      name: 'sendOTPDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get accept {
    return Intl.message(
      'Đồng ý',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Hủy bỏ`
  String get cancel1 {
    return Intl.message(
      'Hủy bỏ',
      name: 'cancel1',
      desc: '',
      args: [],
    );
  }

  /// `Thiết lập mật khẩu mới`
  String get forgotPasswordTitle {
    return Intl.message(
      'Thiết lập mật khẩu mới',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào`
  String get forgotPasswordDescription1 {
    return Intl.message(
      'Xin chào',
      name: 'forgotPasswordDescription1',
      desc: '',
      args: [],
    );
  }

  /// `bạn đã yêu cầu đặt lại mật khẩu. Vui lòng tạo mật khẩu mới.`
  String get forgotPasswordDescription2 {
    return Intl.message(
      'bạn đã yêu cầu đặt lại mật khẩu. Vui lòng tạo mật khẩu mới.',
      name: 'forgotPasswordDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản giới thiệu`
  String get referencePhone {
    return Intl.message(
      'Tài khoản giới thiệu',
      name: 'referencePhone',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng cung cấp số điện thoại người giới thiệu để nhận thêm nhiều ưu đãi`
  String get referencePhoneDescription {
    return Intl.message(
      'Bạn vui lòng cung cấp số điện thoại người giới thiệu để nhận thêm nhiều ưu đãi',
      name: 'referencePhoneDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số điện thoại người giới thiệu`
  String get referencePhoneHintField {
    return Intl.message(
      'Nhập số điện thoại người giới thiệu',
      name: 'referencePhoneHintField',
      desc: '',
      args: [],
    );
  }

  /// `Liên hệ với chúng tôi`
  String get contactUs {
    return Intl.message(
      'Liên hệ với chúng tôi',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản của bạn đang được đăng nhập trên thiết bị`
  String get multiSignInDescription1 {
    return Intl.message(
      'Tài khoản của bạn đang được đăng nhập trên thiết bị',
      name: 'multiSignInDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Nếu đó không phải là bạn, vui lòng liên hệ ngay với chúng tôi theo số điện thoại`
  String get multiSignInDescription2 {
    return Intl.message(
      'Nếu đó không phải là bạn, vui lòng liên hệ ngay với chúng tôi theo số điện thoại',
      name: 'multiSignInDescription2',
      desc: '',
      args: [],
    );
  }

  /// `để được hỗ trợ`
  String get multiSignInDescription3 {
    return Intl.message(
      'để được hỗ trợ',
      name: 'multiSignInDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập số điện thoại người giới thiệu`
  String get phoneReferenceValidEmpty {
    return Intl.message(
      'Vui lòng nhập số điện thoại người giới thiệu',
      name: 'phoneReferenceValidEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại giới thiệu bị trùng số điện thoại đăng nhập`
  String get phoneReferenceValidEqualPhoneLogin {
    return Intl.message(
      'Số điện thoại giới thiệu bị trùng số điện thoại đăng nhập',
      name: 'phoneReferenceValidEqualPhoneLogin',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào!\nBạn muốn vay tiền hay đầu tư?`
  String get appPickTitle {
    return Intl.message(
      'Xin chào!\nBạn muốn vay tiền hay đầu tư?',
      name: 'appPickTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hãy chọn một phương thức để bắt đầu. Một tài khoản chỉ có thể là một trong hai.`
  String get appPickDescription {
    return Intl.message(
      'Hãy chọn một phương thức để bắt đầu. Một tài khoản chỉ có thể là một trong hai.',
      name: 'appPickDescription',
      desc: '',
      args: [],
    );
  }

  /// `Chọn`
  String get select {
    return Intl.message(
      'Chọn',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Vay tiền`
  String get appPickMenuBorrowerTitle {
    return Intl.message(
      'Vay tiền',
      name: 'appPickMenuBorrowerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vay trực tiếp từ những nhà đầu tư cá nhân trên sàn giao dịch của chúng tôi.`
  String get appPickMenuBorrowerDescription {
    return Intl.message(
      'Vay trực tiếp từ những nhà đầu tư cá nhân trên sàn giao dịch của chúng tôi.',
      name: 'appPickMenuBorrowerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Đầu tư`
  String get appPickMenuInvestorTitle {
    return Intl.message(
      'Đầu tư',
      name: 'appPickMenuInvestorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lựa chọn trong các gói vay được đăng lên từ người vay để đầu tư/cho vay và nhận được lãi suất sau đó.`
  String get appPickMenuInvestorDescription {
    return Intl.message(
      'Lựa chọn trong các gói vay được đăng lên từ người vay để đầu tư/cho vay và nhận được lãi suất sau đó.',
      name: 'appPickMenuInvestorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển app`
  String get switchInvestorAppTitle {
    return Intl.message(
      'Chuyển app',
      name: 'switchInvestorAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bạn sẽ được chuyển sang app phiên bản nhà đầu tư. Bạn có chắc chắn không?`
  String get switchInvestorAppMsg {
    return Intl.message(
      'Bạn sẽ được chuyển sang app phiên bản nhà đầu tư. Bạn có chắc chắn không?',
      name: 'switchInvestorAppMsg',
      desc: '',
      args: [],
    );
  }

  /// `Vay tiền`
  String get loan {
    return Intl.message(
      'Vay tiền',
      name: 'loan',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý vay`
  String get loanManager {
    return Intl.message(
      'Quản lý vay',
      name: 'loanManager',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản`
  String get account {
    return Intl.message(
      'Tài khoản',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notification {
    return Intl.message(
      'Thông báo',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Hồ sơ`
  String get profile {
    return Intl.message(
      'Hồ sơ',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Bạn muốn vay để làm gì?`
  String get loanTitleEmpty {
    return Intl.message(
      'Bạn muốn vay để làm gì?',
      name: 'loanTitleEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đang có`
  String get loanTitleHasData1 {
    return Intl.message(
      'Bạn đang có',
      name: 'loanTitleHasData1',
      desc: '',
      args: [],
    );
  }

  /// `khoản vay.`
  String get loanTitleHasData2 {
    return Intl.message(
      'khoản vay.',
      name: 'loanTitleHasData2',
      desc: '',
      args: [],
    );
  }

  /// `Hãy lựa chọn cho mình một khoản vay phù hợp trong danh sách dưới đây.`
  String get loanDescriptionEmpty {
    return Intl.message(
      'Hãy lựa chọn cho mình một khoản vay phù hợp trong danh sách dưới đây.',
      name: 'loanDescriptionEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể thao tác với khoản vay hiện tại hoặc tạo khoản vay mới.`
  String get loanDescriptionHasData {
    return Intl.message(
      'Bạn có thể thao tác với khoản vay hiện tại hoặc tạo khoản vay mới.',
      name: 'loanDescriptionHasData',
      desc: '',
      args: [],
    );
  }

  /// `Lưu ý`
  String get notice {
    return Intl.message(
      'Lưu ý',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Các thông tin bạn cung cấp sau đây ảnh hưởng tới mức lãi suất khoản vay của bạn. Bạn vui lòng điền thông tin chính xác để nhận được mức lãi suất phù hợp nhất`
  String get confirmBeforeCreateLoanMessage {
    return Intl.message(
      'Các thông tin bạn cung cấp sau đây ảnh hưởng tới mức lãi suất khoản vay của bạn. Bạn vui lòng điền thông tin chính xác để nhận được mức lãi suất phù hợp nhất',
      name: 'confirmBeforeCreateLoanMessage',
      desc: '',
      args: [],
    );
  }

  /// `Không hiện lại nữa`
  String get notShowAgain {
    return Intl.message(
      'Không hiện lại nữa',
      name: 'notShowAgain',
      desc: '',
      args: [],
    );
  }

  /// `Trở về`
  String get goBack {
    return Intl.message(
      'Trở về',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay`
  String get loanAmount {
    return Intl.message(
      'Khoản vay',
      name: 'loanAmount',
      desc: '',
      args: [],
    );
  }

  /// `Cá nhân`
  String get personal {
    return Intl.message(
      'Cá nhân',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `Nghề nghiệp`
  String get job {
    return Intl.message(
      'Nghề nghiệp',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `Nhân thân`
  String get identity {
    return Intl.message(
      'Nhân thân',
      name: 'identity',
      desc: '',
      args: [],
    );
  }

  /// `Bổ sung`
  String get additional {
    return Intl.message(
      'Bổ sung',
      name: 'additional',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối Facebook`
  String get connectFacebook {
    return Intl.message(
      'Kết nối Facebook',
      name: 'connectFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Tạo yêu cầu vay`
  String get createLoanTitle {
    return Intl.message(
      'Tạo yêu cầu vay',
      name: 'createLoanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bước 1`
  String get step1 {
    return Intl.message(
      'Bước 1',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin khoản vay`
  String get loanInfo {
    return Intl.message(
      'Thông tin khoản vay',
      name: 'loanInfo',
      desc: '',
      args: [],
    );
  }

  /// `Mục đích vay`
  String get purposeLoan {
    return Intl.message(
      'Mục đích vay',
      name: 'purposeLoan',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền vay`
  String get loanAmountMoney {
    return Intl.message(
      'Số tiền vay',
      name: 'loanAmountMoney',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền vay được duyệt`
  String get loanAmountConfirm {
    return Intl.message(
      'Số tiền vay được duyệt',
      name: 'loanAmountConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Kỳ hạn vay`
  String get loanDuration {
    return Intl.message(
      'Kỳ hạn vay',
      name: 'loanDuration',
      desc: '',
      args: [],
    );
  }

  /// `Kỳ hạn vay được duyệt`
  String get loanDurationConfirm {
    return Intl.message(
      'Kỳ hạn vay được duyệt',
      name: 'loanDurationConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất dự kiến`
  String get expectedInterestRate {
    return Intl.message(
      'Lãi suất dự kiến',
      name: 'expectedInterestRate',
      desc: '',
      args: [],
    );
  }

  /// `Phí dịch vụ`
  String get serviceCharge {
    return Intl.message(
      'Phí dịch vụ',
      name: 'serviceCharge',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán dự kiến`
  String get expectedPayment {
    return Intl.message(
      'Thanh toán dự kiến',
      name: 'expectedPayment',
      desc: '',
      args: [],
    );
  }

  /// `triệu`
  String get million {
    return Intl.message(
      'triệu',
      name: 'million',
      desc: '',
      args: [],
    );
  }

  /// `Ngày`
  String get day {
    return Intl.message(
      'Ngày',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Tuần`
  String get week {
    return Intl.message(
      'Tuần',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Tháng`
  String get month {
    return Intl.message(
      'Tháng',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Năm`
  String get year {
    return Intl.message(
      'Năm',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Khoản phí được thu khi khoản vay được giải ngân thành công`
  String get serviceChargeNote {
    return Intl.message(
      'Khoản phí được thu khi khoản vay được giải ngân thành công',
      name: 'serviceChargeNote',
      desc: '',
      args: [],
    );
  }

  /// `Kết quả tính toán chỉ mang tính chất tham khảo. Khoản thanh toán thực tế có thể điều chỉnh và sẽ được đưa ra sau khi khoản vay của bạn được phê duyệt.`
  String get createLoanStep1Note {
    return Intl.message(
      'Kết quả tính toán chỉ mang tính chất tham khảo. Khoản thanh toán thực tế có thể điều chỉnh và sẽ được đưa ra sau khi khoản vay của bạn được phê duyệt.',
      name: 'createLoanStep1Note',
      desc: '',
      args: [],
    );
  }

  /// `Tính toán lịch trả nợ`
  String get calculatePaymentSchedule {
    return Intl.message(
      'Tính toán lịch trả nợ',
      name: 'calculatePaymentSchedule',
      desc: '',
      args: [],
    );
  }

  /// `đ`
  String get money_currency {
    return Intl.message(
      'đ',
      name: 'money_currency',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin lãi suất`
  String get interestRateInfo {
    return Intl.message(
      'Thông tin lãi suất',
      name: 'interestRateInfo',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất vay`
  String get loanInterestRate {
    return Intl.message(
      'Lãi suất vay',
      name: 'loanInterestRate',
      desc: '',
      args: [],
    );
  }

  /// `Bước 2`
  String get step2 {
    return Intl.message(
      'Bước 2',
      name: 'step2',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin cá nhân`
  String get personalInfo {
    return Intl.message(
      'Thông tin cá nhân',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên`
  String get fullName {
    return Intl.message(
      'Họ và tên',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Của bạn`
  String get yourself {
    return Intl.message(
      'Của bạn',
      name: 'yourself',
      desc: '',
      args: [],
    );
  }

  /// `Giới tính`
  String get sex {
    return Intl.message(
      'Giới tính',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Nam`
  String get male {
    return Intl.message(
      'Nam',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Nữ`
  String get female {
    return Intl.message(
      'Nữ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Ngày sinh`
  String get birthday {
    return Intl.message(
      'Ngày sinh',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Số CMND/thẻ căn cước`
  String get IDCardNumber {
    return Intl.message(
      'Số CMND/thẻ căn cước',
      name: 'IDCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Ngày cấp CMND/thẻ căn cước`
  String get IDCardIssueDate {
    return Intl.message(
      'Ngày cấp CMND/thẻ căn cước',
      name: 'IDCardIssueDate',
      desc: '',
      args: [],
    );
  }

  /// `Nơi cấp`
  String get issueBy {
    return Intl.message(
      'Nơi cấp',
      name: 'issueBy',
      desc: '',
      args: [],
    );
  }

  /// `Nơi cấp CMND/thẻ căn cước`
  String get IDCardIssueBy {
    return Intl.message(
      'Nơi cấp CMND/thẻ căn cước',
      name: 'IDCardIssueBy',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại liên lạc của người thân`
  String get phoneOfRelative {
    return Intl.message(
      'Số điện thoại liên lạc của người thân',
      name: 'phoneOfRelative',
      desc: '',
      args: [],
    );
  }

  /// `SĐT người thân`
  String get phoneOfRelativeHintField {
    return Intl.message(
      'SĐT người thân',
      name: 'phoneOfRelativeHintField',
      desc: '',
      args: [],
    );
  }

  /// `Người thân`
  String get yourRelative {
    return Intl.message(
      'Người thân',
      name: 'yourRelative',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ thường trú`
  String get permanentAddress {
    return Intl.message(
      'Địa chỉ thường trú',
      name: 'permanentAddress',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ tạm trú`
  String get temporaryAddress {
    return Intl.message(
      'Địa chỉ tạm trú',
      name: 'temporaryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chọn địa chỉ`
  String get clickToSelectAddress {
    return Intl.message(
      'Nhấn để chọn địa chỉ',
      name: 'clickToSelectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Chúng tôi chỉ sử dụng các thông tin liên lạc bạn cung cấp nếu không thể liên lạc được với bạn khi cần thiết.`
  String get contactInfoNote {
    return Intl.message(
      'Chúng tôi chỉ sử dụng các thông tin liên lạc bạn cung cấp nếu không thể liên lạc được với bạn khi cần thiết.',
      name: 'contactInfoNote',
      desc: '',
      args: [],
    );
  }

  /// `Loại hình sở hữu`
  String get ownerShipType {
    return Intl.message(
      'Loại hình sở hữu',
      name: 'ownerShipType',
      desc: '',
      args: [],
    );
  }

  /// `Tình trạng hôn nhân`
  String get maritalStatus {
    return Intl.message(
      'Tình trạng hôn nhân',
      name: 'maritalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chọn`
  String get clickToSelect {
    return Intl.message(
      'Nhấn để chọn',
      name: 'clickToSelect',
      desc: '',
      args: [],
    );
  }

  /// `Lưu`
  String get save {
    return Intl.message(
      'Lưu',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Tỉnh/Thành phố`
  String get provinceOrCity {
    return Intl.message(
      'Tỉnh/Thành phố',
      name: 'provinceOrCity',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa chọn`
  String get dropDownValidateText {
    return Intl.message(
      'Bạn chưa chọn',
      name: 'dropDownValidateText',
      desc: '',
      args: [],
    );
  }

  /// `Quận/Huyện`
  String get district {
    return Intl.message(
      'Quận/Huyện',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Phường/Xã/Thị trấn`
  String get ward {
    return Intl.message(
      'Phường/Xã/Thị trấn',
      name: 'ward',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ`
  String get address {
    return Intl.message(
      'Địa chỉ',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số nhà, đường, xóm, thôn...`
  String get hintDetailAddress {
    return Intl.message(
      'Nhập số nhà, đường, xóm, thôn...',
      name: 'hintDetailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Hạng`
  String get rank {
    return Intl.message(
      'Hạng',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Bạn sẽ thoát?`
  String get createLoanExitMsg {
    return Intl.message(
      'Bạn sẽ thoát?',
      name: 'createLoanExitMsg',
      desc: '',
      args: [],
    );
  }

  /// `Thoát`
  String get exit {
    return Intl.message(
      'Thoát',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng nhập`
  String get validatorEmptyField {
    return Intl.message(
      'Vui lòng nhập',
      name: 'validatorEmptyField',
      desc: '',
      args: [],
    );
  }

  /// `để tiếp tục`
  String get validatorToNextMsg {
    return Intl.message(
      'để tiếp tục',
      name: 'validatorToNextMsg',
      desc: '',
      args: [],
    );
  }

  /// ` Ngày không hợp lệ`
  String get invalidDate {
    return Intl.message(
      ' Ngày không hợp lệ',
      name: 'invalidDate',
      desc: '',
      args: [],
    );
  }

  /// `Bước 3`
  String get step3 {
    return Intl.message(
      'Bước 3',
      name: 'step3',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin nghề nghiệp`
  String get occupationInfo {
    return Intl.message(
      'Thông tin nghề nghiệp',
      name: 'occupationInfo',
      desc: '',
      args: [],
    );
  }

  /// `Nghề nghiệp`
  String get occupation {
    return Intl.message(
      'Nghề nghiệp',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Chọn nghề nghiệp`
  String get selectOccupation {
    return Intl.message(
      'Chọn nghề nghiệp',
      name: 'selectOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Khác`
  String get other {
    return Intl.message(
      'Khác',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tên nghề nghiệp`
  String get hintFiledOccupation {
    return Intl.message(
      'Nhập tên nghề nghiệp',
      name: 'hintFiledOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Vị trí làm việc`
  String get positionOccupation {
    return Intl.message(
      'Vị trí làm việc',
      name: 'positionOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Vị trí làm việc trong cơ quan`
  String get positionOccupationHint {
    return Intl.message(
      'Vị trí làm việc trong cơ quan',
      name: 'positionOccupationHint',
      desc: '',
      args: [],
    );
  }

  /// `Nơi làm việc`
  String get nameOccupation {
    return Intl.message(
      'Nơi làm việc',
      name: 'nameOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Tên cơ quan/công ty bạn đang làm`
  String get nameOccupationHint {
    return Intl.message(
      'Tên cơ quan/công ty bạn đang làm',
      name: 'nameOccupationHint',
      desc: '',
      args: [],
    );
  }

  /// `Tên trường học`
  String get nameSchool {
    return Intl.message(
      'Tên trường học',
      name: 'nameSchool',
      desc: '',
      args: [],
    );
  }

  /// `Tên trường bạn đang theo học`
  String get nameSchoolHint {
    return Intl.message(
      'Tên trường bạn đang theo học',
      name: 'nameSchoolHint',
      desc: '',
      args: [],
    );
  }

  /// `Thu nhập hàng tháng`
  String get monthlyIncome {
    return Intl.message(
      'Thu nhập hàng tháng',
      name: 'monthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ cơ quan`
  String get addressOccupation {
    return Intl.message(
      'Địa chỉ cơ quan',
      name: 'addressOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ trường học`
  String get addressSchool {
    return Intl.message(
      'Địa chỉ trường học',
      name: 'addressSchool',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại cơ quan`
  String get phoneOccupation {
    return Intl.message(
      'Số điện thoại cơ quan',
      name: 'phoneOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại trường học`
  String get phoneSchool {
    return Intl.message(
      'Số điện thoại trường học',
      name: 'phoneSchool',
      desc: '',
      args: [],
    );
  }

  /// `Chúng tôi chỉ sử dụng các thông tin liên lạc bạn cung cấp nếu không thể liên lạc được với bạn khi quá hạn trả nợ.`
  String get occupationNote {
    return Intl.message(
      'Chúng tôi chỉ sử dụng các thông tin liên lạc bạn cung cấp nếu không thể liên lạc được với bạn khi quá hạn trả nợ.',
      name: 'occupationNote',
      desc: '',
      args: [],
    );
  }

  /// `Bước 4`
  String get step4 {
    return Intl.message(
      'Bước 4',
      name: 'step4',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản nhận tiền`
  String get paymentAccount {
    return Intl.message(
      'Tài khoản nhận tiền',
      name: 'paymentAccount',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có tài khoản nhận tiền nào. Vui lòng nhấn nút ‘Thêm tài khoản nhận tiền’ bên dưới để tiếp tục đăng ký vay`
  String get linkedPaymentsEmpty {
    return Intl.message(
      'Bạn chưa có tài khoản nhận tiền nào. Vui lòng nhấn nút ‘Thêm tài khoản nhận tiền’ bên dưới để tiếp tục đăng ký vay',
      name: 'linkedPaymentsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Thêm tài khoản nhận tiền`
  String get addLinkedPayment {
    return Intl.message(
      'Thêm tài khoản nhận tiền',
      name: 'addLinkedPayment',
      desc: '',
      args: [],
    );
  }

  /// `Chọn tài khoản để nhận tiền`
  String get selectLinkedPayment {
    return Intl.message(
      'Chọn tài khoản để nhận tiền',
      name: 'selectLinkedPayment',
      desc: '',
      args: [],
    );
  }

  /// `Chọn phương thức nhận tiền`
  String get selectPaymentType {
    return Intl.message(
      'Chọn phương thức nhận tiền',
      name: 'selectPaymentType',
      desc: '',
      args: [],
    );
  }

  /// `Các tài khoản đã liên kết`
  String get linkedPayments {
    return Intl.message(
      'Các tài khoản đã liên kết',
      name: 'linkedPayments',
      desc: '',
      args: [],
    );
  }

  /// `Thêm tài khoản mới`
  String get addNewAccount {
    return Intl.message(
      'Thêm tài khoản mới',
      name: 'addNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Họ và tên chủ tài khoản`
  String get fullNameBankAcc {
    return Intl.message(
      'Họ và tên chủ tài khoản',
      name: 'fullNameBankAcc',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản`
  String get numberBank {
    return Intl.message(
      'Số tài khoản',
      name: 'numberBank',
      desc: '',
      args: [],
    );
  }

  /// `Ví dụ`
  String get example {
    return Intl.message(
      'Ví dụ',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Thêm tài khoản`
  String get addAccount {
    return Intl.message(
      'Thêm tài khoản',
      name: 'addAccount',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ngân hàng`
  String get selectBank {
    return Intl.message(
      'Chọn ngân hàng',
      name: 'selectBank',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ví`
  String get selectWallet {
    return Intl.message(
      'Chọn ví',
      name: 'selectWallet',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ví điện tử`
  String get selectVirtualWallet {
    return Intl.message(
      'Chọn ví điện tử',
      name: 'selectVirtualWallet',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để`
  String get tapTo {
    return Intl.message(
      'Nhấn để',
      name: 'tapTo',
      desc: '',
      args: [],
    );
  }

  /// `Chủ tài khoản`
  String get accountHolder {
    return Intl.message(
      'Chủ tài khoản',
      name: 'accountHolder',
      desc: '',
      args: [],
    );
  }

  /// `Chủ ví`
  String get walletHolder {
    return Intl.message(
      'Chủ ví',
      name: 'walletHolder',
      desc: '',
      args: [],
    );
  }

  /// `Số tài khoản`
  String get numberAccount {
    return Intl.message(
      'Số tài khoản',
      name: 'numberAccount',
      desc: '',
      args: [],
    );
  }

  /// `Thêm`
  String get add {
    return Intl.message(
      'Thêm',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Ngân hàng`
  String get bank {
    return Intl.message(
      'Ngân hàng',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Ví điện tử`
  String get virtualWallet {
    return Intl.message(
      'Ví điện tử',
      name: 'virtualWallet',
      desc: '',
      args: [],
    );
  }

  /// `Sửa thông tin tài khoản`
  String get editAccountInfo {
    return Intl.message(
      'Sửa thông tin tài khoản',
      name: 'editAccountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xóa tài khoản`
  String get removeAccount {
    return Intl.message(
      'Xóa tài khoản',
      name: 'removeAccount',
      desc: '',
      args: [],
    );
  }

  /// `Bước 5`
  String get step5 {
    return Intl.message(
      'Bước 5',
      name: 'step5',
      desc: '',
      args: [],
    );
  }

  /// `Nhân thân`
  String get ID {
    return Intl.message(
      'Nhân thân',
      name: 'ID',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh bạn đang cầm CMND/thẻ căn cước`
  String get cardWithUserImageLabel {
    return Intl.message(
      'Ảnh bạn đang cầm CMND/thẻ căn cước',
      name: 'cardWithUserImageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chụp hình ảnh bạn cầm CMND/thẻ căn cước trước ngực. Yêu cầu rõ nét và chụp trực tiếp từ camera.`
  String get cardWithUserImageHint {
    return Intl.message(
      'Nhấn để chụp hình ảnh bạn cầm CMND/thẻ căn cước trước ngực. Yêu cầu rõ nét và chụp trực tiếp từ camera.',
      name: 'cardWithUserImageHint',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh mặt trước CMND/thẻ căn cước`
  String get cardFrontImageLabel {
    return Intl.message(
      'Ảnh mặt trước CMND/thẻ căn cước',
      name: 'cardFrontImageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chụp hình ảnh mặt trước của CMND/thẻ căn cước. Yêu cầu rõ nét và chụp trực tiếp từ camera.`
  String get cardFrontImageHint {
    return Intl.message(
      'Nhấn để chụp hình ảnh mặt trước của CMND/thẻ căn cước. Yêu cầu rõ nét và chụp trực tiếp từ camera.',
      name: 'cardFrontImageHint',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh mặt sau CMND/thẻ căn cước`
  String get cardBackImageLabel {
    return Intl.message(
      'Ảnh mặt sau CMND/thẻ căn cước',
      name: 'cardBackImageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nhấn để chụp hình ảnh mặt sau của CMND/thẻ căn cước. Yêu cầu rõ nét và chụp trực tiếp từ camera.`
  String get cardBackImageHint {
    return Intl.message(
      'Nhấn để chụp hình ảnh mặt sau của CMND/thẻ căn cước. Yêu cầu rõ nét và chụp trực tiếp từ camera.',
      name: 'cardBackImageHint',
      desc: '',
      args: [],
    );
  }

  /// `Chụp ảnh`
  String get takePicture {
    return Intl.message(
      'Chụp ảnh',
      name: 'takePicture',
      desc: '',
      args: [],
    );
  }

  /// `Chọn ảnh có sẵn`
  String get selectPicture {
    return Intl.message(
      'Chọn ảnh có sẵn',
      name: 'selectPicture',
      desc: '',
      args: [],
    );
  }

  /// `Bước 6`
  String get step6 {
    return Intl.message(
      'Bước 6',
      name: 'step6',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin bổ sung`
  String get additionInfo {
    return Intl.message(
      'Thông tin bổ sung',
      name: 'additionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh bảng lương/chấm công của bạn`
  String get payrollOrTimeSheetsImage {
    return Intl.message(
      'Ảnh bảng lương/chấm công của bạn',
      name: 'payrollOrTimeSheetsImage',
      desc: '',
      args: [],
    );
  }

  /// `Bước 7`
  String get step7 {
    return Intl.message(
      'Bước 7',
      name: 'step7',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối với Facebook`
  String get connectWithFacebook {
    return Intl.message(
      'Kết nối với Facebook',
      name: 'connectWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối tài khoản Facebook`
  String get connectFacebookAccount {
    return Intl.message(
      'Kết nối tài khoản Facebook',
      name: 'connectFacebookAccount',
      desc: '',
      args: [],
    );
  }

  /// `Chúng tôi cam kết không sử dụng các thông tin Facebook của bạn vào mục đích gì khác ngoài việc xác thực thông tin cá nhân.`
  String get connectFacebookNote {
    return Intl.message(
      'Chúng tôi cam kết không sử dụng các thông tin Facebook của bạn vào mục đích gì khác ngoài việc xác thực thông tin cá nhân.',
      name: 'connectFacebookNote',
      desc: '',
      args: [],
    );
  }

  /// `Ảnh`
  String get picture {
    return Intl.message(
      'Ảnh',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiết đơn vay`
  String get detailLoan {
    return Intl.message(
      'Chi tiết đơn vay',
      name: 'detailLoan',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tạo đơn`
  String get dateCreateLoan {
    return Intl.message(
      'Ngày tạo đơn',
      name: 'dateCreateLoan',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền vay`
  String get amountLoan {
    return Intl.message(
      'Số tiền vay',
      name: 'amountLoan',
      desc: '',
      args: [],
    );
  }

  /// `Kỳ hạn vay`
  String get durationLoan {
    return Intl.message(
      'Kỳ hạn vay',
      name: 'durationLoan',
      desc: '',
      args: [],
    );
  }

  /// `Tôi đã hiểu và đồng ý với`
  String get agreeWith {
    return Intl.message(
      'Tôi đã hiểu và đồng ý với',
      name: 'agreeWith',
      desc: '',
      args: [],
    );
  }

  /// `Điều khoản và điều kiện vay`
  String get loanTermsAndConditions {
    return Intl.message(
      'Điều khoản và điều kiện vay',
      name: 'loanTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Gửi hồ sơ vay tiền`
  String get sendLoanProfile {
    return Intl.message(
      'Gửi hồ sơ vay tiền',
      name: 'sendLoanProfile',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật hồ sơ vay tiền`
  String get updateLoanProfile {
    return Intl.message(
      'Cập nhật hồ sơ vay tiền',
      name: 'updateLoanProfile',
      desc: '',
      args: [],
    );
  }

  /// `Trả góp dự kiến hàng tháng`
  String get estimatedMonthlyInstallments {
    return Intl.message(
      'Trả góp dự kiến hàng tháng',
      name: 'estimatedMonthlyInstallments',
      desc: '',
      args: [],
    );
  }

  /// `Gửi đơn vay`
  String get sendLoan {
    return Intl.message(
      'Gửi đơn vay',
      name: 'sendLoan',
      desc: '',
      args: [],
    );
  }

  /// `Gửi đơn vay thành công!`
  String get sendLoanProfileSuccess {
    return Intl.message(
      'Gửi đơn vay thành công!',
      name: 'sendLoanProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn đã được gửi đi thành công. Hệ thống sẽ tiến hành phê duyệt và đưa ra mức lãi suất, khoản thanh toán phù hợp nhất với bạn. Hãy theo dõi thông báo để biết kết quả!`
  String get sendLoanProfileSuccessMsg {
    return Intl.message(
      'Đơn vay của bạn đã được gửi đi thành công. Hệ thống sẽ tiến hành phê duyệt và đưa ra mức lãi suất, khoản thanh toán phù hợp nhất với bạn. Hãy theo dõi thông báo để biết kết quả!',
      name: 'sendLoanProfileSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Về trang chủ`
  String get backHome {
    return Intl.message(
      'Về trang chủ',
      name: 'backHome',
      desc: '',
      args: [],
    );
  }

  /// `Xin chào`
  String get welcome {
    return Intl.message(
      'Xin chào',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Trạng thái`
  String get status {
    return Intl.message(
      'Trạng thái',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Thời hạn`
  String get duration {
    return Intl.message(
      'Thời hạn',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Tạo khoản vay mới`
  String get createNewLoan {
    return Intl.message(
      'Tạo khoản vay mới',
      name: 'createNewLoan',
      desc: '',
      args: [],
    );
  }

  /// `Hoàn thiện đơn vay`
  String get completeLoan {
    return Intl.message(
      'Hoàn thiện đơn vay',
      name: 'completeLoan',
      desc: '',
      args: [],
    );
  }

  /// `Hủy yêu cầu vay`
  String get cancelLoanRequest {
    return Intl.message(
      'Hủy yêu cầu vay',
      name: 'cancelLoanRequest',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắc muốn hủy yêu cầu vay`
  String get cancelLoanRequestMsg1 {
    return Intl.message(
      'Bạn có chắc chắc muốn hủy yêu cầu vay',
      name: 'cancelLoanRequestMsg1',
      desc: '',
      args: [],
    );
  }

  /// `này`
  String get cancelLoanRequestMsg2 {
    return Intl.message(
      'này',
      name: 'cancelLoanRequestMsg2',
      desc: '',
      args: [],
    );
  }

  /// `Sửa đơn vay`
  String get editLoan {
    return Intl.message(
      'Sửa đơn vay',
      name: 'editLoan',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật thông tin`
  String get updateInfo {
    return Intl.message(
      'Cập nhật thông tin',
      name: 'updateInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xem thêm thông tin`
  String get detailInfo {
    return Intl.message(
      'Xem thêm thông tin',
      name: 'detailInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xóa đơn vay`
  String get removeLoan {
    return Intl.message(
      'Xóa đơn vay',
      name: 'removeLoan',
      desc: '',
      args: [],
    );
  }

  /// `Chưa hoàn thiện`
  String get incomplete {
    return Intl.message(
      'Chưa hoàn thiện',
      name: 'incomplete',
      desc: '',
      args: [],
    );
  }

  /// `Đang đợi duyệt`
  String get submitted {
    return Intl.message(
      'Đang đợi duyệt',
      name: 'submitted',
      desc: '',
      args: [],
    );
  }

  /// `Cần cập nhật thông tin`
  String get updateRequired {
    return Intl.message(
      'Cần cập nhật thông tin',
      name: 'updateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Cần bổ sung thông tin`
  String get moreInfoRequired {
    return Intl.message(
      'Cần bổ sung thông tin',
      name: 'moreInfoRequired',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay bị từ chối`
  String get reject {
    return Intl.message(
      'Đơn vay bị từ chối',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Đã xóa`
  String get cancelStatus {
    return Intl.message(
      'Đã xóa',
      name: 'cancelStatus',
      desc: '',
      args: [],
    );
  }

  /// `Cần xác nhận lãi suất`
  String get interestRateConfirmStatus {
    return Intl.message(
      'Cần xác nhận lãi suất',
      name: 'interestRateConfirmStatus',
      desc: '',
      args: [],
    );
  }

  /// `Đang huy động vốn`
  String get onMarket {
    return Intl.message(
      'Đang huy động vốn',
      name: 'onMarket',
      desc: '',
      args: [],
    );
  }

  /// `Đang huy động vốn`
  String get fundRaised {
    return Intl.message(
      'Đang huy động vốn',
      name: 'fundRaised',
      desc: '',
      args: [],
    );
  }

  /// `Đã huy động`
  String get raised {
    return Intl.message(
      'Đã huy động',
      name: 'raised',
      desc: '',
      args: [],
    );
  }

  /// `Đã huy động đủ 100%`
  String get fundRaisedEnough {
    return Intl.message(
      'Đã huy động đủ 100%',
      name: 'fundRaisedEnough',
      desc: '',
      args: [],
    );
  }

  /// `Hết thời gian huy động`
  String get fundOvertime {
    return Intl.message(
      'Hết thời gian huy động',
      name: 'fundOvertime',
      desc: '',
      args: [],
    );
  }

  /// `Đang chờ nhận tiền`
  String get disburmentPending {
    return Intl.message(
      'Đang chờ nhận tiền',
      name: 'disburmentPending',
      desc: '',
      args: [],
    );
  }

  /// `Đang vay tiền`
  String get onLoan {
    return Intl.message(
      'Đang vay tiền',
      name: 'onLoan',
      desc: '',
      args: [],
    );
  }

  /// `Xóa`
  String get delete {
    return Intl.message(
      'Xóa',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu vay của bạn đã được hủy. Bạn có thể tạo một yêu cầu vay mới`
  String get cancelLoanSuccessMsg {
    return Intl.message(
      'Yêu cầu vay của bạn đã được hủy. Bạn có thể tạo một yêu cầu vay mới',
      name: 'cancelLoanSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Loại gói vay`
  String get loanProduct {
    return Intl.message(
      'Loại gói vay',
      name: 'loanProduct',
      desc: '',
      args: [],
    );
  }

  /// `Trả góp hàng tháng`
  String get monthlyInstallment {
    return Intl.message(
      'Trả góp hàng tháng',
      name: 'monthlyInstallment',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử thanh toán`
  String get historyPayment {
    return Intl.message(
      'Lịch sử thanh toán',
      name: 'historyPayment',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán`
  String get pay {
    return Intl.message(
      'Thanh toán',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Bổ sung thông tin`
  String get implementInfo {
    return Intl.message(
      'Bổ sung thông tin',
      name: 'implementInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xóa yêu cầu vay`
  String get deleteLoanRequest {
    return Intl.message(
      'Xóa yêu cầu vay',
      name: 'deleteLoanRequest',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận lãi suất`
  String get interestRateConfirm {
    return Intl.message(
      'Xác nhận lãi suất',
      name: 'interestRateConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Giải ngân`
  String get disbursement {
    return Intl.message(
      'Giải ngân',
      name: 'disbursement',
      desc: '',
      args: [],
    );
  }

  /// `Đã cập nhật thông tin`
  String get updatedInfo {
    return Intl.message(
      'Đã cập nhật thông tin',
      name: 'updatedInfo',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận lãi suất\nthành công`
  String get confirmInterestRateSuccess {
    return Intl.message(
      'Xác nhận lãi suất\nthành công',
      name: 'confirmInterestRateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn đã sẵn sàng trên sàn giao dịch và bắt đầu huy động vốn từ các nhà đầu tư. Vui lòng kiểm tra các thông báo từ FinSmart để cập nhật tình hình sớm nhất về khoản vay này.`
  String get confirmInterestRateSuccessMsg {
    return Intl.message(
      'Đơn vay của bạn đã sẵn sàng trên sàn giao dịch và bắt đầu huy động vốn từ các nhà đầu tư. Vui lòng kiểm tra các thông báo từ FinSmart để cập nhật tình hình sớm nhất về khoản vay này.',
      name: 'confirmInterestRateSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn đang được phê duyệt.`
  String get submittedLoanStatusTitle {
    return Intl.message(
      'Đơn vay của bạn đang được phê duyệt.',
      name: 'submittedLoanStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn cần được cập nhật thông tin.`
  String get updateRequiredStatusTitle {
    return Intl.message(
      'Đơn vay của bạn cần được cập nhật thông tin.',
      name: 'updateRequiredStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Đơn vay của bạn cần được bổ sung thông tin.`
  String get moreInfoRequiredStatusTitle {
    return Intl.message(
      'Đơn vay của bạn cần được bổ sung thông tin.',
      name: 'moreInfoRequiredStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rất tiếc, yêu cầu vay của bạn đã bị từ chối.`
  String get rejectStatusTitle {
    return Intl.message(
      'Rất tiếc, yêu cầu vay của bạn đã bị từ chối.',
      name: 'rejectStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Chúc mừng`
  String get congratulation {
    return Intl.message(
      'Chúc mừng',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `đơn vay của bạn được duyệt với lãi suất`
  String get interestRateConfirmStatusTitle {
    return Intl.message(
      'đơn vay của bạn được duyệt với lãi suất',
      name: 'interestRateConfirmStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hãy ấn ‘Xác nhận lãi suất’ để bắt đầu huy động tiền từ các nhà đầu tư.`
  String get interestRateConfirmStatusMsg {
    return Intl.message(
      'Hãy ấn ‘Xác nhận lãi suất’ để bắt đầu huy động tiền từ các nhà đầu tư.',
      name: 'interestRateConfirmStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `FinSmart đang huy động cho khoản vay của bạn.`
  String get onMarketStatusTitle {
    return Intl.message(
      'FinSmart đang huy động cho khoản vay của bạn.',
      name: 'onMarketStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Xin vui lòng chờ, khoản vay của bạn đang được huy động vốn từ các nhà đầu tư.`
  String get onMarketStatusMsg {
    return Intl.message(
      'Xin vui lòng chờ, khoản vay của bạn đang được huy động vốn từ các nhà đầu tư.',
      name: 'onMarketStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `khoản vay của bạn đã được huy động đủ.`
  String get fundRaisedEnoughStatusTitle {
    return Intl.message(
      'khoản vay của bạn đã được huy động đủ.',
      name: 'fundRaisedEnoughStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hãy ấn nút ‘Giải ngân’ để ký hợp đồng và nhận tiền ngay.`
  String get fundRaisedEnoughStatusMsg {
    return Intl.message(
      'Hãy ấn nút ‘Giải ngân’ để ký hợp đồng và nhận tiền ngay.',
      name: 'fundRaisedEnoughStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã huy động được`
  String get fundRaisedNotEnoughStatusTitle1 {
    return Intl.message(
      'Bạn đã huy động được',
      name: 'fundRaisedNotEnoughStatusTitle1',
      desc: '',
      args: [],
    );
  }

  /// `trong vòng`
  String get fundRaisedNotEnoughStatusTitle2 {
    return Intl.message(
      'trong vòng',
      name: 'fundRaisedNotEnoughStatusTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có thể tiếp tục huy động để có đủ số tiền vay hoặc ấn "Giải ngân sớm" để nhận ngay số tiền đã huy động được.`
  String get fundRaisedNotEnoughStatusMsg {
    return Intl.message(
      'Bạn có thể tiếp tục huy động để có đủ số tiền vay hoặc ấn "Giải ngân sớm" để nhận ngay số tiền đã huy động được.',
      name: 'fundRaisedNotEnoughStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `Đã hết thời gian huy động. Số tiền huy động được:`
  String get fundOverTimeStatusTitle {
    return Intl.message(
      'Đã hết thời gian huy động. Số tiền huy động được:',
      name: 'fundOverTimeStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay của bạn đã hết thời gian huy động. Bạn có thể giải ngân số tiền huy động được.`
  String get fundOverTimeStatusMsg {
    return Intl.message(
      'Khoản vay của bạn đã hết thời gian huy động. Bạn có thể giải ngân số tiền huy động được.',
      name: 'fundOverTimeStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `Đã hết thời gian huy động nhưng chưa đủ số tiền để giải ngân.`
  String get fundOverTimeNotEnoughStatusTitle {
    return Intl.message(
      'Đã hết thời gian huy động nhưng chưa đủ số tiền để giải ngân.',
      name: 'fundOverTimeNotEnoughStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay của bạn đã hết thời gian huy động nhưng không đủ để được giải ngân`
  String get fundOverTimeNotEnoughStatusMsg {
    return Intl.message(
      'Khoản vay của bạn đã hết thời gian huy động nhưng không đủ để được giải ngân',
      name: 'fundOverTimeNotEnoughStatusMsg',
      desc: '',
      args: [],
    );
  }

  /// `Ký hợp đồng thành công. Bạn sẽ nhận tiền trong thời gian sớm nhất`
  String get disbursementPendingStatusTitle {
    return Intl.message(
      'Ký hợp đồng thành công. Bạn sẽ nhận tiền trong thời gian sớm nhất',
      name: 'disbursementPendingStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ngày duyệt đơn`
  String get dateSubmitLoan {
    return Intl.message(
      'Ngày duyệt đơn',
      name: 'dateSubmitLoan',
      desc: '',
      args: [],
    );
  }

  /// `Ngày vay`
  String get dateLoan {
    return Intl.message(
      'Ngày vay',
      name: 'dateLoan',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền muốn vay`
  String get amountExpectedLoan {
    return Intl.message(
      'Số tiền muốn vay',
      name: 'amountExpectedLoan',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền huy động được`
  String get amountRaised {
    return Intl.message(
      'Số tiền huy động được',
      name: 'amountRaised',
      desc: '',
      args: [],
    );
  }

  /// `Hạn huy động`
  String get deadlineLoanRaise {
    return Intl.message(
      'Hạn huy động',
      name: 'deadlineLoanRaise',
      desc: '',
      args: [],
    );
  }

  /// `Ngày huy động còn lại`
  String get raisedDayLeft {
    return Intl.message(
      'Ngày huy động còn lại',
      name: 'raisedDayLeft',
      desc: '',
      args: [],
    );
  }

  /// `Giải ngân sớm`
  String get earlyDisbursement {
    return Intl.message(
      'Giải ngân sớm',
      name: 'earlyDisbursement',
      desc: '',
      args: [],
    );
  }

  /// `Xem hợp đồng vay`
  String get readContract {
    return Intl.message(
      'Xem hợp đồng vay',
      name: 'readContract',
      desc: '',
      args: [],
    );
  }

  /// `Xem lại hợp đồng`
  String get reviewContract {
    return Intl.message(
      'Xem lại hợp đồng',
      name: 'reviewContract',
      desc: '',
      args: [],
    );
  }

  /// `Số tháng đã thanh toán`
  String get numberMonthPaid {
    return Intl.message(
      'Số tháng đã thanh toán',
      name: 'numberMonthPaid',
      desc: '',
      args: [],
    );
  }

  /// `Ngày thanh toán tiếp theo`
  String get nextPaymentDate {
    return Intl.message(
      'Ngày thanh toán tiếp theo',
      name: 'nextPaymentDate',
      desc: '',
      args: [],
    );
  }

  /// `bạn đang vay`
  String get youAreBorrowing {
    return Intl.message(
      'bạn đang vay',
      name: 'youAreBorrowing',
      desc: '',
      args: [],
    );
  }

  /// `Bạn cần thanh toán`
  String get youNeedToPay {
    return Intl.message(
      'Bạn cần thanh toán',
      name: 'youNeedToPay',
      desc: '',
      args: [],
    );
  }

  /// `trong tháng này`
  String get inThisMonth {
    return Intl.message(
      'trong tháng này',
      name: 'inThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Hãy thanh toán trước ngày:`
  String get pleasePayBeforeDate {
    return Intl.message(
      'Hãy thanh toán trước ngày:',
      name: 'pleasePayBeforeDate',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay của bạn đang quá hạn`
  String get overDueLoan {
    return Intl.message(
      'Khoản vay của bạn đang quá hạn',
      name: 'overDueLoan',
      desc: '',
      args: [],
    );
  }

  /// `ngay nếu không sẽ`
  String get overDueLoanMsg {
    return Intl.message(
      'ngay nếu không sẽ',
      name: 'overDueLoanMsg',
      desc: '',
      args: [],
    );
  }

  /// `chịu phạt theo như hợp đồng`
  String get overDueLoanMsg1 {
    return Intl.message(
      'chịu phạt theo như hợp đồng',
      name: 'overDueLoanMsg1',
      desc: '',
      args: [],
    );
  }

  /// `Tiền phí sẽ được trừ ngay sau khi giải ngân tiền vay`
  String get confirmInterestRateNote {
    return Intl.message(
      'Tiền phí sẽ được trừ ngay sau khi giải ngân tiền vay',
      name: 'confirmInterestRateNote',
      desc: '',
      args: [],
    );
  }

  /// `tiếp tục huy động`
  String get continueRaised {
    return Intl.message(
      'tiếp tục huy động',
      name: 'continueRaised',
      desc: '',
      args: [],
    );
  }

  /// `Ký hợp đồng để giải ngân`
  String get signContractToDisburse {
    return Intl.message(
      'Ký hợp đồng để giải ngân',
      name: 'signContractToDisburse',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay của bạn đã được huy động đủ số tiền. Chỉ còn một bước ký hợp đồng để nhận tiền.`
  String get disburseNote {
    return Intl.message(
      'Khoản vay của bạn đã được huy động đủ số tiền. Chỉ còn một bước ký hợp đồng để nhận tiền.',
      name: 'disburseNote',
      desc: '',
      args: [],
    );
  }

  /// `Hợp đồng vay`
  String get loanContract {
    return Intl.message(
      'Hợp đồng vay',
      name: 'loanContract',
      desc: '',
      args: [],
    );
  }

  /// `Ký hợp đồng`
  String get signContract {
    return Intl.message(
      'Ký hợp đồng',
      name: 'signContract',
      desc: '',
      args: [],
    );
  }

  /// `Đã ký`
  String get signed {
    return Intl.message(
      'Đã ký',
      name: 'signed',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý ký hợp đồng`
  String get agreeToSignContract {
    return Intl.message(
      'Đồng ý ký hợp đồng',
      name: 'agreeToSignContract',
      desc: '',
      args: [],
    );
  }

  /// `Ký hợp đồng thành công`
  String get signContractSuccess {
    return Intl.message(
      'Ký hợp đồng thành công',
      name: 'signContractSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Chúc mừng bạn đã ký hợp đồng thành công. Khoản vay sẽ được giải ngân vào tài khoản của bạn trong vòng 8 giờ làm việc. Cảm ơn bạn!`
  String get signContractSuccessMsg {
    return Intl.message(
      'Chúc mừng bạn đã ký hợp đồng thành công. Khoản vay sẽ được giải ngân vào tài khoản của bạn trong vòng 8 giờ làm việc. Cảm ơn bạn!',
      name: 'signContractSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Đổi kết nối Facebook`
  String get changeFacebookFacebookConnection {
    return Intl.message(
      'Đổi kết nối Facebook',
      name: 'changeFacebookFacebookConnection',
      desc: '',
      args: [],
    );
  }

  /// `Lịch trả nợ`
  String get repaymentSchedule {
    return Intl.message(
      'Lịch trả nợ',
      name: 'repaymentSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Chưa đến kỳ`
  String get notDueYet {
    return Intl.message(
      'Chưa đến kỳ',
      name: 'notDueYet',
      desc: '',
      args: [],
    );
  }

  /// `Đã thanh toán`
  String get paid {
    return Intl.message(
      'Đã thanh toán',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Cần thanh toán ngay`
  String get needPaymentNow {
    return Intl.message(
      'Cần thanh toán ngay',
      name: 'needPaymentNow',
      desc: '',
      args: [],
    );
  }

  /// `Chọn loại thanh toán`
  String get choosePaymentType {
    return Intl.message(
      'Chọn loại thanh toán',
      name: 'choosePaymentType',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán tháng này`
  String get payThisMonth {
    return Intl.message(
      'Thanh toán tháng này',
      name: 'payThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Hạn`
  String get deadline {
    return Intl.message(
      'Hạn',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Thanh toán trước toàn bộ`
  String get fullPaymentAdvance {
    return Intl.message(
      'Thanh toán trước toàn bộ',
      name: 'fullPaymentAdvance',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get amount {
    return Intl.message(
      'Số tiền',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Tiền gốc`
  String get principalAmount {
    return Intl.message(
      'Tiền gốc',
      name: 'principalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Tiền lãi`
  String get interestAmount {
    return Intl.message(
      'Tiền lãi',
      name: 'interestAmount',
      desc: '',
      args: [],
    );
  }

  /// `Phí chuyển khoản`
  String get transferFees {
    return Intl.message(
      'Phí chuyển khoản',
      name: 'transferFees',
      desc: '',
      args: [],
    );
  }

  /// `Phí trả nợ trước hạn`
  String get prepaymentFees {
    return Intl.message(
      'Phí trả nợ trước hạn',
      name: 'prepaymentFees',
      desc: '',
      args: [],
    );
  }

  /// `Quản lý các khoản vay`
  String get loansManager {
    return Intl.message(
      'Quản lý các khoản vay',
      name: 'loansManager',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu`
  String get changePassword {
    return Intl.message(
      'Đổi mật khẩu',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Tính toán lịch trả nợ`
  String get calculatorSchedulePayment {
    return Intl.message(
      'Tính toán lịch trả nợ',
      name: 'calculatorSchedulePayment',
      desc: '',
      args: [],
    );
  }

  /// `Mail hỗ trợ`
  String get supportMail {
    return Intl.message(
      'Mail hỗ trợ',
      name: 'supportMail',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản giới thiệu`
  String get referenceAccount {
    return Intl.message(
      'Tài khoản giới thiệu',
      name: 'referenceAccount',
      desc: '',
      args: [],
    );
  }

  /// `Các câu hỏi thường gặp`
  String get frequentlyAskedQuestions {
    return Intl.message(
      'Các câu hỏi thường gặp',
      name: 'frequentlyAskedQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Điều khoản sử dụng`
  String get termsOfUse {
    return Intl.message(
      'Điều khoản sử dụng',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Giới thiệu`
  String get introduction {
    return Intl.message(
      'Giới thiệu',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `Mony`
  String get mony {
    return Intl.message(
      'Mony',
      name: 'mony',
      desc: '',
      args: [],
    );
  }

  /// `Đã kết nối`
  String get connected {
    return Intl.message(
      'Đã kết nối',
      name: 'connected',
      desc: '',
      args: [],
    );
  }

  /// `Tạo đơn vay`
  String get createLoan {
    return Intl.message(
      'Tạo đơn vay',
      name: 'createLoan',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có khoản vay nào. Vui lòng tạo một đơn vay mới để bắt đầu vay tiền.`
  String get loanManagerEmpty {
    return Intl.message(
      'Bạn chưa có khoản vay nào. Vui lòng tạo một đơn vay mới để bắt đầu vay tiền.',
      name: 'loanManagerEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Khoản vay hiện tại`
  String get currentLoans {
    return Intl.message(
      'Khoản vay hiện tại',
      name: 'currentLoans',
      desc: '',
      args: [],
    );
  }

  /// `Các khoản vay đã kết thúc`
  String get endLoans {
    return Intl.message(
      'Các khoản vay đã kết thúc',
      name: 'endLoans',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa có thông báo nào. Các thông báo về Mony sẽ được hiển thị ở đây.`
  String get notificationEmptyMsg {
    return Intl.message(
      'Bạn chưa có thông báo nào. Các thông báo về Mony sẽ được hiển thị ở đây.',
      name: 'notificationEmptyMsg',
      desc: '',
      args: [],
    );
  }

  /// `Lựa chọn thêm`
  String get additionalOption {
    return Intl.message(
      'Lựa chọn thêm',
      name: 'additionalOption',
      desc: '',
      args: [],
    );
  }

  /// `Đánh dấu tất cả đã đọc`
  String get markAllAsRead {
    return Intl.message(
      'Đánh dấu tất cả đã đọc',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
