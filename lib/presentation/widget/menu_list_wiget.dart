import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';

import 'menu_item_widget.dart';

class MenuListWiget extends StatefulWidget {
  final List<Word> words;
  final String label;
  final String hint;
  final void Function({required Word word, required bool select}) onPress;
  const MenuListWiget({
    super.key,
    required this.words,
    required this.onPress,
    required this.label,
    required this.hint,
  });

  @override
  State<MenuListWiget> createState() => _MenuListWigetState();
}

class _MenuListWigetState extends State<MenuListWiget> {
  final Set<String> checked = {};

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<Word>> entries = widget.words
        .map(
          (entry) => DropdownMenuEntry<Word>(
            value: entry,
            label: entry.sku,
            enabled: true,
            labelWidget: CheckboxListTile(
              value: checked.contains(entry.sku),
              onChanged: (bool? value) {
                widget.onPress(word: entry, select: value!);

                if (value) {
                  setState(() {
                    checked.add(entry.sku);
                  });
                } else {
                  checked.remove(entry.sku);
                }
              },
              title: ScriptMenuItemWidget(word: entry),
            ),
          ),
        )
        .toList();

    return DropdownMenu(
      //initialSelection: "Script",
      label: Text(widget.label),
      hintText: widget.hint,
      dropdownMenuEntries: entries,
    );
  }
}
