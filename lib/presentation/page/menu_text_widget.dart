import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';

import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';

import 'package:kris/presentation/widget/dialect/dialect_content_widget.dart';
import 'package:kris/presentation/widget/language/language_content_widget.dart';
import 'package:kris/presentation/widget/script/script_content_widget.dart';

import 'package:kris/model/text.dart' as w;

import '../../model/script.dart';

class MenuTextWidget extends StatefulWidget {
  final Identifier identifier;
  final bool selected;
  final ValueChanged<bool> onChanged;
  final String maya;

  const MenuTextWidget({
    super.key,
    required this.identifier,
    required this.selected,
    required this.onChanged,
    required this.maya,
  });

  @override
  State<MenuTextWidget> createState() => _MenuTextWidgetState();
}

class _MenuTextWidgetState extends State<MenuTextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    if (widget.maya == 'LANGUAGE') {
      context.read<LanguageBloc>().add(
        BaseEvent.text(identifier: widget.identifier),
      );
    } else if (widget.maya == 'DIALECT') {
      context.read<DialectBloc>().add(
        BaseEvent.text(identifier: widget.identifier),
      );
    } else {
      context.read<ScriptBloc>().add(
        BaseEvent.text(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.maya == 'LANGUAGE') {
      return BlocSelector<
        LanguageBloc,
        BaseState<Language, w.Text, Content, Payload>,
        w.Text?
      >(
        selector: (state) {
          return state.texts[widget.identifier.sku];
        },
        builder: (context, text) {
          if (text == null) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return _buildMenuText(text);
        },
      );
    }

    if (widget.maya == 'DIALECT') {
      return BlocSelector<
        DialectBloc,
        BaseState<Dialect, w.Text, Content, Payload>,
        w.Text?
      >(
        selector: (state) {
          return state.texts[widget.identifier.sku];
        },
        builder: (context, text) {
          if (text == null) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return _buildMenuText(text);
        },
      );
    }

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      w.Text?
    >(
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return _buildMenuText(text);
      },
    );
  }

  Card _buildMenuText(w.Text text) {
    final content = text.contents.first;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: widget.selected,
              onChanged: (value) {
                if (value != null) {
                  widget.onChanged(value);
                }
              },
            ),

            if (widget.maya == 'SCRIPT')
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: ScriptContentWidget(
                    key: ValueKey(content.sku),
                    identifier: content,
                  ),
                ),
              ),

            if (widget.maya == 'LANGUAGE')
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: LanguageContentWidget(
                    key: ValueKey(content.sku),
                    identifier: content,
                  ),
                ),
              ),

            if (widget.maya == 'DIALECT')
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: DialectContentWidget(
                    key: ValueKey(content.sku),
                    identifier: content,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
