import 'package:p2p_borrower/data/model/request/linking_payment_request.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'payment_remote_source.g.dart';

@RestApi()
abstract class PaymentRemoteSource {
  factory PaymentRemoteSource(Dio dio, {String baseUrl}) = _PaymentRemoteSource;

  @POST('/borrower/Account/add-update-linked-payment')
  Future<LinkedPaymentResponse?>? addOrUpdateLinkedPayment(@Body() LinkingPaymentRequest request);

  @GET('/borrower/Account/get-payment-services')
  Future<List<PaymentServiceResponse>?>? getPaymentServices();

  @GET('/borrower/Account/get-linked-payments')
  Future<List<LinkedPaymentResponse>?>? getLinkedPayment();

  @DELETE('/borrower/Account/remove-linked-payment')
  Future<void> removeLinkedPayment(@Query("linkedPaymentId") int id);
}
