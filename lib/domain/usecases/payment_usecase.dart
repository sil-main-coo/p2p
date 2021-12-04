import 'package:p2p_borrower/data/model/request/linking_payment_request.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:p2p_borrower/domain/repositories/payment_repository.dart';

class PaymentUseCase {
  final PaymentRepository paymentRepository;

  PaymentUseCase({required this.paymentRepository});

  Future<List<PaymentServiceResponse>?>? fetchPaymentServices() =>
      paymentRepository.getPaymentServices();

  Future<LinkedPaymentResponse?>? addOrUpdateLinkedPayment(
          {required LinkingPaymentRequest request}) =>
      paymentRepository.addOrUpdateLinkedPayment(request);

  Future<List<LinkedPaymentResponse>?>? fetchLinkedPayment() =>
      paymentRepository.getLinkedPayment();

  Future<void> removeLinkedPayment(int id) =>
      paymentRepository.removeLinkedPayment(id);
}
