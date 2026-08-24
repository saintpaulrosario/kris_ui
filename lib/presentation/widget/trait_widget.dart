import 'package:flutter/material.dart';

import 'package:kris/presentation/widget/dialect_widget.dart';

import '../../model/trait.dart';

class TraitWidget extends StatelessWidget {
  final Trait trait;

  const TraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return DialectWidget(identifier: trait.dialect);
  }
}
