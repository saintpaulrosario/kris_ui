import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/payload/bloc/payload_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/content.dart';
import '../../model/payload.dart';
import '../../model/script.dart';
import '../../model/word_text.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
            selector: (state) => state.scripts,
            builder: (context, scriptState) {
              if (scriptState.isEmpty) {
                return const Text("No scripts available for selection");
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: scriptState.values
                    .expand(
                      (script) => script.texts.map(
                        (text) =>
                            BlocSelector<
                              WordTextBloc,
                              WordTextState,
                              Map<String, WordText>
                            >(
                              selector: (state) => state.texts,
                              builder: (context, state) {
                                if (state.isEmpty) {
                                  return const Text("No text available");
                                }

                                if (!state.containsKey(text.sku)) {
                                  return const Text(
                                    "Text not available for this script",
                                  );
                                }

                                return BlocSelector<
                                  WordTextBloc,
                                  WordTextState,
                                  WordText
                                >(
                                  selector: (state) => state.texts[text.sku]!,
                                  builder: (context, wordTextState) {
                                    return BlocSelector<
                                      ContentBloc,
                                      ContentState,
                                      Map<String, Content>
                                    >(
                                      selector: (state) => state.contents,
                                      builder: (context, contentMap) {
                                        if (contentMap.isEmpty) {
                                          return const Text(
                                            "No content available",
                                          );
                                        }

                                        if (!contentMap.containsKey(
                                          wordTextState.sku,
                                        )) {
                                          return const Text(
                                            "Content not available for this script",
                                          );
                                        }

                                        return BlocSelector<
                                          ContentBloc,
                                          ContentState,
                                          Content
                                        >(
                                          selector: (state) => state
                                              .contents[wordTextState.sku]!,
                                          builder: (context, contentState) {
                                            return BlocSelector<
                                              PayloadBloc,
                                              PayloadState,
                                              Payload
                                            >(
                                              selector: (state) => state
                                                  .payloads[contentState.sku]!,
                                              builder: (context, payloadState) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Checkbox(
                                                        value: true,
                                                        onChanged: (value) {
                                                          setState(() {});
                                                        },
                                                      ),
                                                      Text(payloadState.value),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [Text("languages")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [Text("dialects")],
          ),
        ],
      ),
    );
  }
}
