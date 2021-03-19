import 'package:flutter/material.dart';

class VenderPayments extends StatefulWidget {
  @override
  _VenderPaymentsState createState() => _VenderPaymentsState();
}

class _VenderPaymentsState extends State<VenderPayments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height,
    );
  }
}
