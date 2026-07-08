import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,

      title: const Text("ߞߙߌߛߌ"),

      flexibleSpace: Image.network(
        "https://picsum.photos/800/400",
        fit: BoxFit.cover,
      ),

      backgroundColor: Colors.transparent,

      foregroundColor: Colors.white,
    );
  }
}
