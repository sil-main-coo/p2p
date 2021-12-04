import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/data/model/request/linking_payment_request.dart';
import 'package:p2p_borrower/data/model/response/linked_payment_response.dart';
import 'package:p2p_borrower/data/model/response/payment_services_response.dart';
import 'package:p2p_borrower/data/sources/remote/payment_remote_source.dart';
import 'package:p2p_borrower/domain/repositories/payment_repository.dart';

class PaymentRepoImplement implements PaymentRepository {
  final PaymentRemoteSource paymentRemoteSource;

  const PaymentRepoImplement({required this.paymentRemoteSource});

  @override
  Future<LinkedPaymentResponse?>? addOrUpdateLinkedPayment(LinkingPaymentRequest request) async {
    try {
      return await paymentRemoteSource.addOrUpdateLinkedPayment(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<List<LinkedPaymentResponse>?>? getLinkedPayment() async {
    try {
      return await paymentRemoteSource.getLinkedPayment();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<List<PaymentServiceResponse>?>? getPaymentServices() async {
    try {
      return await paymentRemoteSource.getPaymentServices();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<void> removeLinkedPayment(int id) async {
    try {
      return await paymentRemoteSource.removeLinkedPayment(id);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }
}
