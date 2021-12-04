import 'package:flutter/material.dart';

class CreateLoanLoadingWidget extends StatelessWidget {
  const CreateLoanLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: const CircularProgressIndicator());
  }
}
