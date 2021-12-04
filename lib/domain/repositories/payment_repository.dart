import 'package:p2p_borrower/data/model/request/linking_payment_request.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';

abstract class PaymentRepository {
  Future<LinkedPaymentResponse?>? addOrUpdateLinkedPayment(LinkingPaymentRequest request);

  Future<List<PaymentServiceResponse>?>? getPaymentServices();

  Future<List<LinkedPaymentResponse>?>? getLinkedPayment();

  Future<void> removeLinkedPayment(int id);
}
