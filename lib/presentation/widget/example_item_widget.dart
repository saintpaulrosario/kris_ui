import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/example/bloc/example_bloc.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/logic/identifier.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

class ExampleItemWidget extends StatefulWidget {
  final Identifier identifier;
  const ExampleItemWidget({super.key, required this.identifier});

  @override
  State<ExampleItemWidget> createState() => _ExampleItemWidgetState();
}

class _ExampleItemWidgetState extends State<ExampleItemWidget> {
  @override
  void initState() {
    context.read<ExampleBloc>().add(
      ExampleEventFetchByWord(identifier: widget.identifier),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ExampleBloc,
      ExampleState,
      ({bool fetching, Example? example})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          example: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.example == null) {
          return const Text("example not found");
        }

        final identifier = Identifier(
          sku: state.example!.sku,
          version: state.example!.version,
          ordinal: state.example!.ordinal,
          createdDate: state.example!.createdDate,
          lastModifiedDate: state.example!.lastModifiedDate,
          createdBy: state.example!.createdBy,
          lastModifiedBy: state.example!.lastModifiedBy,
          type: state.example!.type,
        );
        return WordItemScreen(identifier: identifier);
      },
    );
  }
}
