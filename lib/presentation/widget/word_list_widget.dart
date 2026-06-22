import 'package:flutter/widgets.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../model/identifier.dart';
import '../../model/word.dart';
import 'image_list_widget.dart';

class WordListWidget extends StatelessWidget {
  final List<Word> words;

  const WordListWidget({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      configuration: PlutoGridConfiguration(
        columnSize: PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.scale,
        ),
      ),
      columns: [
        PlutoColumn(title: 'Word', field: 'word', type: PlutoColumnType.text()),
        PlutoColumn(
          title: 'Definition',
          field: 'definition',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Image',
          field: 'image',
          type: PlutoColumnType.text(),
          renderer: (context) {
            final List<Identifier> images = context.cell.value;
            return ImageListWidget(images: images);
          },
        ),
      ],
      rows: [..._getRows()],
    );
  }

  List<PlutoRow> _getRows() {
    return words
        .map(
          (word) => PlutoRow(
            cells: {
              'word': PlutoCell(value: word.sku),
              'definition': PlutoCell(value: "definition"),
              'image': PlutoCell(value: word.images),
            },
          ),
        )
        .toList();
  }
}
