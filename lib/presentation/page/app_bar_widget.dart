import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/logic/word/word.dart';

import '../widget/menu_widget.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'SCRIPT',
      ),
    );

    context.read<WordBloc>().add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'LANGUAGE',
      ),
    );

    context.read<WordBloc>().add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'DIALECT',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,

      flexibleSpace: Stack(
        fit: StackFit.expand,

        children: [
          Image.network("https://picsum.photos/800/400", fit: BoxFit.cover),

          Container(color: Colors.black.withValues(alpha: 0.35)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const Text(
                    "ߞߙߌߛߌ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      children: [MenuWidget(maya: 'SCRIPT', label: 'script')],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      backgroundColor: Colors.transparent,

      elevation: 4,

      foregroundColor: Colors.white,
    );
  }
}
