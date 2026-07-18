import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/word_text.dart';

class WordDetailPage extends StatefulWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      RetrieveWordBySkuEvent(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),
      builder: (context, wordState) {
        if (wordState.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (wordState.word == null) {
          return const Center(child: Text("Word not found"));
        }

        final word = wordState.word!;

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: word.texts.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, textIndex) {
            final textIdentifier = word.texts[textIndex];

            return BlocSelector<
              WordTextBloc,
              WordTextState,
              ({bool fetching, WordText? text})
            >(
              selector: (state) => (
                fetching: state.fetching.contains(textIdentifier.sku),
                text: state.data[textIdentifier.sku],
              ),
              builder: (context, textState) {
                if (textState.fetching) {
                  return const CircularProgressIndicator();
                }

                if (textState.text == null) {
                  return const Text("Word text not found");
                }

                final wordText = textState.text!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: wordText.contents.map((contentIdentifier) {
                    return BlocSelector<
                      ContentBloc,
                      ContentState,
                      ({bool fetching, Content? content})
                    >(
                      selector: (state) => (
                        fetching: state.fetching.contains(
                          contentIdentifier.sku,
                        ),
                        content: state.data[contentIdentifier.sku],
                      ),
                      builder: (context, contentState) {
                        if (contentState.fetching) {
                          return const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (contentState.content == null) {
                          return const Text("Content not found");
                        }

                        final content = contentState.content!;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: content.payloads.map((
                                  payloadIdentifier,
                                ) {
                                  return BlocSelector<
                                    PayloadBloc,
                                    PayloadState,
                                    ({bool fetching, Payload? payload})
                                  >(
                                    selector: (state) => (
                                      fetching: state.fetching.contains(
                                        payloadIdentifier.sku,
                                      ),
                                      payload:
                                          state.data[payloadIdentifier.sku],
                                    ),
                                    builder: (context, payloadState) {
                                      if (payloadState.fetching) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (payloadState.payload == null) {
                                        return const Text("Payload not found");
                                      }

                                      final payload = payloadState.payload!;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text(payload.sku),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
