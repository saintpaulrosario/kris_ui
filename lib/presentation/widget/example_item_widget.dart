import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/example/bloc/example_bloc.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

class ExampleItemWidget extends StatefulWidget {
  final Identifier identifier;
  const ExampleItemWidget({super.key, required this.identifier});

  @override
  State<ExampleItemWidget> createState() => _ExampleItemWidgetState();
}

class _ExampleItemWidgetState extends State<ExampleItemWidget> {
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
        if (state.fetching) {
          return const CircularProgressIndicator();
        }

        final example = state.example;

        if (example == null) {
          context.read<ExampleBloc>().add(
            ExampleEventFetchBySku(sku: widget.identifier.sku),
          );
          return Text("Example not fetched yet");
        }

        return ContentListWidget(identifiers: example.contents);
      },
    );
  }
}
