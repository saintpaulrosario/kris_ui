import 'package:flutter/material.dart';
import 'package:kris/logic/identifier.dart';

class PayloadPage extends StatefulWidget {
  final Identifier identifier;
  const PayloadPage({super.key, required this.identifier});

  @override
  State<PayloadPage> createState() => _PayloadPageState();
}

class _PayloadPageState extends State<PayloadPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
