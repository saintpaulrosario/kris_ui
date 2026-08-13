import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  void initState() {
    super.initState();
    //context.read<>()
  }

  @override
  Widget build(BuildContext context) {
    return Text("language");
  }
}
